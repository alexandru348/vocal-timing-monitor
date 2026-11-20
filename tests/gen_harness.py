"""Execute the exact arithmetic/control-flow subset of our GenExpr as C++.

This is NOT the Cycling '74 Gen compiler or a Max emulator. It checks the DSP
algorithm with previous-sample History semantics. Max loading, scheduling,
licensing and plugphasor~ behavior must still be checked in Live.
"""
from pathlib import Path
import ctypes
import re
import subprocess
import numpy as np

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / 'src/vtm_engine.genexpr'
BUILD = ROOT / 'tests/_generated'


def compile_harness(source=None, stem='engine_harness', *, inputs=3, outputs=11):
    source = SOURCE if source is None else source
    src = re.sub(r'//[^\n]*', '', source.read_text())
    # Gen declaration grammar: Param name(default); History name(default);
    # RC1's function-like Param(name, value) was invalid Gen, although the
    # original C++ harness mistakenly accepted and erased it before execution.
    assert not re.search(r'\b(?:Param|History)\s*\(', src), 'Invalid Gen declaration syntax'
    params = re.findall(r'\bParam\s+(\w+)\(\s*([-+\d.eE]+)\s*\);', src)
    histories = re.findall(r'\bHistory\s+(\w+)\(\s*([-+\d.eE]+)\s*\);', src)
    buffers = re.findall(r'\bData\s+(\w+)\(\s*(\d+)\s*\);', src)
    body = re.sub(r'\b(?:Param|History)\s+\w+\(\s*[-+\d.eE]+\s*\);|\bData\s+\w+\(\s*\d+\s*\);', '', src)
    assert not re.search(r'\b(?:Param|History|Data)\b', body), 'Unrecognized declaration'
    assigned = set(re.findall(r'\b(\w+)\s*=(?!=)', body))
    members = {n for n, _ in params + histories + buffers}
    locals_ = sorted(assigned - members)
    # These operators are all documented Gen operators used by this source.
    allowed_calls = {'clamp', 'min', 'max', 'floor', 'exp', 'abs', 'sqrt', 'peek', 'poke', 'if', 'for'}
    calls = set(re.findall(r'\b(\w+)\s*\(', body))
    assert calls <= allowed_calls, calls - allowed_calls
    declarations = '\n'.join(f'double {n} = {v};' for n, v in params + histories)
    buffer_declarations = '\n'.join(f'Data {name}{{{size}}};' for name, size in buffers)
    switch = '\n'.join(f'case {i}: e->{n} = v; break;' for i, (n, _) in enumerate(params))
    setter = ('void set_param(void *p,int i,double v){auto *e=(Engine*)p; switch(i){\n' +
              switch + '}}' if params else 'void set_param(void *,int,double){}')
    output = '\n'.join(f'out[{i-1}] = out{i};' for i in range(1, outputs+1))
    step_inputs = ','.join(f'double in{i}' for i in range(1, inputs+1))
    run_inputs = ','.join(f'const double *input{i}' for i in range(1, inputs+1))
    sample_inputs = ','.join(f'input{i}[i]' for i in range(1, inputs+1))
    cpp = '''#include <cmath>
#include <algorithm>
#include <vector>
using std::exp; using std::floor; using std::abs; using std::sqrt;
inline double min(double a,double b){return a < b ? a : b;}
inline double max(double a,double b){return a > b ? a : b;}
inline double clamp(double v,double lo,double hi){return min(hi,max(lo,v));}
struct Data { std::vector<double> v; explicit Data(int n):v(n,0){} };
inline double peek(const Data &d,double i){return d.v.at((int)i);}
inline void poke(Data &d,double v,double i){d.v.at((int)i)=v;}
struct Engine {
double samplerate;
''' + declarations + '\n' + buffer_declarations + '\nvoid step('+step_inputs+',double *out){\n'
    cpp += 'double ' + ','.join(n + '=0' for n in locals_) + ';\n' + body + '\n' + output + '\n}};\n'
    cpp += '''extern "C" {
void *make_engine(double sr){auto *e=new Engine();e->samplerate=sr;return e;}
void free_engine(void *p){delete (Engine*)p;}
''' + setter + '''
void run_engine(void *p,int n,'''+run_inputs+''',double *out){
auto *e=(Engine*)p;for(int i=0;i<n;i++)e->step('''+sample_inputs+''',out+i*'''+str(outputs)+''');
}}
'''
    BUILD.mkdir(exist_ok=True)
    (BUILD / (stem + '.cpp')).write_text(cpp)
    subprocess.run(['g++', '-std=c++17', '-O2', '-Wall', '-Wextra', '-Werror',
        '-shared', '-fPIC', str(BUILD / (stem + '.cpp')), '-o', str(BUILD / (stem + '.so'))], check=True)
    return params


