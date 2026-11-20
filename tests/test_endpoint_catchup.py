"""Captured 63-repeat / 64-step endpoint return, tested as synthetic arithmetic."""
import math
import unittest
import numpy as np
from preflight_harness import ready
from test_endpoint_clock import held_endpoint
from test_clock_fault_capture import run_phase
from test_preflight_diagnostics import at
from clarity_harness import Clarity
from test_assistant_clarity import signals, column


def catchup_trace(p, length=63, error_samples=0, seconds=None):
    step = p.bpm/(60*p.sr)
    # First complete boundary following the current time. Force the endpoint
    # slightly early if a fractional-sample boundary cannot be represented.
    k = math.floor(math.ceil((p.time+2)*step)/step) - p.time
    n = max(k+length+round(.2*p.sr), round((seconds or 0)*p.sr))
    phase = ((np.arange(n)+p.time)*step) % 1
    phase[k:k+length+1] = 1
    resume = k+length+1
    phase[resume:] = ((length+1+error_samples+np.arange(n-resume))*step) % 1
    return phase, k+1, resume


class EndpointCatchupTests(unittest.TestCase):
    def test_024_capture_63_repeats_then_64_steps_preserves_acoustics(self):
        p = ready(quality=0)
        before = p.signal()[-1]
        phase,k,resume = catchup_trace(p)
        out = run_phase(p,phase)
        self.assertAlmostEqual(phase[resume], .002418745275889478, places=12)
        self.assertTrue(np.all(out[:,1] == 1))
        self.assertTrue(np.all(out[:,9] == before[9]))
        self.assertEqual(at(out[-1],'synclosses'),0)
        self.assertEqual(at(out[-1],'endpoint_catchups'),1)
        self.assertEqual(at(out[-1],'endpoint_resume_rejections'),0)
        self.assertEqual(at(out[-1],'endpoint_recoveries'),1)
        self.assertAlmostEqual(at(out[-1],'last_endpoint_resumeinc'),64*100/(60*p.sr))
        self.assertAlmostEqual(at(out[-1],'last_endpoint_error_samples'),0, places=6)
        self.assertFalse(out[:,2].any())

    def test_rate_tempo_and_hold_length_matrix_keeps_period_and_context(self):
        for sr in (44100,48000,96000):
            for bpm in (60,100,153,400):
                for length in (1,31,63,int(sr*.002)):
                    with self.subTest(sr=sr,bpm=bpm,length=length):
                        p=ready(sr=sr,quality=0);p.bpm=bpm
                        before=p.signal()[-1]
                        phase,k,resume=catchup_trace(p,length)
                        out=run_phase(p,phase)
                        self.assertEqual(at(out[-1],'synclosses'),0)
                        self.assertEqual(at(out[-1],'periodchanges'),at(before,'periodchanges'))
                        self.assertTrue(np.all(out[:,9]==before[9]))
                        self.assertEqual(at(out[-1],'endpoint_catchups'),1)
                        self.assertEqual(at(out[-1],'endpoint_recoveries'),1)
                        self.assertAlmostEqual(at(out[-1],'periodms'),60000/bpm,places=6)

    def test_hold_and_return_and_ten_ms_recovery_do_not_emit_musical_phase(self):
        p=ready();p.signal()
        phase,k,resume=catchup_trace(p)
        out=run_phase(p,phase)
        clean=math.ceil(.01*p.sr)
        self.assertFalse(out[k:resume+clean,2].any())
        self.assertFalse(out[k:resume+clean,4].any())
        self.assertEqual(out[resume+clean,2],1)
        np.testing.assert_array_equal(out[:,3],phase)

    def test_wrong_elapsed_advance_is_rejected_even_inside_global_tempo_bounds(self):
        for length in (1,2,31,63):
            for error in (-.25,.25,1):
                p=ready();p.signal()
                phase,k,resume=catchup_trace(p,length,error)
                out=run_phase(p,phase)
                self.assertEqual(out[resume,1],0,(length,error))
                self.assertEqual(out[resume,2],0)
                self.assertEqual(at(out[-1],'endpoint_catchups'),0)
                self.assertEqual(at(out[-1],'endpoint_resume_rejections'),1)
                self.assertAlmostEqual(at(out[-1],'last_endpoint_error_samples'),error,places=6)
                self.assertAlmostEqual(at(out[-1],'last_endpoint_resumeinc'),phase[resume])

    def test_same_large_increment_without_preceding_hold_is_still_a_fault(self):
        p=ready();p.signal()
        step=100/(60*p.sr)
        phase=((np.arange(1000)+p.time)*step)%1
        phase[100:]=(phase[100:]+63*step)%1
        out=run_phase(p,phase)
        self.assertEqual(out[100,1],0)
        self.assertEqual(at(out[-1],'endpoint_catchups'),0)
        self.assertEqual(at(out[-1],'clockfaults'),1)

    def test_over_budget_hold_cannot_be_rescued_by_matching_elapsed_advance(self):
        p=ready();p.signal()
        phase,k,resume=catchup_trace(p,int(p.sr*.002)+1)
        out=run_phase(p,phase)
        self.assertEqual(out[resume,1],0)
        self.assertEqual(at(out[-1],'endpoint_catchups'),0)
        self.assertEqual(at(out[-1],'endpoint_recoveries'),0)

    def test_tempo_change_after_matched_return_still_suspends_evaluation(self):
        p=ready();p.signal()
        phase,k,resume=catchup_trace(p)
        phase[resume+1:]=(phase[resume]+(np.arange(len(phase)-resume-1)+1)*153/(60*p.sr))%1
        out=run_phase(p,phase)
        self.assertEqual(at(out[-1],'endpoint_catchups'),1)
        self.assertGreater(at(out[-1],'periodchanges'),0)
        self.assertFalse(out[k:resume+round(.04*p.sr),2].any())
        self.assertEqual(out[-1,2],1)

    def test_stop_countin_source_edits_and_expired_poll_override_matched_return(self):
        for edit in ({'playing':0},{'countingin':1},{'voicebinding':0},{'apiready':0}):
            p=ready();p.signal()
            phase,k,resume=catchup_trace(p)
            run_phase(p,phase[:resume])
            p.set(**edit)
            out=run_phase(p,phase[resume:resume+1])
            self.assertEqual(out[0,1],0,edit)
            self.assertEqual(out[0,2],0,edit)
        p=ready();p.signal()
        p.signal(seconds=.3,heartbeat=False)
        phase,k,resume=catchup_trace(p)
        out=p.run(np.full(len(phase),.1),np.full(len(phase),.15),phase=phase,heartbeat=False)
        self.assertFalse(out[:,1].any())

    def test_quantized_phase_roundoff_is_accepted_but_large_mismatch_is_not(self):
        for error in (0,1e-7,-1e-7,1e-5):
            p=ready();p.signal()
            phase,k,resume=catchup_trace(p)
            phase[resume:]+=error
            out=run_phase(p,phase.astype(np.float32))
            self.assertEqual(at(out[-1],'endpoint_catchups'),int(abs(error)<1e-6))

    def test_real_jump_after_matched_return_cancels_without_claiming_recovery(self):
        p=ready();p.signal()
        phase,k,resume=catchup_trace(p)
        phase[resume+10:]=(phase[resume+10:]+.1)%1
        out=run_phase(p,phase)
        self.assertEqual(at(out[-1],'endpoint_catchups'),1)
        self.assertEqual(at(out[-1],'endpoint_recoveries'),0)
        self.assertEqual(out[resume+10,1],0)

    def test_frequent_elapsed_returns_keep_thirty_seconds_of_acoustic_evidence(self):
        p,c=ready(quality=0),Clarity()
        ref,other=signals(seconds=1)
        # Same 600 ms period throughout: overwrite the first 64 samples at each
        # wrap with 1, then return directly to the unmodified host phase.
        trace=(np.arange(30*p.sr)*100/(60*p.sr))%1
        for k in range(26460,len(trace)-64,26460):
            trace[k:k+64]=1
        for second in range(30):
            phase=trace[second*p.sr:(second+1)*p.sr]
            pre=p.run(other,ref,phase=phase)
            acoustic=c.run(other,ref,permit=pre[:,1],epoch=pre[:,9],offset=pre[:,11])
        self.assertGreater(acoustic[-1,column('current_run_ms')],29000)
        self.assertGreater(acoustic[-1,column('lifetime_windows')],0)
        self.assertGreater(at(pre[-1],'endpoint_catchups'),40)
        self.assertEqual(at(pre[-1],'synclosses'),0)
        self.assertFalse(pre[:,2].any())
        self.assertFalse(acoustic[:,column('voice_confirmed')].any())


if __name__=='__main__':
    unittest.main()
