"""Bounded endpoint pauses; actual Max host behavior still needs native testing."""
import unittest
import numpy as np
from preflight_harness import ready
from test_clock_fault_capture import run_phase, ramp
from test_preflight_diagnostics import at
from clarity_harness import Clarity
from test_assistant_clarity import signals, column


def held_endpoint(p, length, seconds=.9):
    """64 repeats at phase 1, then a normal increment, as in the native capture.

    The report captures the endpoints and length, not the surrounding stream;
    this fixture is a compatible synthetic case, not an audio replay.
    """
    phase = ramp(p, seconds)
    k = round(p.sr * .6) - p.time
    assert k > 1 and k+length+1 < len(phase)
    phase[k:k+length+1] = 1
    phase[k+length+1:] = ((np.arange(len(phase)-k-length-1)+1)*p.bpm/(60*p.sr)) % 1
    return phase, k+1


class EndpointClockTests(unittest.TestCase):
    def test_native_compatible_64_sample_hold_keeps_acoustic_epoch(self):
        for sr in (44100, 48000, 96000):
            p = ready(sr=sr, quality=0)
            before = p.signal()[-1]
            phase, k = held_endpoint(p, 64)
            out = run_phase(p, phase)
            self.assertTrue(np.all(out[:, 1] == 1))
            self.assertTrue(np.all(out[:, 9] == before[9]))
            self.assertFalse(out[:, 2].any())
            self.assertEqual(at(out[-1], 'synclosses'), 0)
            self.assertEqual(at(out[-1], 'periodchanges'), at(before, 'periodchanges'))
            self.assertEqual(at(out[-1], 'last_endpoint_lengthsamples'), 64)
            self.assertEqual(at(out[-1], 'endpoint_hold_episodes'), 1)
            self.assertEqual(at(out[-1], 'endpoint_recoveries'), 1)
            self.assertEqual(at(out[k], 'endpoint_hold_active'), 1)
            self.assertAlmostEqual(at(out[-1], 'last_endpoint_resumeinc'), 100/(60*sr))

    def test_evaluation_is_zero_during_hold_and_ten_ms_clean_recovery(self):
        p = ready()
        p.signal()
        phase, k = held_endpoint(p, 64)
        out = run_phase(p, phase)
        clean = round(p.sr*.01)
        self.assertTrue(np.all(out[k:k+64+clean-1, 2] == 0))
        self.assertTrue(np.all(out[k:k+64+clean-1, 4] == 0))
        self.assertEqual(out[-1, 2], 1)
        np.testing.assert_array_equal(out[:, 3], phase)

    def test_exact_budget_is_accepted_and_next_sample_revokes_context(self):
        for sr in (44100, 48000, 96000):
            budget = int(sr*.002)
            for length in (budget, budget+1):
                p = ready(sr=sr)
                before = p.signal()[-1]
                phase, k = held_endpoint(p, length)
                out = run_phase(p, phase)
                self.assertTrue(np.all(out[k:k+budget, 1] == 1))
                if length == budget:
                    self.assertEqual(at(out[-1], 'synclosses'), 0)
                    self.assertEqual(out[-1, 9], before[9])
                else:
                    self.assertEqual(out[k+budget, 1], 0)
                    self.assertGreater(out[k+budget, 9], before[9])
                    self.assertEqual(at(out[-1], 'synclosses'), 1)
                    self.assertEqual(at(out[-1], 'endpoint_recoveries'), 0)

    def test_freeze_mid_ramp_and_freeze_zero_still_fail_immediately(self):
        for value in (.5, 0):
            p = ready()
            p.signal()
            out = run_phase(p, np.full(100, value))
            self.assertEqual(out[0, 1], 0)
            self.assertFalse(out[:, 2].any())
            self.assertEqual(at(out[-1], 'endpoint_hold_episodes'), 0)

    def test_endpoint_does_not_establish_initial_sync(self):
        p = ready()
        out = run_phase(p, np.ones(200))
        self.assertFalse(out[:, 1].any())
        self.assertFalse(out[:, 2].any())
        self.assertEqual(at(out[-1], 'endpoint_hold_episodes'), 0)

    def test_raw_out_of_range_is_not_accepted_as_endpoint_duplicate(self):
        p = ready()
        p.signal()
        phase, k = held_endpoint(p, 64)
        phase[k:] = 1.001
        out = run_phase(p, phase)
        self.assertEqual(out[k, 1], 0)
        self.assertFalse(out[k:, 2].any())
        self.assertEqual(at(out[-1], 'endpoint_hold_episodes'), 0)

    def test_host_stop_countin_source_change_and_poll_timeout_override_grace(self):
        for edit in ({'playing': 0}, {'countingin': 1}, {'voicebinding': 0}, {'enabled': 0}):
            p = ready()
            p.signal()
            phase, k = held_endpoint(p, 64)
            run_phase(p, phase[:k+1])
            p.set(**edit)
            out = run_phase(p, phase[k+1:k+2])
            self.assertEqual(out[0, 1], 0, edit)
            self.assertEqual(out[0, 2], 0, edit)
        p = ready()
        p.signal()
        p.signal(seconds=.3, heartbeat=False)
        phase, k = held_endpoint(p, 64)
        out = p.run(np.full(len(phase), .1), np.full(len(phase), .15), phase=phase, heartbeat=False)
        self.assertFalse(out[:, 1].any())

    def test_recovery_jump_and_frozen_lower_endpoint_are_rejected(self):
        for nextphase in (.2, .999, 0):
            p = ready()
            p.signal()
            phase, k = held_endpoint(p, 64)
            phase[k+64:] = nextphase
            out = run_phase(p, phase)
            self.assertEqual(out[k+65, 1], 0)
            self.assertFalse(out[k:k+64+round(.01*p.sr), 2].any())
            self.assertEqual(at(out[-1], 'endpoint_recoveries'), 0)

    def test_tempo_change_on_recovery_suspends_timing(self):
        p = ready()
        p.signal()
        phase, k = held_endpoint(p, 64)
        phase[k+64:] = ((np.arange(len(phase)-k-64)+1)*153/(60*p.sr)) % 1
        out = run_phase(p, phase)
        self.assertFalse(out[k:k+64+round(.04*p.sr), 2].any())
        self.assertGreater(at(out[-1], 'periodchanges'), 0)
        self.assertEqual(out[-1, 2], 1)

    def test_frequent_endpoint_duplicates_allow_long_acoustic_accumulation(self):
        p, c = ready(quality=0), Clarity()
        ref, other = signals(seconds=1)
        cycle = np.concatenate((np.arange(26460)*p.bpm/(60*p.sr), np.ones(65)))
        trace = np.tile(cycle, 51)[:30*p.sr]
        # Repeated endpoint pause at EVERY beat, much more frequent than the
        # native report. Stream outputs to avoid keeping a 30 s trace in RAM.
        for second in range(30):
            phase = trace[second*p.sr:(second+1)*p.sr]
            pre = p.run(other, ref, phase=phase)
            acoustic = c.run(other, ref, permit=pre[:, 1], epoch=pre[:, 9], offset=pre[:, 11])
        self.assertGreater(at(pre[-1], 'endpoint_hold_episodes'), 20)
        self.assertGreater(acoustic[-1, column('current_run_ms')], 29000)
        self.assertGreater(acoustic[-1, column('lifetime_windows')], 0)
        self.assertFalse(acoustic[:, column('voice_confirmed')].any())
        self.assertEqual(at(pre[-1], 'clockfaults'), 0)


if __name__ == '__main__':
    unittest.main()
