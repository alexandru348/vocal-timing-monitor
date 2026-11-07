"""Explicit API-response simulations; these do NOT execute the Ableton API."""
from pathlib import Path
import hashlib
import unittest
from max_event_model import Graph
from test_static import PATCH, boxmap, edges


class StopReadbackTests(unittest.TestCase):
    def label(self,g):
        return ' '.join(map(str,g.state['root/popup/api-text']['label']))

    def test_path_id_alone_is_not_readiness(self):
        g=Graph();g.auto_api_readback=False;g.initialize()
        self.assertEqual(g.id,42)
        self.assertEqual(g.params['apiready'],0)
        self.assertIn('indisponibila',self.label(g))

    def test_preview_mode_does_not_veto_explicitly_armed_request(self):
        g=Graph();g.initialize();g.emit('root/thisdevice',(1,),2)
        g.toggle_stop_at_idle_poll();g.emit('root/thisdevice',(1,),2)
        self.assertEqual(g.params['autostop'],1)
        g.emit('root/snapshot-2',(1,));g.drain()
        self.assertEqual(g.calls,[('call','stop_playing')])
        self.assertEqual(g.params['autostop'],0)
        g.advance(151);g.drain()
        self.assertIn('oprire confirmata',self.label(g))

    def test_preview_mode_never_enables_autostop_itself(self):
        g=Graph();g.initialize();g.emit('root/thisdevice',(1,),2)
        g.emit('root/snapshot-2',(1,));g.drain()
        self.assertFalse(g.calls)
        self.assertEqual(g.params['autostop'],0)

    def test_native_safety_has_six_guards_and_no_preview_dependency(self):
        p=PATCH['patcher'];b=boxmap(p)
        self.assertEqual(b['safety']['numinlets'],6)
        self.assertEqual(b['safety-pak']['text'],'pak 0 1 0 1 0 0')
        self.assertFalse(any(src==('thisdevice',2) for src,dst in edges(p)))
        self.assertNotIn('preview-change',b)

    def test_matching_executor_readback_establishes_readiness(self):
        g=Graph();g.auto_api_readback=False;g.initialize()
        g.emit('root/stop-object',('id',42))
        self.assertEqual(g.params['apiready'],1)
        self.assertIn('pregatita',self.label(g))

    def test_zero_and_mismatched_readbacks_do_not_claim_readiness(self):
        for ack in [0,41,99]:
            g=Graph();g.auto_api_readback=False;g.initialize()
            g.emit('root/stop-object',('id',ack))
            self.assertEqual(g.params['apiready'],0)
            self.assertFalse(g.calls)

    def test_guard_rejection_has_specific_reason_and_no_call(self):
        cases=[
            ('root/live-path',('id',0),1,'fara conexiune'),
            ('root/thisdevice',(0,),1,'dispozitiv inactiv'),
            ('root/snapshot-7',(0,),0,'fara ceas'),
            ('root/audio-off',(0,),0,'fara procesare audio'),
            ('root/popup/enabled',(0,),None,'analiza OFF'),
        ]
        for source,msg,outlet,note in cases:
            with self.subTest(note=note):
                g=Graph();g.initialize()
                if outlet is None:g.send(source,msg)
                else:g.emit(source,msg,outlet)
                g.toggle_stop_at_idle_poll()
                g.emit('root/snapshot-2',(1,));g.drain()
                self.assertFalse(g.calls)
                self.assertEqual(g.params['autostop'],0)
                self.assertIn(note,self.label(g))

    def test_user_off_is_reported_as_cancelled(self):
        g=Graph();g.initialize();g.toggle_stop_at_idle_poll()
        g.emit('root/snapshot-2',(1,));g.toggle_stop_at_idle_poll();g.drain()
        self.assertFalse(g.calls)
        self.assertIn('comutator OFF',self.label(g))

    def test_dispatch_alone_does_not_claim_stop_confirmation(self):
        g=Graph();g.initialize();g.toggle_stop_at_idle_poll()
        g.emit('root/snapshot-2',(1,));g.drain()
        self.assertEqual(len(g.calls),1)
        self.assertIn('comanda trimisa',self.label(g))
        self.assertNotIn('confirmata',self.label(g))

    def test_stopped_host_readback_confirms_one_request(self):
        g=Graph();g.initialize();g.toggle_stop_at_idle_poll()
        g.emit('root/snapshot-2',(1,));g.drain()
        g.advance(151);g.drain()
        self.assertIn('oprire confirmata',self.label(g))
        self.assertEqual(len(g.calls),1)
        self.assertEqual(g.params['autostop'],0)

    def test_running_host_readback_is_not_falsely_confirmed(self):
        g=Graph();g.simulate_stop_effect=False;g.initialize();g.toggle_stop_at_idle_poll()
        g.emit('root/snapshot-2',(1,));g.drain()
        g.advance(151);g.drain()
        self.assertIn('Live inca reda',self.label(g))
        self.assertEqual(len(g.calls),1)
        self.assertEqual(g.params['autostop'],0)

    def test_api_loss_cancels_pending_property_query(self):
        g=Graph();g.initialize();g.toggle_stop_at_idle_poll()
        g.emit('root/snapshot-2',(1,));g.drain()
        g.emit('root/live-path',('id',0),1);g.drain()
        g.advance(151);g.drain()
        self.assertIn('indisponibila',self.label(g))
        self.assertEqual(len(g.calls),1)

    def test_disarm_before_any_stop_request_has_a_reason(self):
        for source,msg,outlet,note in [
            ('root/snapshot-7',(0,),0,'fara ceas'),
            ('root/audio-off',(0,),0,'fara procesare audio')]:
            g=Graph();g.initialize();g.toggle_stop_at_idle_poll()
            g.emit(source,msg,outlet)
            self.assertEqual(g.params['autostop'],0)
            self.assertIn(note,self.label(g))
            self.assertFalse(g.calls)

    def test_host_stop_after_request_does_not_overwrite_its_result(self):
        g=Graph();g.initialize();g.toggle_stop_at_idle_poll()
        g.emit('root/snapshot-2',(1,));g.drain();g.advance(151);g.drain()
        g.emit('root/snapshot-7',(0,))
        self.assertIn('oprire confirmata',self.label(g))

    def test_audio_engine_preserves_host_observed_rc4_algorithm(self):
        src=Path(__file__).resolve().parents[1]/'src/vtm_engine.genexpr'
        body='\n'.join(src.read_text().splitlines()[1:])
        self.assertEqual(hashlib.sha256(body.encode()).hexdigest(),
            'e2d8e89e2886a3331c3dd40c0969b1b05bc0bb984b78efae93bf8393146e81c7')


if __name__=='__main__':unittest.main()
