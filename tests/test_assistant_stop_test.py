"""Controlled timing observations and the private build's transport relay."""
import unittest

import numpy as np

from assistant_clarity import make_clarity_patch
from assistant_stop_test import ROOT
from assistant_test_setup import load_test_setup
from gen_harness import Engine, compile_harness, load_library
from genexpr_scope import validate_scope
from test_assistant_clarity import ClarityGraph
from test_assistant_reference_timing import ReferenceTiming


STIMULUS = ROOT / 'src/vtm_assistant_stop_test.genexpr'
RESULTS = ROOT / 'src/vtm_assistant_stop_test_results.genexpr'
validate_scope(STIMULUS.read_text(), inputs=3, outputs=3)
validate_scope(RESULTS.read_text(), inputs=5, outputs=8)


class StopTestStimulus(Engine):
    params = compile_harness(STIMULUS, 'assistant_stop_test_harness', inputs=3, outputs=3)
    lib = load_library('assistant_stop_test_harness', inputs=3)
    output_count = 3


class StopTestResults(Engine):
    params = compile_harness(RESULTS, 'assistant_stop_results_harness', inputs=5, outputs=8)
    lib = load_library('assistant_stop_results_harness', inputs=5)
    output_count = 8

    def evaluate(self, stimulus, review):
        return self.run(left=stimulus[:, 0], right=stimulus[:, 1], phase=review[:, 0],
                        extra=(review[:, 1], review[:, 2]))


class StopTestTests(unittest.TestCase):
    def probe(self, sr, recording):
        ready = np.ones_like(recording)
        source = StopTestStimulus(sr=sr, request=1).run(left=recording, right=ready, phase=ready)
        events = source[:, 1]
        review = ReferenceTiming(sr=sr).compare(np.zeros_like(ready), source[:, 2], error=35,
            context=events, unique=events, recording=recording, event=events)
        results = StopTestResults(sr=sr)
        return source, results.evaluate(source, review), results

    def test_real_recording_gate_and_first_on_time_verdict_precede_eligible_stop(self):
        for sr in (44100, 48000):
            with self.subTest(sr=sr):
                recording = np.ones(3*sr)
                source, rows, results = self.probe(sr, recording)
                first, second = np.flatnonzero(source[:, 1])
                self.assertGreaterEqual(second-first, int(1.5*sr))
                self.assertFalse(rows[:second, 7].any())
                np.testing.assert_array_equal(rows[-1], [5, 2, 2, 3, 0, -150, 1, 1])
                results.set(cancel=1)
                canceled = results.evaluate(np.array([[5, 0, 0]]), np.zeros((1, 3)))[0]
                np.testing.assert_array_equal(canceled, [5, 2, 2, 3, 0, -150, 1, 0])

    def test_no_recording_or_recording_loss_cannot_emit_stop(self):
        sr = 44100
        for recording, count in ((np.zeros(3*sr), 0), (np.arange(3*sr) < sr, 1)):
            with self.subTest(count=count):
                _, rows, _ = self.probe(sr, recording)
                self.assertEqual(rows[-1, 0], 6)
                self.assertEqual(rows[-1, 1], count)
                self.assertFalse(rows[:, 7].any())

    def test_transport_test_build_is_private(self):
        generic = make_clarity_patch()['patcher']
        self.assertNotIn('ast-stimulus', [w['box']['id'] for w in generic['boxes']])
        with self.assertRaises(ValueError):
            make_clarity_patch(transport_stop_test=True)

    def graph(self, *, armed, recording):
        graph = ClarityGraph(test_setup=load_test_setup(), transport_stop_test=True).initialized()
        graph.emit('root/lat-observe-0', (recording,))
        if armed:
            graph.toggle_stop_at_idle_poll()
        graph.send('root/asrc-popup/ast-button', (1,))
        graph.emit('root/snapshot-2', (0,))
        return graph

    def test_wired_executor_sends_exactly_one_command_and_reports_host_confirmation(self):
        graph = self.graph(armed=True, recording=1)
        graph.emit('root/snapshot-2', (1,))  # Legacy detector is isolated in the test build.
        graph.emit('root/ast-request-sample', (0,))
        graph.drain()
        self.assertFalse(graph.calls)
        graph.emit('root/ast-request-sample', (1,))
        graph.emit('root/ast-request-sample', (1,))
        graph.drain()
        graph.advance(151)
        graph.drain()
        self.assertEqual(graph.calls, [('call', 'stop_playing')])
        report = graph.state['root/asrc-report']['data']
        self.assertEqual(report['stop_test_calls'], (1,))
        self.assertEqual(report['stop_test_readback'], (9,))

    def test_wired_executor_respects_off_and_invalidates_recording_changes_before_commit(self):
        for armed, recording, interrupt in ((False, 1, False), (True, 0, False), (True, 1, True)):
            with self.subTest(armed=armed, recording=recording, interrupt=interrupt):
                graph = self.graph(armed=armed, recording=recording)
                graph.emit('root/ast-request-sample', (1,))
                if interrupt:
                    graph.emit('root/lat-observe-0', (0,))
                    graph.emit('root/lat-observe-0', (1,))
                graph.drain()
                self.assertFalse(graph.calls)
                report = graph.state['root/asrc-report']['data']
                self.assertEqual(report['stop_test_calls'], (0,))
                self.assertEqual(report['stop_test_readback'], (0,))

    def test_recording_restart_cannot_relay_an_old_dsp_snapshot(self):
        graph = self.graph(armed=True, recording=1)
        graph.emit('root/lat-observe-0', (0,))
        graph.emit('root/lat-observe-0', (1,))
        graph.emit('root/snapshot-2', (0,))
        graph.emit('root/ast-request-sample', (1,))
        graph.drain()
        self.assertFalse(graph.calls)
