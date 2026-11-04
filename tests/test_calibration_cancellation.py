"""Duplicate host value reports are harmless; real changes still cancel."""
import unittest
import numpy as np
from max_event_model import Graph
from test_latency import result
from latency_harness import Calibrator,reference

class CancellationMessageTests(unittest.TestCase):
    def ready(self):
        g=Graph();g.initialize({'VTM Compensation ms':37.5});return g
    def counter(self,g):return g.state['root/lat-cancel-counter'].get('value',0)
    def test_unchanged_numeric_control_echoes_do_not_cancel(self):
        g=self.ready();g.click('calibrate');before=self.counter(g)
        values=[g.state['root/popup/gatedb']['value']]+[g.params[k] for k in ['enabled','autostop','grid','redms','offsetms']]
        for outlet,value in enumerate(values):g.emit('root/control-route',(value,),outlet)
        self.assertEqual(self.counter(g),before)
        self.assertEqual(g.state['root/lat-accept-pak']['values'][1],1)
        result(g,92.2);self.assertEqual(g.params['offsetms'],92.2)
    def test_identical_source_readbacks_do_not_cancel(self):
        g=self.ready()
        for outlet,value in [(0,(4,)),(1,(2,))]:g.emit('root/beat-router',value,outlet)
        g.click('calibrate');before=self.counter(g)
        for _ in range(3):
            g.emit('root/beat-router',(4,),0);g.emit('root/beat-router',(2,),1)
        self.assertEqual(self.counter(g),before);result(g,92.2)
        self.assertEqual(g.params['offsetms'],92.2)
    def test_repeated_dsp_reports_are_ignored_but_a_new_vector_cancels(self):
        g=self.ready()
        values=[1,44100,64,256]
        for outlet,value in enumerate(values):g.emit('root/wave-samplerate',(value,),outlet)
        g.click('calibrate');before=self.counter(g)
        for outlet,value in enumerate(values):g.emit('root/wave-samplerate',(value,),outlet)
        self.assertEqual(self.counter(g),before)
        g.emit('root/wave-samplerate',(512,),3)
        self.assertGreater(self.counter(g),before)
        self.assertIn((0,('cancelreason',18)),g.state['root/lat-engine']['controls'])
    def test_actual_control_change_still_cancels_and_sends_cause_before_sequence(self):
        g=self.ready();g.click('calibrate');before=self.counter(g)
        start=len(g.state['root/lat-engine']['controls'])
        g.send('root/popup/gatedb',(-27.,))
        self.assertGreater(self.counter(g),before)
        controls=g.state['root/lat-engine']['controls'][start:]
        j=next(i for i,(_,m) in enumerate(controls) if m==('cancelreason',1))
        self.assertEqual(controls[j+1][1][0],'cancelseq')
        result(g,92.2);self.assertEqual(g.params['offsetms'],37.5)
    def test_real_source_change_and_explicit_reset_and_refresh_still_cancel(self):
        for action in ['source','reset','refresh']:
            g=self.ready();g.emit('root/beat-router',(4,),0);g.click('calibrate');before=self.counter(g)
            if action=='source':g.emit('root/beat-router',(5,),0)
            if action=='reset':g.click('reset')
            if action=='refresh':g.click('beat-refresh')
            self.assertGreater(self.counter(g),before,action)
            result(g,92.2);self.assertEqual(g.params['offsetms'],37.5)
    def test_cancellation_packet_renders_exact_cause(self):
        for code,phrase in [(106,'Compensarea a fost modificată'),(111,'Ableton a schimbat sursa'),(208,'REC a fost activat'),(300,'Ceasul audio')]:
            g=self.ready();g.click('calibrate');g.emit('root/lat-snapshot-5',(code,));result(g,92.2,status=5)
            label=' '.join(g.state['root/popup/calibration-help']['label'])
            self.assertIn(phrase,label);self.assertIn('[C'+str(code)+']',label)
            self.assertEqual(g.params['offsetms'],37.5)
    def test_commit_failures_identify_quality_range_and_consumed_request(self):
        for value,quality,consume,code in [(92.,.5,False,404),(500.,.99,False,405),(92.,.99,True,402)]:
            g=self.ready();g.click('calibrate')
            if consume:g.click('reset')
            result(g,value,quality=quality)
            label=' '.join(g.state['root/popup/calibration-help']['label'])
            self.assertIn('[C'+str(code)+']',label);self.assertEqual(g.params['offsetms'],37.5)
    def test_diagnostics_do_not_overwrite_terminal_text_after_guard_recovery(self):
        g=self.ready();g.click('calibrate');g.emit('root/lat-snapshot-5',(300,));result(g,92.,status=5)
        before=g.state['root/popup/calibration-help']['label']
        g.send('root/popup',('latencycancelreason',0));g.emit('root/lat-observe-0',(0,))
        self.assertEqual(g.state['root/popup/calibration-help']['label'],before)

class CancellationSignalTests(unittest.TestCase):
    def active(self):
        c=Calibrator();z=np.zeros(2205);c.run(z,z);c.set(requestseq=1,permit=1)
        r=reference(44100,seconds=2);c.run(r[:44100],r[:44100]);return c,r[44100:]
    def test_explicit_cause_is_latched_after_terminal_cancellation(self):
        c,r=self.active();c.set(cancelseq=1,cancelreason=6)
        out=c.run(r,r);self.assertEqual(out[-1,0],5);self.assertEqual(out[-1,5],106)
        c.set(cancelreason=7,guardreason=8,permit=1)
        out=c.run(r,r);self.assertEqual(out[-1,5],106)
    def test_recording_guard_loss_reports_guard_instead_of_generic_cancel(self):
        c,r=self.active();c.set(permit=0,guardreason=8)
        out=c.run(r,r);self.assertEqual(out[-1,0],5);self.assertEqual(out[-1,5],208)
    def test_audio_clock_loss_is_distinguished_from_control_change(self):
        c,r=self.active();out=c.run(r,r,phase=np.zeros(len(r)))
        self.assertEqual(out[-1,0],5);self.assertIn(out[-1,5],[302,303])

if __name__=='__main__':unittest.main()
