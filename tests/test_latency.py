import hashlib
from pathlib import Path
import unittest
import numpy as np
from latency_harness import Calibrator, reference, shifted
from gen_harness import Engine, pulse_train, events
from max_event_model import Graph
from test_static import PATCH, boxmap, edges

def result(g, value, token=None, quality=.98, status=3, drain=True):
    if token is None:token=g.state['root/lat-request-counter']['value']
    g.emit('root/lat-snapshot-1',(value,))
    g.emit('root/lat-snapshot-2',(quality,))
    g.emit('root/lat-snapshot-4',(token,))
    g.emit('root/lat-snapshot-0',(status,))
    if drain:g.drain()

class CalibrationSignalTests(unittest.TestCase):
    def test_known_delays_and_rational_sample_rates(self):
        for sr in [44100,48000,96000]:
            r=reference(sr)
            for delay in [0,23.6,92.2,173,-74]:
                with self.subTest(sr=sr,delay=delay):
                    o=Calibrator(sr).measure(.2*shifted(r,sr,delay),r)
                    self.assertEqual(o[-1,0],3)
                    self.assertAlmostEqual(o[-1,1],delay,delta=.6)
                    self.assertGreater(o[-1,2],.85)
    def test_stereo_polarity_and_unbalanced_gains(self):
        sr=44100;r=reference(sr);m=.03*shifted(r,sr,92.2)
        o=Calibrator(sr).measure(m*0,r,right_mic=-m,right_ref=-r)
        self.assertEqual(o[-1,0],3);self.assertAlmostEqual(o[-1,1],92.2,delta=.6)
    def test_noise_and_mild_echo_preserve_estimated_delay(self):
        sr=44100;r=reference(sr);rng=np.random.default_rng(1)
        m=.15*shifted(r,sr,92.2)+.025*shifted(r,sr,98.2)+rng.normal(size=len(r))*.003
        o=Calibrator(sr).measure(m,r)
        self.assertEqual(o[-1,0],3);self.assertAlmostEqual(o[-1,1],92.2,delta=3)
    def test_no_reference_or_no_microphone_is_rejected(self):
        r=reference(44100);z=np.zeros_like(r)
        for m,ref in [(z,r),(r,z),(z,z)]:
            o=Calibrator().measure(m,ref)
            self.assertEqual(o[-1,0],4);self.assertEqual(o[-1,1],0)
    def test_unrelated_or_dominant_vocal_signal_is_not_treated_as_latency(self):
        r=reference(44100);v=reference(44100,seed=314)
        for m in [v,v+.02*shifted(r,44100,92.2)]:
            o=Calibrator().measure(m,r)
            self.assertEqual(o[-1,0],4)
    def test_periodic_reference_with_multiple_plausible_lags_is_rejected(self):
        sr=44100;t=np.arange(sr*14)/sr
        r=(np.cos(2*np.pi*t/.2)+1)*.2*np.cos(2*np.pi*1200*t)
        o=Calibrator(sr).measure(shifted(r,sr,92.2),r)
        self.assertEqual(o[-1,0],4)
    def test_changing_delay_between_independent_windows_is_rejected(self):
        sr=44100;r=reference(sr);a=shifted(r,sr,70);b=shifted(r,sr,120)
        a[round(sr*1.9):]=b[round(sr*1.9):]
        o=Calibrator(sr).measure(a,r);self.assertEqual(o[-1,0],4)
    def test_outside_search_range_and_boundary_are_rejected(self):
        sr=44100;r=reference(sr)
        for delay in [400,-400,470]:
            o=Calibrator(sr).measure(shifted(r,sr,delay),r)
            self.assertEqual(o[-1,0],4)
    def test_stop_or_permit_loss_cancels_without_success(self):
        sr=44100;r=reference(sr);z=np.zeros(round(sr*.05))
        for mode in ['permit','clock','cancel']:
            c=Calibrator(sr);c.run(z,z);c.set(permit=1,requestseq=1)
            c.run(r[:sr],r[:sr])
            if mode=='permit':c.set(permit=0)
            if mode=='cancel':c.set(cancelseq=1)
            out=c.run(r[sr:],r[sr:],phase=np.zeros(len(r)-sr) if mode=='clock' else None)
            self.assertEqual(out[-1,0],5);self.assertEqual(out[-1,3],0)
    def test_blocked_request_does_not_measure(self):
        r=reference(44100)
        c=Calibrator();c.set(requestseq=1)
        o=c.run(r,r);self.assertEqual(o[-1,0],6);self.assertEqual(o[-1,3],0)
    def test_compensation_preserves_real_early_and_late_errors_and_stop(self):
        sr=44100;r=reference(sr);offset=Calibrator(sr).measure(.2*shifted(r,sr,92.2),r)[-1,1]
        for true_error in [0,-140,140]:
            times=[.6+i*.6+(92.2+true_error)/1000 for i in range(4)]
            audio=pulse_train(sr,3,times)
            e=Engine(sr=sr,offsetms=offset,autostop=1,apiready=1)
            out=e.run(left=audio);idx,ev=events(out)
            self.assertGreaterEqual(len(idx),4)
            np.testing.assert_allclose(ev[:,0],true_error,atol=1.5)
            self.assertEqual(int(out[-1,2]),int(true_error!=0))
            self.assertTrue(np.all(ev[:,3]==(4 if true_error==0 else 9)))