PARAMS = compile_harness()
PTR = ctypes.POINTER(ctypes.c_double)


def load_library(stem, *, inputs=3):
    lib = ctypes.CDLL(str(BUILD / (stem + '.so')))
    lib.make_engine.argtypes = [ctypes.c_double]
    lib.make_engine.restype = ctypes.c_void_p
    lib.free_engine.argtypes = [ctypes.c_void_p]
    lib.set_param.argtypes = [ctypes.c_void_p, ctypes.c_int, ctypes.c_double]
    lib.run_engine.argtypes = [ctypes.c_void_p, ctypes.c_int]+[PTR]*(inputs+1)
    return lib


LIB = load_library('engine_harness')


class Engine:
    lib = LIB
    params = PARAMS
    output_count = 11

    def __init__(self, sr=44100, **params):
        self.sr = sr
        self.ptr = self.lib.make_engine(sr)
        self.time = 0
        self.bpm = 100
        self.play = 1
        self.set(**params)

    def __del__(self):
        if getattr(self, 'ptr', None):
            self.lib.free_engine(self.ptr)
            self.ptr = None

    def set(self, **params):
        for name, value in params.items():
            i = [n for n, _ in self.params].index(name)
            self.lib.set_param(self.ptr, i, value)

    def run(self, seconds=None, left=None, right=None, phase=None, *, extra=()):
        n = int(round(seconds * self.sr)) if seconds is not None else len(left)
        left = np.zeros(n) if left is None else np.asarray(left, dtype=np.float64)
        right = left if right is None else np.asarray(right, dtype=np.float64)
        if phase is None:
            phase = ((np.arange(n) + self.time) * self.bpm / (60 * self.sr)) % 1 if self.play else np.zeros(n)
        arrays = [np.ascontiguousarray(x, dtype=np.float64) for x in [left, right, phase]]
        arrays.extend(np.ascontiguousarray(np.broadcast_to(x, (n,)), dtype=np.float64) for x in extra)
        assert all(len(x) == n for x in arrays)
        out = np.empty((n, self.output_count), dtype=np.float64)
        self.lib.run_engine(self.ptr, n, *(x.ctypes.data_as(PTR) for x in arrays), out.ctypes.data_as(PTR))
        self.time += n
        assert np.isfinite(out).all()
        return out


def pulse_train(sr, seconds, times, amplitude=0.3, width=.012):
    audio = np.zeros(int(round(sr * seconds)))
    n = int(round(width * sr))
    t = np.arange(n) / sr
    # Fixed deterministic 1800 Hz burst with exponential tail; onset is known.
    pulse = amplitude * np.cos(2 * np.pi * 1800 * t) * np.exp(-t / .004)
    for at in times:
        i = int(round(at * sr))
        k = min(n, len(audio)-i)
        if 0 <= i < len(audio):
            audio[i:i+k] += pulse[:k]
    return audio


def events(out):
    idx = np.flatnonzero(np.diff(np.r_[0, out[:, 1]]) > 0)
    return idx, out[idx]
