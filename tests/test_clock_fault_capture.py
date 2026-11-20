"""Synthetic clock fault captures; no claim about native plugphasor behavior."""
import unittest
import numpy as np
from preflight_harness import ready
from test_preflight_diagnostics import at


def ramp(p, seconds):
    return (((np.arange(round(p.sr*seconds)) + p.time) * p.bpm / (60*p.sr)) % 1)


def run_phase(p, phase):
    return p.run(np.full(len(phase), .1), np.full(len(phase), .15), phase=phase)


class ClockFaultCaptureTests(unittest.TestCase):
    def test_repeated_single_sample_is_captured_before_recovery(self):
        for sr in (44100, 48000, 96000):
            p = ready(sr=sr, quality=0)
            p.signal()
            phase = ramp(p, .25)
            k = round(sr*.05)
            phase[k] = phase[k-1]
            out = run_phase(p, phase)
            event, end = out[k], out[-1]
            self.assertEqual(event[1], 0)
            self.assertEqual(at(event, 'lastfaultmask'), 1)
            self.assertEqual(at(event, 'lastfaultinc'), 0)
            self.assertEqual(at(end, 'clockfaults'), 1)
            self.assertEqual(at(end, 'lastfaultlengthsamples'), 1)
            self.assertAlmostEqual(at(end, 'lastfaultprevious'), phase[k-1])
            self.assertAlmostEqual(at(end, 'lastfaultphase'), phase[k])
            self.assertAlmostEqual(at(end, 'lastrecoveryinc'), phase[k+1]-phase[k])
            self.assertAlmostEqual(at(end, 'lastrecoveryms')-at(end, 'lastfaultms'), 1000/sr)
            self.assertAlmostEqual(at(end, 'lastfaultperiodms'), 600, places=6)
            self.assertEqual(at(end, 'lastfaultplaying'), 1)
            self.assertEqual(at(end, 'lastfaultcountingin'), 0)
            self.assertEqual(end[1], 1)
            self.assertFalse(out[:, 2].any())

    def test_backward_fast_and_slow_transitions_are_distinguished(self):
        for kind, expected in (('backward', 2), ('fast', 8), ('slow', 4)):
            p = ready()
            p.signal()
            phase = ramp(p, .25)
            k = 2205
            if kind == 'backward':
                phase[k:] = (phase[k:] - .1) % 1
            elif kind == 'fast':
                phase[k:] = (phase[k:] + .1) % 1
            else:
                phase[k] = phase[k-1]+1e-7
            out = run_phase(p, phase)
            self.assertEqual(at(out[k], 'lastfaultmask'), expected, kind)
            self.assertEqual(out[k, 1], 0)
            self.assertEqual(at(out[-1], 'lastfaultlengthsamples'), 1)
            self.assertEqual(out[-1, 1], 1)

    def test_out_of_range_raw_input_is_retained_without_clamping_away_evidence(self):
        p = ready()
        p.signal()
        phase = ramp(p, .25)
        k = 2205
        phase[k] = 1.1
        out = run_phase(p, phase)
        self.assertTrue(int(at(out[k], 'lastfaultmask')) & 16)
        self.assertEqual(at(out[-1], 'lastfaultphase'), 1.1)
        self.assertEqual(at(out[-1], 'lastfaultlengthsamples'), 2)
        self.assertEqual(at(out[-1], 'clockfaults'), 1)

    def test_duplicate_wrap_endpoint_preserves_acoustics_but_masks_timing(self):
        p = ready()
        phase = ramp(p, .9)
        k = 26460  # exact 600 ms boundary at 100 BPM / 44.1 kHz
        phase[k-1] = 1
        out = run_phase(p, phase)
        self.assertEqual(at(out[-1], 'clockfaults'), 0)
        self.assertEqual(at(out[k], 'endpoint_hold_active'), 1)
        self.assertEqual(out[k, 1], 1)
        self.assertEqual(out[k, 2], 0)
        self.assertEqual(at(out[-1], 'last_endpoint_lengthsamples'), 1)
        self.assertEqual(at(out[-1], 'endpoint_recoveries'), 1)

    def test_hold_duration_excludes_reacquisition_and_survives_recovery(self):
        p = ready()
        p.signal()
        phase = ramp(p, .3)
        k, length = 2205, 64
        # Skip forward after the hold: two distinct adjacent bad ranges can
        # merge; instead continue smoothly from the held phase after it.
        phase[k:] = (phase[k:] - length*p.bpm/(60*p.sr)) % 1
        phase[k:k+length] = phase[k-1]
        out = run_phase(p, phase)
        self.assertEqual(at(out[-1], 'lastfaultlengthsamples'), length)
        self.assertEqual(at(out[-1], 'maxfaultlengthsamples'), length)
        self.assertAlmostEqual(at(out[-1], 'lastrecoveryms')-at(out[-1], 'lastfaultms'), 1000*length/p.sr)
        self.assertEqual(out[-1, 1], 1)
        before = out[-1]
        # Explicit reset does not erase diagnostic history or make it evidence
        # usable for musical evaluation.
        p.set(resetseq=1, quality=0)
        after = run_phase(p, (phase[-1]+(np.arange(100)+1)*p.bpm/(60*p.sr)) % 1)[-1]
        self.assertEqual(at(after, 'lastfaultms'), at(before, 'lastfaultms'))
        self.assertEqual(after[2], 0)

    def test_expected_transport_stop_retains_host_state_and_open_hold(self):
        p = ready()
        p.signal()
        p.set(playing=0)
        out = run_phase(p, np.zeros(4410))
        self.assertEqual(at(out[-1], 'lastfaultplaying'), 0)
        self.assertEqual(at(out[-1], 'lastfaultlengthsamples'), 4410)
        self.assertEqual(at(out[-1], 'lastrecoveryms'), 0)
        self.assertFalse(out[:, 1].any())

    def test_invalid_window_period_can_lose_sync_without_an_invalid_increment(self):
        p = ready()
        p.signal(seconds=.2)
        base = ((p.time-1)*p.bpm/(60*p.sr)) % 1
        phase = (base+(np.arange(round(.1*p.sr))+1)*19.7/(60*p.sr)) % 1
        out = run_phase(p, phase)
        self.assertEqual(at(out[-1], 'lastfaultmask'), 64)
        self.assertEqual(at(out[-1], 'lastfaultlengthsamples'), 0)
        self.assertEqual(at(out[-1], 'lastrecoveryms'), 0)
        self.assertEqual(out[-1, 1], 0)

    def test_long_quantized_ideal_clock_does_not_create_anomalies(self):
        for bpm in (20, 100, 153, 400):
            p = ready(quality=0)
            p.bpm = bpm
            # Chunked 20 second playback, with ordinary wraps, without retaining
            # an unnecessarily large 45-column output for the whole interval.
            for _ in range(20):
                phase = ramp(p, 1).astype(np.float32)
                row = run_phase(p, phase)[-1]
                self.assertEqual(at(row, 'clockfaults'), 0)
                self.assertEqual(at(row, 'synclosses'), 0)
                self.assertEqual(row[1], 1)
                self.assertEqual(row[2], 0)


if __name__ == '__main__':
    unittest.main()
