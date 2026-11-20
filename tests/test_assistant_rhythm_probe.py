"""Clock alignment, reference matching and frozen results for the rhythm probe."""
import unittest

import numpy as np

from assistant_clarity import RHYTHM_CAPTURE_SOURCE, RHYTHM_RESULTS_SOURCE, RHYTHM_TEST_MARGIN_MS
from gen_harness import Engine, compile_harness, load_library
from test_assistant_bleed_probe import GuidedProbe, SR, result
from test_assistant_reference_timing import ReferenceTiming


class RhythmCapture(Engine):
    params = compile_harness(RHYTHM_CAPTURE_SOURCE, 'rhythm_capture_harness', inputs=17, outputs=12)
    lib = load_library('rhythm_capture_harness', inputs=17)
    output_count = 12


class RhythmResults(Engine):
    params = compile_harness(RHYTHM_RESULTS_SOURCE, 'rhythm_results_harness', inputs=10, outputs=26)
    lib = load_library('rhythm_results_harness', inputs=10)
    output_count = 26


def run_capture(rate, performance, *, period=600, jump=0, detector_state=2, compensation=90, clipped=(),
                second_cue_delay=0, mic_pause=None, ref_pause=False):
    clock = np.arange(10 * rate)
    when_ms = clock * 1000 / rate
    stage = np.select([when_ms < 100, when_ms < 300, when_ms < 8300, when_ms < 8500],
                      [1, 2, 3, 4], default=5)
    phase = (when_ms / period + jump * (when_ms > 2800)) % 1
    event = np.zeros_like(when_ms)
    possible = np.zeros_like(when_ms)
    onset = np.zeros_like(when_ms)
    for compensated_ms in performance:
        # Clock anchor is at 600 ms of this test. Confirm 15 ms after onset.
        raw_ms = compensated_ms + 600 + compensation
        sample = round((raw_ms + 15) * rate / 1000)
        event[sample] = 1
        onset[sample] = raw_ms
    for compensated_ms in clipped:
        raw_ms = compensated_ms + 600 + compensation
        sample = round((raw_ms + 8) * rate / 1000)
        possible[sample] = 1
        onset[sample] = raw_ms
    pause = np.zeros_like(when_ms, dtype=bool) if mic_pause is None else (
        (when_ms >= mic_pause[0]) & (when_ms < mic_pause[1]))
    capture = RhythmCapture(sr=rate, secondcuedelayms=second_cue_delay).run(
                    left=stage, right=np.full(len(clock), 2), phase=phase,
                    extra=(period, 1, (possible == 0) & ~pause, clock, event, onset, compensation,
                           detector_state, possible, onset, compensation, pause, 1, pause * (3 if ref_pause else 1)))
    status = ReferenceTiming(sr=rate).compare(capture[:, 2], capture[:, 3],
        event=capture[:, 1], error=RHYTHM_TEST_MARGIN_MS, context=capture[:, 5],
        unique=capture[:, 6], recording=0)
    log = RhythmResults(sr=rate).run(left=capture[:, 0], right=stage, phase=np.full(len(clock), 2),
                          extra=(capture[:, 1], capture[:, 4], status[:, 0], status[:, 1], capture[:, 8],
                                 capture[:, 9], capture[:, 10]))
    return capture, status, log


class RhythmProbeTests(unittest.TestCase):
    def test_rhythm_mode_preserves_the_quiet_interval_and_leaves_prompt_to_reference(self):
        silence = np.zeros(36 * SR)
        rows = GuidedProbe(sr=SR, rhythmrequest=1).run_probe(silence, silence)
        self.assertEqual(result(rows[-1])['phrase_mode'], 2)
        self.assertEqual(result(rows[-1])['speech_window_ms'], 8000)
        self.assertEqual(result(rows[-1])['stage'], 5)
        self.assertEqual(np.sum(rows[:, 0] == 2), 5 * SR)
        self.assertEqual(np.sum(rows[:, 0] == 3), 8 * SR)
        self.assertFalse(rows[:, -1].any())

    def test_alternating_on_and_between_beats_uses_compensated_onset_not_confirmation(self):
        for rate in (44100, 48000):
            with self.subTest(rate=rate):
                capture, status, log = run_capture(rate, [1800, 3315, 4980, 6180])
                np.testing.assert_array_equal(log[-1, :10], [5, 0, 1, 1, 1, 1, 2, 2, 4, 1])
                np.testing.assert_allclose(log[-1, 10:15], [0, 15, 180, -120, 300], atol=.03)
                np.testing.assert_array_equal(log[-1, 24:], [4, 0])
                self.assertFalse(status[:, 2].any())
                self.assertTrue({5, 6, 7, 8} <= set(capture[:, 7]))

    def test_duplicate_missing_and_unassigned_attacks_are_reported_explicitly(self):
        _, _, log = run_capture(44100, [1790, 1840, 2550, 3300, 6300])
        np.testing.assert_array_equal(log[-1, :10], [5, 1, 2, 1, 0, 1, 1, 2, 0, 2])
        self.assertEqual(log[-1, 24], 2)

    def test_unstable_tempo_lost_phase_or_invalid_detector_disables_results(self):
        for settings in ({'period': 610}, {'jump': .25}, {'detector_state': 3}):
            with self.subTest(settings=settings):
                _, _, log = run_capture(44100, [1800, 3300, 4800, 6300], **settings)
                np.testing.assert_array_equal(log[-1], [6] + [0] * 23 + [-1, 0])

    def test_countdown_uses_same_anchor_as_the_reference_and_last_slot_accepts_high_latency(self):
        rate = 44100
        capture, _, log = run_capture(rate, [1800, 3300, 4800, 6530], compensation=500)
        for i, target in enumerate([1800, 3300, 4800, 6300]):
            for advance, cue in zip([725, 450, 150, 0], [12+3*i, 13+3*i, 14+3*i, 5+i]):
                sample = round((600 + target - advance) * rate / 1000)
                self.assertEqual(capture[sample, 7], cue)
        np.testing.assert_array_equal(log[-1, 2:10], [1, 1, 1, 1, 2, 2, 2, 4])
        self.assertAlmostEqual(log[-1, 13], 230)

    def test_all_four_clock_cues_leave_the_detection_count_at_zero_without_attacks(self):
        capture, _, log = run_capture(44100, [])
        self.assertTrue({5, 6, 7, 8} <= set(capture[:, 7]))
        self.assertFalse(log[:, 24].any())
        self.assertEqual(log[-1, 0], 5)

    def test_clipped_candidates_do_not_count_as_confirmed_or_produce_a_verdict(self):
        capture, review, log = run_capture(44100, [4800], clipped=[2000, 2550])
        candidates = capture[:, 9] == 1
        self.assertFalse(review[candidates, 0].any())
        self.assertFalse(review[:, 2].any())
        np.testing.assert_array_equal(log[-1, 2:10], [0, 0, 1, 0, 0, 0, 2, 0])
        np.testing.assert_allclose(log[-1, 15:24], [1, 1, 0, 0, 0, 200, 0, 0, 0], atol=.03)
        np.testing.assert_array_equal(log[-1, 24:], [1, 1])
