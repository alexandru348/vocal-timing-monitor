"""Instrumental leakage and overlapping sound tests for the timing probe DSP."""
import unittest

import numpy as np

from gen_harness import Engine, ROOT, compile_harness, load_library
from genexpr_scope import validate_scope
from test_assistant_features import FeatureEngine
from test_assistant_grid import project


SOURCE = ROOT / 'src/vtm_assistant_bleed.genexpr'
validate_scope(SOURCE.read_text(), inputs=17, outputs=22)
PARAMS = compile_harness(SOURCE, 'assistant_bleed_harness', inputs=17, outputs=22)


class BleedEngine(Engine):
    lib = load_library('assistant_bleed_harness', inputs=17)
    params = PARAMS
    output_count = 22

    def run_probe(self, mic, ref, features, *, permit=1, epoch=1, offset=91.8,
                  source=0, calibration=0, bands=(0, 0, 0, 0)):
        return self.run(left=mic[0], right=mic[1], phase=ref[0],
                        extra=(ref[1], features[:, 0], features[:, 11], features[:, 12],
                               features[:, 13], permit, epoch, offset, source, calibration, *bands))


def beats(sr, positions, seconds, seed):
    random = np.random.default_rng(seed)
    audio = np.zeros(round(sr*seconds))
    for pos in positions:
        at = round(pos*sr)
        t = np.arange(round(.054*sr)) / sr
        bass = .29 * np.sin(2*np.pi*(68*t - 130*t*t))
        body = .17 * np.sin(2*np.pi*(165*t + 870*t*t) + .4*seed)
        bright = .1 * random.uniform(-1, 1, len(t))
        audio[at:at+len(t)] = (bass + body + bright) * np.exp(-27*t)
    return audio


def shift(audio, sr, ms):
    samples = np.arange(len(audio))
    return np.interp(samples-ms*sr/1000, samples, audio, left=0, right=0)


def trace(sr, delay=91.65, *, overlap=False):
    positions = (.6, .9, 1.2, 1.5, 1.8, 2.1)
    ref = (beats(sr, positions, 3, 2), beats(sr, positions, 3, 7))
    left = shift(.22*ref[0] + .07*ref[1], sr, delay+4.5)
    left += shift(.025*ref[0], sr, delay+10.1)
    right = shift(.19*ref[0] - .04*ref[1], sr, delay+4.5)
    right += shift(.022*ref[0], sr, delay+10.1)
    if overlap:
        # A synthetic voiced attack 3 ms after the arriving beat. Give it its
        # own spectrum and phase so a source cannot pass by timing alone.
        at = round((positions[2] + (delay+7.5)/1000)*sr)
        t = np.arange(round(.052*sr)) / sr
        voice = .055 * (np.sin(2*np.pi*(271*t + 300*t*t)) +
                         .27*np.sin(2*np.pi*727*t)) * np.exp(-7*t)
        left[at:at+len(t)] += voice
        right[at:at+len(t)] += .76*voice
    mic = (left, right)
    features = FeatureEngine(sr=sr, hostcontext=1).run(left=left, right=right,
                                                       extra=(1, 1, 600, delay))
    return mic, ref, features


class AssistantBleedTests(unittest.TestCase):
    def test_stereo_beat_at_unknown_gain_and_with_short_echo(self):
        for sr in (44100, 48000, 96000):
            with self.subTest(sr=sr):
                mic, ref, features = trace(sr)
                rows = BleedEngine(sr=sr).run_probe(mic, ref, features)
                self.assertGreaterEqual(rows[-1, 4], 6)
                self.assertEqual(rows[-1, 4], rows[-1, 5])
                self.assertFalse(rows[:, 0].any())

    def test_voiced_attack_survives_over_the_beat_and_keeps_its_timestamp(self):
        for offset in (-500., -92., 0., 91.65, 500.):
            with self.subTest(offset=offset):
                mic, ref, features = trace(44100, offset, overlap=True)
                filtered = BleedEngine().run_probe(mic, ref, features)
                events = filtered[filtered[:, 0] == 1]
                self.assertEqual(len(events), 1)
                self.assertGreaterEqual(filtered[-1, 5], 5)
                self.assertEqual(filtered[-1, 4], 1 + sum(filtered[-1, 5:7]))
                raw = features[features[:, 0] == 1][:, 11:14]
                self.assertTrue(np.any(np.all(raw == events[0, 1:4], axis=1)))
                result = project(events[:, 1], period=events[:, 2], offset=events[:, 3])
                self.assertLessEqual(abs(result[0, 1]), 12)

    def test_known_silent_reference_does_not_block_a_candidate(self):
        mic, ref, features = trace(44100)
        silent = ref[0] * 0
        rows = BleedEngine().run_probe(mic, (silent, silent), features)
        np.testing.assert_array_equal(rows[rows[:, 0] == 1, 1:4],
                                      features[features[:, 0] == 1, 11:14])

    def test_pending_candidate_is_discarded_on_context_change(self):
        mic, ref, features = trace(44100, -92, overlap=True)
        first_arrival = np.flatnonzero(features[:, 0])[0]
        epoch = np.ones(len(ref[0]))
        epoch[first_arrival+1:] = 2
        rows = BleedEngine().run_probe(mic, ref, features, epoch=epoch)
        self.assertEqual(rows[first_arrival+1, 6], 1)
        self.assertFalse(rows[:first_arrival+round(.12*44100), 0].any())


