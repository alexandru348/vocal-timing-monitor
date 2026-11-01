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


def compile_harness():
    src = re.sub(r'//[^\n]*', '', SOURCE.read_text())
    # Gen declaration grammar: Param name(default); History name(default);
    # RC1's function-like Param(name, value) was invalid Gen, although the
    # original C++ harness mistakenly accepted and erased it before execution.
    assert not re.search(r'\b(?:Param|History)\s*\(', src), 'Invalid Gen declaration syntax'
    params = re.findall(r'\bParam\s+(\w+)\(\s*([-+\d.eE]+)\s*\);', src)
    histories = re.findall(r'\bHistory\s+(\w+)\(\s*([-+\d.eE]+)\s*\);', src)
    body = re.sub(r'\b(?:Param|History)\s+\w+\(\s*[-+\d.eE]+\s*\);', '', src)
    assert not re.search(r'\b(?:Param|History)\b', body), 'Unrecognized declaration'
    assigned = set(re.findall(r'\b(\w+)\s*=(?!=)', body))
    members = {n for n, _ in params + histories}
    locals_ = sorted(assigned - members)
    # These operators are all documented Gen operators used by this source.
    allowed_calls = {'clamp', 'min', 'max', 'floor', 'exp', 'abs', 'if'}
    calls = set(re.findall(r'\b(\w+)\s*\(', body))
    assert calls <= allowed_calls, calls - allowed_calls
    declarations = '\n'.join(f'double {n} = {v};' for n, v in params + histories)
    switch = '\n'.join(f'case {i}: e->{n} = v; break;' for i, (n, _) in enumerate(params))
    output = '\n'.join(f'out[{i-1}] = out{i};' for i in range(1, 12))
    cpp = '''#include <cmath>
#include <algorithm>
using std::exp; using std::floor; using std::abs;
inline double min(double a,double b){return a < b ? a : b;}
inline double max(double a,double b){return a > b ? a : b;}
inline double clamp(double v,double lo,double hi){return min(hi,max(lo,v));}
struct Engine {
double samplerate;
''' + declarations + '\nvoid step(double in1,double in2,double in3,double *out){\n'
    cpp += 'double ' + ','.join(n + '=0' for n in locals_) + ';\n' + body + '\n' + output + '\n}};\n'
    cpp += '''extern "C" {
void *make_engine(double sr){auto *e=new Engine();e->samplerate=sr;return e;}
void free_engine(void *p){delete (Engine*)p;}
void set_param(void *p,int i,double v){auto *e=(Engine*)p; switch(i){
''' + switch + '''}}
void run_engine(void *p,int n,const double *l,const double *r,const double *ph,double *out){
auto *e=(Engine*)p;for(int i=0;i<n;i++)e->step(l[i],r[i],ph[i],out+i*11);
}}
'''
    BUILD.mkdir(exist_ok=True)
    (BUILD / 'engine_harness.cpp').write_text(cpp)
    subprocess.run(['g++', '-std=c++17', '-O2', '-Wall', '-Wextra', '-Werror',
        '-shared', '-fPIC', str(BUILD / 'engine_harness.cpp'), '-o', str(BUILD / 'engine_harness.so')], check=True)
    return params


PARAMS = compile_harness()
LIB = ctypes.CDLL(str(BUILD / 'engine_harness.so'))
PTR = ctypes.POINTER(ctypes.c_double)
LIB.make_engine.argtypes = [ctypes.c_double]; LIB.make_engine.restype = ctypes.c_void_p
LIB.free_engine.argtypes = [ctypes.c_void_p]
LIB.set_param.argtypes = [ctypes.c_void_p, ctypes.c_int, ctypes.c_double]
LIB.run_engine.argtypes = [ctypes.c_void_p, ctypes.c_int, PTR, PTR, PTR, PTR]


class Engine:
    def __init__(self, sr=44100, **params):
        self.sr = sr
        self.ptr = LIB.make_engine(sr)
        self.time = 0
        self.bpm = 100
        self.play = 1
        self.set(**params)

    def __del__(self):
        if getattr(self, 'ptr', None):
            LIB.free_engine(self.ptr)
            self.ptr = None

    def set(self, **params):
        for name, value in params.items():
            i = [n for n, _ in PARAMS].index(name)
            LIB.set_param(self.ptr, i, value)

    def run(self, seconds=None, left=None, right=None, phase=None):
        n = int(round(seconds * self.sr)) if seconds is not None else len(left)
        left = np.zeros(n) if left is None else np.asarray(left, dtype=np.float64)
        right = left if right is None else np.asarray(right, dtype=np.float64)
        if phase is None:
            phase = ((np.arange(n) + self.time) * self.bpm / (60 * self.sr)) % 1 if self.play else np.zeros(n)
        arrays = [np.ascontiguousarray(x, dtype=np.float64) for x in [left, right, phase]]
        assert all(len(x) == n for x in arrays)
        out = np.empty((n, 11), dtype=np.float64)
        LIB.run_engine(self.ptr, n, *(x.ctypes.data_as(PTR) for x in arrays), out.ctypes.data_as(PTR))
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
