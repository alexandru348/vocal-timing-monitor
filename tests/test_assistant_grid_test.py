"""The internal grid check has an independent sample-clock stimulus."""
import unittest

import numpy as np

from assistant_clarity import RHYTHM_TEST_MARGIN_MS, TIMING_GRID_TEST_SOURCE, TIMING_GRID_TEST_RESULTS_SOURCE
from gen_harness import Engine, compile_harness, load_library
from genexpr_scope import validate_scope
from test_assistant_grid import project
from test_assistant_timing_bands import AttackLog, BandLevels, EnergyAttacks


class Stimulus(Engine):
    params = compile_harness(TIMING_GRID_TEST_SOURCE, 'assistant_grid_test_harness',
                             inputs=5, outputs=5)
    lib = load_library('assistant_grid_test_harness', inputs=5)
    output_count = 5

    def send_clock(self, phase, *, period=600, synced=1, ready=1):
        clock = self.time + np.arange(len(phase))
        return self.run(left=phase, right=np.broadcast_to(period, phase.shape),
                        phase=np.broadcast_to(synced, phase.shape), extra=(ready, clock))


class GridTestResults(Engine):
    validate_scope(TIMING_GRID_TEST_RESULTS_SOURCE.read_text(), inputs=5, outputs=10)
    params = compile_harness(TIMING_GRID_TEST_RESULTS_SOURCE, 'assistant_grid_test_results_harness',
                             inputs=5, outputs=10)
    lib = load_library('assistant_grid_test_results_harness', inputs=5)
    output_count = 10

    def evaluate(self, stage, event, review):
        return self.run(left=stage, right=event, phase=review[:, 0], extra=(review[:, 1], review[:, 2]))


class InternalGridTests(unittest.TestCase):
    def test_six_known_onsets_through_the_phrase_detector_and_projection(self):
        from test_assistant_reference_timing import ReferenceTiming

        expected = [-150, 0, 150, -150, 0, 150]
        for rate in (44100, 48000):
            with self.subTest(rate=rate):
                clock = np.arange(7 * rate)
                phase = ((clock + 131) % int(.6 * rate)) / (.6 * rate)
                # Live may need time to recover from duplicate endpoint samples.
                ready = phase >= .020
                stage, clock_error, audio, emitted, emission_clock = Stimulus(
                    sr=rate, request=1).send_clock(phase, ready=ready).T
                onsets = np.flatnonzero((audio != 0) & np.r_[True, audio[:-1] == 0])
                anchor = np.flatnonzero(stage == 2)[0]
                origin = anchor - round(phase[anchor] * .6 * rate)
                known_onsets = origin + np.rint((np.arange(3, 9) * .6 +
                                                np.array(expected) / 1000 + .09) * rate)
                np.testing.assert_array_equal(onsets, known_onsets)
                np.testing.assert_array_equal(np.flatnonzero(emitted), onsets)
                self.assertEqual(stage[-1], 5)
                self.assertLess(clock_error[-1], .001)
                source_grid = project(phase, period=600, offset=90, event=emitted)
                source_log = AttackLog(sr=rate).capture(source_grid, onsets_ms=emission_clock,
                    clock=clock, stage=stage, baseline_state=2)
                self.assertEqual(tuple(source_log[-1, :2]), (6, 0))
                np.testing.assert_allclose(source_log[-1, 2:8], [490, 1240, 1990, 2290, 3040, 3790],
                                           atol=1000/rate, rtol=0)
                np.testing.assert_allclose(source_log[-1, 14:20], expected, atol=.001, rtol=0)

                silence = np.zeros_like(audio)
                bands = BandLevels(sr=rate).measure((audio, silence), (silence, silence))
                attacks = EnergyAttacks(sr=rate).run(left=stage, right=np.ones_like(audio),
                    phase=np.ones_like(audio), extra=(bands[:, :3].sum(axis=1), bands[:, 6],
                                                     .02, 2, phase, 600, 90, clock, 0, 0, 0))
                self.assertEqual(attacks[-1, 0], 2)
                self.assertEqual(attacks[-1, 2], 0)
                timing = project(attacks[:, 12], period=attacks[:, 13], offset=attacks[:, 14],
                                 event=attacks[:, 11], context=ready)
                log = AttackLog(sr=rate).capture(timing, onsets_ms=attacks[:, 15],
                    clock=clock, stage=stage, baseline_state=attacks[:, 0])
                self.assertEqual(tuple(log[-1, :2]), (6, 0))
                np.testing.assert_allclose(log[-1, 14:20], expected, atol=5.1, rtol=0)
                self.assertTrue(np.all(np.diff(log[-1, 2:8]) > 0))

                event = timing[:, 0]
                review = ReferenceTiming(sr=rate).compare(np.zeros_like(phase), timing[:, 1],
                    error=RHYTHM_TEST_MARGIN_MS, context=event, unique=event, recording=1, event=event)
                result = GridTestResults(sr=rate).evaluate(stage, event, review)[-1]
                np.testing.assert_array_equal(result[[0, 1, 3]], [5, 6, 1])
                self.assertLessEqual(result[2], 5.1)
                np.testing.assert_array_equal(result[4:], [3, 2, 4, 3, 2, 4])

    def test_reports_missing_pulses_wrong_verdicts_inaccurate_offsets_and_false_stop(self):
        review = np.array([[3, -150, 1], [2, 0, 0], [4, 150, 1]] * 2)
        modifications = ((2, 0, 1), (3, 1, -140), (4, 2, 1))
        cases = [review[:-1]]
        for event, field, value in modifications:
            changed = review.copy()
            changed[event, field] = value
            cases.append(changed)
        for events in cases:
            stage = np.r_[1, 2, np.full(len(events), 3), 5]
            event = (stage == 3).astype(float)
            rows = np.vstack((np.zeros((2, 3)), events, np.zeros((1, 3))))
            result = GridTestResults().evaluate(stage, event, rows)[-1]
            self.assertEqual(result[0], 7)

    def test_incompatible_tempo_and_transport_jump_invalidates_run(self):
        rate = 44100
        clock = np.arange(7 * rate)
        phase = clock / (.6 * rate) % 1
        for observed_phase, period in ((phase, 599),
                                       ((phase + .25 * (clock >= 2 * rate)) % 1, 600)):
            with self.subTest(period=period):
                stage, _, audio, emitted, _ = Stimulus(sr=rate, request=1).send_clock(
                    observed_phase, period=period).T
                self.assertEqual(stage[-1], 6)
                self.assertFalse(np.any(stage == 5))
                self.assertFalse(np.any(audio[stage == 6]))
                self.assertFalse(np.any(emitted[stage == 6]))
