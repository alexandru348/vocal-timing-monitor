"""Execute the exact calibration GenExpr arithmetic as C++; not a native Gen compiler."""
from pathlib import Path
import ctypes
import re
import subprocess
import numpy as np

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / 'src/vtm_latency.genexpr'
BUILD = ROOT / 'tests/_generated'

def compile_harness():
    src = re.sub(r'//[^\n]*', '', SOURCE.read_text())
    params = re.findall(r'\bParam\s+(\w+)\(\s*([-+\d.eE]+)\s*\);', src)
    histories = re.findall(r'\bHistory\s+(\w+)\(\s*([-+\d.eE]+)\s*\);', src)
    datas = re.findall(r'\bData\s+(\w+)\((\d+)\);', src)
    body = re.sub(r'\b(?:Param|History|Data)\s+\w+\(\s*[-+\d.eE]+\s*\);', '', src)
    assigned = set(re.findall(r'\b(\w+)\s*=(?!=)', body))
    members = {n for n, _ in params + histories + datas}
    locals_ = sorted(assigned - members)
    calls = set(re.findall(r'\b(\w+)\s*\(', body))
    assert calls <= {'clamp','min','max','floor','exp','abs','sqrt','peek','poke','if','for'}, calls
    declarations = '\n'.join(f'double {n}={v};' for n,v in params+histories)
    declarations += '\n'+'\n'.join(f'Data {n}{{{v}}};' for n,v in datas)
    switch = '\n'.join(f'case {i}: e->{n}=v; break;' for i,(n,_) in enumerate(params))
    cpp = '''#include <cmath>
#include <vector>
using std::exp; using std::floor; using std::abs; using std::sqrt;
double min(double a,double b){return a<b?a:b;}
double max(double a,double b){return a>b?a:b;}
double clamp(double v,double l,double h){return min(h,max(l,v));}
struct Data { std::vector<double> v; explicit Data(int n):v(n,0){} };
double peek(const Data &d,double i){int k=(int)i;return k>=0&&k<(int)d.v.size()?d.v[k]:0;}
void poke(Data &d,double v,double i){int k=(int)i;if(k>=0&&k<(int)d.v.size())d.v[k]=v;}
struct Calibrator { double samplerate;
'''+declarations+'\nvoid step(double in1,double in2,double in3,double in4,double in5,double *out){\n'
    cpp+='double '+','.join(n+'=0' for n in locals_)+';\n'+body+'\n'
    cpp+=''.join(f'out[{i}]=out{i+1};' for i in range(13))+'\n}};\n'
    cpp+='''extern "C" {
void *make_cal(double sr){auto *e=new Calibrator();e->samplerate=sr;return e;}
double read_band(void *p,int i){return ((Calibrator*)p)->bandinfo.v.at(i);}
void free_cal(void *p){delete (Calibrator*)p;}
void set_cal(void *p,int i,double v){auto *e=(Calibrator*)p;switch(i){'''+switch+'''}}
void run_cal(void *p,int n,const double *m,const double *mr,const double *r,const double *rr,const double *ph,double *out){
auto *e=(Calibrator*)p;for(int i=0;i<n;i++)e->step(m[i],mr[i],r[i],rr[i],ph[i],out+i*13);}
}'''
    BUILD.mkdir(exist_ok=True)
    (BUILD/'latency_harness.cpp').write_text(cpp)
    subprocess.run(['g++','-std=c++17','-O2','-Wall','-Wextra','-Werror','-shared','-fPIC',str(BUILD/'latency_harness.cpp'),'-o',str(BUILD/'latency_harness.so')],check=True)
    return params

PARAMS = compile_harness()
LIB = ctypes.CDLL(str(BUILD/'latency_harness.so'))
PTR = ctypes.POINTER(ctypes.c_double)
LIB.make_cal.argtypes=[ctypes.c_double];LIB.make_cal.restype=ctypes.c_void_p
LIB.free_cal.argtypes=[ctypes.c_void_p]
LIB.read_band.argtypes=[ctypes.c_void_p,ctypes.c_int];LIB.read_band.restype=ctypes.c_double
LIB.set_cal.argtypes=[ctypes.c_void_p,ctypes.c_int,ctypes.c_double]
LIB.run_cal.argtypes=[ctypes.c_void_p,ctypes.c_int,PTR,PTR,PTR,PTR,PTR,PTR]

class Calibrator:
    def __init__(self,sr=44100,**params):
        self.sr=sr;self.time=0;self.ptr=LIB.make_cal(sr);self.set(**params)
    def __del__(self):
        if getattr(self,'ptr',None): LIB.free_cal(self.ptr);self.ptr=None
    def set(self,**params):
        for n,v in params.items():LIB.set_cal(self.ptr,[x[0] for x in PARAMS].index(n),v)
    def run(self,mic,ref,right_mic=None,right_ref=None,phase=None):
        n=len(mic)
        if phase is None:phase=((np.arange(n)+self.time)*100/(60*self.sr))%1
        arrays=[np.ascontiguousarray(x,dtype=np.float64) for x in [mic,mic if right_mic is None else right_mic,ref,ref if right_ref is None else right_ref,phase]]
        assert all(len(a)==n for a in arrays)
        out=np.empty((n,13),dtype=np.float64)
        LIB.run_cal(self.ptr,n,*(a.ctypes.data_as(PTR) for a in arrays),out.ctypes.data_as(PTR))
        self.time+=n
        assert np.isfinite(out).all()
        return out
    def evidence(self):
        return np.array([LIB.read_band(self.ptr,i) for i in range(40)]).reshape(4,10)
    def measure(self,mic,ref,**kw):
        z=np.zeros(round(self.sr*.05));self.run(z,z)
        self.set(permit=1,requestseq=1)
        return self.run(mic,ref,**kw)

def reference(sr,seconds=14,seed=123):
    """Synthetic nonperiodic percussion-like bursts; no user audio."""
    rng=np.random.default_rng(seed); n=round(sr*seconds); a=np.zeros(n)
    at=.02
    while at<seconds:
        width=float(rng.uniform(.018,.13));count=round(width*sr);t=np.arange(count)/sr
        burst=(rng.normal(size=count)*.2+np.cos(2*np.pi*rng.uniform(180,2200)*t)*.3)*np.exp(-t/rng.uniform(.006,.07))
        i=round(at*sr);k=min(count,n-i);a[i:i+k]+=burst[:k]
        at+=float(rng.uniform(.07,.25))
    return a

def shifted(a,sr,ms):
    d=round(ms*sr/1000);b=np.zeros_like(a)
    if d==0:b[:]=a
    elif d>0:b[d:]=a[:-d]
    else:b[:d]=a[-d:]
    return b
