"""Captured boundary roundoff in synthetic arithmetic, not a native Live test."""
import unittest
import numpy as np
from preflight_harness import ready
from test_clock_fault_capture import run_phase
from test_endpoint_catchup import catchup_trace
from test_preflight_diagnostics import at
from clarity_harness import Clarity
from test_assistant_clarity import signals, column


class PhaseRoundoffTests(unittest.TestCase):
    def test_captured_upper_boundary_preserves_context_and_recovers(self):
        p = ready(); before = p.signal()[-1]
        phase, start, resume = catchup_trace(p)
        phase[start-2] = 0.9999622071050713
        phase[start-1:resume] = 1.000000000000007
        out = run_phase(p, phase)
        self.assertTrue(np.all(out[:, 1] == 1))
        self.assertTrue(np.all(out[:, 9] == before[9]))
        self.assertEqual(at(out[-1], 'clockfaults'), 0)
        self.assertEqual(at(out[-1], 'endpoint_catchups'), 1)
        self.assertEqual(at(out[-1], 'endpoint_recoveries'), 1)
        self.assertFalse(out[start:resume+441, 2].any())
        self.assertEqual(out[resume+441, 2], 1)
        self.assertTrue(np.all(out[start-1:resume, 3] == 1))

    def test_0217_captured_endpoint_just_below_one_preserves_probe_context(self):
        p = ready()
        before = p.signal()[-1]
        period_step = p.bpm / (60 * p.sr)
        phase, start, resume = catchup_trace(p, length=64)
        phase[start-1:resume] = 0.999999999999801
        # The report shows an ordinary first increment after the repeated phase.
        phase[resume:] = (np.arange(1, len(phase)-resume+1) * period_step) % 1
        out = run_phase(p, phase)
        self.assertTrue(np.all(out[:, 1] == 1))
        self.assertTrue(np.all(out[:, 9] == before[9]))
        self.assertEqual(at(out[-1], 'clockfaults'), 0)
        self.assertEqual(at(out[-1], 'last_endpoint_lengthsamples'), 64)
        self.assertEqual(at(out[-1], 'endpoint_recoveries'), 1)
        self.assertFalse(out[start:resume+440, 2].any())

    def test_duplicate_below_endpoint_budget_remains_a_clock_fault(self):
        p = ready()
        p.signal()
        phase, start, resume = catchup_trace(p, length=64)
        phase[start-1:resume] = 1 - 2e-12
        out = run_phase(p, phase)
        self.assertEqual(out[start, 1], 0)
        self.assertEqual(at(out[-1], 'lastfaultmask'), 1)
        self.assertEqual(at(out[-1], 'endpoint_hold_episodes'), 0)
        self.assertEqual(at(out[-1], 'lastfaultphase'), 1 - 2e-12)

    def test_inside_budget_roundoff_across_rates_tempos_and_hold_lengths(self):
        for sr in (44100, 48000, 96000):
            for bpm in (60, 100, 153, 400):
                for length in (1, 63, int(sr*.002)):
                    with self.subTest(sr=sr, bpm=bpm, length=length):
                        p = ready(sr=sr); p.bpm = bpm; p.signal()
                        phase, start, resume = catchup_trace(p, length)
                        phase[start-1:resume] += 5e-13
                        out = run_phase(p, phase)
                        self.assertEqual(at(out[-1], 'synclosses'), 0)
                        self.assertEqual(at(out[-1], 'endpoint_recoveries'), 1)
                        self.assertAlmostEqual(at(out[-1], 'periodms'), 60000/bpm, places=6)

    def test_small_negative_wrap_alias_uses_same_bounded_normalization(self):
        p = ready(); p.signal()
        phase, start, resume = catchup_trace(p, length=1)
        phase[start] = -5e-13
        # The existing zero-alias contract resumes at the ordinary next step.
        phase[resume:] -= p.bpm/(60*p.sr)
        out = run_phase(p, phase)
        self.assertEqual(at(out[-1], 'clockfaults'), 0)
        self.assertEqual(at(out[-1], 'endpoint_recoveries'), 1)
        self.assertEqual(out[start, 3], 0)
        self.assertEqual(out[start, 2], 0)

    def test_outside_budget_is_rejected_and_raw_value_is_retained(self):
        for value in (1+2e-12, -2e-12, 1.000001, -.000001, 1.1):
            with self.subTest(value=value):
                p = ready(); p.signal()
                phase, start, resume = catchup_trace(p)
                phase[start-1] = value
                out = run_phase(p, phase)
                self.assertEqual(out[start-1, 1], 0)
                self.assertEqual(out[start-1, 2], 0)
                self.assertTrue(int(at(out[start-1], 'lastfaultmask')) & 16)
                self.assertEqual(at(out[start-1], 'lastfaultphase'), value)

    def test_roundoff_does_not_hide_overlong_hold_or_wrong_return(self):
        for length, error in ((89, 0), (63, 1), (63, -1)):
            p = ready(); p.signal()
            phase, start, resume = catchup_trace(p, length, error)
            phase[start-1:resume] = 1.000000000000007
            out = run_phase(p, phase)
            self.assertEqual(at(out[-1], 'clockfaults'), 1)
            self.assertEqual(at(out[-1], 'endpoint_catchups'), 0)
            self.assertEqual(out[resume, 2], 0)

    def test_frozen_zero_and_midpoint_are_not_tolerated_as_roundoff(self):
        for value in (-5e-13, 0., .5):
            p = ready(); p.signal()
            out = run_phase(p, np.full(1000, value))
            self.assertEqual(out[-1, 1], 0)
            self.assertFalse(out[:, 2].any())
            self.assertEqual(at(out[-1], 'endpoint_hold_episodes'), 0)
            self.assertGreater(at(out[-1], 'clockfaults'), 0)

    def test_no_startup_lock_or_host_override_from_rounded_endpoint(self):
        p = ready()
        out = run_phase(p, np.full(1000, 1.000000000000007))
        self.assertFalse(out[:, 1].any())
        self.assertFalse(out[:, 2].any())
        for edit in ({'playing': 0}, {'countingin': 1}, {'voicebinding': 0}):
            p = ready(); p.signal()
            phase, start, resume = catchup_trace(p)
            phase[start-1:resume] = 1.000000000000007
            run_phase(p, phase[:start]); p.set(**edit)
            out = run_phase(p, phase[start:])
            self.assertFalse(out[:, 1].any())
            self.assertFalse(out[:, 2].any())

    def test_repeated_roundoff_holds_keep_thirty_seconds_of_acoustic_context(self):
        p, c = ready(quality=0), Clarity()
        ref, other = signals(seconds=1)
        trace = (np.arange(30*p.sr)*100/(60*p.sr)) % 1
        for k in range(26460, len(trace)-64, 26460):
            trace[k:k+64] = 1.000000000000007
        for second in range(30):
            pre = p.run(other, ref, phase=trace[second*p.sr:(second+1)*p.sr])
            acoustic = c.run(other, ref, permit=pre[:, 1], epoch=pre[:, 9], offset=pre[:, 11])
        self.assertGreater(acoustic[-1, column('current_run_ms')], 29000)
        self.assertGreater(at(pre[-1], 'endpoint_catchups'), 40)
        self.assertEqual(at(pre[-1], 'synclosses'), 0)
        self.assertFalse(pre[:, 2].any())
        self.assertFalse(acoustic[:, column('voice_confirmed')].any())


if __name__ == '__main__':
    unittest.main()
