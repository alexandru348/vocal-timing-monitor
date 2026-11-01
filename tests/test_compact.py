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
        self.assertEqual(p['rect'][2:], [600., 340.])
        self.assertEqual(p['openrect'][2:], [600., 340.])
        self.assertLess(600*340/(900*720), .32)
        for id in ['voice-scope','beat-scope','grid-scope','state-text','delta-text',
                   'autostop','enabled','reset','count-text','settings']:
            x,y,w,h = b[id]['presentation_rect']
            self.assertTrue(0 <= x and x+w <= 600 and 0 <= y and y+h <= 340, id)
        for id in ['beat-type','beat-channel','grid-ui','redms','offsetms','gatedb',
                   'voice-gain','beat-gain','calibrate','test','api-text']:
            x,y,w,h = b[id]['presentation_rect']
            self.assertTrue(y >= 350 and x+w <= 600 and y+h <= 620, id)

    def test_interactive_controls_do_not_overlap_in_either_view(self):
        controls = [(id,b['presentation_rect']) for id,b in boxmap(self.ui()).items()
                    if b.get('presentation') and b['maxclass'] in
                    ['textbutton','number','flonum','umenu']]
        for i,(aid,(ax,ay,aw,ah)) in enumerate(controls):
            for bid,(bx,by,bw,bh) in controls[i+1:]:
                self.assertFalse(ax < bx+bw and bx < ax+aw and ay < by+bh and by < ay+ah,
                                 (aid,bid))

    def test_settings_expand_and_collapse_at_moved_window_origin(self):
        for left,top in [(60,50),(700,120),(-590,240)]:
            g = Graph(); g.initialize()
            window = g.state['root/popup/window']
            window['rect']=(left,top,left+600,top+340)
            g.click('settings')
            self.assertEqual(window['rect'],(left,top,left+600,top+620))
            g.click('settings')
            self.assertEqual(window['rect'],(left,top,left+600,top+340))
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
        for state,label in [(4,'ON BEAT'),(5,'USOR DECALAT'),(6,'OFF BEAT'),(9,'OPRIRE...')]:
            g.send('root/popup',('state',state))
            self.assertEqual(g.state['root/popup/state-text']['label'],tuple(label.split()))
        self.assertFalse(g.calls)

    def test_confirmed_engine_and_parent_protocol_are_unchanged(self):
        # Fixture digest of RC1 parent excluding presentation/version text and
        # popup contents: audio, lifecycle, API and all parent patchlines.
        p = json.loads(json.dumps(PATCH['patcher']))
        p.pop('digest',None)
        for wrapped in p['boxes']:
            b=wrapped['box']
            if b['id']=='popup':b.pop('patcher')
            if b['id']=='version':b.pop('text')
        self.assertEqual(hashlib.sha256(json.dumps(p,sort_keys=True).encode()).hexdigest(),
                         '718e30262a8779e2d4265430b0105ee26bba96651ea651cbdac5281fa1d5e9d0')


if __name__=='__main__':unittest.main()
