"""Rejected estimates must be explainable without becoming compensation."""
import unittest
import numpy as np
from latency_harness import Calibrator, reference, shifted
from max_event_model import Graph
from test_latency import result
from test_static import PATCH, boxmap, edges

class CalibrationDiagnosticTests(unittest.TestCase):
    def test_missing_reference_and_microphone_have_distinct_reasons(self):
        r=reference(44100);z=np.zeros_like(r)
        for m,ref,reason in [(r,z,1),(z,r,2),(z,z,1)]:
            out=Calibrator().measure(m,ref)[-1]
            self.assertEqual(out[0],4);self.assertEqual(out[5],reason)
            self.assertEqual(out[1],0)
    def test_unrelated_signal_reports_insufficient_match(self):
        out=Calibrator().measure(reference(44100,seed=314),reference(44100))[-1]
        self.assertEqual(out[5],3);self.assertLess(out[2],.85)
    def test_periodic_signal_reports_competing_peaks(self):
        sr=44100;t=np.arange(sr*14)/sr
        r=(np.cos(2*np.pi*t/.2)+1)*.2*np.cos(2*np.pi*1200*t)
        out=Calibrator().measure(shifted(r,sr,92.2),r)[-1]
        self.assertEqual(out[5],4);self.assertLess(out[9],.12)
    def test_success_has_no_rejection_and_read_only_metrics_match(self):
        r=reference(44100);out=Calibrator().measure(.2*shifted(r,44100,92.2),r)[-1]
        self.assertEqual(out[0],3);self.assertEqual(out[5],0)
        self.assertAlmostEqual(out[6],92,delta=1)
        self.assertGreaterEqual(out[7],.85);self.assertGreaterEqual(out[8],.85)
        self.assertGreaterEqual(out[9],.12);self.assertLessEqual(out[10],3)
    def reject(self,g,reason,token=None):
        g.send('root/popup',('latencydiagnostics',reason,.61,95.,.72,.68,.04,12.,0,0.))
        result(g,95.,status=4,token=token)
        return ' '.join(g.state['root/popup/calibration-help'].get('label',()))
    def test_all_reasons_render_metrics_and_retain_manual_compensation(self):
        expected=['Instrumental fără','Microfon fără','Potrivire insuficientă','Mai multe întârzieri','Întârziere instabilă','Candidat la limita']
        for reason,phrase in enumerate(expected,1):
            g=Graph();g.initialize({'VTM Compensation ms':37.5});g.click('calibrate')
            label=self.reject(g,reason)
            self.assertIn(phrase,label);self.assertIn('C=0.61',label)
            self.assertIn('candidat=95ms',label);self.assertIn('D=12ms',label)
            self.assertEqual(g.params['offsetms'],37.5);self.assertEqual(g.calls,[])
    def test_diagnostics_do_not_overwrite_measuring_or_stale_request(self):
        g=Graph();g.initialize();g.click('calibrate');old=g.state['root/lat-request-counter']['value']
        g.click('calibrate');result(g,0,status=1)
        label=self.reject(g,3,token=old)
        self.assertIn('Măsor',label);self.assertNotIn('C=',label)
        result(g,92.2);self.assertEqual(g.params['offsetms'],92.2)
    def test_poll_samples_metrics_then_reason_then_state(self):
        g=Graph();g.initialize();g.click('calibrate')
        values=[4,0,.61,0,g.state['root/lat-request-counter']['value'],3,95,.72,.68,.04,12]
        for outlet,value in enumerate(values):
            key='root/lat-snapshot-'+str(outlet)
            if key in g.boxes:g.state[key]['signal_sample']=value
        g.send('root/lat-poll',('bang',));g.drain()
        label=' '.join(g.state['root/popup/calibration-help']['label'])
        self.assertIn('C=0.61',label);self.assertIn('M=0.04',label)
        self.assertIn('A/B=0.72/0.68',label)
    def test_current_metrics_replace_previous_rejection_on_repeat(self):
        g=Graph();g.initialize();g.click('calibrate');self.reject(g,3)
        g.click('calibrate');label=self.reject(g,4)
        self.assertIn('Mai multe întârzieri',label)
    def test_diagnostics_are_not_stored_controls_and_add_no_presentation_boxes(self):
        p=PATCH['patcher'];b=boxmap(p);u=b['popup']['patcher']
        self.assertEqual(len(p['parameters'])-1,12)
        self.assertTrue(all(not w['box'].get('presentation') for w in u['boxes'] if w['box']['id'].startswith('lat-diagnostic-')))
        self.assertEqual(b['lat-engine']['numoutlets'],13)
        self.assertFalse(any(s[0]=='lat-engine' and d[0] in ['engine','plugout'] for s,d in edges(p)))

if __name__=='__main__':unittest.main()
