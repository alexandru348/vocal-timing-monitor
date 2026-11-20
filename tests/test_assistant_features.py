"""Stage 1 synthetic DSP checks; not Max/Live or musical-accuracy tests."""
import unittest
import numpy as np
from gen_harness import ROOT, Engine, compile_harness, load_library

FEATURE_PARAMS = compile_harness(ROOT / 'src/vtm_assistant_features.genexpr',
                                 'assistant_features_harness', inputs=7, outputs=14)


class FeatureEngine(Engine):
    lib = load_library('assistant_features_harness', inputs=7)
    params = FEATURE_PARAMS
    output_count = 14

    def run(self, *args, extra=(0, 0, 0, 0), **kwargs):
        return super().run(*args, extra=extra, **kwargs)


def tone(sr, seconds, freq=350, amplitude=.12, start=.2, end=.6):
    t = np.arange(round(seconds * sr)) / sr
    return amplitude * np.sin(2 * np.pi * freq * t) * ((t >= start) & (t < end))


def detected(out):
    return out[out[:, 0] > 0]


class AssistantFeaturesTests(unittest.TestCase):
    def test_silence_and_low_noise_produce_no_candidates(self):
        for sr in (44100, 48000, 96000):
            for audio in (np.zeros(sr), np.random.default_rng(10).normal(0, .00015, sr)):
                self.assertEqual(len(detected(FeatureEngine(sr=sr).run(left=audio))), 0)

    def test_known_isolated_attack_across_rates(self):
        for sr in (44100, 48000, 96000):
            rows = detected(FeatureEngine(sr=sr).run(left=tone(sr, .8)))
            self.assertEqual(len(rows), 1, sr)
            self.assertLessEqual(abs(rows[0, 2] - 200), 11)
            self.assertTrue(int(rows[0, 3]) & 1)

    def test_stereo_inversion_and_single_channel_are_preserved(self):
        for sr in (44100, 48000, 96000):
            audio = tone(sr, .8)
            for left, right in ((audio, -audio), (audio, audio * 0), (audio * 0, audio)):
                self.assertEqual(len(detected(FeatureEngine(sr=sr).run(left=left, right=right))), 1)

    def test_band_change_on_continuous_equal_peak_tone(self):
        for sr in (44100, 48000, 96000):
            t = np.arange(sr) / sr
            # Both regions have equal peak amplitude; no silent rearming gap.
            freq = np.where(t < .5, 220., 2800.)
            phase = np.cumsum(freq) / sr
            audio = .12 * np.sin(2 * np.pi * phase) * (t >= .2)
            rows = detected(FeatureEngine(sr=sr).run(left=audio))
            changed = rows[(rows[:, 2] >= 480) & (rows[:, 2] <= 530)]
            self.assertEqual(len(changed), 1, (sr, rows[:, 2:4]))
            self.assertTrue(int(changed[0, 3]) & 2)

    def test_sustained_tone_does_not_retrigger_each_frame(self):
        for frequency in (120, 220, 350, 1000, 2800):
            for sr in (44100, 48000):
                rows = detected(FeatureEngine(sr=sr).run(left=tone(sr, 2, freq=frequency, end=1.9)))
                self.assertEqual(len(rows), 1, (sr, frequency, rows[:, 2:4]))

    def test_single_sample_click_is_not_confirmed(self):
        sr = 44100
        audio = np.zeros(sr)
        audio[round(.2 * sr)] = .9
        self.assertEqual(len(detected(FeatureEngine(sr=sr).run(left=audio))), 0)

    def test_clipping_is_reported_without_a_musical_verdict(self):
        sr = 44100
        audio = np.clip(tone(sr, .8, amplitude=2), -1, 1)
        rows = detected(FeatureEngine(sr=sr).run(left=audio))
        self.assertEqual(len(rows), 1)
        self.assertEqual(rows[0, 6], 1)
        self.assertNotIn('autostop', dict(FEATURE_PARAMS))

    def test_block_boundaries_do_not_change_results(self):
        sr = 44100
        audio = tone(sr, .8)
        expected = FeatureEngine(sr=sr).run(left=audio)
        engine = FeatureEngine(sr=sr)
        pieces = [engine.run(left=audio[i:i+257]) for i in range(0, len(audio), 257)]
        np.testing.assert_array_equal(np.concatenate(pieces), expected)

    def test_disabled_or_stopped_clock_produces_no_events(self):
        sr = 44100
        audio = tone(sr, .8)
        engine = FeatureEngine(sr=sr, enabled=0)
        self.assertEqual(len(detected(engine.run(left=audio))), 0)
        engine = FeatureEngine(sr=sr)
        engine.play = 0
        self.assertEqual(len(detected(engine.run(left=audio))), 0)

    def test_reset_cancels_pending_candidate_and_clears_results(self):
        sr = 48000
        engine = FeatureEngine(sr=sr)
        engine.run(left=tone(sr, .215, end=.215))
        engine.set(resetseq=1)
        out = engine.run(seconds=.1)
        self.assertEqual(len(detected(out)), 0)
        self.assertEqual(out[-1, 1], 0)
        self.assertEqual(out[-1, 2], 0)

    def test_confirmation_uses_only_past_and_present_audio(self):
        sr = 48000
        audio = tone(sr, .8)
        out = FeatureEngine(sr=sr).run(left=audio)
        indices = np.flatnonzero(out[:, 0] > 0)
        self.assertEqual(len(indices), 1)
        emitted_ms = indices[0] * 1000 / sr
        timestamp_ms = out[indices[0], 2]
        self.assertGreaterEqual(emitted_ms - timestamp_ms, 10)
        self.assertLessEqual(emitted_ms - 200, 31)


if __name__ == '__main__':
    unittest.main()
