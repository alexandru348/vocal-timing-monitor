"""Synthetic acoustic diagnostics, explicitly not voice/musical-accuracy tests."""
from collections import defaultdict
from copy import deepcopy
import json
import struct
import unittest
import numpy as np
import build
from assistant_clarity import (make_clarity_patch, NAME, SOURCE, OUTPUTS, STATES, VERSION, TIMING_ENERGY_ATTACKS_FIELDS,
                               TIMING_ATTACK_LOG_CAPACITY, TIMING_GUIDED_FIELDS, TIMING_GUIDED_MESSAGES,
                               TIMING_SPEECH_CUE_FIELDS, TIMING_SPEECH_CUES, TIMING_PHRASE_CUE)
from assistant_sources import make_source_patch
from assistant_calibration_profile import PROFILE_NAME
from assistant_preflight import OUTPUTS as PREFLIGHT_OUTPUTS
from clarity_harness import Clarity
from latency_harness import shifted
from test_assistant_sources import SourceGraph
from test_latency import result
from test_static import boxmap, edges, walk, chunk


def column(name):
    return OUTPUTS.index(name)


def signals(sr=44100, seconds=4):
    t = np.arange(round(sr*seconds))/sr
    env = .45+.25*np.sin(2*np.pi*2.3*t)+.16*np.sin(2*np.pi*6.7*t)
    ref = env*(.22*np.sin(2*np.pi*170*t)+.16*np.sin(2*np.pi*760*t)+.10*np.sin(2*np.pi*3100*t))
    venv = .5+.27*np.sin(2*np.pi*4.1*t)+.17*np.sin(2*np.pi*9.3*t)
    other = venv*(.12*np.sin(2*np.pi*230*t)+.09*np.sin(2*np.pi*1100*t)+.08*np.sin(2*np.pi*2300*t))
    return ref, other


