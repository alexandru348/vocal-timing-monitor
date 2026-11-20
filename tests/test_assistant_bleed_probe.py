import unittest

import numpy as np

from assistant_clarity import TIMING_GUIDED_FIELDS, TIMING_SPEECH_CUE_FIELDS, TIMING_SPEECH_CUE_SOURCE
from gen_harness import Engine, ROOT, compile_harness, load_library
from genexpr_scope import validate_scope


SOURCE = ROOT / 'src/vtm_assistant_bleed_probe.genexpr'
WIDTH = len(TIMING_GUIDED_FIELDS) + 2
validate_scope(SOURCE.read_text(), inputs=12, outputs=WIDTH)
PARAMS = compile_harness(SOURCE, 'assistant_bleed_probe_harness', inputs=12, outputs=WIDTH)
CUE_WIDTH = 4 * len(TIMING_SPEECH_CUE_FIELDS)
validate_scope(TIMING_SPEECH_CUE_SOURCE.read_text(), inputs=8, outputs=CUE_WIDTH)
CUE_PARAMS = compile_harness(TIMING_SPEECH_CUE_SOURCE, 'assistant_speech_cues_harness', inputs=8, outputs=CUE_WIDTH)
SR = 8000


class GuidedProbe(Engine):
    lib = load_library('assistant_bleed_probe_harness', inputs=12)
    params = PARAMS
    output_count = WIDTH

    def run_probe(self, mic, ref, *, permit=1, offset=91.8, candidates=0,
                  measured=0, rejected=0, uncertain=0, compared=0, similarity=0):
        return self.run(left=mic, right=mic, phase=ref, extra=(
            ref, permit, offset, candidates, measured, rejected, uncertain, compared, similarity))


class SpeechCues(Engine):
    lib = load_library('assistant_speech_cues_harness', inputs=8)
    params = CUE_PARAMS
    output_count = CUE_WIDTH


def impulse_counts(entries, n):
    increments = np.zeros(n)
    increments[np.rint(np.asarray(entries)*SR).astype(int)] = 1
    return increments, np.cumsum(increments)


def result(row):
    return dict(zip(TIMING_GUIDED_FIELDS, row))


