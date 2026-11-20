"""Execute clarity GenExpr arithmetic, not the native Gen compiler or Live."""
from pathlib import Path
import ctypes
import re
import subprocess
import numpy as np
from assistant_clarity import OUTPUTS, make_clarity_patch
from genexpr_scope import validate_scope

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / 'src/vtm_assistant_clarity.genexpr'
BUILD = ROOT / 'tests/_generated'
PTR = ctypes.POINTER(ctypes.c_double)
WIDTH = len(OUTPUTS)


def compile_clarity(*, patch=None, stem='clarity_harness', report_outputs=None):
    # Compile both deployed codeboxes and follow their GENERATED signal wires.
    # This does not emulate native Max port limits or its compiler/scheduler.
    patch = make_clarity_patch()['patcher'] if patch is None else patch
    report_outputs = OUTPUTS if report_outputs is None else report_outputs
    boxes = {w['box']['id']: w['box'] for w in patch['boxes']}
    wires = [w['patchline'] for w in patch['lines']]
    cpp = '''#include <cmath>
#include <vector>
using std::exp; using std::floor; using std::abs; using std::sqrt;
double min(double a,double b){return a<b?a:b;}
double max(double a,double b){return a>b?a:b;}
double clamp(double v,double l,double h){return min(h,max(l,v));}
struct Data { std::vector<double> v; explicit Data(int n):v(n,0){} };
double peek(const Data &d,double i){return d.v.at((int)i);}
void poke(Data &d,double v,double i){d.v.at((int)i)=v;}
'''
    def compile_box(id, cls):
        nonlocal cpp
        box = boxes[id]
        code = next(w['box']['code'] for w in box['patcher']['boxes']
                    if w['box']['maxclass'] == 'codebox')
        validate_scope(code, inputs=box['numinlets'], outputs=box['numoutlets'])
        src = re.sub(r'//[^\n]*', '', code)
        declarations = {op: re.findall(r'\b'+op+r'\s+(\w+)\(\s*([-+\d.eE]+)\s*\);', src)
                        for op in ('Param', 'History', 'Data')}
        body = re.sub(r'\b(?:Param|History|Data)\s+\w+\(\s*[-+\d.eE]+\s*\);', '', src)
        assert not re.search(r'\b(?:Param|History|Data)\b', body)
        calls = set(re.findall(r'\b(\w+)\s*\(', body))
        assert calls <= {'clamp', 'min', 'max', 'floor', 'exp', 'sqrt', 'abs', 'peek', 'poke', 'if', 'for'}, calls
        members = {name for rows in declarations.values() for name, _ in rows}
        locals_ = sorted(set(re.findall(r'\b(\w+)\s*=(?!=)', body))-members)
        cpp += 'struct '+cls+' { double samplerate;\n'
        cpp += '\n'.join(f'double {n}={v};' for n,v in declarations['Param']+declarations['History'])
        cpp += '\n'+'\n'.join(f'Data {n}{{{v}}};' for n,v in declarations['Data'])
        cpp += '\nvoid step(const double *input,double *out){\n'
        cpp += ''.join(f'double in{i+1}=input[{i}];' for i in range(box['numinlets']))
        cpp += 'double '+','.join(n+'=0' for n in locals_)+';\n'+body+'\n'
        cpp += ''.join(f'out[{i}]=out{i+1};' for i in range(box['numoutlets']))+'\n}};\n'
        return declarations['Param']
    parameters = compile_box('aq-engine', 'ClarityCore')
    assert not compile_box('aq-result-engine', 'CompletedResult')
    cpp += 'struct Clarity { ClarityCore core; CompletedResult keeper;\n'
    cpp += 'void step(double in1,double in2,double in3,double in4,double in5,double in6,double in7,double in8,double *out){\n'
    cpp += 'double input[]={in1,in2,in3,in4,in5,in6,in7,in8};\n'
    cpp += 'double raw['+str(boxes['aq-engine']['numoutlets'])+'];core.step(input,raw);\n'
    inputs = [None]*boxes['aq-result-engine']['numinlets']
    for wire in wires:
        src, dst = wire['source'], wire['destination']
        if dst[0] != 'aq-result-engine': continue
        if src[0] == 'aq-engine': value = f'raw[{src[1]}]'
        else:
            assert src == ['apf-engine',11], src
            value = 'in7'
        assert inputs[dst[1]] is None
        inputs[dst[1]] = value
    assert all(inputs)
    cpp += 'double keeperinput[]={'+','.join(inputs)+'};\n'
    cpp += 'double result['+str(boxes['aq-result-engine']['numoutlets'])+'];keeper.step(keeperinput,result);\n'
    for i,name in enumerate(report_outputs):
        origins = [w['source'] for w in wires if w['destination'] == ['aq-'+name,0]
                   and w['source'][0] in ('aq-engine', 'aq-result-engine')]
        assert len(origins) == 1, (name,origins)
        src, port = origins[0]
        array = {'aq-engine':'raw','aq-result-engine':'result'}[src]
        cpp += f'out[{i}]={array}[{port}];\n'
    cpp += '}};\n'
    cpp += '''extern "C" {
void *make_clarity(double sr){auto *p=new Clarity();p->core.samplerate=sr;p->keeper.samplerate=sr;return p;}
void free_clarity(void *p){delete (Clarity*)p;}
void set_clarity(void *ptr,int i,double v){auto *p=(Clarity*)ptr;switch(i){
'''+''.join(f'case {i}:p->core.{name}=v;break;' for i, (name, _) in enumerate(parameters))+'''}}
void run_clarity(void *ptr,int n,const double *a,const double *b,const double *c,const double *d,const double *permit,const double *epoch,const double *offset,const double *clip_pause,double *out){
auto *p=(Clarity*)ptr;for(int i=0;i<n;i++)p->step(a[i],b[i],c[i],d[i],permit[i],epoch[i],offset[i],clip_pause[i],out+i*WIDTH);}
}'''.replace('i*WIDTH', 'i*'+str(len(report_outputs)))
    BUILD.mkdir(exist_ok=True)
    (BUILD/(stem+'.cpp')).write_text(cpp)
    subprocess.run(['g++', '-std=c++17', '-O2', '-Wall', '-Wextra', '-Werror',
                    '-shared', '-fPIC', str(BUILD/(stem+'.cpp')),
                    '-o', str(BUILD/(stem+'.so'))], check=True)
    return parameters


