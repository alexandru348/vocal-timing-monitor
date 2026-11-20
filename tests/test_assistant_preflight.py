"""Known synthetic source facts and native graph model; no Max/Live execution."""
from collections import defaultdict
import unittest
import numpy as np
from preflight_harness import Preflight, ready, PARAMS
from assistant_preflight import make_experimental_patch, STATES, OUTPUTS, SOURCE
from max_event_model import Graph
from test_static import PATCH, boxmap, edges, walk


class PreflightTests(unittest.TestCase):
    def test_quantized_clock_settles_without_repeated_context_resets(self):
        for sr in (44100, 48000, 96000):
            for bpm in (20, 60, 100, 153, 300, 400):
                with self.subTest(sr=sr, bpm=bpm):
                    p = ready(sr=sr)
                    p.bpm = bpm
                    n = round(sr*1.3)
                    phase = (((np.arange(n)*bpm)/(60*sr)) % 1).astype(np.float32).astype(float)
                    out = p.run(np.full(n, .1), np.full(n, .15), phase=phase)
                    tail = out[-round(sr*.5):]
                    self.assertTrue(np.all(tail[:, 0] == 15))
                    self.assertEqual(np.ptp(tail[:, 9]), 0)
                    # Endpoint rounding across 10 ms bounds period error to
                    # <0.06 ms even at 20 BPM; offset error stays below .01 ms.
                    np.testing.assert_allclose(tail[:, 5], 60000/bpm, atol=.06, rtol=0)
                    expected = (tail[:, 3] - 83/(60000/bpm)) % 1
                    phase_error = (tail[:, 4] - expected + .5) % 1 - .5
                    self.assertLess(np.max(np.abs(phase_error))*(60000/bpm), .01)

    def test_quantized_clock_does_not_bypass_unknown_quality(self):
        p = ready(quality=0)
        n = round(p.sr*1.3)
        phase = (((np.arange(n)*p.bpm)/(60*p.sr)) % 1).astype(np.float32).astype(float)
        out = p.run(np.full(n, .1), np.full(n, .15), phase=phase)
        self.assertEqual(out[-1, 0], 11)
        self.assertFalse(out[:, 2].any())

    def test_out_of_range_clock_does_not_settle(self):
        for bpm in (10, 500):
            p = ready()
            p.bpm = bpm
            out = p.signal(seconds=.5)
            self.assertEqual(out[-1, 0], 5)
            self.assertFalse(out[:, 2].any())

    def test_quantized_tempo_jump_and_clock_loss_still_suspend(self):
        p = ready()
        n = round(p.sr*.3)
        phase = ((np.arange(n)*100/(60*p.sr)) % 1).astype(np.float32).astype(float)
        p.run(np.full(n, .1), np.full(n, .15), phase=phase)
        n2 = round(p.sr*.04)
        newphase = ((phase[-1] + (np.arange(n2)+1)*153/(60*p.sr)) % 1).astype(np.float32).astype(float)
        changed = p.run(np.full(n2, .1), np.full(n2, .15), phase=newphase)
        self.assertEqual(changed[-1, 0], 5)
        self.assertEqual(changed[-1, 2], 0)
        n3 = round(p.sr*.2)
        settledphase = ((newphase[-1] + (np.arange(n3)+1)*153/(60*p.sr)) % 1).astype(np.float32).astype(float)
        settled = p.run(np.full(n3, .1), np.full(n3, .15), phase=settledphase)
        self.assertEqual(settled[-1, 0], 15)
        lost = p.run(np.zeros(100), np.zeros(100), phase=np.zeros(100))
        self.assertFalse(lost[:, 2].any())
        self.assertEqual(lost[-1, 0], 5)

    def test_unknown_defaults_never_claim_readiness(self):
        p = Preflight()
        out = p.signal()
        self.assertEqual(out[-1, 0], 2)
        self.assertFalse(out[:, 2].any())

    def test_valid_live_and_recorded_contexts_across_rates(self):
        for sr in (44100, 48000, 96000):
            for params, state in [({}, 15), ({'recording': 1}, 14),
                                  ({'sourcemode': 2, 'timingpolicy': 2, 'timelinevalid': 1}, 16)]:
                with self.subTest(sr=sr, params=params):
                    out = ready(sr=sr, **params).signal()
                    self.assertEqual(out[-1, 0], state)
                    self.assertEqual(out[-1, 2], 1)

    def test_unknown_host_fields_and_unsupported_values_fail_closed(self):
        for field in ('playing', 'countingin', 'recording', 'sessionrecord', 'sessionstatus'):
            for value in (-1, 3):
                out = ready(**{field: value}).signal()
                self.assertEqual(out[-1, 0], 2, (field, value))
                self.assertFalse(out[:, 2].any())

    def test_countin_is_not_a_rhythm_error_even_before_playing(self):
        for playing in (0, 1):
            p = ready(countingin=1, playing=playing)
            out = p.signal()
            self.assertEqual(out[-1, 0], 4)
            self.assertFalse(out[:, 2].any())
            p.set(countingin=0, playing=1)
            self.assertEqual(p.signal()[-1, 0], 15)

    def test_stopped_transport_and_loss_of_clock_suspend(self):
        for playing, play, state in [(0, False, 3), (1, False, 5)]:
            p = ready(playing=playing)
            p.play = play
            out = p.signal()
            self.assertEqual(out[-1, 0], state)
            self.assertFalse(out[:, 2].any())

    def test_source_binding_is_not_inferred_from_loud_audio(self):
        for params, state in [({'sourcemode': 0}, 6), ({'voicebinding': 0}, 6),
                              ({'voicebinding': 2}, 6), ({'referencebinding': 0}, 7),
                              ({'referencebinding': 2}, 7)]:
            out = ready(**params).signal()
            self.assertEqual(out[-1, 0], state)
            self.assertEqual(out[-1, 1], 0)
            self.assertFalse(out[:, 2].any())

    def test_each_recording_mode_is_observed(self):
        for field in ('recording', 'sessionrecord', 'sessionstatus'):
            out = ready(**{field: 1}).signal()
            self.assertEqual(out[-1, 0], 14)
        out = ready(sessionstatus=2).signal()
        self.assertEqual(out[-1, 0], 14)

    def test_recorded_review_conflict_is_not_mistaken_for_live_input(self):
        for field in ('recording', 'sessionrecord', 'sessionstatus'):
            p = ready(sourcemode=2, timingpolicy=2, timelinevalid=1, **{field: 1})
            out = p.signal()
            self.assertEqual(out[-1, 0], 17)
            self.assertFalse(out[:, 2].any())

    def test_calibration_requires_a_matching_nonzero_path_revision(self):
        for params in ({'calibrationvalid': 0}, {'audiorevision': 2},
                       {'audiorevision': 0, 'calibratedrevision': 0},
                       {'timingpolicy': 0}, {'offsetms': 501}):
            out = ready(**params).signal()
            self.assertEqual(out[-1, 0], 8, params)
            self.assertFalse(out[:, 2].any())

    def test_zero_calibration_is_valid_when_explicitly_confirmed(self):
        out = ready(offsetms=0).signal()
        self.assertEqual(out[-1, 0], 15)
        self.assertEqual(out[-1, 11], 0)

    def test_offset_applied_once_and_wraps_correctly_at_all_rates(self):
        for sr in (44100, 48000, 96000):
            for bpm in (60, 100, 153, 300):
                for offset in (-120., 0., 83.):
                    p = ready(sr=sr, offsetms=offset)
                    p.bpm = bpm
                    out = p.signal(seconds=.2)
                    valid = out[:, 2] > 0
                    expected = (out[valid, 3] - offset/(60000/bpm)) % 1
                    error = (out[valid, 4] - expected + .5) % 1 - .5
                    np.testing.assert_allclose(error, 0, atol=1e-10)
                    self.assertTrue(valid.any())

    def test_recorded_timeline_does_not_reapply_saved_mic_offset(self):
        p = ready(sourcemode=2, timingpolicy=2, timelinevalid=1, offsetms=83)
        out = p.signal()
        valid = out[:, 2] > 0
        np.testing.assert_array_equal(out[valid, 4], out[valid, 3])
        self.assertEqual(out[-1, 11], 0)
        for params in ({'timelinevalid': 0}, {'sourcemode': 1},
                       {'timelinerevision': -1}, {'audiorevision': 2}):
            other = ready(sourcemode=2, timingpolicy=2, timelinevalid=1)
            other.set(**params)
            self.assertEqual(other.signal()[-1, 0], 8)

    def test_signal_presence_is_not_voice_or_separation_proof(self):
        for quality in (0, 2):
            out = ready(quality=quality).signal()
            self.assertEqual(out[-1, 0], 11)
            self.assertEqual(out[-1, 1], 1)  # diagnostic detection only
            self.assertFalse(out[:, 2].any())

    def test_silence_on_either_input_waits_without_offbeat_verdict(self):
        for mic, ref, state in [(0, .15, 13), (.1, 0, 12), (0, 0, 12)]:
            out = ready().signal(mic=mic, ref=ref)
            self.assertEqual(out[-1, 0], state)
            self.assertFalse(out[:, 2].any())

    def test_short_gaps_tolerated_and_long_silence_suspends(self):
        p = ready()
        p.signal()
        gap = p.signal(seconds=.04, mic=0, ref=0)
        self.assertEqual(gap[-1, 2], 1)
        gap = p.signal(seconds=.65, mic=0, ref=0)
        self.assertEqual(gap[-1, 2], 0)
        self.assertEqual(gap[-1, 0], 12)
        self.assertEqual(p.signal()[-1, 0], 15)

    def test_clipping_suspends_both_channels_and_recovers(self):
        for side in ('mic', 'ref'):
            p = ready()
            out = p.signal(**{side: 2})
            self.assertEqual(out[-1, 0], 9 if side == 'mic' else 10)
            self.assertEqual(out[-1, 1], 0)
            self.assertEqual(out[-1, 2], 0)
            self.assertEqual(p.signal(seconds=.4)[-1, 0], 15)

    def test_loud_mic_keeps_timing_and_full_scale_pauses_only_locally(self):
        permit = OUTPUTS.index('timing_probe_permit')
        clip_pause = OUTPUTS.index('probe_clip_pause')
        for sr in (44100, 48000, 96000):
            with self.subTest(sr=sr):
                p = ready(sr=sr)
                initial = p.signal()[-1]
                loud = p.signal(mic=.999)
                self.assertTrue(loud[:, permit].all())
                self.assertTrue((loud[:, 9] == initial[9]).all())
                self.assertFalse(loud[:, clip_pause].any())

                mic = np.full(round(.04*sr), .15)
                mic[0] = 32767 / 32768
                spike = p.run(np.zeros_like(mic), np.full_like(mic, .1), right_mic=mic)
                self.assertEqual(spike[0, OUTPUTS.index('last_clip_input_mask')], 1)
                blocked = round(.020*sr) + 1  # include the release boundary
                self.assertFalse(spike[:blocked, permit].any())
                self.assertTrue(spike[:blocked, clip_pause].all())
                self.assertTrue(spike[blocked:, permit].all())

    def test_antiphase_and_right_only_signal_are_not_lost(self):
        sr = 44100
        t = np.arange(round(sr*.16))/sr
        voice = .1*np.sin(2*np.pi*350*t)
        beat = .15*np.sin(2*np.pi*1300*t)
        for left, right in ((voice, -voice), (np.zeros_like(voice), voice)):
            out = ready().run(left, beat, right_mic=right, right_ref=-beat)
            self.assertEqual(out[-1, 2], 1)

    def test_lease_expires_then_a_new_poll_revalidates(self):
        p = ready()
        out = p.signal()
        epoch = out[-1, 9]
        out = p.signal(seconds=.35, heartbeat=False)
        self.assertEqual(out[-1, 0], 2)
        self.assertGreater(out[-1, 9], epoch)
        self.assertEqual(out[-1, 2], 0)
        self.assertEqual(p.signal()[-1, 0], 15)

    def test_explicitly_invalid_host_poll_token_revokes_immediately(self):
        p = ready()
        p.signal()
        p.set(hostseq=0)
        out = p.signal(seconds=.001, heartbeat=False)
        self.assertEqual(out[0, 0], 2)
        self.assertEqual(out[0, 2], 0)

    def test_every_context_edit_invalidates_same_sample_and_changes_epoch(self):
        edits = [dict(enabled=0), dict(deviceon=0), dict(apiready=0),
                 dict(playing=0), dict(countingin=1), dict(recording=1),
                 dict(sessionrecord=1), dict(sessionstatus=1), dict(sourcemode=2),
                 dict(voicebinding=2), dict(referencebinding=2), dict(quality=2),
                 dict(timingpolicy=2), dict(calibrationvalid=0), dict(audiorevision=2),
                 dict(calibratedrevision=2), dict(timelinevalid=1), dict(timelinerevision=2),
                 dict(positionseq=1), dict(offsetms=84),
                 dict(micfloor=.005), dict(reffloor=.0002), dict(resetseq=1)]
        for edit in edits:
            p = ready()
            initial = p.signal()[-1]
            p.set(**edit)
            out = p.signal(seconds=.001)
            self.assertEqual(out[0, 2], 0, edit)
            self.assertGreater(out[0, 9], initial[9], edit)
            self.assertEqual(out[0, 6], 0, edit)
            self.assertEqual(out[0, 7], 0, edit)

    def test_clipping_and_recovery_invalidate_previous_context(self):
        p = ready()
        start = p.signal()[-1, 9]
        clipped = p.signal(mic=2)
        self.assertGreater(clipped[-1, 9], start)
        end = p.signal(seconds=.4)
        self.assertGreater(end[-1, 9], clipped[-1, 9])

    def test_tempo_jump_suspends_phase_conversion_until_settled(self):
        p = ready()
        old = p.signal()[-1, 9]
        p.bpm = 153
        changed = p.signal(seconds=.04)
        self.assertEqual(changed[-1, 0], 5)
        self.assertEqual(changed[-1, 2], 0)
        self.assertGreater(changed[-1, 9], old)
        settled = p.signal()
        self.assertEqual(settled[-1, 0], 15)

    def test_long_offset_requires_matching_tempo_history(self):
        p = ready(offsetms=400)
        self.assertEqual(p.signal(seconds=.2)[-1, 0], 5)
        self.assertEqual(p.signal(seconds=.3)[-1, 0], 15)

    def test_repeated_control_readbacks_do_not_create_false_boundaries(self):
        p = ready()
        before = p.signal()[-1, 9]
        p.set(playing=1, countingin=0, recording=0, offsetms=83, audiorevision=1)
        out = p.signal()
        self.assertEqual(out[-1, 9], before)
        self.assertEqual(out[0, 2], 1)

    def test_a_quiet_gap_does_not_create_a_new_take(self):
        p = ready()
        before = p.signal()[-1, 9]
        out = p.signal(seconds=.7, mic=0, ref=0)
        self.assertEqual(out[-1, 9], before)
        self.assertEqual(p.signal()[-1, 9], before)

    def test_repeated_take_boundaries_do_not_reuse_prior_signal_presence(self):
        p = ready()
        last_epoch = p.signal()[-1, 9]
        for _ in range(5):
            p.set(playing=0, recording=0)
            p.play = False
            out = p.signal(seconds=.04)
            self.assertEqual(out[-1, 2], 0)
            p.set(playing=1, recording=1)
            p.play = True
            out = p.signal(mic=0, ref=0)
            self.assertEqual(out[-1, 2], 0)
            self.assertGreater(out[-1, 9], last_epoch)
            last_epoch = out[-1, 9]
            self.assertEqual(p.signal()[-1, 0], 14)

    def test_no_stop_or_musical_verdict_in_protocol(self):
        self.assertNotIn('autostop', dict(PARAMS))
        self.assertNotIn('stop', OUTPUTS)
        self.assertEqual(set(STATES), set(range(18)))


