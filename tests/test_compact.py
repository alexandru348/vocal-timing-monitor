"""Compact-window scenarios; this is not native Max rendering validation."""
import hashlib
import json
import unittest
from collections import defaultdict, deque
from pathlib import Path
from max_event_model import Graph
from test_static import PATCH, boxmap, edges

ROOT = Path(__file__).resolve().parents[1]


class CompactTests(unittest.TestCase):
    def ui(self):
        return boxmap(PATCH['patcher'])['popup']['patcher']

    def test_primary_workflow_fits_collapsed_window(self):
        p = self.ui(); b = boxmap(p)
        self.assertEqual(p['rect'][2:], [640., 370.])
        self.assertEqual(p['openrect'][2:], [640., 370.])
        self.assertLess(640*370/(900*720), .37)
        for id in ['voice-scope','beat-scope','grid-scope','state-text','delta-text',
                   'autostop','enabled','reset','count-text','settings']:
            x,y,w,h = b[id]['presentation_rect']
            self.assertTrue(0 <= x and x+w <= 640 and 0 <= y and y+h <= 370, id)
        # Native regression: time labels need room above the lower border.
        for id in ('time-old','time-mid','time-now'):
            x,y,w,h = b[id]['presentation_rect']
            self.assertGreaterEqual(370 - (y+h), 12, id)
        for id in ('settings-heading','advanced'):
            self.assertGreaterEqual(b[id]['presentation_rect'][1], 370, id)
        for id in ['beat-type','beat-channel','grid-ui','redms','offsetms','gatedb',
                   'voice-gain','beat-gain','calibrate','test','api-text']:
            x,y,w,h = b[id]['presentation_rect']
            self.assertTrue(y >= 410 and x+w <= 640 and y+h <= 760, id)

    def test_interactive_controls_do_not_overlap_in_either_view(self):
        controls = [(id,b['presentation_rect']) for id,b in boxmap(self.ui()).items()
                    if b.get('presentation') and not b.get('hidden') and b['maxclass'] in
                    ['textbutton','number','flonum','umenu','live.numbox']]
        for i,(aid,(ax,ay,aw,ah)) in enumerate(controls):
            for bid,(bx,by,bw,bh) in controls[i+1:]:
                self.assertFalse(ax < bx+bw and bx < ax+aw and ay < by+bh and by < ay+ah,
                                 (aid,bid))

    def test_settings_expand_and_collapse_at_moved_window_origin(self):
        for left,top in [(60,50),(700,120),(-590,240)]:
            g = Graph(); g.initialize()
            window = g.state['root/popup/window']
            window['rect']=(left,top,left+640,top+370)
            g.click('settings')
            self.assertEqual(window['rect'],(left,top,left+640,top+760))
            g.click('settings')
            self.assertEqual(window['rect'],(left,top,left+640,top+370))
            self.assertEqual(g.openings,0)

    def test_settings_keep_source_gains_analysis_and_stop_intent(self):
        g = Graph(); g.initialize()
        g.send('root/popup/beat-type',(3,))
        g.send('root/popup/beat-channel',(2,))
        g.send('root/popup/voice-gain',(2.,))
        g.click('autostop')
        before = dict(g.params)
        commands = list(g.state['root/beat-router']['commands'])
        for _ in range(4):g.click('settings')
        self.assertEqual(g.params,before)
        self.assertEqual(g.params['autostop'],1)
        self.assertEqual(g.state['root/beat-router']['commands'],commands)
        self.assertEqual(g.state['root/popup/voice-gain']['value'],2.)
        self.assertFalse(g.calls)
        # Existing first-large-event route is still armed after using settings.
        g.emit('root/snapshot-2',(1,)); g.drain(); g.advance(151); g.drain()
        self.assertEqual(g.calls,[('call','stop_playing')])
        self.assertEqual(g.params['autostop'],0)

    def test_settings_button_has_no_path_to_core_or_source_controls(self):
        p=self.ui(); adj=defaultdict(list)
        for s,d in edges(p):adj[s[0]].append(d[0])
        visited=set(); todo=deque(['settings'])
        while todo:
            n=todo.popleft()
            if n in visited:continue
            visited.add(n); todo.extend(adj[n])
        self.assertFalse(visited & {'out','autostop','enabled','grid-ui','beat-type','beat-channel'})

    def test_renamed_timing_bands_do_not_hide_moderate_deviation(self):
        g=Graph(); g.initialize()
        for state,label in [(4,'Aproape de grilă'),(5,'Decalaj moderat'),(6,'Peste toleranță'),(9,'Se oprește redarea')]:
            g.send('root/popup',('state',state))
            self.assertEqual(g.state['root/popup/state-text']['label'],tuple(label.split()))
        self.assertFalse(g.calls)

    def test_confirmed_engine_and_parent_protocol_are_unchanged(self):
        # Fixture digest of RC1 parent excluding presentation/version text and
        # popup contents: audio, lifecycle, API and all parent patchlines.
        p = json.loads(json.dumps(PATCH['patcher']))
        p.pop('digest',None)
        # Normalize the parameter registry and explicitly listed root UI copy
        # changes only. All audio/API objects and every parent edge stay pinned.
        p['parameters'] = {'inherited_shortname': 1}
        # Remove only the explicitly named display-only module. Keep every
        # original audio/control/Live API object and edge in the pinned digest.
        device_ui={w['box']['id'] for w in p['boxes'] if w['box']['id'].startswith('ui-device-')}
        p['boxes']=[w for w in p['boxes'] if w['box']['id'] not in device_ui]
        p['lines']=[w for w in p['lines'] if w['patchline']['source'][0] not in device_ui
                    and w['patchline']['destination'][0] not in device_ui]
        for wrapped in p['boxes']:
            b=wrapped['box']
            # RC1.2 changes only font metadata on the five root UI objects.
            if b['id'] in ('title','version','open','note1','note2'):
                b.pop('fontname',None)
                b.pop('varname',None)
                b['textcolor']=[0.29,0.79,0.91,1.] if b['id'] in ('title','open') else [0.59,0.67,0.77,1.]
            if b['id']=='open':
                b.update(bgcolor=[.12,.17,.22,1.],bgoncolor=[.12,.17,.22,1.],textoncolor=[.91,.94,.98,1.])
                b.pop('textovercolor',None);b.pop('usetextovercolor',None)
            if b['id']=='title':
                b['fontsize']=17.
                b['presentation_rect'][3]=26.
            if b['id']=='popup':
                b.pop('patcher');b['numoutlets']=1
            if b['id']=='version':b.pop('text')
            if b['id']=='note1':
                b['text']='ANALIZA ON / AUTO STOP OFF la incarcare'
                b['fontsize']=11.
            if b['id']=='note2':b['text']='Iesire muta cat timp dispozitivul este activ.'
            if b['id']=='open':b['text']=b['texton']='OPEN MONITOR'
            # RC3.3 permits the initial OFF (zero) status to reach the UI;
            # normalize this display-only initializer, not any audio/API edge.
            if b['id']=='state-change':b['text']='change'
        self.assertEqual(hashlib.sha256(json.dumps(p,sort_keys=True).encode()).hexdigest(),
                         '718e30262a8779e2d4265430b0105ee26bba96651ea651cbdac5281fa1d5e9d0')


if __name__=='__main__':unittest.main()
