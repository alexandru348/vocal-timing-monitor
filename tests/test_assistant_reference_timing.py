"""Explicit reference timing and the existing Stop executor in the local model."""
import unittest

import numpy as np

from gen_harness import Engine, ROOT, compile_harness, load_library
from genexpr_scope import validate_scope
from max_event_model import Graph
from test_assistant_grid_test import Stimulus
from test_assistant_timing_bands import BandLevels, EnergyAttacks
from test_session_workflow import host_play


SOURCE = ROOT / 'src/vtm_assistant_reference_timing.genexpr'
validate_scope(SOURCE.read_text(), inputs=7, outputs=3)


class ReferenceTiming(Engine):
    params = compile_harness(SOURCE, 'assistant_reference_timing_harness', inputs=7, outputs=3)
    lib = load_library('assistant_reference_timing_harness', inputs=7)
    output_count = 3

    def compare(self, expected, observed, *, error=25, context=1, unique=1, recording=1, event=1):
        expected = np.atleast_1d(np.asarray(expected, dtype=float))
        event = np.broadcast_to(event, expected.shape)
        observed = np.broadcast_to(observed, expected.shape)
        return self.run(left=event, right=expected, phase=observed,
                        extra=(error, context, unique, recording))


class ReferenceTimingTests(unittest.TestCase):
    def test_intentional_entries_between_beats_match_the_reference(self):
        reference = [600, 900, 1050, 1620, 1800, 2200, 3600]
        moved = [0, 20, -14, 0, 35, -22, 25]
        # Includes a pickup, swing, a triplet offset and a long rest.
        out = ReferenceTiming().compare(reference, np.add(reference, moved))
        np.testing.assert_array_equal(out[:, 0], 2)
        np.testing.assert_array_equal(out[:, 1], moved)
        np.testing.assert_array_equal(out[:, 2], 0)

    def test_only_complete_uncertainty_interval_can_pass_or_exceed_tolerance(self):
        offsets = [-126, -125, -76, -75, 0, 75, 76, 125, 126]
        out = ReferenceTiming().compare(np.repeat(900, len(offsets)), np.add(900, offsets))
        np.testing.assert_array_equal(out[:, 0], [3, 1, 1, 2, 2, 2, 1, 1, 4])
        np.testing.assert_array_equal(out[:, 2], [1, 0, 0, 0, 0, 0, 0, 0, 1])

    def test_missing_ambiguous_or_invalid_evidence_never_requests_stop(self):
        for overrides, state in (({'event': 0}, 0), ({'context': 0}, 1),
                                 ({'unique': 0}, 1), ({'error': -1}, 1)):
            with self.subTest(overrides=overrides):
                status, deviation, request = ReferenceTiming().compare(900, 1080, **overrides)[0]
                self.assertEqual((status, deviation, request), (state, 0, 0))

    def test_playback_can_show_a_deviation_without_requesting_stop(self):
        out = ReferenceTiming().compare(900, 1050, recording=0)
        np.testing.assert_array_equal(out[0], [4, 150, 0])

    def test_tolerance_uses_the_configured_value(self):
        out = ReferenceTiming(tolerancems=60).compare([600, 900], [690, 985])
        np.testing.assert_array_equal(out[:, 0], [4, 1])
        np.testing.assert_array_equal(out[:, 2], [1, 0])


class ReferenceStopTests(unittest.TestCase):
    def ready(self, armed=True):
        graph = Graph()
        graph.initialize({'VTM Compensation ms': 90})
        if armed:
            graph.toggle_stop_at_idle_poll()
        return graph

    def feed_comparison(self, graph, expected, observed, **evidence):
        # Use the generated executor graph's detector port. This is a local
        # test adapter, not a new cable in the Ableton device.
        request = ReferenceTiming().compare(expected, observed, **evidence)[0, 2]
        graph.emit('root/snapshot-2', (int(request),))

    def test_first_confirmed_deviation_stops_once_after_valid_and_uncertain_attacks(self):
        graph = self.ready()
        self.feed_comparison(graph, 900, 900)
        self.feed_comparison(graph, 1050, 1160)
        graph.drain()
        self.assertEqual(graph.calls, [])
        self.feed_comparison(graph, 1620, 1780)
        graph.drain()
        self.assertEqual(graph.calls, [('call', 'stop_playing')])
        self.feed_comparison(graph, 2400, 2240)
        graph.drain()
        self.assertEqual(len(graph.calls), 1)
        graph.advance(151)
        graph.drain()
        self.assertIn('oprire confirmata', ' '.join(graph.state['root/popup/api-text']['label']))

    def test_disarmed_or_non_recording_comparison_cannot_stop(self):
        for armed, recording in ((False, 1), (True, 0)):
            with self.subTest(armed=armed):
                graph = self.ready(armed)
                self.feed_comparison(graph, 900, 1070, recording=recording)
                graph.drain()
                self.assertEqual(graph.calls, [])

    def test_queued_request_cannot_stop_the_next_take(self):
        graph = self.ready()
        self.feed_comparison(graph, 900, 1070)
        host_play(graph, 0)
        host_play(graph, 1)
        graph.emit('root/snapshot-2', (0,))
        graph.drain()
        self.assertEqual(graph.calls, [])
        self.feed_comparison(graph, 900, 1070)
        graph.drain()
        self.assertEqual(graph.calls, [('call', 'stop_playing')])

    def test_same_detected_syncopation_can_be_on_time_or_late_against_the_reference(self):
        rate = 44100
        clock = np.arange(7 * rate)
        phase = ((clock + 131) % int(.6 * rate)) / (.6 * rate)
        stage, _, generated, _, _ = Stimulus(sr=rate, request=1).send_clock(phase).T
        silence = np.zeros_like(generated)
        levels = BandLevels(sr=rate).measure((generated, silence), (silence, silence))
        attacks = EnergyAttacks(sr=rate).run(left=stage, right=np.ones_like(generated),
            phase=np.ones_like(generated), extra=(levels[:, :3].sum(axis=1), levels[:, 6],
                                                  .02, 2, phase, 600, 90, clock, 0, 0, 0))
        anchor = np.flatnonzero(stage == 2)[0]
        origin_ms = (anchor - round(phase[anchor] * .6 * rate)) * 1000 / rate
        observed = attacks[attacks[:, 11] == 1, 15] - origin_ms - 90
        reference = np.array([1650, 2400, 3150, 3450, 4200, 4950])
        self.assertEqual(len(observed), len(reference))

        valid = self.ready()
        for intended, played in zip(reference, observed):
            self.feed_comparison(valid, intended, played, error=6)
            valid.drain()
        self.assertEqual(valid.calls, [])

        early_reference = reference.copy()
        early_reference[2] -= 150
        changed = self.ready()
        for index, (intended, played) in enumerate(zip(early_reference, observed)):
            self.feed_comparison(changed, intended, played, error=6)
            changed.drain()
            self.assertEqual(len(changed.calls), int(index >= 2))
