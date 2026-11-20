"""Timing, classification and export of the three requested speech-test intervals."""
import math
import unittest

import numpy as np

from assistant_clarity import GUIDED_CUES, GUIDED_INTERVALS, GUIDED_RESULT_FIELDS, OUTPUTS
from test_assistant_clarity import ClarityGraph, column, signals
from test_background_capture import stream
from test_background_comparison import tone
from test_signal_test_phases import BANDS, first_phase


GUIDED_COLUMNS = [column(name) for name in GUIDED_RESULT_FIELDS]
CUE = column('guided_cue')


def guided_probe(loud_windows):
    engine, baseline, muted, start = first_phase()
    sr = engine.sr
    engine.set(speakersrequest=1)
    row = engine.run(tone(sr, 1, start), np.zeros(1))[0]
    start += 1
    assert row[CUE] == 1
    gate = int(row[column('test_audible_gate_sampleclock')])
    anchor = int(muted[column('test_muted_end_sampleclock')]) + 1
    window = round(muted[column('background_comparison_duration_ms')] * sr / 1000)
    first = anchor + math.ceil(max(0, gate-anchor) / window) * window
    setup_samples = first - 1 - int(row[column('sampleclock')])
    reference, distinct = signals(sr, seconds=22)
    quiet = tone(sr, setup_samples, start)
    stream(engine, quiet, reference[:setup_samples])
    start += setup_samples

    rows = []
    for i in range(1, 21):
        begin = setup_samples + (i-1)*window
        end = begin + window
        mic = .6*distinct[begin:end] if i in loud_windows else tone(sr, window, start)
        rows.append(stream(engine, mic, reference[begin:end]))
        start += window
    return engine, baseline, np.stack(rows)


class GuidedSignalProbeTests(unittest.TestCase):
    def test_cues_follow_sample_clock_and_summary_matches_each_observation(self):
        engine, baseline, rows = guided_probe(range(6, 14))
        np.testing.assert_array_equal(rows[:, CUE], [1]*4 + [2]*8 + [3]*7 + [4])
        self.assertFalse(rows[:-1, GUIDED_COLUMNS].any())
        final = rows[-1]
        self.assertEqual(final[column('completed_guided_available')], 1)
        self.assertFalse(rows[:, column('voice_confirmed')].any())
        groups = {'quiet_before': rows[1:5], 'speech_prompt': rows[7:13], 'quiet_after': rows[15:20]}
        for interval, observations in groups.items():
            prefix = 'completed_guided_'+interval+'_'
            codes = observations[:, column('joint_band_codes')].astype(int)
            self.assertEqual(final[column(prefix+'observations')], GUIDED_INTERVALS[interval])
            self.assertEqual(final[column(prefix+'skipped')], 0)
            for i, band in enumerate(BANDS):
                categories = codes // (8**i) % 8
                self.assertEqual(final[column(prefix+'persistent_'+band)], (categories >= 3).sum())
                self.assertEqual(final[column(prefix+'low_match_'+band)], (categories == 4).sum())
                self.assertEqual(final[column(prefix+'persistent_'+band)], 6 if interval == 'speech_prompt' else 0)
                threshold = final[column('completed_result_background_limit_'+band)]
                self.assertAlmostEqual(threshold, baseline[column('background_limit_'+band)], places=15)
                np.testing.assert_allclose(observations[:, column('background_limit_'+band)],
                                           threshold, rtol=0, atol=1e-15)
        self.assertGreater(final[column('completed_guided_speech_prompt_low_match_high')], 0)

        stopped = engine.run(np.zeros(1), np.zeros(1), permit=0)[0]
        np.testing.assert_array_equal(final[GUIDED_COLUMNS], stopped[GUIDED_COLUMNS])
        self.assertEqual(stopped[CUE], 4)
        engine.set(backgroundrequest=2)
        restarted = engine.run(np.zeros(1), np.zeros(1))[0]
        self.assertFalse(restarted[GUIDED_COLUMNS].any())
        self.assertEqual(restarted[CUE], 0)

    def test_loud_transitions_are_only_in_the_overall_phase(self):
        _, _, rows = guided_probe({1, 6, 7, 14, 15})
        final = rows[-1]
        self.assertGreater(final[column('completed_result_audible_above_windows_high')], 0)
        for interval in GUIDED_INTERVALS:
            for band in BANDS:
                self.assertEqual(final[column('completed_guided_'+interval+'_persistent_'+band)], 0)

    def test_stopping_before_completion_publishes_no_interval_statistics(self):
        engine, _, _, _ = first_phase()
        engine.set(speakersrequest=1)
        sr = engine.sr
        ref, mic = signals(sr, seconds=12)
        row = stream(engine, mic, ref)
        self.assertEqual(row[CUE], 2)
        stopped = engine.run(np.zeros(1), np.zeros(1), permit=0)[0]
        self.assertEqual(stopped[CUE], 0)
        self.assertFalse(stopped[GUIDED_COLUMNS].any())

    def test_live_cues_and_frozen_export_validate_all_interval_counts(self):
        engine, _, rows = guided_probe(range(6, 14))
        graph = ClarityGraph().initialized()
        for code, label in GUIDED_CUES.items():
            graph.state['root/aq-guided_cue']['signal_sample'] = code
            graph.send('root/aq-poll')
            self.assertEqual(' '.join(graph.state['root/asrc-popup/aq-guided-cue']['label']), label)

        stopped = engine.run(np.zeros(1), np.zeros(1), permit=0)[0]
        for name in OUTPUTS:
            graph.state['root/aq-'+name]['signal_sample'] = stopped[column(name)]
        graph.send('root/asrc-popup/export', (1,))
        frozen = dict(graph.state['root/aq-export-dict']['data'])
        for name in GUIDED_RESULT_FIELDS:
            self.assertEqual(frozen['clarity_'+name], (stopped[column(name)],))
        valid_key = 'clarity_completed_guided_export_valid'
        self.assertEqual(frozen[valid_key], (1,))
        self.assertEqual(frozen['clarity_completed_result_export_valid'], (1,))
        self.assertEqual(frozen['clarity_completed_guided_quiet_after_observations'], (5,))
        graph.state['root/aq-completed_guided_quiet_after_observations']['signal_sample'] = 0
        self.assertEqual(graph.state['root/aq-export-dict']['data'], frozen)
        graph.send('root/asrc-popup/export', (1,))
        self.assertEqual(graph.state['root/aq-export-dict']['data'][valid_key], (0,))
        self.assertFalse(graph.calls)
