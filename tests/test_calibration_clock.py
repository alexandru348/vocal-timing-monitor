"""Calibration phase liveness is distinct from instantaneous grid timestamping."""
import unittest
import numpy as np
from latency_harness import Calibrator,reference,shifted
from max_event_model import Graph
from test_latency import result
from test_static import PATCH,boxmap,edges

class CalibrationClockTests(unittest.TestCase):
    def active(self,sr=44100):
        c=Calibrator(sr);z=np.zeros(round(sr*.05));c.run(z,z);c.set(permit=1,requestseq=1)
        return c
    def test_isolated_holds_and_small_negative_corrections_keep_known_delay(self):
        for sr in [44100,48000,96000]:
            c=self.active(sr);r=reference(sr);p=((np.arange(len(r))+c.time)*100/(60*sr))%1
            for at in range(4096,len(p)-1,4096):p[at]=p[at-1]
            for at in range(6144,len(p)-1,12288):p[at]=p[at-1]-100/(60*sr)
            out=c.run(.2*shifted(r,sr,92.2),r,phase=p)
            self.assertEqual(out[-1,0],3);self.assertAlmostEqual(out[-1,1],92.2,delta=.6)
            self.assertFalse(np.any(out[:,0]==5))
    def test_one_millisecond_phase_hold_does_not_discard_sample_clock_capture(self):
        sr=44100;c=self.active(sr);r=reference(sr)
        p=((np.arange(len(r))+c.time)*100/(60*sr))%1
        for at in range(sr,len(p)-sr,sr):p[at:at+44]=p[at-1]
        out=c.run(.2*shifted(r,sr,92.2),r,phase=p)
        self.assertEqual(out[-1,0],3);self.assertAlmostEqual(out[-1,1],92.2,delta=.6)
    def test_float32_phase_and_inclusive_wrap_endpoints_are_tolerated(self):
        sr=44100;c=self.active(sr);r=reference(sr)
        p=(((np.arange(len(r))+c.time)*100/(60*sr))%1).astype(np.float32).astype(float)
        for at in np.flatnonzero(np.diff(p)<-.5):p[at+1]=0.;p[at]=1.
        out=c.run(.2*shifted(r,sr,92.2),r,phase=p)
        self.assertEqual(out[-1,0],3);self.assertAlmostEqual(out[-1,1],92.2,delta=.6)
    def test_persistent_stalled_clock_cancels_within_two_milliseconds(self):
        sr=44100;c=self.active(sr);r=reference(sr,seconds=2)
        first=c.run(r[:sr],r[:sr]);lastphase=((c.time-1)*100/(60*sr))%1
        out=c.run(r[sr:],r[sr:],phase=np.full(sr,lastphase))
        i=np.flatnonzero(out[:,0]==5)[0]
        self.assertLessEqual(i/sr,.0021);self.assertEqual(out[-1,5],302)
        self.assertEqual(out[-1,1],0)
    def test_large_forward_and_backward_position_jumps_cancel_immediately(self):
        sr=44100;r=reference(sr,seconds=2)
        for jump in [.1,-.1]:
            c=self.active(sr);p=((np.arange(len(r))+c.time)*100/(60*sr))%1
            p[sr:]=(p[sr:]+jump)%1
            out=c.run(r,r,phase=p)
            self.assertEqual(out[sr,0],5);self.assertEqual(out[-1,5],303)
            self.assertEqual(out[-1,1],0)
    def test_short_bad_clock_before_initial_lock_does_not_invent_readiness(self):
        sr=44100;c=Calibrator(sr);c.set(permit=1,requestseq=1)
        z=np.zeros(sr);out=c.run(z,z,phase=np.zeros(sr))
        self.assertEqual(out[-1,0],6);self.assertEqual(out[-1,1],0)
    def test_core_sync_status_alone_no_longer_cancels_calibration(self):
        g=Graph();g.initialize({'VTM Compensation ms':37.5});g.click('calibrate')
        g.emit('root/snapshot-7',(0,));g.emit('root/snapshot-7',(1,))
        self.assertEqual(g.state['root/lat-permit-pak']['values'][2],1)
        result(g,92.2);self.assertEqual(g.params['offsetms'],92.2)
    def test_transport_stop_or_unknown_report_still_blocks_deferred_write(self):
        for value in [0,-1]:
            g=Graph();g.initialize({'VTM Compensation ms':37.5});g.click('calibrate')
            result(g,92.2,drain=False);g.emit('root/lat-observe-3',(value,));g.drain()
            self.assertEqual(g.params['offsetms'],37.5);self.assertEqual(g.calls,[])
    def test_playback_observer_is_bound_requeried_and_resets_unknown_on_api_loss(self):
        p=PATCH['patcher'];b=boxmap(p);e=edges(p)
        self.assertEqual(b['lat-observe-3']['text'],'live.observer is_playing')
        self.assertEqual(b['lat-property-3']['text'],'property is_playing')
        self.assertIn((('bind-id',0),('lat-observe-3',1)),e)
        self.assertIn((('lat-observe-3',0),('lat-permit-pak',2)),e)
        self.assertNotIn((('sync-render-change',0),('lat-permit-pak',2)),e)
        g=Graph();g.initialize();g.emit('root/live-path',('id',0),1)
        self.assertEqual(g.state['root/lat-permit-pak']['values'][2],-1)

if __name__=='__main__':unittest.main()
