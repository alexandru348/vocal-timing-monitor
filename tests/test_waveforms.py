"""Display graph arithmetic and routing protocol tests, not Max GUI/Live tests.

The signal evaluator reads the generated native graph. It does not emulate
live.scope~ drawing, DeviceIO audio delivery or Max's real-time scheduler.
"""
from collections import defaultdict, deque
import hashlib
from pathlib import Path
import unittest
import numpy as np
from max_event_model import Graph
from test_static import PATCH, boxmap, edges

ROOT = Path(__file__).resolve().parents[1]


class DisplaySignals:
    def __init__(self, sources, grid=4, valid=1):
        self.p = PATCH['patcher']; self.b = boxmap(self.p)
        self.src = sources; self.grid = grid; self.valid = valid
        self.n = len(next(iter(sources.values())))
        self.incoming = defaultdict(list)
        for source, dest in edges(self.p):self.incoming[dest].append(source)
        self.cache = {}

    def inlet(self, id, inlet=0, fallback=0.):
        candidates = self.incoming[(id,inlet)]
        # UI controls are held values, not audio sources.
        candidates = [s for s in candidates if s[0] not in ['wave-grid-div','sync-render-change']]
        if not candidates:return np.full(self.n,fallback)
        return sum(self.signal(*s) for s in candidates)

    def signal(self,id,outlet=0):
        key=(id,outlet)
        if key in self.src:return self.src[key]
        if key in self.cache:return self.cache[key]
        w=self.b[id]['text'].split();op=w[0]
        if op=='abs~':r=np.abs(self.inlet(id))
        elif op=='>=~':r=(self.inlet(id)>=self.inlet(id,1)).astype(float)
        elif op=='+~':r=self.inlet(id)+self.inlet(id,1,float(w[1]))
        elif op=='selector~':
            idx=self.inlet(id).astype(int)
            r=np.where(idx==1,self.inlet(id,1),np.where(idx==2,self.inlet(id,2),0.))
        elif op=='*~':r=self.inlet(id)*self.inlet(id,1,self.grid/4 if id=='wave-grid-scale' else self.valid)
        elif op=='%~':r=np.fmod(self.inlet(id),float(w[1]))
        elif op=='<~':r=(self.inlet(id)<float(w[1])).astype(float)
        else:raise AssertionError(('not an implemented display signal operation',id,op))
        self.cache[key]=r;return r