PARAMS = compile_clarity()
def load_library(path):
    lib = ctypes.CDLL(str(path))
    lib.make_clarity.argtypes = [ctypes.c_double]
    lib.make_clarity.restype = ctypes.c_void_p
    lib.free_clarity.argtypes = [ctypes.c_void_p]
    lib.set_clarity.argtypes = [ctypes.c_void_p, ctypes.c_int, ctypes.c_double]
    lib.run_clarity.argtypes = [ctypes.c_void_p, ctypes.c_int]+[PTR]*9
    return lib


LIB = load_library(BUILD/'clarity_harness.so')


class Clarity:
    def __init__(self, sr=44100, *, library=None, width=WIDTH, **params):
        self.sr = sr
        self.lib = LIB if library is None else library
        self.width = width
        self.ptr = self.lib.make_clarity(sr)
        self.set(**({'profilevalid': 1, 'sourcemode': 1} | params))

    def __del__(self):
        if getattr(self, 'ptr', None):
            self.lib.free_clarity(self.ptr)
            self.ptr = None

    def set(self, **params):
        names = [name for name, _ in PARAMS]
        for name, value in params.items(): self.lib.set_clarity(self.ptr, names.index(name), value)

    def run(self, mic, ref, right_mic=None, right_ref=None, permit=1, epoch=1, offset=0, clip_pause=0):
        n = len(mic)
        def array(value):
            return np.ascontiguousarray(np.full(n, value) if np.isscalar(value) else value, dtype=np.float64)
        arrays = [array(x) for x in (mic, mic if right_mic is None else right_mic,
                  ref, ref if right_ref is None else right_ref, permit, epoch, offset, clip_pause)]
        assert all(len(a) == n for a in arrays)
        out = np.empty((n, self.width), dtype=np.float64)
        self.lib.run_clarity(self.ptr, n, *(a.ctypes.data_as(PTR) for a in arrays), out.ctypes.data_as(PTR))
        assert np.isfinite(out).all()
        return out
