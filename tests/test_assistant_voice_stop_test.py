import unittest

import numpy as np

from assistant_clarity import make_clarity_patch, RHYTHM_TEST_MARGIN_MS
from assistant_test_setup import load_test_setup
from assistant_voice_stop_test import SECOND_CUE_DELAY_MS, SOURCE
from gen_harness import Engine, compile_harness, load_library
from genexpr_scope import validate_scope
from test_assistant_clarity import ClarityGraph
from test_assistant_reference_timing import ReferenceTiming
from test_assistant_rhythm_probe import run_capture
from test_static import boxmap


class VoiceStop(Engine):
    validate_scope(SOURCE.read_text(), inputs=12, outputs=7)
    params = compile_harness(SOURCE, 'assistant_voice_stop_harness', inputs=12, outputs=7)
    lib = load_library('assistant_voice_stop_harness', inputs=12)
    output_count = 7

    def evaluate(self, capture, stage, *, recording=1, permit=1, clean=1):
        rows = ReferenceTiming(sr=self.sr).compare(capture[:, 2], capture[:, 3],
            error=RHYTHM_TEST_MARGIN_MS, event=capture[:, 1], context=capture[:, 5],
            unique=capture[:, 6], recording=recording)
        return self.run(left=stage, right=np.full(len(stage), 2), phase=np.broadcast_to(recording, stage.shape),
                        extra=(permit, capture[:, 1], capture[:, 9], capture[:, 4], rows[:, 0], rows[:, 1],
                               clean, rows[:, 2], capture[:, 11]))