class WaveformTests(unittest.TestCase):
    def root(self):return PATCH['patcher']

    def test_embedded_engine_is_identical_to_confirmed_rc6(self):
        # Pinned standalone body hash keeps this check useful without an older
        # source directory installed beside this archive.
        body='\n'.join((ROOT/'src/vtm_engine.genexpr').read_text().splitlines()[1:])
        self.assertEqual(hashlib.sha256(body.encode()).hexdigest(),
                         'e2d8e89e2886a3331c3dd40c0969b1b05bc0bb984b78efae93bf8393146e81c7')

    def test_two_host_buses_and_five_outlet_routing_contract(self):
        b=boxmap(self.root())
        self.assertEqual(b['plugin']['text'],'plugin~ 1 2')
        self.assertEqual(b['beat-plugin']['text'],'plugin~ 3 4')
        self.assertEqual(b['beat-router']['text'],'live.routing @port audio_inputs @index 1')
        self.assertEqual(b['beat-router']['numoutlets'],5)
        for outlet,tag in enumerate(['wave_type','wave_channel','wave_types','wave_channels']):
            self.assertIn((('beat-router',outlet),(tag+'-ui-tag',0)),edges(self.root()))

    def test_no_beat_signal_or_visual_gain_path_to_engine_or_audio_output(self):
        p=self.root();adj=defaultdict(list)
        for s,d in edges(p):
            # Popup sends UI commands through outlet 0; audio has no outlet.
            if s[0]!='popup' and d[0]!='popup':adj[s[0]].append(d[0])
        visited=set();q=deque(['beat-plugin'])
        while q:
            node=q.popleft()
            if node in visited:continue
            visited.add(node);q.extend(adj[node])
        self.assertNotIn('engine',visited);self.assertNotIn('plugout',visited)
        u=boxmap(p)['popup']['patcher'];ue=edges(u)
        for n in ['voice','beat']:
            self.assertEqual([d for s,d in ue if s==(n+'-gain',0)],[(n+'-magnify',1)])
        self.assertEqual([s for s,d in edges(p) if d[0]=='plugout'],[('silence',0),('silence',0)])

    def test_scope_histories_have_same_time_axis_and_no_signal_trigger(self):
        p=self.root();u=boxmap(p)['popup']['patcher'];b=boxmap(u)
        histories=[b[n+'-scope'] for n in ['voice','beat','grid']]
        self.assertTrue(all(h['maxclass']=='live.scope~' and h['mode']==0 for h in histories))
        for field in ['samples','interval']:
            self.assertEqual(len({h[field] for h in histories}),1)
        self.assertEqual({(h['presentation_rect'][0],h['presentation_rect'][2]) for h in histories},{(16.,568.)})
        self.assertEqual({h['samples'] for h in histories},{264600.})
        self.assertFalse(any(d[0].endswith('-scope') and d[1]==1 for s,d in edges(u)))
        self.assertFalse(any(h['grid'] for h in histories),'fixed lines are not beat markers')

    def test_inlet_indices_are_explicit_and_audio_is_not_sent_to_message_route(self):
        b=boxmap(self.root());u=boxmap(b['popup']['patcher'])
        self.assertEqual(b['popup']['numinlets'],4)
        for name,index in [('voice',2),('beat',3),('grid',4)]:
            self.assertEqual(u[name+'-signal']['index'],index)
            self.assertEqual(u[name+'-signal']['outlettype'],['signal'])
        self.assertEqual(u['in']['index'],1)

    def test_display_gain_defaults_and_limits(self):
        u=boxmap(boxmap(self.root())['popup']['patcher'])
        for n in ['voice','beat']:
            self.assertEqual(u[n+'-magnify']['text'],'*~ 1.')
            self.assertEqual(u[n+'-initial-gain']['text'],'1.')
            self.assertEqual((u[n+'-gain']['minimum'],u[n+'-gain']['maximum']),(1.,8.))

    def test_stereo_antiphase_and_right_only_still_visible(self):
        for left,right,expected in [([.2,-.3],[0,0],[.2,-.3]),([0,0],[.4,-.5],[.4,-.5]),
                                     ([.2,-.3],[-.2,.3],[.2,-.3])]:
            src={('plugin',0):np.array(left),('plugin',1):np.array(right)}
            np.testing.assert_array_equal(DisplaySignals(src).signal('voice-display-select'),expected)

    def test_separate_pcm_events_keep_their_time_and_amplitude(self):
        n=1000;v=np.zeros(n);beat=np.zeros(n);v[125:135]=.25;beat[600:610]=.75
        src={('plugin',0):v,('plugin',1):v*0,('beat-plugin',0):beat,('beat-plugin',1):beat*0}
        m=DisplaySignals(src)
        voice=m.signal('voice-display-select');instrumental=m.signal('beat-display-select')
        self.assertEqual(np.flatnonzero(voice)[0],125)
        self.assertEqual(np.flatnonzero(instrumental)[0],600)
        self.assertAlmostEqual(voice.max(),.25);self.assertAlmostEqual(instrumental.max(),.75)
        self.assertTrue(np.all(instrumental[125:135]==0))

    def test_grid_pulses_follow_host_phase_for_each_grid_and_tempo(self):
        sr=44100
        for bpm in [60,100,153,200]:
            for grid in [4,8,16]:
                n=sr*3;t=np.arange(n)/sr
                phase=np.mod(t*bpm/60.,1.)
                out=DisplaySignals({('phasor',0):phase},grid=grid).signal('wave-grid-valid')
                rises=np.flatnonzero(np.diff(out)>0)
                spacing=sr*60/bpm*4/grid
                self.assertGreater(len(rises),1)
                np.testing.assert_allclose(np.diff(rises),spacing,atol=1.)
                invalid=DisplaySignals({('phasor',0):phase},grid=grid,valid=0).signal('wave-grid-valid')
                self.assertFalse(invalid.any())

    def test_sample_rate_only_changes_all_display_lengths(self):
        for sr in [44100,48000,96000]:
            g=Graph();g.initialize();before=dict(g.params)
            g.emit('root/wave-samplerate',(sr,),1)
            for name in ['voice','beat','grid']:
                self.assertEqual(g.state['root/popup/'+name+'-scope']['samples'],(sr*6.,))
            self.assertEqual(g.params,before)
        self.assertFalse(any(s==('wave-samplerate',0) for s,d in edges(self.root())))

    def test_source_menus_accept_spaces_and_update_without_recursive_commands(self):
        g=Graph();g.initialize();before=dict(g.params)
        for i,menu,names,selected in [(2,'beat-type',('No Input','4 primul beat','Puls_calibrare'),'4 primul beat'),
                                       (3,'beat-channel',('Pre FX','Post FX','Post Mixer'),'Post Mixer')]:
            g.emit('root/beat-router',names,i)
            g.emit('root/beat-router',(selected,),i-2)
            state=g.state['root/popup/'+menu]
            self.assertEqual(state['items'],list(names));self.assertEqual(state['selected_symbol'],selected)
        self.assertEqual(g.state['root/beat-router']['commands'],[('port','audio_inputs'),('index',1)])
        self.assertEqual(g.params,before)

    def test_source_selection_and_refresh_never_become_gen_parameters(self):
        g=Graph();g.initialize();before=dict(g.params)
        g.send('root/popup/beat-type',(3,));g.send('root/popup/beat-channel',(2,));g.click('beat-refresh')
        self.assertEqual(g.state['root/beat-router']['commands'][-3:],[('type',3),('channel',2),('index',1)])
        self.assertEqual(g.params,before);self.assertFalse(g.calls)

    def test_new_ui_controls_cannot_arm_or_cancel_explicit_autostop(self):
        g=Graph();g.initialize();g.click('autostop');before=dict(g.params)
        g.send('root/popup/voice-gain',(8.,));g.send('root/popup/beat-gain',(3.,))
        g.send('root/popup/beat-type',(2,));g.click('beat-refresh')
        self.assertEqual(g.params,before);self.assertEqual(g.params['autostop'],1)
        g.emit('root/snapshot-2',(1,));g.drain();g.advance(151);g.drain()
        self.assertEqual(g.calls,[('call','stop_playing')]);self.assertEqual(g.params['autostop'],0)
        self.assertIn('oprire confirmata',' '.join(g.state['root/popup/api-text']['label']))


if __name__=='__main__':unittest.main()
