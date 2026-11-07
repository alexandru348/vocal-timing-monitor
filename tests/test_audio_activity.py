import unittest
import numpy as np
from gen_harness import Engine
from max_event_model import Graph
from test_static import PATCH,boxmap,edges


class AudioActivityTests(unittest.TestCase):
    def ready(self):
        g=Graph();g.initialize();return g

    def label(self,g,id):
        return ' '.join(map(str,g.state['root/popup/'+id]['label']))

    def test_counter_runs_with_silent_input_and_stopped_transport(self):
        e=Engine();e.set(enabled=0);e.play=0
        out=e.run(seconds=.05)
        self.assertTrue(np.all(np.diff(out[:,10])==1))
        self.assertFalse(out[:,1].any())
        self.assertFalse(out[:,7].any())

    def test_global_dspstate_no_longer_overwrites_local_state(self):
        b=boxmap(PATCH['patcher'])
        self.assertNotIn('dspstate',b)
        self.assertIn((('engine',10),('heartbeat-snapshot',0)),edges(PATCH['patcher']))

    def test_live_counter_does_not_disarm_manual_autostop(self):
        g=self.ready();g.toggle_stop_at_idle_poll()
        for i in range(1,20):
            g.advance(20);g.emit('root/heartbeat-snapshot',(4410.+i*882,))
        self.assertEqual(g.params['autostop'],1)
        self.assertFalse(g.calls)

    def test_stalled_counter_disarms_and_invalidates_sync(self):
        g=self.ready();g.toggle_stop_at_idle_poll()
        g.advance(200);g.emit('root/heartbeat-snapshot',(4410.,)) # same frozen sample
        g.advance(51)
        self.assertEqual(g.params['autostop'],0)
        self.assertIn('Verifică motorul audio',self.label(g,'state-text'))
        self.assertIn('Pornește redarea',self.label(g,'clock-text'))
        self.assertFalse(g.calls)

    def test_recovery_restores_state_even_if_engine_status_unchanged(self):
        g=self.ready();g.emit('root/snapshot-3',(3,))
        self.assertIn('Pregătit să te asculte',self.label(g,'state-text'))
        g.advance(251)
        self.assertIn('Verifică motorul audio',self.label(g,'state-text'))
        g.emit('root/heartbeat-snapshot',(5000.,))
        self.assertIn('Pregătit să te asculte',self.label(g,'state-text'))
        self.assertIn('sincronizat',self.label(g,'clock-text'))

    def test_audio_loss_cancels_queued_stop(self):
        g=self.ready();g.toggle_stop_at_idle_poll();g.emit('root/snapshot-2',(1,))
        g.advance(251);g.drain()
        self.assertFalse(g.calls)

    def test_probe_is_raw_stereo_peak_independent_of_gen(self):
        p=PATCH['patcher'];b=boxmap(p);es=edges(p)
        self.assertIn((('plugin',0),('input-abs-l',0)),es)
        self.assertIn((('plugin',1),('input-abs-r',0)),es)
        self.assertIn((('input-abs-r',0),('input-max',1)),es)
        self.assertEqual(b['input-peak']['text'],'peakamp~ 600')
        self.assertIn((('input-peak',0),('level-ui-tag',0)),es)
        self.assertNotIn((('snapshot-4',0),('level-ui-tag',0)),es)

    def test_actual_input_peak_messages_reach_ui(self):
        g=self.ready();g.emit('root/input-peak',(.1,))
        self.assertEqual(self.label(g,'level-text'),'Nivel: -20.0 dB')
        g.emit('root/input-peak',(.001,))
        self.assertEqual(self.label(g,'level-text'),'Nivel: -60.0 dB')

    def test_startup_without_audio_is_inactive(self):
        g=Graph();g.emit('root/load')
        self.assertIn('Verifică motorul audio',self.label(g,'state-text'))
        self.assertFalse(g.calls)

    def test_restored_analysis_off_initial_zero_is_rendered_after_reopen(self):
        # Regression reproduced from owner RC3.2 before/after screenshots:
        # UI/engine OFF survived, but `change` suppressed the initial state 0
        # and left state-pak's fallback 1 (waiting for clock) on the display.
        g=Graph();g.initialize({'VTM Analysis':0,'VTM Grid':1,'VTM Threshold ms':80})
        e=Engine();e.set(enabled=g.params['enabled']);e.play=0
        out=e.run(seconds=.02)
        self.assertEqual(int(out[-1,3]),0)
        g.emit('root/snapshot-3',(int(out[-1,3]),))
        self.assertEqual(self.label(g,'state-text'),'Analiză oprită')
        self.assertEqual(g.state['root/popup/enabled']['value'],0)
        self.assertFalse(out[:,1].any())
        self.assertFalse(g.calls)


if __name__=='__main__':unittest.main()
