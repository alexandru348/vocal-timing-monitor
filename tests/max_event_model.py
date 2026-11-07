"""Small message-routing model of the GENERATED patch graph, not Max itself.
DSP, GUI painting, clocks and Live API are stubs. Only the native message
subset needed for lifecycle, controls and stop safety is interpreted.
"""
import math
import re
from collections import defaultdict
from test_static import PATCH

BANG = ('bang',)


def parameter_enabled(box):
    # Wrapped newobj attributes have a different serialized location from UI
    # box attributes. The RC3 model previously ignored that distinction.
    return (box.get('saved_object_attributes',{}) if box['maxclass']=='newobj'
            else box).get('parameter_enable',0)


def atoms(text):
    result = []
    for t in text.split():
        try:
            n = float(t)
            result.append(int(n) if n.is_integer() else n)
        except ValueError:
            result.append(t)
    return tuple(result)


class Graph:
    def __init__(self):
        self.boxes = {}; self.wires = defaultdict(list); self.state = defaultdict(dict)
        self.params = {}; self.deferred = []; self.calls = []; self.openings = 0
        self.id = 0; self.steps = 0
        self.now = 0; self.timers = {}
        self.auto_api_readback=True; self.simulate_stop_effect=True; self.playing=True
        self.recording=0; self.session_record=0; self.session_record_status=0
        self._flatten(PATCH['patcher'], 'root')

    def _flatten(self, patch, prefix):
        for wrapped in patch['boxes']:
            b = wrapped['box']; key = prefix + '/' + b['id']; self.boxes[key] = b
            if 'patcher' in b and b['text'].startswith('p '):
                self._flatten(b['patcher'], key)
        for wrapped in patch['lines']:
            l = wrapped['patchline']; src, out = l['source']; dst, inlet = l['destination']
            self.wires[(prefix+'/'+src, out)].append((l.get('order', 0), prefix+'/'+dst, inlet))

    def emit(self, id, msg=BANG, outlet=0):
        for _, dst, inlet in sorted(self.wires[(id, outlet)]):
            self.send(dst, msg, inlet)

    def click(self, name):
        id = 'root/popup/' + name
        self.send(id, (1-int(self.state[id].get('value', 0)),))

    def toggle_stop_at_idle_poll(self):
        """Toggle, then model a fresh zero Stop snapshot before later events.

        Legacy message-only tests previously armed instantaneously. RC1.7
        requires an actual DSP-low acknowledgement, supplied explicitly here.
        New handshake/race tests use click() without this convenience method.
        """
        self.click('autostop')
        if self.state['root/popup/autostop']['value']:
            self.emit('root/snapshot-2',(0,))

    def drain(self):
        while self.deferred:
            id, msg = self.deferred.pop(0); self.emit(id, msg)

    def advance(self, milliseconds):
        target=self.now+milliseconds
        while self.timers and min(self.timers.values()) <= target:
            id=min(self.timers,key=self.timers.get)
            self.now=self.timers.pop(id)
            self.emit(id,BANG)
        self.now=target

    def send(self, id, msg=BANG, inlet=0):
        self.steps += 1
        assert self.steps < 100000, 'message recursion'
        b = self.boxes[id]; s = self.state[id]; cls = b['maxclass']; text = b.get('text', '')
        msg = tuple(msg); head = msg[0] if msg else 'bang'
        if cls in ['comment','panel','textbutton','number','flonum','umenu','multislider','live.scope~','live.numbox'] and head in ['bgcolor','bgfillcolor','activebgcolor','textcolor','textoncolor','bgoncolor','textovercolor','linecolor','activelinecolor','slidercolor','lcdbgcolor','lcdcolor','inactivelcdcolor','bordercolor','focusbordercolor']:
            s.setdefault('attrs',{})[head]=msg[1:];return
        if cls=='multislider':
            if head=='setlist':s['value']=msg[1:]
            return
        if cls in ['comment', 'panel']:
            if head == 'set': s['label'] = msg[1:]
            return
        if cls == 'live.scope~':
            # UI attributes only. No claim to emulate waveform painting.
            if head != 'bang':s[head]=msg[1:]
            return
        if cls == 'inlet':self.emit(id,msg);return
        if cls == 'message':
            if head == 'set':
                s['text'] = msg[1:]; return
            if 'text' in s:
                self.emit(id, s['text']); return
            for part in re.split(r'(?<!\\),',text):
                part=part.replace('\\,',',').replace('\\;',';').replace('\\\\','\\')
                output = tuple(msg[int(a[1:])-1] if isinstance(a,str) and re.fullmatch(r'\$[1-9]',a)
                               else a for a in atoms(part.strip()))
                self.emit(id, output)
            return
        if cls in ['textbutton', 'number', 'flonum', 'umenu','live.numbox']:
            if cls == 'umenu':
                if head=='clear':s['items']=[];return
                if head=='append':s.setdefault('items',[]).append(msg[1]);return
                if head=='setsymbol':s['selected_symbol']=msg[1];return
            if head in ['set', 'active']:
                s['value' if head == 'set' else 'active'] = msg[1]; return
            if head == 'bang':
                # textbutton toggles on bang; number/umenu repeat current value.
                head = 1-int(s.get('value',0)) if cls=='textbutton' else s.get('value',0)
            if not isinstance(head, (float, int)): return
            if cls == 'textbutton': head = int(head != 0)
            else:
                a=b.get('saved_attribute_attributes',{}).get('valueof',{})
                low=a.get('parameter_mmin',-1e12) if cls=='live.numbox' else b.get('minimum',-1e12)
                high=a.get('parameter_mmax',1e12) if cls=='live.numbox' else b.get('maximum',1e12)
                head=max(low,min(high,head))
                if cls=='live.numbox':self.emit(id,((head-low)/(high-low),),1)
            s['value'] = head; self.emit(id, (head,)); return
        words = text.split(); op = words[0] if words else ''
        if id == 'root/engine':
            self.params[head] = msg[1] if len(msg)>1 else None; return
        if op == 'live.observer':
            # Model the documented positional argument/property message only.
            # RC1 incorrectly accepted an undocumented @property constructor.
            if len(words)>1 and not words[1].startswith('@'):s.setdefault('property',words[1])
            if inlet==1:
                assert head=='id'
                s['id']=msg[1]
            elif head=='property':s['property']=msg[1]
            if s.get('id',0)>0 and s.get('property') and self.auto_api_readback:
                prop=s['property']
                self.deferred.append((id,(self.recording if prop=='record_mode' else int(self.playing) if prop=='is_playing' else getattr(self,prop),)))
            return
        if op == 'p':
            self.send(id+'/in', msg); return
        if op == 'inlet': self.emit(id, msg); return
        if op == 'outlet':
            parent = id.rsplit('/',1)[0]
            outlets = sorted((k for k,v in self.boxes.items()
                              if k.rsplit('/',1)[0] == parent
                              and v.get('text') == 'outlet'),
                             key=lambda k:self.boxes[k]['patching_rect'][0])
            self.emit(parent, msg, outlets.index(id)); return
        if op == 'prepend': self.emit(id, (words[1],)+msg); return
        if op == 'tosymbol': self.emit(id,(' '.join(map(str,msg)),)); return
        if op == 'zl' and words[1:] == ['change']:
            if inlet==1:s['list']=msg;return
            changed=msg!=s.get('list')
            self.emit(id,(int(changed),),1)
            if changed:s['list']=msg;self.emit(id,msg)
            return
        if op == 'zl' and words[1:] == ['reg']:
            if head!='bang':s['list']=msg
            if inlet==0:self.emit(id,s.get('list',()))
            return
        if op == 'zl' and words[1:] == ['rev']:
            self.emit(id,tuple(reversed(msg)));return
        if op == 'pattr':
            if '@bindto' in words:
                target=words[words.index('@bindto')+1]
                scope=id.rsplit('/',1)[0]+'/'
                bound=next(k for k,v in self.boxes.items()
                           if k.startswith(scope) and v.get('varname')==target)
                if head=='bang':self.emit(id,(self.state[bound].get('value',0),))
                return
            if head=='bang':self.emit(id,s.get('value',('__vtm_unset__',)))
            else:s['value']=msg
            # The generated routing pattrs have @thru 0: only bang emits.
            return
        if op == 'coll':
            data=s.setdefault('data',{})
            if head=='clear':data.clear()
            elif head=='store':data[msg[1]]=msg[2:]
            elif isinstance(head,(int,float)) and len(msg)>1:data[int(head)]=msg[1:]
            else:
                key=msg[1] if head=='symbol' and len(msg)==2 else head
                if key in data:
                    value=data[key]
                    # Documented coll output preserves a lone symbol with the
                    # explicit symbol selector. Actual owner RC3.2 ALS stores it.
                    self.emit(id,('symbol',)+value if len(value)==1 and isinstance(value[0],str) else value)
            return
        if op == 'route':
            selectors = atoms(' '.join(words[1:]))
            if head in selectors: self.emit(id, msg[1:] or BANG, selectors.index(head))
            else: self.emit(id, msg, len(selectors))
            return
        if op in ['t', 'trigger']:
            for i in reversed(range(len(words)-1)):
                kind = words[i+1]
                self.emit(id, BANG if kind=='b' else ('clear',) if kind=='clear' else msg, i)
            return
        if op == 'deferlow': self.deferred.append((id, msg)); return
        if op == 'delay':
            if head=='stop': self.timers.pop(id,None)
            elif head=='bang': self.timers[id]=self.now+float(words[1])
            return
        if op == 'snapshot~':
            # Optional synthetic DSP backend used by the integration tests.
            # This is a held signal sample, not an emulation of MSP scheduling.
            if head == 'bang' and 'signal_sample' in s:
                self.emit(id, (s['signal_sample'],))
            return
        if op == 'gate':
            if inlet==0: s['open']=bool(head)
            elif s.get('open', bool(int(words[2])) if len(words)>2 else False): self.emit(id,msg)
            return
        if op == 'sel':
            selectors=atoms(' '.join(words[1:]))
            self.emit(id, BANG if head in selectors else msg, selectors.index(head) if head in selectors else len(selectors)); return
        if op == 'change':
            if head == 'set': s['value']=msg[1]; return
            initial=float(words[1]) if len(words)>1 else 0
            if head != s.get('value',initial): s['value']=head; self.emit(id,msg)
            return
        if op in ['f','i']:
            if head != 'bang': s['value']=int(head) if op=='i' else float(head)
            initial=float(words[1]) if len(words)>1 else 0
            if inlet==0: self.emit(id,(s.get('value',initial),))
            return
        if op == 'counter':
            lo, hi = map(int, words[1:])
            if head=='set':s['value']=int(msg[1])-1;return
            s['value']=s.get('value',lo-1)+1
            if s['value']>hi: s['value']=lo
            self.emit(id,(s['value'],)); return
        if op in ['pak','pack']:
            vals=s.setdefault('values',list(atoms(' '.join(words[1:]))))
            vals[inlet]=head
            if op=='pak' or inlet==0:self.emit(id,tuple(vals))
            return
        if op == 'unpack':
            for i in reversed(range(min(len(msg),len(words)-1))): self.emit(id,(msg[i],),i)
            return
        if op=='clip':
            self.emit(id,(max(float(words[1]),min(float(words[2]),head)),));return
        if op == 'maximum':
            if inlet==1: s['floor']=head; return
            self.emit(id,(max(head,s.get('floor',float(words[1]))),)); return
        if op in ['*','/','+']:
            if inlet==1:s['right']=head;return
            right=s.get('right',float(words[1]))
            self.emit(id,(head*right if op=='*' else head/right if op=='/' else head+right,));return
        if op=='iter':
            for atom in msg:self.emit(id,(atom,))
            return
        if op=='live.routing':
            s.setdefault('commands',[]).append(msg)
            return
        if '~' in op and op not in ['snapshot~']:
            # Native DSP and painters are not simulated by this message model.
            s.setdefault('controls',[]).append((inlet,msg));return
        if op in ['>','==']:
            self.emit(id,(int(head>float(words[1]) if op=='>' else head==float(words[1])),)); return
        if op == 'expr':
            vals=s.setdefault('values',[0]*b['numinlets']); vals[inlet]=head
            if inlet!=0: return
            expression=text[5:]
            # Evaluate the actual generated expression; do not substitute a
            # hand-coded result for syntax that the target might reject.
            assert '?' not in expression, 'Max expr does not accept C ternary syntax'
            expression=re.sub(r'\$[if](\d)',lambda m:str(vals[int(m[1])-1]),expression)
            expression=expression.replace('&&',' and ').replace('||',' or ')
            expression=re.sub(r'!(?!=)',' not ',expression)
            value=eval(expression,{'__builtins__':{},'exp':math.exp,'log10':math.log10})
            self.emit(id,(int(value) if isinstance(value,bool) else value,)); return
        if op == 'sprintf':
            # Formatting only; no Max font or locale claim.
            fmt=text[8:].replace('%ld','%d')
            if fmt.startswith('symout '):fmt=fmt[7:]
            count=len(re.findall(r'%(?!%)[^a-zA-Z]*[a-zA-Z]',fmt))
            vals=s.setdefault('values',[0]*count)
            for i,value in enumerate(msg):
                if inlet+i<count:vals[inlet+i]=value
            if inlet==0:self.emit(id,(fmt % tuple(vals),))
            return
        if op == 'live.object':
            # Explicit simulation: numeric binding + deferred readback, no host.
            if inlet==1:
                assert head=='id' and isinstance(msg[1],(int,float)), 'typed id message required'
                self.id=msg[1]
            elif head=='getid':
                if self.auto_api_readback:self.deferred.append((id,('id',self.id)))
            elif head=='call':
                assert self.id>0, 'invalid Live object'
                self.calls.append(msg)
                if self.simulate_stop_effect:self.playing=False
            elif msg==('get','is_playing'):
                assert self.id>0, 'invalid property read'
                if self.auto_api_readback:self.deferred.append((id,('is_playing',int(self.playing))))
            return
        if op == 'pcontrol': self.openings+=1; return
        if op == 'thispatcher':
            # Models the documented window protocol only, not a native GUI.
            s.setdefault('commands',[]).append(msg)
            if msg[:2]==('script','send'):
                scope=id.rsplit('/',1)[0]+'/'
                target=next(k for k,v in self.boxes.items() if k.startswith(scope) and v.get('varname')==msg[2])
                self.send(target,msg[3:])
            elif msg[:2] in [('script','show'),('script','hide')]:
                scope=id.rsplit('/',1)[0]+'/'
                target=next(k for k,v in self.boxes.items() if k.startswith(scope) and v.get('varname')==msg[2])
                self.state[target]['hidden']=(msg[1]=='hide')
            elif msg==('window','getsize'):
                self.emit(id,('window','size')+s.get('rect',(60,50,700,410)))
            elif msg[:2]==('window','size'):
                s['rect']=tuple(msg[2:])
            return
        if op in ['qmetro','metro','loadbang','live.path','live.thisdevice','plugsync~','snapshot~','dspstate~','thispatcher','plugin~','plugout~','plugphasor~','sig~']:
            return
        raise AssertionError(('unmodelled object',id,text,cls,msg))

    def initialize(self, saved=None):
        # Explicit HOST STUB: emulate delivery of default/saved Live parameters
        # before live.thisdevice. This does not execute Ableton's serializer.
        self.restore_parameters(saved or {})
        self.emit('root/thisdevice', BANG, 0); self.drain()
        self.emit('root/live-path', ('id',42),1)
        self.emit('root/thisdevice',(1,),1)
        self.emit('root/thisdevice',(0,),2)
        self.drain()
        self.emit('root/snapshot-7',(1,))
        self.emit('root/heartbeat-snapshot',(4410.,))
        # A real polling cycle also observes the initially low DSP Stop latch.
        self.emit('root/snapshot-2',(0,))

    def restore_parameters(self, saved):
        for id,b in self.boxes.items():
            attrs=b.get('saved_attribute_attributes',{}).get('valueof',{})
            if not parameter_enabled(b) or attrs.get('parameter_invisible')!=1:continue
            name=attrs['parameter_longname']
            default=attrs.get('parameter_initial',b.get('restore',[0]))
            value=saved.get(name,default[0])
            self.send(id,tuple(value) if isinstance(value,(tuple,list)) else (value,))

    def saved_parameters(self):
        saved={}
        for id,b in self.boxes.items():
            attrs=b.get('saved_attribute_attributes',{}).get('valueof',{})
            if parameter_enabled(b) and attrs.get('parameter_invisible')==1:
                saved[attrs['parameter_longname']]=self.state[id].get('value')
        return saved