class PreflightGraph(Graph):
    def __init__(self):
        super().__init__()
        self.boxes = {}
        self.wires = defaultdict(list)
        self.is_counting_in = 0
        self.preflight_params = {}
        self._flatten(make_experimental_patch()['patcher'], 'root')

    def send(self, id, msg=('bang',), inlet=0):
        if id == 'root/apf-engine':
            self.preflight_params[msg[0]] = msg[1]
            return
        super().send(id, msg, inlet)


class PreflightGraphTests(unittest.TestCase):
    def test_native_graph_embeds_source_and_exact_input_mapping(self):
        patch = make_experimental_patch()['patcher']
        b = boxmap(patch)
        self.assertEqual(boxmap(b['apf-engine']['patcher'])['code']['code'], SOURCE.read_text())
        es = edges(patch)
        for src, outlet, inlet in [('plugin', 0, 0), ('plugin', 1, 1),
                                  ('beat-plugin', 0, 2), ('beat-plugin', 1, 3), ('phasor', 0, 4)]:
            self.assertIn(((src, outlet), ('apf-engine', inlet)), es)
        self.assertEqual(b['popup'], boxmap(PATCH['patcher'])['popup'])

    def test_all_graph_ports_and_fanout_remain_valid(self):
        for name, patch in walk(make_experimental_patch()['patcher']):
            b = boxmap(patch)
            self.assertEqual(len(b), len(patch['boxes']), name)
            groups = defaultdict(list)
            for wrapped in patch['lines']:
                line = wrapped['patchline']
                src, dst = line['source'], line['destination']
                self.assertIn(src[0], b)
                self.assertIn(dst[0], b)
                self.assertLess(src[1], b[src[0]]['numoutlets'])
                self.assertLess(dst[1], b[dst[0]]['numinlets'])
                groups[tuple(src)].append(line)
            if patch['classnamespace'] == 'box':
                for lines in groups.values():
                    if len(lines) > 1:
                        self.assertEqual(sorted(x['order'] for x in lines), list(range(len(lines))))

    def test_native_observers_supply_all_host_flags_and_unknown_on_loss(self):
        g = PreflightGraph()
        g.initialize()
        for field, value in [('playing', 1), ('countingin', 0), ('recording', 0),
                             ('sessionrecord', 0), ('sessionstatus', 0)]:
            self.assertEqual(g.preflight_params[field], value, field)
        self.assertNotIn('voicebinding', g.preflight_params)
        self.assertNotIn('quality', g.preflight_params)
        g.emit('root/api-clear', (0,))
        for field in ('playing', 'countingin', 'recording', 'sessionrecord', 'sessionstatus'):
            self.assertEqual(g.preflight_params[field], -1)

    def test_countin_messages_and_polling_are_forwarded(self):
        g = PreflightGraph()
        g.initialize()
        g.emit('root/apf-count-observer', (1,))
        self.assertEqual(g.preflight_params['countingin'], 1)
        g.emit('root/qmetro')
        sequence = g.preflight_params['hostseq']
        g.emit('root/qmetro')
        self.assertGreater(g.preflight_params['hostseq'], sequence)
        self.assertFalse(g.calls)

    def test_routing_edit_revokes_acceptance_until_new_source_check(self):
        g = PreflightGraph()
        g.initialize()
        g.preflight_params['referencebinding'] = 1  # previously accepted fact
        g.emit('root/wave-control-route', (2,), 0)
        self.assertEqual(g.preflight_params['referencebinding'], 0)
        # An actual readback changes the path revision, never proves a voice.
        g.emit('root/beat-router', (2,), 0)
        self.assertGreater(g.preflight_params['audiorevision'], 0)
        self.assertEqual(g.preflight_params['referencebinding'], 0)

    def test_added_diagnostics_have_no_path_to_transport_or_old_controls(self):
        patch = make_experimental_patch()['patcher']
        adjacency = defaultdict(set)
        for src, dst in edges(patch):
            adjacency[src[0]].add(dst[0])
        for start in ('apf-state', 'apf-eligible', 'apf-epoch', 'apf-engine'):
            visited = set()
            pending = [start]
            while pending:
                current = pending.pop()
                if current in visited:
                    continue
                visited.add(current)
                pending.extend(adjacency[current])
            self.assertFalse(visited & {'stop-defer', 'stop-call', 'stop-object', 'engine', 'popup'})


if __name__ == '__main__':
    unittest.main()
