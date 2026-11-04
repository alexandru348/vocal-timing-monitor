"""Spectral coloration fixtures use no owner audio. SciPy is test-only."""
import unittest
from pathlib import Path
import numpy as np
from scipy.signal import lfilter
from latency_harness import Calibrator, reference, shifted
from max_event_model import Graph
from test_latency import result


def lowpass(x,frequency,sr):
    c=np.exp(-2*np.pi*frequency/sr)
    return lfilter([1-c],[1,-c],x)


def highpass(x,frequency,sr):
    c=np.exp(-2*np.pi*frequency/sr)
    return lfilter([1,-1],[1,-c],x)


def bandpass(x,low,high,sr):
    return lowpass(lowpass(highpass(highpass(x,low,sr),low,sr),high,sr),high,sr)


def colored_reference(sr=44100,seed=1983,seconds=14):
    rng=np.random.default_rng(seed);n=round(sr*seconds);r=np.zeros(n)
    # Independent overlapping rhythms in bass, mid and high bands.
    for lo,hi,level in [(70,220,1.8),(500,1100,.3),(1400,3000,.2),(3500,6500,.1)]:
        a=np.zeros(n);at=.02
        while at<seconds-.1:
            width=float(rng.uniform(.04,.18));k=round(width*sr);t=np.arange(k)/sr
            w=bandpass(rng.normal(size=k),lo,hi,sr)*np.exp(-t/rng.uniform(.02,.09))
            i=round(at*sr);end=min(i+k,n);a[i:end]+=w[:end-i]
            at+=rng.uniform(.11,.45)
        r+=level*a
    return r


class MultibandCalibrationTests(unittest.TestCase):
    def test_colored_path_rejected_by_broadband_is_recovered_by_consensus(self):
        sr=44100;r=colored_reference(sr)
        m=shifted(.3*bandpass(r,600,3800,sr),sr,92.2)
        m+=np.random.default_rng(100).normal(size=len(r))*.0008
        c=Calibrator(sr);out=c.measure(m,r)[-1];e=c.evidence()
        self.assertEqual(e[0,0],0);self.assertLess(e[0,2],.85)
        self.assertEqual(out[0],3);self.assertGreaterEqual(out[11],2)
        self.assertAlmostEqual(out[1],92.2,delta=1)
        self.assertLessEqual(out[12],3)
        for row in e[e[:,0]>0]:
            self.assertGreaterEqual(row[2],.85);self.assertGreaterEqual(row[6],.12)
            self.assertLessEqual(row[7],3)
    def test_colored_paths_at_other_sample_rates_keep_physical_delay(self):
        for sr,delay in [(48000,23.6),(96000,173)]:
            r=colored_reference(sr)
            m=shifted(.3*bandpass(r,600,3800,sr),sr,delay)
            out=Calibrator(sr).measure(m,r)[-1]
            self.assertEqual(out[0],3);self.assertAlmostEqual(out[1],delay,delta=1.5)
            self.assertGreaterEqual(out[11],2)
    def split_paths(self,level):
        sr=44100;r1=bandpass(reference(sr,seed=161),220,600,sr)
        r2=bandpass(reference(sr,seed=271),2500,6000,sr)
        r=level*r1+r2;m=shifted(level*r1,sr,70)+shifted(r2,sr,120)
        c=Calibrator(sr);return c.measure(m,r)[-1],c.evidence()
    def test_two_strong_bands_with_different_delays_are_rejected(self):
        out,e=self.split_paths(1.3)
        self.assertGreaterEqual(np.sum(e[:,0]),2)
        self.assertEqual(out[0],4);self.assertEqual(out[5],8)
        self.assertGreater(out[12],40);self.assertEqual(out[1],0)
    def test_one_strong_band_cannot_apply_before_fresh_confirmation(self):
        sr=44100;r1=bandpass(reference(sr,seed=161),220,600,sr)
        r2=bandpass(reference(sr,seed=271),2500,6000,sr)
        r=r1+r2;m=shifted(r1,sr,70)+shifted(r2,sr,120)
        c=Calibrator(sr);n=sr*7
        out=c.measure(m[:n],r[:n])[-1]
        self.assertEqual(out[0],7);self.assertEqual(out[3],1);self.assertEqual(out[1],0)
        self.assertEqual(out[2],0)
    def test_repeated_request_needs_no_reset_and_does_not_reuse_previous_buffers(self):
        sr=44100;r=reference(sr);c=Calibrator(sr)
        first=c.measure(.2*shifted(r,sr,92.2),r)[-1]
        self.assertEqual(first[0],3)
        c.set(requestseq=2)
        second=c.run(.2*shifted(r,sr,173),r)[-1]
        self.assertEqual(second[0],3);self.assertAlmostEqual(second[1],173,delta=.6)
        self.assertEqual(second[4],2)
    def test_cancellation_during_later_band_analysis_does_not_publish_result(self):
        sr=44100;r=reference(sr);c=Calibrator(sr)
        c.run(np.zeros(2205),np.zeros(2205));c.set(permit=1,requestseq=1)
        n=round(sr*4.9);before=c.run(r[:n],r[:n])[-1]
        self.assertEqual(before[0],2);self.assertEqual(before[3],1)
        c.set(cancelseq=1);after=c.run(r[n:],r[n:])[-1]
        self.assertEqual(after[0],5);self.assertEqual(after[1],0)
    def test_consensus_failure_renders_reason_and_retains_parameter(self):
        for reason,phrase in [(7,'Confirmare insuficientă'),(8,'Benzile indică')]:
            g=Graph();g.initialize({'VTM Compensation ms':37.5});g.click('calibrate')
            values=[4,0,.91,0,g.state['root/lat-request-counter']['value'],reason,120,.91,.96,.63,0,2,49.7]
            for i,v in enumerate(values):
                key='root/lat-snapshot-'+str(i)
                if key in g.boxes:g.state[key]['signal_sample']=v
            g.send('root/lat-poll',('bang',));g.drain()
            label=' '.join(g.state['root/popup/calibration-help']['label'])
            self.assertIn(phrase,label);self.assertIn('N=2 S=49.7ms',label)
            self.assertEqual(g.params['offsetms'],37.5);self.assertEqual(g.calls,[])
    def test_strict_checks_and_all_qualified_band_agreement_are_explicit(self):
        source=(Path(__file__).resolve().parents[1]/'src/vtm_latency.genexpr').read_text()
        self.assertIn('(nbest >= 0.85) && ((nbest - nrunner) >= 0.12)',source)
        self.assertIn('(abs(nla - nlb) <= 3)',source)
        self.assertIn('(nconfirmed >= 2) && (nspread <= 3)',source)

if __name__=='__main__':unittest.main()