def reflected_beat(sr, seconds=8, delay=91.8):
    """Several distinct reflections distort the reference rather than just scaling it."""
    n = round(sr * seconds)
    t = np.arange(n) / sr
    env = np.exp(-np.remainder(t+.01, .20) / .045)
    rng = np.random.default_rng(714)
    left, right = [env * .4 * rng.uniform(-1, 1, n) for _ in range(2)]
    mic = (
        shift(.22*left, sr, delay-8.2) + shift(-.20*right, sr, delay-.6) +
        shift(.21*left, sr, delay+9.7) + shift(.18*right, sr, delay+12),
        shift(.21*right, sr, delay-7.3) + shift(.22*left, sr, delay+3.1) -
        shift(.22*right, sr, delay+10.3))
    return mic, (left, right)


def features_for(mic, sr, offset):
    return FeatureEngine(sr=sr, hostcontext=1).run(left=mic[0], right=mic[1],
                                                   extra=(1, 1, 600, offset))


class LearnedBleedTests(unittest.TestCase):
    def test_learns_reflected_beat_and_keeps_an_overlapping_voice(self):
        sr = 44100
        offset = 91.8
        mic, ref = reflected_beat(sr, delay=offset)
        voice_at = round((6.00 + offset/1000 - .012) * sr)
        t = np.arange(round(.065*sr)) / sr
        voice = .030 * (np.sin(2*np.pi*(238*t + 400*t*t)) +
                         .5*np.sin(2*np.pi*713*t)) * np.exp(-8*t)
        mic[0][voice_at:voice_at+len(t)] += voice
        mic[1][voice_at:voice_at+len(t)] += .8*voice
        features = features_for(mic, sr, offset)
        old = BleedEngine(sr=sr).run_probe(mic, ref, features, offset=offset)
        engine = BleedEngine(sr=sr, learningstage=2)
        split = 5*sr
        fit = engine.run_probe(tuple(x[:split] for x in mic), tuple(x[:split] for x in ref),
                               features[:split], offset=offset)
        self.assertEqual(fit[-1, 9], 2)
        self.assertGreater(fit[-1, 10], .65)
        self.assertGreater(fit[-1, 13], 0)
        engine.set(learningstage=3)
        measured = engine.run_probe(tuple(x[split:] for x in mic), tuple(x[split:] for x in ref),
                                    features[split:], offset=offset)
        self.assertEqual(measured[-1, 10], fit[-1, 10])
        self.assertEqual(measured[-1, 11], fit[-1, 11])
        self.assertGreater(measured[-1, 14], 0)
        self.assertGreater(np.count_nonzero(old[split:, 0]), np.count_nonzero(measured[:, 0]))
        raw_phase = (voice_at / sr / .6) % 1
        kept = measured[measured[:, 0] != 0]
        phase_errors = (kept[:, 1] - raw_phase + .5) % 1 - .5
        self.assertTrue(np.any(np.abs(phase_errors) < .04))

    def test_independent_signal_fails_validation(self):
        sr = 16000
        mic, ref = reflected_beat(sr, seconds=5)
        unrelated = (np.roll(mic[0], round(.313*sr)), np.roll(mic[1], round(.313*sr)))
        features = features_for(unrelated, sr, 91.8)
        rows = BleedEngine(sr=sr, learningstage=2).run_probe(unrelated, ref, features)
        self.assertEqual(rows[-1, 9], 3)
        self.assertGreater(rows[-1, 11], 500)
        self.assertEqual(rows[-1, 12], 0)

    def test_prediction_level_is_reduced_before_independent_validation(self):
        sr = 44100
        mic, ref = reflected_beat(sr, seconds=5)
        changed = round(2.61*sr)
        mic[0][changed:] *= .28
        mic[1][changed:] *= .42
        features = features_for(mic, sr, 91.8)
        rows = BleedEngine(sr=sr, learningstage=2).run_probe(mic, ref, features)
        final = rows[-1]
        self.assertEqual(final[9], 2)
        self.assertGreater(final[10], .8)
        self.assertGreater(final[15], 450)
        self.assertAlmostEqual(final[16], .28, delta=.04)
        self.assertAlmostEqual(final[17], .42, delta=.04)
        self.assertGreater(final[18], 2)

    def test_gain_fit_does_not_approve_a_signal_that_fails_the_next_portion(self):
        sr = 16000
        mic, ref = reflected_beat(sr, seconds=5)
        gain_changed = round(2.61*sr)
        holdout_changed = round(3.12*sr)
        for channel in mic:
            channel[gain_changed:] *= .3
            channel[holdout_changed:] *= -1
        features = features_for(mic, sr, 91.8)
        rows = BleedEngine(sr=sr, learningstage=2).run_probe(mic, ref, features)
        self.assertAlmostEqual(rows[-1, 16], .3, delta=.06)
        self.assertEqual(rows[-1, 9], 3)
        self.assertGreater(rows[-1, 11], 800)
        self.assertEqual(rows[-1, 12], 0)

    def test_early_speech_and_path_change_disable_the_model(self):
        sr = 16000
        mic, ref = reflected_beat(sr, seconds=5)
        features = features_for(mic, sr, 91.8)
        split = sr
        early = BleedEngine(sr=sr, learningstage=2)
        early.run_probe(tuple(x[:split] for x in mic), tuple(x[:split] for x in ref),
                        features[:split])
        early.set(learningstage=3)
        after = early.run_probe(tuple(x[split:] for x in mic), tuple(x[split:] for x in ref),
                                features[split:])
        self.assertEqual(after[-1, 9], 3)
        self.assertEqual(after[-1, 12], 0)
        route_change = np.arange(len(mic[0])) >= 4*sr
        switched = BleedEngine(sr=sr, learningstage=2).run_probe(
            mic, ref, features, source=route_change)
        self.assertEqual(switched[4*sr-1, 9], 2)
        self.assertEqual(switched[4*sr, 9], 3)
        self.assertEqual(switched[-1, 12], switched[4*sr-1, 12])