class GuidedTimingProbeTests(unittest.TestCase):
    def test_four_cues_use_the_same_clock_as_the_per_cue_report(self):
        n = 30 * SR
        silence = np.zeros(n)
        permit = np.ones(n)
        permit[9*SR:9*SR+SR//4] = 0
        clip_pause = np.zeros(n)
        clip_pause[9*SR:9*SR+SR//50] = 1
        probe = GuidedProbe(sr=SR, proberequest=1).run_probe(silence, silence, permit=permit)
        stage, cue = probe[:, 0], probe[:, -2]
        self.assertEqual(probe[-1, 0], 5)
        np.testing.assert_array_equal(cue, probe[:, -1])
        self.assertEqual(list(cue[stage != 3].nonzero()[0]), [])
        np.testing.assert_array_equal(cue[stage == 3], np.repeat([1, 2, 3, 4], 5*SR//4))

        frame, candidate, above, level = [np.zeros(n) for _ in range(4)]
        for index, (seconds, peak) in enumerate(zip((6.5, 7.5, 8.75, 10.5), (.06, .12, .09, .04))):
            at = round(seconds*SR)
            frame[at], level[at] = 1, peak
            frame[at+10], level[at+10] = 1, peak/2
            candidate[at+10] = index != 2
            above[at+10] = index == 1
        model = SpeechCues(sr=SR)
        measured = model.run(left=stage, right=cue, phase=permit, extra=(level, frame, candidate, above, clip_pause))
        np.testing.assert_allclose(measured[-1].reshape(-1, 4), [
            [1250, 1250, 1000, 1250], [.06, .12, .09, .04], [1, 1, 0, 1],
            [.03, .06, 0, .02], [0, 1, 0, 0], [0, 0, 20, 0],
        ])
        reset = model.run(left=np.ones(1), right=0, phase=1, extra=(0, 0, 0, 0, 0))
        np.testing.assert_array_equal(reset[-1], np.zeros(CUE_WIDTH))

    def test_phrase_has_one_prompt_and_keeps_four_reporting_windows(self):
        probe = GuidedProbe(sr=SR, phraserequest=1)
        intro = np.zeros(3*SR)
        probe.run_probe(intro, intro)
        # A click on the other button must not change a running probe.
        probe.set(proberequest=1)
        remainder = np.zeros(34*SR)
        capture = probe.run_probe(remainder, remainder)
        speaking = capture[capture[:, 0] == 3]
        np.testing.assert_array_equal(speaking[:, -2], np.repeat([1, 2, 3, 4], 3*SR))
        self.assertTrue(np.all(speaking[:, -1] == 5))
        self.assertEqual(result(capture[-1])['phrase_mode'], 1)
        self.assertEqual(result(capture[-1])['speech_window_ms'], 12000)
        self.assertEqual(result(capture[-1])['beat_valid_ms'], 5000)
        self.assertEqual(result(capture[-1])['stage'], 5)
        probe.set(proberequest=2)
        after = result(probe.run_probe(intro[:1], intro[:1])[-1])
        self.assertEqual(after['phrase_mode'], 0)
        self.assertEqual(after['speech_window_ms'], 5000)
        self.assertEqual(after['stage'], 1)

    def test_acoustic_offset_is_measured_independently_and_evidence_survives_stop(self):
        n = 12 * SR
        ref = np.zeros(n)
        rng = np.random.default_rng(42)
        for pos, length in ((1.38, .08), (2.14, .14), (2.62, .09), (3.27, .2), (4.72, .17), (5.23, .06)):
            count = round(length * SR)
            at = round(pos * SR)
            ref[at:at+count] = .13*rng.uniform(-1, 1, count)*np.exp(-np.arange(count)/count)
        for delay in (-.125, .155):
            with self.subTest(delay=delay):
                mic = .22 * np.roll(ref, round(delay*SR))
                probe = GuidedProbe(sr=SR, proberequest=1)
                pulse, candidates = impulse_counts((1.8, 3.5, 6.8, 7.0, 9.1), n)
                _, measured = impulse_counts((3.5, 6.8, 7.0, 9.1), n)
                _, rejected = impulse_counts((1.8,), n)
                capture = probe.run_probe(mic, ref, candidates=candidates, measured=measured,
                                          rejected=rejected, compared=pulse,
                                          similarity=np.where(np.arange(n) < 6*SR, .8, .3))
                self.assertEqual(capture[-1, 0], 4)
                silence = np.zeros(18*SR)
                finished = probe.run_probe(silence, silence, permit=0,
                                           candidates=20, measured=14, rejected=6)
                final = result(finished[-1])
                self.assertEqual(final['stage'], 5)
                self.assertEqual(final['calibrated_offset_ms'], 91.8)
                self.assertAlmostEqual(final['acoustic_lag_ms'], 1000*delay)
                self.assertGreater(final['envelope_match'], .99)
                self.assertLess(final['envelope_alternative'], .8)
                self.assertLess(final['envelope_at_calibrated_offset'], .8)
                self.assertEqual(final['alignment_pairs'], 840)
                self.assertGreater(final['beat_mic_level'], 0)
                self.assertGreater(final['beat_reference_level'], final['beat_mic_level'])
                self.assertEqual((final['beat_candidates'], final['speech_candidates']), (2, 3))
                self.assertEqual((final['beat_measured'], final['speech_measured']), (1, 3))
                self.assertEqual((final['beat_reference_rejected'], final['speech_reference_rejected']), (1, 0))
                self.assertAlmostEqual(final['beat_mean_waveform_match'], .8)
                self.assertAlmostEqual(final['speech_mean_waveform_match'], .3)
                self.assertEqual((final['beat_valid_ms'], final['speech_valid_ms']), (5000, 5000))
                again = probe.run_probe(silence[:64], silence[:64], permit=0, candidates=25)
                np.testing.assert_array_equal(finished[-1], again[-1])

    def test_reference_silence_has_no_inferred_acoustic_offset(self):
        silence = np.zeros(30*SR)
        probe = GuidedProbe(sr=SR, proberequest=1)
        final = result(probe.run_probe(silence, silence)[-1])
        self.assertEqual(final['stage'], 5)
        self.assertEqual(final['alignment_pairs'], 0)
        self.assertEqual(final['envelope_match'], 0)

    def test_short_permit_gap_is_excluded_but_can_finish_capture(self):
        samples = np.zeros(12*SR)
        permit = np.ones(len(samples))
        permit[3*SR:3*SR+SR//4] = 0
        probe = GuidedProbe(sr=SR, proberequest=1)
        final = result(probe.run_probe(samples, samples, permit=permit)[-1])
        self.assertEqual(final['stage'], 4)
        self.assertEqual(final['beat_valid_ms'], 4750)

    def test_lost_playback_interrupts_and_can_restart_without_stale_evidence(self):
        n = 5*SR
        samples = np.zeros(n)
        permit = np.ones(n)
        permit[2*SR:] = 0
        probe = GuidedProbe(sr=SR, proberequest=1)
        _, candidates = impulse_counts((1.4,), n)
        final = result(probe.run_probe(samples, samples, permit=permit, candidates=candidates)[-1])
        self.assertEqual(final['stage'], 6)
        self.assertEqual(final['beat_candidates'], 1)
        probe.set(proberequest=2)
        final = result(probe.run_probe(samples[:32], samples[:32], permit=0, candidates=1)[-1])
        self.assertEqual(final['stage'], 1)
        self.assertEqual(final['beat_candidates'], 0)