class VoiceStopTests(unittest.TestCase):
    def test_second_cue_moves_without_moving_reference_and_first_large_deviation_wins(self):
        rate = 16000
        delay = SECOND_CUE_DELAY_MS
        stage = np.repeat([1, 2, 3, 4, 5], [1600, 3200, 128000, 3200, 24000])
        capture, _, _ = run_capture(rate, [1800, 3300+delay, 4970], second_cue_delay=delay)
        original, _, _ = run_capture(rate, [1800, 3300+delay, 4970])
        first_ta = lambda cues: np.flatnonzero(cues[:, 7] == 6)[0]
        self.assertAlmostEqual((first_ta(capture)-first_ta(original))*1000/rate, delay, delta=.1)
        np.testing.assert_array_equal(capture[:, :7], original[:, :7])
        rows = VoiceStop(sr=rate, generation=17).evaluate(capture, stage)
        events = np.flatnonzero(capture[:, 1])
        self.assertFalse(rows[:events[1], 4].any())
        self.assertEqual(rows[events[1], 4], 17)
        np.testing.assert_allclose(rows[-1], [3, 2, 4, delay, 0, 0, 0], atol=.03)

    def test_microphone_only_pause_delays_stop_and_times_out_safely(self):
        rate = 16000
        stage = np.repeat([1, 2, 3, 4, 5], [1600, 3200, 128000, 3200, 24000])
        ms = np.arange(len(stage)) * 1000 / rate
        for end, ref_pause, dispatch, expired in ((4400, False, True, 0), (4800, False, False, 1),
                                                   (4400, True, False, 0)):
            with self.subTest(end=end, ref_pause=ref_pause):
                capture, _, _ = run_capture(rate, [1800, 3480], mic_pause=(4110, end), ref_pause=ref_pause)
                permit = (ms < 4110) | (ms >= end)
                rows = VoiceStop(sr=rate, generation=17).evaluate(capture, stage, permit=permit)
                self.assertFalse(rows[ms < end, 4].any())
                self.assertEqual(bool(rows[:, 4].any()), dispatch)
                self.assertEqual(rows[-1, 6], expired)
                if dispatch:
                    np.testing.assert_allclose(rows[-1, 1:4], [2, 4, 180], atol=.03)

    def test_uncertain_repeat_clipping_and_inactive_recording_cannot_request_stop(self):
        rate = 16000
        stage = np.repeat([1, 2, 3, 4, 5], [1600, 3200, 128000, 3200, 24000])
        cases = (([1800, 1990, 3180], (), 1, 1), ([1980], (), 0, 1),
                 ([1980], (), 1, 0), ([1980], [1850], 1, 1))
        for timing, possible, record, clean in cases:
            with self.subTest(timing=timing, possible=possible, record=record, clean=clean):
                capture, _, _ = run_capture(rate, timing, clipped=possible)
                rows = VoiceStop(sr=rate, generation=5).evaluate(capture, stage, recording=record, clean=clean)
                self.assertFalse(rows[:, 4].any())

    def test_only_personal_voice_test_has_transport_wiring(self):
        default = make_clarity_patch()['patcher']
        self.assertFalse(any(w['box']['id'] == 'voice-stop-test' for w in default['boxes']))
        with self.assertRaises(ValueError):
            make_clarity_patch(voice_stop_test=True)

    def test_distributable_guided_stop_uses_tested_signal_path_without_deliberate_late_cue(self):
        public = make_clarity_patch(guided_stop=True)['patcher']
        personal = make_clarity_patch(test_setup=load_test_setup(), voice_stop_test=True)['patcher']
        public_boxes = boxmap(public)
        personal_boxes = boxmap(personal)
        for name in ('aq-rhythm-capture', 'aq-rhythm-review', 'aq-timing-voiced-attacks', 'voice-stop-test'):
            self.assertEqual(public_boxes[name], personal_boxes[name])
        self.assertNotIn('voice-stop-visual-delay', public_boxes)
        self.assertNotIn('ast-stimulus', public_boxes)
        with self.assertRaises(ValueError):
            make_clarity_patch(test_setup=load_test_setup(), guided_stop=True)

        graph = ClarityGraph(guided_stop=True).initialized()
        graph.emit('root/lat-observe-0', (1,))
        graph.toggle_stop_at_idle_poll()
        generation = graph.state['root/as-generation-store']['value']
        graph.emit('root/voice-stop-start-sample', (1,))
        graph.emit('root/voice-stop-sample', (generation,))
        graph.drain()
        graph.advance(151)
        graph.drain()
        self.assertEqual(graph.calls, [('call', 'stop_playing')])

    def test_live_relay_suppresses_off_and_stale_events_and_sends_one_fresh_call(self):
        for armed, recording, interrupt in ((True, 1, ''), (False, 1, ''), (True, 0, ''),
                                             (True, 1, 'before'), (True, 1, 'after')):
            with self.subTest(armed=armed, recording=recording, interrupt=interrupt):
                graph = ClarityGraph(test_setup=load_test_setup(), voice_stop_test=True).initialized()
                graph.emit('root/lat-observe-0', (recording,))
                if armed:
                    graph.toggle_stop_at_idle_poll()
                graph.emit('root/voice-stop-start-sample', (1,))
                generation = graph.state['root/as-generation-store']['value']
                self.assertGreater(generation, 0)
                if interrupt == 'before':
                    graph.emit('root/lat-observe-0', (0,))
                    graph.emit('root/lat-observe-0', (1,))
                    graph.emit('root/snapshot-2', (0,))
                graph.emit('root/snapshot-2', (1,))
                graph.emit('root/voice-stop-sample', (generation,))
                graph.emit('root/voice-stop-sample', (generation,))
                if interrupt == 'after':
                    graph.emit('root/lat-observe-0', (0,))
                graph.drain()
                graph.advance(151)
                graph.drain()
                expected = armed and recording and not interrupt
                self.assertEqual(graph.calls, [('call', 'stop_playing')] if expected else [])
                report = graph.state['root/asrc-report']['data']
                self.assertEqual(report['voice_stop_test_calls'], (int(bool(expected)),))
                self.assertEqual(report['voice_stop_test_readback'], (9 if expected else 0,))
