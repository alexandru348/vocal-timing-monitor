"""Execute stage 2 Gen arithmetic as C++; not Max/Gen or Live execution."""
from pathlib import Path
import ctypes
import re
import subprocess
import numpy as np
from assistant_preflight import OUTPUTS

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / 'src/vtm_assistant_preflight.genexpr'
BUILD = ROOT / 'tests/_generated'
PTR = ctypes.POINTER(ctypes.c_double)
WIDTH = len(OUTPUTS)


def compile_preflight():
    source = re.sub(r'//[^\n]*', '', SOURCE.read_text())
    params = re.findall(r'\bParam\s+(\w+)\(\s*([-+\d.eE]+)\s*\);', source)
    histories = re.findall(r'\bHistory\s+(\w+)\(\s*([-+\d.eE]+)\s*\);', source)
    body = re.sub(r'\b(?:Param|History)\s+\w+\(\s*[-+\d.eE]+\s*\);', '', source)
    assert not re.search(r'\b(?:Param|History)\b', body), 'Invalid Gen declaration'
    calls = set(re.findall(r'\b(\w+)\s*\(', body))
    assert calls <= {'clamp', 'min', 'max', 'floor', 'exp', 'abs', 'if'}
    members = {name for name, _ in params + histories}
    locals_ = sorted(set(re.findall(r'\b(\w+)\s*=(?!=)', body)) - members)
    declarations = '\n'.join(f'double {name}={value};' for name, value in params + histories)
    setters = '\n'.join(f'case {index}: p->{name}=v; break;' for index, (name, _) in enumerate(params))
    output = '\n'.join(f'out[{index}]=out{index+1};' for index in range(WIDTH))
    cpp = '''#include <cmath>
using std::exp; using std::floor; using std::abs;
double min(double a,double b){return a<b?a:b;}
double max(double a,double b){return a>b?a:b;}
double clamp(double v,double l,double h){return min(h,max(l,v));}
struct Preflight { double samplerate;
''' + declarations + '\nvoid step(double in1,double in2,double in3,double in4,double in5,double *out){\n'
    cpp += 'double ' + ','.join(name+'=0' for name in locals_) + ';\n' + body + '\n' + output + '\n}};\n'
    cpp += '''extern "C" {
void *make_preflight(double sr){auto *p=new Preflight();p->samplerate=sr;return p;}
void free_preflight(void *p){delete (Preflight*)p;}
void set_preflight(void *ptr,int i,double v){auto *p=(Preflight*)ptr; switch(i){
''' + setters + '''}}
void run_preflight(void *ptr,int n,const double *a,const double *b,const double *c,const double *d,const double *ph,double *out){
auto *p=(Preflight*)ptr;for(int i=0;i<n;i++)p->step(a[i],b[i],c[i],d[i],ph[i],out+i*WIDTH);}
}'''.replace('i*WIDTH', 'i*'+str(WIDTH))
    BUILD.mkdir(exist_ok=True)
    (BUILD/'assistant_preflight.cpp').write_text(cpp)
    subprocess.run(['g++', '-std=c++17', '-O2', '-Wall', '-Wextra', '-Werror',
                    '-shared', '-fPIC', str(BUILD/'assistant_preflight.cpp'),
                    '-o', str(BUILD/'assistant_preflight.so')], check=True)
    return params


PARAMS = compile_preflight()
LIB = ctypes.CDLL(str(BUILD/'assistant_preflight.so'))
LIB.make_preflight.argtypes = [ctypes.c_double]
LIB.make_preflight.restype = ctypes.c_void_p
LIB.free_preflight.argtypes = [ctypes.c_void_p]
LIB.set_preflight.argtypes = [ctypes.c_void_p, ctypes.c_int, ctypes.c_double]
LIB.run_preflight.argtypes = [ctypes.c_void_p, ctypes.c_int, PTR, PTR, PTR, PTR, PTR, PTR]


class Preflight:
    def __init__(self, sr=44100, **params):
        self.sr = sr
        self.time = 0
        self.bpm = 100
        self.play = True
        self.sequence = 0
        self.ptr = LIB.make_preflight(sr)
        self.set(**params)

    def __del__(self):
        if getattr(self, 'ptr', None):
            LIB.free_preflight(self.ptr)
            self.ptr = None

    def set(self, **params):
        names = [name for name, _ in PARAMS]
        for name, value in params.items():
            LIB.set_preflight(self.ptr, names.index(name), value)

    def run(self, mic, ref, right_mic=None, right_ref=None, phase=None, heartbeat=True):
        count = len(mic)
        if phase is None:
            phase = ((np.arange(count) + self.time) * self.bpm / (60*self.sr)) % 1 if self.play else np.zeros(count)
        arrays = [np.ascontiguousarray(array, dtype=np.float64) for array in
                  (mic, mic if right_mic is None else right_mic,
                   ref, ref if right_ref is None else right_ref, phase)]
        assert all(len(array) == count for array in arrays)
        out = np.empty((count, WIDTH), dtype=np.float64)
        # Simulate current host polls, not an automatically trustworthy signal.
        block = max(1, round(.02*self.sr))
        for start in range(0, count, block):
            stop = min(count, start+block)
            if heartbeat:
                self.sequence += 1
                self.set(hostseq=self.sequence)
            LIB.run_preflight(self.ptr, stop-start,
                *(array[start:stop].ctypes.data_as(PTR) for array in arrays),
                out[start:stop].ctypes.data_as(PTR))
        self.time += count
        assert np.isfinite(out).all()
        return out

    def signal(self, seconds=.16, mic=.1, ref=.15, **kwargs):
        t = (np.arange(round(seconds*self.sr)) + self.time) / self.sr
        return self.run(mic*np.sin(2*np.pi*350*t), ref*np.sin(2*np.pi*1300*t), **kwargs)


def ready(sr=44100, **changes):
    params = dict(apiready=1, playing=1, countingin=0, recording=0,
                  sessionrecord=0, sessionstatus=0, sourcemode=1,
                  voicebinding=1, referencebinding=1, quality=1,
                  timingpolicy=1, calibrationvalid=1, audiorevision=1,
                  calibratedrevision=1, timelinerevision=1, offsetms=83.0)
    params.update(changes)
    return Preflight(sr=sr, **params)
