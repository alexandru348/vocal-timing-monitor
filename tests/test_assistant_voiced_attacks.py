import unittest

import numpy as np

from assistant_clarity import TIMING_VOICED_ATTACKS_SOURCE
from gen_harness import Engine, compile_harness, load_library
from genexpr_scope import validate_scope


class VoicedAttacks(Engine):
    validate_scope(TIMING_VOICED_ATTACKS_SOURCE.read_text(), inputs=12, outputs=8)
    params = compile_harness(TIMING_VOICED_ATTACKS_SOURCE, 'assistant_voiced_attacks_harness',
                             inputs=12, outputs=8)
    lib = load_library('assistant_voiced_attacks_harness', inputs=12)
    output_count = 8

    def confirm(self, left, right, events, *, stage=3, state=2, permit=1, clip_pause=0, clip_input=0):
        return self.run(left=left, right=right, phase=np.broadcast_to(stage, left.shape),
                        extra=(state, permit, clip_pause, clip_input, events,
                               .31, 600, 92, 975))


class VoicedAttacksTests(unittest.TestCase):
    def test_keeps_clean_onset_time_only_after_voiced_followup(self):
        for rate in (44100, 48000, 96000):
            with self.subTest(rate=rate):
                times = np.arange(rate) / rate
                start = round(.10 * rate)
                click = round(.45 * rate)
                since_onset = times - .10
                vowel = .20 * (np.sin(2*np.pi*155*since_onset) + .30*np.sin(2*np.pi*310*since_onset))
                audio = np.where((since_onset > .015) & (since_onset < .22), vowel, 0)
                audio[click:click+70] += np.random.default_rng(4).uniform(-.5, .5, 70)
                events = np.zeros(rate)
                events[[start, click]] = 1

                result = VoicedAttacks(sr=rate).confirm(audio, -audio, events)
                index, = np.flatnonzero(result[:, 0])
                self.assertGreater(index - start, .05 * rate)
                self.assertLess(index - start, .13 * rate)
                np.testing.assert_allclose(result[index, 1:5], [.31, 600, 92, 975])
                self.assertEqual(result[-1, 5], 1)
                self.assertEqual(result[-1, 6], 0)
                self.assertEqual(result[index, 7], 1)

    def test_clipping_marks_confirmed_observation_and_context_loss_cancels(self):
        rate = 44100
        t = np.arange(rate // 2) / rate
        audio = np.clip(1.6*np.sin(2*np.pi*152*t), -1, 1)
        events = np.zeros(len(t))
        events[0] = 1
        clip = t >= .01

        result = VoicedAttacks(sr=rate).confirm(audio, audio, events, permit=~clip,
                                               clip_pause=clip, clip_input=1)
        self.assertEqual(np.count_nonzero(result[:, 0]), 1)
        self.assertEqual(result[-1, 6], 1)
        self.assertFalse(np.any(result[:, 7]))
        for context in ({'permit': ~clip}, {'permit': ~clip, 'clip_pause': clip, 'clip_input': 2},
                        {'stage': np.where(clip, 4, 3)}, {'state': 3}):
            with self.subTest(context=tuple(context)):
                result = VoicedAttacks(sr=rate).confirm(audio, audio, events, **context)
                self.assertFalse(np.any(result[:, 0]))
