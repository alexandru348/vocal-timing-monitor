"""A lone conclusive band needs a fresh second acquisition, never a direct write."""
import unittest
import numpy as np
from latency_harness import Calibrator,shifted
from test_multiband_calibration import colored_reference,bandpass
from gen_harness import Engine,pulse_train,events
from max_event_model import Graph
from test_latency import result

class TemporalConfirmationTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.sr=44100;cls.ref=colored_reference(cls.sr)
        cls.filtered=.3*bandpass(cls.ref,1500,6000,cls.sr)
        cls.mic=shifted(cls.filtered,cls.sr,92.2)
        c=Calibrator(cls.sr);cls.output=c.measure(cls.mic,cls.ref)
    def first_half(self):
        c=Calibrator(self.sr);n=self.sr*7
        o=c.measure(self.mic[:n],self.ref[:n])[-1]
        self.assertEqual(o[0],7);self.assertEqual(o[1],0);self.assertEqual(o[2],0)
        return c,n
    def test_single_band_succeeds_only_after_separate_second_capture(self):
        out=self.output
        self.assertTrue(np.any(out[:,0]==7))
        i=np.flatnonzero(out[:,0]==3)[0]
        self.assertGreater(i/self.sr,10)
        self.assertEqual(out[-1,11],1)
        self.assertAlmostEqual(out[-1,1],92.2,delta=1)
        self.assertGreaterEqual(out[-1,2],.85);self.assertLessEqual(out[-1,12],3)
        self.assertTrue(np.all(out[out[:,0]==7,1]==0))
    def test_changed_delay_in_new_capture_is_rejected(self):
        m=self.mic.copy();new=shifted(self.filtered,self.sr,173)
        m[self.sr*5:]=new[self.sr*5:]
        out=Calibrator(self.sr).measure(m,self.ref)[-1]
        self.assertEqual(out[0],4);self.assertEqual(out[5],10)
        self.assertEqual(out[1],0);self.assertGreater(out[12],70)
    def test_missing_second_reference_cannot_reuse_first_capture(self):
        r=self.ref.copy();r[self.sr*5:]=0
        out=Calibrator(self.sr).measure(self.mic,r)[-1]
        self.assertEqual(out[0],4);self.assertEqual(out[5],9);self.assertEqual(out[1],0)
    def test_lifecycle_loss_during_reconfirmation_cancels(self):
        for mode in ['permit','reset']:
            c,n=self.first_half()
            c.set(**({'permit':0} if mode=='permit' else {'cancelseq':1}))
            out=c.run(self.mic[n:],self.ref[n:])[-1]
            self.assertEqual(out[0],5);self.assertEqual(out[1],0);self.assertEqual(out[3],0)
    def test_new_request_clears_the_old_anchor_and_requires_its_own_confirmation(self):
        c,n=self.first_half();c.set(requestseq=2)
        out=c.run(shifted(self.filtered,self.sr,173),self.ref)
        self.assertTrue(np.any(out[:,0]==7));self.assertEqual(out[-1,0],3)
        self.assertAlmostEqual(out[-1,1],173,delta=1);self.assertEqual(out[-1,4],2)
    def test_provisional_status_is_displayed_without_consuming_or_applying_request(self):
        g=Graph();g.initialize({'VTM Compensation ms':37.5});g.click('calibrate')
        result(g,92.,quality=.93,status=7)
        label=' '.join(g.state['root/popup/calibration-help']['label'])
        self.assertIn('captură nouă',label);self.assertEqual(g.params['offsetms'],37.5)
        self.assertEqual(g.state['root/lat-accept-pak']['values'][1],1)
        g.emit('root/lat-observe-0',(1,));result(g,92.2)
        self.assertEqual(g.params['offsetms'],37.5);self.assertEqual(g.calls,[])
    def test_second_capture_rejection_reasons_render_and_preserve_manual_value(self):
        for reason,phrase in [(9,'Reconfirmare neconcludentă'),(10,'Întârzierea diferă')]:
            g=Graph();g.initialize({'VTM Compensation ms':37.5});g.click('calibrate')
            g.send('root/popup',('latencydiagnostics',reason,.93,173.,.95,.93,.5,1.,1,81.))
            result(g,173.,status=4)
            self.assertIn(phrase,' '.join(g.state['root/popup/calibration-help']['label']))
            self.assertEqual(g.params['offsetms'],37.5)
    def test_temporally_confirmed_compensation_preserves_real_timing_error_and_stop(self):
        offset=self.output[-1,1];sr=self.sr
        for true_error in [0,-140,140]:
            times=[.6+i*.6+(92.2+true_error)/1000 for i in range(4)]
            audio=pulse_train(sr,3,times)
            out=Engine(sr=sr,offsetms=offset,autostop=1,apiready=1).run(left=audio)
            idx,ev=events(out);self.assertGreaterEqual(len(idx),4)
            np.testing.assert_allclose(ev[:,0],true_error,atol=1.5)
            self.assertEqual(int(out[-1,2]),int(true_error!=0))

if __name__=='__main__':unittest.main()