class AcousticDiagnosticsTests(unittest.TestCase):
    def test_calibrated_echo_recognized_across_rates_and_both_offset_signs(self):
        for sr in (44100, 48000, 96000):
            ref, _ = signals(sr)
            for offset in (-91.837, 0, 91.837, 500, -500):
                with self.subTest(sr=sr, offset=offset):
                    out = Clarity(sr).run(.2*shifted(ref, sr, offset), ref, offset=offset)
                    tail = out[-round(sr*.8):]
                    self.assertTrue(np.any(tail[:, 0] == 5))
                    self.assertFalse(np.any(out[:, 0] == 6))
                    self.assertGreater(np.max(tail[:, 1]), .90)
                    self.assertFalse(out[:, 8].any())

    def test_independent_modulated_signal_is_a_candidate_not_confirmed_voice(self):
        for sr in (44100, 48000, 96000):
            ref, other = signals(sr)
            out = Clarity(sr).run(other, ref)
            self.assertTrue(np.any(out[:, 0] == 6), sr)
            self.assertGreater(out[-1, 10], 0)
            self.assertFalse(out[:, 8].any())

    def test_stereo_inversion_right_only_and_channel_swap_do_not_cancel(self):
        ref, _ = signals()
        z = np.zeros_like(ref)
        for ml, mr, rl, rr in ((ref*.2, -ref*.2, ref, -ref),
                                (z, ref*.2, z, ref), (ref*.2, z, z, ref)):
            out = Clarity().run(ml, rl, right_mic=mr, right_ref=rr)
            self.assertEqual(out[-1, 0], 5)
            self.assertGreater(out[-1, 1], .98)

    def test_silence_weak_microphone_and_absent_reference_have_explicit_states(self):
        ref, other = signals()
        z = np.zeros_like(ref)
        for mic, r, expected in ((z, ref, 3), (other*.001, ref, 3), (other, z, 4), (z, z, 4)):
            out = Clarity().run(mic, r)
            self.assertEqual(out[-1, 0], expected)
            self.assertFalse(out[:, 8].any())

    def test_stationary_noise_is_not_promoted_to_distinct_candidate(self):
        for sr in (44100, 48000, 96000):
            ref, _ = signals(sr)
            noise = np.random.default_rng(12).normal(0, .02, len(ref))
            out = Clarity(sr).run(noise, ref)
            self.assertFalse(np.any(out[:, 0] == 6), sr)
            self.assertEqual(out[-1, 0], 7)

    def test_modulated_noise_can_be_distinct_but_never_voice(self):
        ref, _ = signals()
        t = np.arange(len(ref))/44100
        noise = np.random.default_rng(14).normal(0, .06, len(ref))*(.5+.45*np.sin(2*np.pi*3.1*t))
        out = Clarity().run(noise, ref)
        self.assertTrue(np.any(out[:, 0] == 6))
        self.assertFalse(out[:, 8].any())

    def test_mixture_and_reverberation_never_confirm_voice(self):
        ref, other = signals()
        echo = shifted(ref, 44100, 91.837)
        reverberant = .16*echo+.07*shifted(echo, 44100, 31)+.04*shifted(echo, 44100, 67)
        for input in (reverberant, reverberant+.03*other, reverberant+other):
            out = Clarity().run(input, ref, offset=91.837)
            self.assertFalse(out[:, 8].any())
            self.assertTrue(np.all((out[:, 1:3] >= 0) & (out[:, 1:3] <= 1)))

    def test_single_click_does_not_become_distinct_candidate(self):
        ref, _ = signals()
        mic = ref*0
        mic[60000] = .9
        out = Clarity().run(mic, ref)
        self.assertFalse(np.any(out[:, 0] == 6))

    def test_unmodulated_reference_is_insufficient_evidence(self):
        sr = 44100
        t = np.arange(sr*3)/sr
        ref = .2*np.sin(2*np.pi*300*t)
        out = Clarity().run(ref*.2, ref)
        self.assertEqual(out[-1, 0], 7)
        self.assertFalse(out[:, 8].any())

    def test_evidence_never_carries_over_epoch_or_offset_change(self):
        ref, other = signals()
        for change in ({'epoch': 2}, {'offset': 83}, {'permit': 0}):
            engine = Clarity()
            self.assertGreater(engine.run(other, ref)[-1, 10], 0)
            out = engine.run(other[:100], ref[:100], **change)
            self.assertTrue(np.all(out[:, [1, 2, 3, 4, 6, 9, 10, 11]] == 0))
            self.assertEqual(out[-1, 5], 0)

    def test_profile_revocation_and_recorded_mode_suspend_immediately(self):
        ref, other = signals()
        for params, code in (({'profilevalid': 0}, 8), ({'sourcemode': 2}, 9)):
            engine = Clarity()
            engine.run(other, ref)
            engine.set(**params)
            out = engine.run(other[:1], ref[:1])
            self.assertEqual(out[0, 0], code)
            self.assertEqual(out[0, 10], 0)
            self.assertEqual(out[0, 5], 0)

    def test_clipping_on_either_channel_revokes_stored_observations(self):
        ref, other = signals()
        for channel in range(4):
            engine = Clarity()
            engine.run(other, ref)
            arrays = [np.zeros(15000) for _ in range(4)]
            arrays[channel][0] = 1
            out = engine.run(arrays[0], arrays[2], right_mic=arrays[1], right_ref=arrays[3])
            self.assertEqual(out[0, 0], 2)
            hold = round(engine.sr * (.020 if channel < 2 else .250))
            self.assertEqual(out[hold-1, 0], 2)
            self.assertEqual(out[hold, 0], 1)
            self.assertEqual(out[-1, 0], 1)
            self.assertFalse(out[:, 10].any())

    def test_loud_mic_below_the_limit_preserves_acoustic_observations(self):
        ref, other = signals()
        engine = Clarity()
        before = engine.run(other, ref)[-1]
        after = engine.run(np.array([.995]), ref[:1])[0]
        self.assertGreater(before[column('distinct_windows')], 0)
        self.assertEqual(after[column('distinct_windows')], before[column('distinct_windows')])
        self.assertEqual(after[column('reset_episodes')], before[column('reset_episodes')])

    def test_chunking_does_not_change_envelope_or_state_results(self):
        ref, other = signals(seconds=2)
        expected = Clarity().run(other, ref, offset=83)
        engine = Clarity()
        actual = np.concatenate([engine.run(other[i:i+257], ref[i:i+257], offset=83)
                                 for i in range(0, len(ref), 257)])
        np.testing.assert_array_equal(actual, expected)

    def test_resume_rebuilds_the_full_window_without_stale_ring_contents(self):
        ref, other = signals()
        engine = Clarity()
        engine.run(other, ref)
        engine.run(other[:100], ref[:100], permit=0)
        out = engine.run(other[:22050], ref[:22050])
        self.assertTrue(np.all(out[:, 0] == 1))
        self.assertFalse(out[:, 10].any())

    def test_window_uses_past_samples_and_never_announces_early(self):
        ref, other = signals(seconds=2)
        out = Clarity().run(other, ref, offset=500)
        # 600 ms context + 500 ms delay + 40 ms lag guard + stability windows.
        self.assertFalse(np.any(out[:round(44100*1.14), 0] == 6))
        self.assertTrue(np.all(out[:, 5] <= 600))
        self.assertFalse(out[:, 8].any())

    def test_lifetime_diagnostics_distinguish_a_reset_from_no_computation(self):
        ref, other = signals(seconds=2)
        engine = Clarity()
        before = engine.run(other, ref, offset=91.47841113293867)
        self.assertGreater(before[-1, column('lifetime_windows')], 0)
        self.assertGreater(before[-1, column('longest_run_ms')], 1900)
        after = engine.run(other[:100], ref[:100], epoch=2, offset=91.47841113293867)
        self.assertEqual(after[-1, 0], 1)
        self.assertEqual(after[-1, 5], 0)
        self.assertEqual(after[-1, column('lifetime_windows')], before[-1, column('lifetime_windows')])
        self.assertEqual(after[-1, column('epoch_changes')], before[-1, column('epoch_changes')]+1)
        self.assertEqual(after[-1, column('last_reset_reason')], 2)
        self.assertEqual(after[-1, column('reset_episodes')], before[-1, column('reset_episodes')]+1)

    def test_repeated_short_contexts_reproduce_waiting_with_specific_cause(self):
        ref, other = signals(seconds=3)
        # Each context lasts less than the 730 ms required at this offset.
        epochs = 1+np.arange(len(ref))//round(.4*44100)
        out = Clarity().run(other, ref, epoch=epochs, offset=91.47841113293867)
        self.assertEqual(out[-1, 0], 1)
        self.assertFalse(out[:, 5].any())
        self.assertEqual(out[-1, column('lifetime_windows')], 0)
        self.assertGreater(out[-1, column('epoch_changes')], 5)
        self.assertLessEqual(out[-1, column('longest_run_ms')], 400)

    def test_harmless_offset_rounding_does_not_perpetually_restart(self):
        ref, other = signals(seconds=2)
        offset = 91.47841113293867+np.where(np.arange(len(ref)) % 2, 1e-8, -1e-8)
        out = Clarity().run(other, ref, offset=offset)
        self.assertGreater(out[-1, column('lifetime_windows')], 0)
        self.assertEqual(out[-1, column('offset_changes')], 1)

    def test_offset_anchor_detects_accumulated_drift_and_rejects_old_context(self):
        ref, other = signals(seconds=2)
        engine = Clarity()
        engine.run(other, ref, offset=91)
        # Every individual step is below epsilon but accumulated drift isn't.
        drift = 91+np.arange(1000)*1e-8
        out = engine.run(other[:1000], ref[:1000], offset=drift)
        self.assertGreater(out[-1, column('offset_changes')], 1)
        self.assertEqual(out[-1, 5], 0)

    def test_loss_of_permission_has_separate_diagnostic_counter(self):
        ref, other = signals(seconds=2)
        engine = Clarity()
        engine.run(other, ref)
        out = engine.run(other[:1000], ref[:1000], permit=0)
        self.assertEqual(out[-1, 0], 0)
        self.assertEqual(out[-1, column('permit_interruptions')], 1)
        self.assertEqual(out[-1, column('last_reset_reason')], 1)
        self.assertGreater(out[-1, column('lifetime_windows')], 0)
        self.assertEqual(out[-1, column('current_run_ms')], 0)

    def test_real_preflight_signal_outputs_supply_a_stable_analysis_window(self):
        from test_assistant_preflight import ready
        p = ready(quality=0, offsetms=91.47841113293867)
        ref, other = signals(seconds=3)
        preflight = p.run(other, ref)
        out = Clarity().run(other, ref, permit=preflight[:, 1],
                            epoch=preflight[:, 9], offset=preflight[:, 11])
        self.assertGreater(out[-1, column('lifetime_windows')], 0)
        self.assertFalse(out[:, 8].any())
        self.assertFalse(preflight[:, 2].any())