class CalibrationBindingTests(unittest.TestCase):
    def ready(self):
        g=Graph();g.initialize({'VTM Compensation ms':37.5});return g
    def test_reference_success_applies_once_and_saves_existing_parameter(self):
        g=self.ready();g.click('calibrate');result(g,92.2)
        self.assertEqual(g.params['offsetms'],92.2)
        self.assertEqual(g.saved_parameters()['VTM Compensation ms'],92.2)
        self.assertEqual(len(g.saved_parameters()),10)
        self.assertEqual(g.calls,[])
        result(g,170.)
        self.assertEqual(g.params['offsetms'],92.2)
    def test_raw_voice_delta_cannot_change_calibration_or_trigger_transport(self):
        g=self.ready();g.send('root/popup',('raw',240.));g.send('root/popup',('count',20))
        g.click('calibrate');self.assertEqual(g.params['offsetms'],37.5);self.assertFalse(g.calls)
    def test_rejected_measurement_retains_existing_value(self):
        g=self.ready();g.click('calibrate');result(g,100.,status=4)
        self.assertEqual(g.params['offsetms'],37.5)
    def test_terminal_failure_consumes_request_before_any_late_success_packet(self):
        for status in [4,5,6]:
            g=self.ready();g.click('calibrate');result(g,90.,status=status)
            result(g,92.2,status=3)
            self.assertEqual(g.params['offsetms'],37.5)
    def test_recording_and_autostop_block_application_without_disarming_user(self):
        for id,msg in [('lat-observe-0',(1,)),('lat-observe-1',(1,)),('lat-observe-2',(2,)),('popup/autostop',(1,))]:
            g=self.ready()
            if id.startswith('popup/'):g.send('root/'+id,msg)
            else:g.emit('root/'+id,msg)
            before=dict(g.params);g.click('calibrate');result(g,92.2)
            self.assertEqual(g.params,before);self.assertFalse(g.calls)
    def test_unknown_observer_blocks_even_if_api_is_ready(self):
        g=self.ready();g.emit('root/lat-observe-0',(-1,));g.click('calibrate');result(g,92.2)
        self.assertEqual(g.params['offsetms'],37.5)
    def test_loss_after_queued_success_is_rechecked(self):
        for action in ['record','stop','api','source','manual','reset','buffer','auto']:
            g=self.ready();g.click('calibrate');result(g,92.2,drain=False)
            if action=='record':g.emit('root/lat-observe-0',(1,))
            if action=='stop':g.emit('root/lat-observe-3',(0,))
            if action=='api':g.emit('root/live-path',('id',0),1)
            if action=='source':g.send('root/popup/beat-type',(3,))
            if action=='manual':g.send('root/popup/offsetms',(44.,))
            if action=='reset':g.click('reset')
            if action=='buffer':g.emit('root/wave-samplerate',(512,),3)
            if action=='auto':g.click('autostop')
            g.drain()
            self.assertEqual(g.params['offsetms'],44. if action=='manual' else 37.5,action)
            self.assertFalse(g.calls,action)
            label=' '.join(g.state['root/popup/calibration-help'].get('label',()))
            self.assertNotIn('Calibrare aplicată',label,action)
    def test_stale_generation_is_never_applied(self):
        g=self.ready();g.click('calibrate');old=g.state['root/lat-request-counter']['value']
        g.click('calibrate');result(g,92.2,token=old)
        self.assertEqual(g.params['offsetms'],37.5)
    def test_insufficient_quality_and_out_of_range_values_are_rejected(self):
        for value,q in [(90,.5),(500,.99),(-500,.99)]:
            g=self.ready();g.click('calibrate');result(g,value,quality=q)
            self.assertEqual(g.params['offsetms'],37.5)
    def test_page_theme_and_zoom_leave_calibration_request_unchanged(self):
        g=self.ready();g.click('calibrate')
        controls=list(g.state['root/lat-engine']['controls'])
        for control in ['settings','advanced','theme']:g.click(control)
        g.send('root/popup/voice-gain',(3.,))
        self.assertEqual(g.state['root/lat-engine']['controls'],controls)
    def test_waveforms_onset_engine_and_output_stay_on_original_paths(self):
        p=PATCH['patcher'];b=boxmap(p)
        source=Path(__file__).resolve().parents[1]/'src/vtm_engine.genexpr'
        self.assertEqual(hashlib.sha256(source.read_bytes()).hexdigest(),'5da751738b15e42bb4ad708eda7c8007a89c3a7b587823080fbe4941600f0945')
        self.assertFalse(any(s[0]=='lat-engine' and d[0] in ['engine','plugout'] for s,d in edges(p)))
        self.assertEqual([s[0] for s,d in edges(p) if d[0]=='plugout'],['silence','silence'])
        popup=b['popup']['patcher'];pb=boxmap(popup)
        self.assertNotIn('raw-store',pb)
        self.assertEqual(pb['calibrate']['text'],'Preia întârzierea')
        self.assertEqual(pb['calibrate']['presentation_rect'],[180.,476.,204.,30.])
        self.assertEqual(len([w for w in p['parameters'] if w!='inherited_shortname']),10)

if __name__=='__main__':unittest.main()