class ClarityGraph(SourceGraph):
    def __init__(self, **patch_options):
        super().__init__()
        self.boxes = {}
        self.wires = defaultdict(list)
        self._flatten(make_clarity_patch(**patch_options)['patcher'], 'root')
        self.clarity_params = {}

    def send(self, id, msg=('bang',), inlet=0):
        if id == 'root/aq-engine' and inlet == 0 and len(msg) == 2:
            self.clarity_params[msg[0]] = msg[1]
            return
        if id == 'root/aq-export-dict' and msg[0] == 'clone':
            # Stub only the documented dict clone semantics, not native Max.
            self.assert_clone_source = msg[1]
            assert msg[1] == '#0_vtm_source_report'
            self.state[id]['data'] = deepcopy(self.state['root/asrc-report']['data'])
            return
        super().send(id, msg, inlet)


class ClarityIntegrationTests(unittest.TestCase):
    def test_successful_calibration_and_mode_feed_distinctness_engine(self):
        g = ClarityGraph().initialized()
        self.assertEqual(g.clarity_params, {'profilevalid': 0, 'sourcemode': 1})
        g.click('calibrate'); result(g, 91.837)
        self.assertEqual(g.clarity_params['profilevalid'], 1)
        g.emit('root/audio-lost')
        self.assertEqual(g.clarity_params['profilevalid'], 0)
        self.assertNotIn('quality', g.preflight_params)

    def test_diagnostic_telemetry_and_explicit_export_include_new_observations(self):
        g = ClarityGraph().initialized()
        values = {name: float(i) for i, name in enumerate(OUTPUTS)}
        for name, value in values.items(): g.emit('root/aq-'+name, (value,))
        data = g.state['root/asrc-report']['data']
        for name, value in values.items(): self.assertEqual(data['clarity_'+name], (value,))
        self.assertEqual(data['format'], ('vtm-assistant-signal-'+VERSION,))
        self.assertNotIn('export_requested', g.state['root/asrc-report'])
        g.send('root/asrc-popup/export', (1,))
        self.assertTrue(g.state['root/aq-export-dict']['export_requested'])
        self.assertNotIn('export_requested', g.state['root/asrc-report'])
        self.assertFalse(g.calls)

    def test_export_refreshes_clones_then_survives_live_updates(self):
        g = ClarityGraph().initialized()
        g.state['root/aq-state']['signal_sample'] = 6
        g.state['root/aq-lifetime_windows']['signal_sample'] = 42
        g.state['root/apf-epoch']['signal_sample'] = 104
        g.state['root/aq-timing-count']['signal_sample'] = 8
        g.state['root/aq-timing-last_ms']['signal_sample'] = -26.5
        g.state['root/aq-timing-ready']['signal_sample'] = 1
        g.state['root/aq-timing-candidates']['signal_sample'] = 23
        g.state['root/aq-timing-reference_rejected']['signal_sample'] = 12
        g.state['root/aq-timing-uncertain']['signal_sample'] = 3
        g.state['root/aq-timing-model_state']['signal_sample'] = 2
        g.state['root/aq-timing-model_validation_reduction']['signal_sample'] = .78
        g.state['root/aq-timing-model_gain_fit_ms']['signal_sample'] = 495
        g.state['root/aq-timing-model_gain_left']['signal_sample'] = .28
        g.state['root/aq-timing-model_gain_right']['signal_sample'] = .42
        g.state['root/aq-timing-model_unscaled_validation_power_ratio']['signal_sample'] = 3.1
        g.state['root/aq-timing-model_beat_rejected']['signal_sample'] = 5
        g.state['root/aq-timing-model_speech_rejected']['signal_sample'] = 2
        timing_fields = {'band_state': 2, 'band_supported_mask': 7, 'band_validation_ms': 900,
                       'band_score_low': .84, 'band_score_mid': .67, 'band_score_high': .89,
                       'band_processed_ms': 12000, 'band_fit_ms': 2525, 'band_input_stage': 5,
                       'band_envelope_processed_ms': 11998, 'band_frames_received': 2394,
                       'band_requested_stage': 5,
                       'band_rejected': 4, 'band_beat_rejected': 3, 'band_speech_rejected': 1,
                       'attack_baseline_state': 2, 'attack_baseline_fit_ms': 3000,
                       'attack_baseline_validation_ms': 2000, 'attack_baseline_validation_candidates': 13,
                       'attack_baseline_validation_above': 0, 'attack_baseline_speech_candidates': 14,
                       'attack_baseline_speech_above': 3, 'attack_baseline_level_limit': .034,
                       'attack_baseline_speech_peak': .061}
        for field, value in timing_fields.items():
            g.state['root/aq-timing-'+field]['signal_sample'] = value
        attack_log = (3, 0) + (121.5, 798.25, 1350.75) + (0.,)*9 + (-30., 0., 22.5) + (0.,)*9
        for i, value in enumerate(attack_log):
            g.state['root/aq-timing-attack-log-sample-'+str(i)]['signal_sample'] = value
        for i in range(4*len(TIMING_SPEECH_CUE_FIELDS)):
            g.state['root/aq-timing-speech-cues-sample-'+str(i)]['signal_sample'] = i
        energy = (2, 2000, 0, 1, 0, 1, 1, 200, -1, 2710, 3950)
        for i, value in enumerate(energy):
            g.state['root/aq-timing-energy-attacks-sample-'+str(i)]['signal_sample'] = value
        energy_log = (2, 0) + (200., 2710.) + (0.,)*10 + (-27., 22.) + (0.,)*10
        for i, value in enumerate(energy_log):
            g.state['root/aq-timing-energy-attack-log-sample-'+str(i)]['signal_sample'] = value
        g.state['root/aq-timing-short-energy-attack-log-sample-0']['signal_sample'] = 3
        g.state['root/aq-timing-short-limit']['signal_sample'] = .105
        g.state['root/aq-grid-test-sample-0']['signal_sample'] = 5
        g.state['root/aq-grid-test-sample-1']['signal_sample'] = .0625
        g.state['root/aq-grid-test-attack-log-sample-0']['signal_sample'] = 6
        for i, value in enumerate((5, 6, 4.25, 1, 3, 2, 4, 3, 2, 4)):
            g.state['root/aq-grid-test-results-sample-'+str(i)]['signal_sample'] = value
        stimulus_times = (490., 1240., 1990., 2290., 3040., 3790.)
        expected_deltas = (-150., 0., 150., -150., 0., 150.)
        stimulus_log = (6, 0) + stimulus_times + (0.,)*6 + expected_deltas + (0.,)*6
        for i, value in enumerate(stimulus_log):
            g.state['root/aq-grid-test-stimulus-log-sample-'+str(i)]['signal_sample'] = value
        rhythm = (5, 1, 1, 1, 1, 2, 2, 4, 1, 1, 0., 165., 113., 0., 300.,
                  1, 0, 1, 0, 0, 0., 172., 0., 0.)
        for i, value in enumerate(rhythm):
            g.state['root/aq-rhythm-results-sample-'+str(i)]['signal_sample'] = value
        for i, field in enumerate(TIMING_GUIDED_FIELDS):
            g.state['root/aq-guided-timing-'+field]['signal_sample'] = i
        g.send('root/asrc-popup/export', (1,))
        frozen = deepcopy(g.state['root/aq-export-dict']['data'])
        self.assertEqual(frozen['clarity_state'], (6,))
        self.assertEqual(frozen['clarity_lifetime_windows'], (42,))
        self.assertEqual(frozen['preflight_epoch'], (104,))
        self.assertEqual(frozen['timing_probe_count'], (8,))
        self.assertEqual(frozen['timing_probe_last_ms'], (-26.5,))
        self.assertEqual(frozen['timing_probe_ready'], (1,))
        self.assertEqual(frozen['timing_probe_candidates'], (23,))
        self.assertEqual(frozen['timing_probe_reference_rejected'], (12,))
        self.assertEqual(frozen['timing_probe_uncertain'], (3,))
        self.assertEqual(frozen['timing_probe_model_state'], (2,))
        self.assertEqual(frozen['timing_probe_model_validation_reduction'], (.78,))
        self.assertEqual(frozen['timing_probe_model_gain_fit_ms'], (495,))
        self.assertEqual(frozen['timing_probe_model_gain_left'], (.28,))
        self.assertEqual(frozen['timing_probe_model_gain_right'], (.42,))
        self.assertEqual(frozen['timing_probe_model_unscaled_validation_power_ratio'], (3.1,))
        self.assertEqual(frozen['timing_probe_model_beat_rejected'], (5,))
        self.assertEqual(frozen['timing_probe_model_speech_rejected'], (2,))
        for field, value in timing_fields.items():
            self.assertEqual(frozen['timing_probe_'+field], (value,))
        self.assertEqual(frozen['timing_probe_above_limit_count'], (3,))
        self.assertEqual(frozen['timing_probe_above_limit_overflow'], (0,))
        capacity = TIMING_ATTACK_LOG_CAPACITY
        self.assertEqual(frozen['timing_probe_above_limit_after_prompt_ms'], attack_log[2:2+capacity])
        self.assertEqual(frozen['timing_probe_above_limit_quarter_note_delta_ms'], attack_log[2+capacity:])
        self.assertEqual(frozen['timing_probe_energy_attack_timing_count'], (2,))
        self.assertEqual(frozen['timing_probe_short_energy_attack_timing_count'], (3,))
        self.assertEqual(frozen['timing_probe_short_attack_baseline_level_limit'], (.105,))
        self.assertEqual(frozen['timing_probe_energy_attack_timing_overflow'], (0,))
        self.assertEqual(frozen['timing_probe_energy_attack_timing_after_prompt_ms'], energy_log[2:2+capacity])
        self.assertEqual(frozen['timing_probe_energy_attack_timing_quarter_note_delta_ms'], energy_log[2+capacity:])
        self.assertEqual(frozen['timing_grid_test_stage'], (5,))
        self.assertEqual(frozen['timing_grid_test_max_clock_error_ms'], (.0625,))
        self.assertEqual(frozen['timing_grid_test_count'], (6,))
        self.assertEqual(frozen['timing_grid_test_review_state'], (5,))
        self.assertEqual(frozen['timing_grid_test_review_count'], (6,))
        self.assertEqual(frozen['timing_grid_test_review_max_error_ms'], (4.25,))
        self.assertEqual(frozen['timing_grid_test_review_first_simulated_stop_index'], (1,))
        self.assertEqual(frozen['timing_grid_test_review_verdicts'], (3, 2, 4, 3, 2, 4))
        self.assertEqual(frozen['timing_grid_test_stimulus_count'], (6,))
        self.assertEqual(frozen['timing_grid_test_stimulus_after_prompt_ms'][:6], stimulus_times)
        self.assertEqual(frozen['timing_grid_test_stimulus_quarter_note_delta_ms'][:6], expected_deltas)
        self.assertEqual(frozen['rhythm_probe_state'], (5,))
        self.assertEqual(frozen['rhythm_probe_extra_attacks'], (1,))
        self.assertEqual(frozen['rhythm_probe_slot_counts'], (1, 1, 1, 2))
        self.assertEqual(frozen['rhythm_probe_slot_verdicts'], (2, 4, 1, 1))
        self.assertEqual(frozen['rhythm_probe_slot_deviation_ms'], (0., 165., 113., 0.))
        self.assertEqual(frozen['rhythm_probe_reference_ms'], (1800., 3300., 4800., 6300.))
        self.assertEqual(frozen['rhythm_probe_anchor_after_prompt_ms'], (300.,))
        self.assertEqual(frozen['rhythm_probe_extra_clipped_candidates'], (1,))
        self.assertEqual(frozen['rhythm_probe_slot_clipped_candidates'], (0, 1, 0, 0))
        self.assertEqual(frozen['rhythm_probe_slot_clipped_estimate_ms'], (0., 172., 0., 0.))
        self.assertEqual(frozen['timing_grid_test_expected_ms'], expected_deltas)
        self.assertEqual(frozen['timing_grid_test_injected_delay_ms'], (90.,))
        for i, field in enumerate(TIMING_SPEECH_CUE_FIELDS):
            self.assertEqual(frozen['timing_probe_speech_cue_'+field], tuple(range(4*i, 4*(i+1))))
        i = 0
        for field, width in TIMING_ENERGY_ATTACKS_FIELDS:
            self.assertEqual(frozen['timing_probe_energy_attacks_'+field], energy[i:i+width])
            i += width
        for i, field in enumerate(TIMING_GUIDED_FIELDS):
            self.assertEqual(frozen['timing_guided_'+field], (i,))
        # E.g. poll lease expires while the native save dialog is open.
        g.emit('root/aq-state', (1,))
        g.emit('root/apf-epoch', (105,))
        self.assertEqual(g.state['root/aq-export-dict']['data'], frozen)
        self.assertEqual(g.state['root/asrc-report']['data']['clarity_state'], (1,))
        self.assertFalse(g.calls)

    def test_new_ui_explains_unknown_origin_and_follows_theme(self):
        g = ClarityGraph().initialized()
        for code, label in STATES.items():
            g.emit('root/aq-state', (code,))
            self.assertEqual(' '.join(g.state['root/asrc-popup/aq-status']['label']), label)
        for code, label in enumerate(TIMING_GUIDED_MESSAGES):
            g.emit('root/aq-guided-timing-stage', (code,))
            self.assertEqual(' '.join(g.state['root/asrc-popup/aq-guided-timing-note']['label']), label)
        g.emit('root/aq-guided-timing-stage', (3,))
        for cue, label in enumerate((*TIMING_SPEECH_CUES, TIMING_PHRASE_CUE), start=1):
            g.emit('root/aq-timing-speech-cue', (cue,))
            self.assertEqual(' '.join(map(str, g.state['root/asrc-popup/aq-guided-timing-note']['label'])), label)
        g.emit('root/aq-guided-timing-stage', (5,))
        g.emit('root/aq-timing-speech-cue', (0,))
        self.assertEqual(' '.join(g.state['root/asrc-popup/aq-guided-timing-note']['label']), TIMING_GUIDED_MESSAGES[5])
        g.click('theme')
        commands = g.state['root/asrc-popup/window']['commands']
        self.assertTrue(any(cmd[:4] == ('script', 'send', 'asrc_ui_aq-status', 'textcolor') for cmd in commands))
        self.assertFalse(g.calls)

    def test_rhythm_cues_and_detected_count_have_independent_labels(self):
        g = ClarityGraph().initialized()
        displayed = lambda name: ' '.join(g.state['root/asrc-popup/'+name]['label'])
        g.emit('root/aq-rhythm-progress', (0,))
        for cue in (5, 6, 7, 8):
            g.emit('root/aq-rhythm-cue', (cue,))
            self.assertEqual(displayed('aq-guided-timing-note'), f'TA · reper {cue-4}/4')
            self.assertEqual(displayed('aq-rhythm-progress'), 'Repere · 0/4')
        g.emit('root/aq-rhythm-clip-warning', (1,))
        self.assertIn('atac posibil', displayed('aq-rhythm-clip-warning'))
        self.assertEqual(displayed('aq-rhythm-progress'), 'Repere · 0/4')
        g.emit('root/aq-rhythm-progress', (1,))
        self.assertEqual(displayed('aq-rhythm-progress'), 'Repere · 1/4')
        g.emit('root/aq-rhythm-clip-warning', (0,))
        self.assertEqual(displayed('aq-rhythm-clip-warning'), '')
        g.emit('root/aq-rhythm-progress', (-1,))
        self.assertEqual(displayed('aq-rhythm-progress'), '')

    def test_wiring_geometry_and_coherent_signal_context(self):
        patch = make_clarity_patch()['patcher']
        for path, graph in walk(patch):
            boxes = boxmap(graph)
            self.assertEqual(len(boxes), len(graph['boxes']))
            self.assertEqual(len(edges(graph)), len(set(edges(graph))))
            for src, dst in edges(graph):
                self.assertTrue(0 <= src[1] < boxes[src[0]]['numoutlets'], (path, src))
                self.assertTrue(0 <= dst[1] < boxes[dst[0]]['numinlets'], (path, dst))
            if path in ('root', 'root/asrc-popup'):
                width, height = (360, 169) if path == 'root' else tuple(graph['openrect'][2:])
                for box in boxes.values():
                    if box.get('presentation'):
                        x, y, w, h = box['presentation_rect']
                        self.assertTrue(x >= 0 and y >= 0 and x+w <= width and y+h <= height, (path, box['id']))
        for outlet, inlet in ((1, 4), (9, 5), (11, 6)):
            self.assertIn((('apf-engine', outlet), ('aq-engine', inlet)), edges(patch))
        wiring = set(edges(patch))
        for channel in range(2):
            self.assertIn((('beat-plugin', channel), ('aq-timing-bleed', 2+channel)), wiring)
            self.assertIn((('beat-plugin', channel), ('aq-timing-band-levels', 2+channel)), wiring)
            self.assertIn((('plugin', channel), ('aq-timing-band-levels', channel)), wiring)
            self.assertIn((('beat-plugin', channel), ('aq-guided-timing-engine', 2+channel)), wiring)
        for outlet in range(7):
            self.assertIn((('aq-timing-band-levels', outlet), ('aq-timing-bands', outlet)), wiring)
        for outlet in range(4):
            self.assertIn((('aq-timing-bands', outlet), ('aq-timing-bleed', 13+outlet)), wiring)
        self.assertIn((('aq-guided-timing-request', 0), ('aq-guided-timing-engine', 0)), wiring)
        self.assertIn((('aq-guided-phrase-request', 0), ('aq-guided-timing-engine', 0)), wiring)
        self.assertIn((('aq-guided-timing-change', 0), ('aq-guided-timing-learning', 0)), wiring)
        self.assertIn((('aq-guided-timing-learning', 0), ('aq-timing-bleed', 0)), wiring)
        self.assertIn((('aq-guided-timing-change', 0), ('aq-guided-timing-band-stage', 0)), wiring)
        self.assertIn((('aq-guided-timing-band-stage', 0), ('aq-timing-bands', 12)), wiring)
        self.assertEqual(boxmap(patch)['aq-guided-timing-band-stage']['text'], 'sig~ 0')
        self.assertIn((('aq-timing-features', 0), ('aq-timing-bleed', 4)), wiring)
        for inlet, outlet in enumerate((0, 1, 2, 6)):
            self.assertIn((('aq-timing-band-levels', outlet), ('aq-timing-attack-baseline', inlet)), wiring)
        self.assertIn((('aq-timing-features', 0), ('aq-timing-attack-baseline', 4)), wiring)
        self.assertIn((('aq-guided-timing-engine', 0), ('aq-timing-attack-baseline', 9)), wiring)
        self.assertEqual({dst[0] for src, dst in wiring if src[0] == 'aq-timing-attack-baseline'},
                         {'aq-timing-attack-grid', 'aq-timing-attack-log', 'aq-timing-speech-cues',
                          'aq-timing-energy-attacks'} | {'aq-timing-'+field for field in (
                             'attack_baseline_state', 'attack_baseline_fit_ms', 'attack_baseline_validation_ms',
                             'attack_baseline_validation_candidates', 'attack_baseline_validation_above',
                             'attack_baseline_speech_candidates', 'attack_baseline_speech_above',
                             'attack_baseline_level_limit', 'attack_baseline_speech_peak')})
        self.assertIn((('aq-timing-attack-baseline', 9), ('aq-timing-attack-grid', 0)), wiring)
        self.assertIn((('aq-timing-attack-baseline', 9), ('aq-timing-speech-cues', 6)), wiring)
        self.assertIn((('aq-timing-attack-baseline', 10), ('aq-timing-speech-cues', 3)), wiring)
        self.assertIn((('aq-guided-timing-engine', 0), ('aq-timing-attack-log', 4)), wiring)
        self.assertIn((('aq-timing-attack-baseline', 11), ('aq-timing-energy-attacks', 2)), wiring)
        self.assertIn((('aq-timing-attack-baseline', 12), ('aq-timing-energy-attacks', 3)), wiring)
        for inlet, name in enumerate(('rawphase', 'periodms', 'appliedoffsetms', 'sampleclock'), start=7):
            self.assertIn((('apf-engine', PREFLIGHT_OUTPUTS.index(name)), ('aq-timing-energy-attacks', inlet)), wiring)
        mode_outlet = TIMING_GUIDED_FIELDS.index('phrase_mode')
        self.assertIn((('aq-guided-timing-engine', mode_outlet), ('aq-timing-energy-attacks', 11)), wiring)
        self.assertEqual(boxmap(patch)['aq-timing-short-init']['text'], 'shortframes 1')
        self.assertEqual({dst[0] for src, dst in wiring if src[0] == 'aq-timing-short-init'},
                         {'aq-timing-short-band-levels', 'aq-timing-short-attack-baseline',
                          'aq-timing-short-energy-attacks'})
        for inlet, name in enumerate(('probe_clip_pause', 'clipping'), start=12):
            self.assertIn((('apf-engine', PREFLIGHT_OUTPUTS.index(name)), ('aq-timing-energy-attacks', inlet)), wiring)
        self.assertEqual(boxmap(patch)['aq-grid-test-mode']['text'], 'sig~ 0')
        self.assertIn((('aq-grid-test-mode', 0), ('aq-grid-test-attacks', 11)), wiring)
        self.assertEqual({dst for src, dst in wiring if src == ('aq-grid-test-review', 2)},
                         {('aq-grid-test-results', 4)})
        self.assertEqual({src for src, dst in wiring if dst == ('aq-grid-test-status-sample', 0)},
                         {('aq-grid-test-results', 0), ('poll', 0)})
        for inlet in range(4):
            self.assertIn((('aq-timing-energy-attacks', 11+inlet), ('aq-timing-energy-attack-grid', inlet)), wiring)
        self.assertEqual({dst[0] for src, dst in wiring if src[0] == 'aq-timing-energy-attacks'},
                         {f'aq-timing-energy-attacks-sample-{i}'
                          for i in range(sum(size for _, size in TIMING_ENERGY_ATTACKS_FIELDS))} |
                         {'aq-timing-energy-attack-grid', 'aq-timing-energy-attack-log', 'aq-rhythm-capture'})
        self.assertEqual({dst for src, dst in wiring if src[0] == 'aq-rhythm-review'},
                         {('aq-rhythm-results', 5), ('aq-rhythm-results', 6)})
        self.assertEqual({dst for src, dst in wiring if src == ('aq-timing-energy-attacks', 16)},
                         {('aq-rhythm-capture', 11)})
        self.assertEqual({(src, dst) for src, dst in wiring if src in {('aq-rhythm-capture', 9),
                                                                    ('aq-rhythm-capture', 10)}},
                         {(('aq-rhythm-capture', 9), ('aq-rhythm-results', 8)),
                          (('aq-rhythm-capture', 10), ('aq-rhythm-results', 9))})
        self.assertNotIn(('aq-rhythm-review', 6), {dst for _, dst in wiring})
        self.assertEqual({dst[0] for src, dst in wiring if src[0] == 'aq-timing-speech-cues'},
                         {f'aq-timing-speech-cues-sample-{i}' for i in range(4*len(TIMING_SPEECH_CUE_FIELDS))})
        for inlet, outlet in enumerate((11, 12, 13, 7), start=1):
            self.assertIn((('aq-timing-features', outlet), ('aq-timing-attack-grid', inlet)), wiring)
        for outlet in range(2+2*TIMING_ATTACK_LOG_CAPACITY):
            snapshot = 'aq-timing-attack-log-sample-'+str(outlet)
            self.assertIn((('aq-timing-attack-log', outlet), (snapshot, 0)), wiring)
            self.assertIn((('aq-timing-attack-log-poll', outlet), (snapshot, 0)), wiring)
        self.assertEqual({src for src, dst in wiring if dst == ('aq-timing-grid', 0)},
                         {('aq-timing-bleed', 0)})

    def test_no_new_path_to_original_controls_quality_or_stop(self):
        patch = make_clarity_patch()['patcher']
        original = make_source_patch()['patcher']
        self.assertEqual(boxmap(patch)['popup'], boxmap(original)['popup'])
        self.assertEqual(patch['parameters'],
                         original['parameters'] | {'ac-profile-persist': [PROFILE_NAME, PROFILE_NAME, 0]})
        original_edges = set(edges(original))
        for src, dst in edges(patch):
            if src[0].startswith('aq-'):
                calibration_snapshot = src == ('aq-export-capture', 7) and dst in (
                    ('ac-automatic-requests-store', 0), ('ac-manual-requests-store', 0))
                self.assertTrue(calibration_snapshot or dst[0].startswith('aq-') or dst[0] in (
                    'asrc-report', 'asrc-popup', 'asrc-export', 'apf-poll', 'apf-diagnostic-poll'), (src, dst))
        # The frozen export and the automatic retry hook replace these wires.
        replaced = {(('asrc-ui-route', 2), ('asrc-export', 0)),
                    (('asrc-export', 0), ('asrc-report', 0)),
                    (('control-route', 5), ('ac-nonzero', 0)),
                    *((('lat-terminal', outlet), ('ac-inactive', 0)) for outlet in range(3))}
        self.assertEqual(original_edges-set(edges(patch)), replaced)
        for id, box in boxmap(patch).items():
            if id.startswith('aq-'):
                self.assertNotIn('quality', box.get('text', ''))
                self.assertFalse(box.get('text', '').startswith(('set ', 'call ', 'live.routing')))
        self.assertIn('out9 = 0;', SOURCE.read_text())

    def test_frozen_package_roundtrip_and_no_external_runtime_dependencies(self):
        patch = make_clarity_patch()
        blob = build.amxd_bytes(patch, NAME+'.amxd')
        self.assertEqual(blob[:4], b'ampf')
        self.assertEqual(struct.unpack_from('<I', blob, 28)[0], len(blob)-32)
        collective = blob[32:]
        _, directory, _ = chunk(collective, struct.unpack_from('>I', collective, 12)[0], b'dlst')
        _, entry, _ = chunk(directory, 0, b'dire')
        fields = {}; pos = 0
        while pos < len(entry):
            tag, value, pos = chunk(entry, pos); fields[tag] = value
        offset = struct.unpack('>I', fields[b'of32'])[0]
        size = struct.unpack('>I', fields[b'sz32'])[0]
        self.assertEqual(json.loads(collective[offset:offset+size]), patch)
        self.assertEqual(patch['patcher']['dependency_cache'], [])


if __name__ == '__main__':
    unittest.main()
