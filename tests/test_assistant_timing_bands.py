"""Paired microphone/reference tests including different waveform phases."""
import re
import unittest

import numpy as np

from assistant_clarity import TIMING_ENERGY_ATTACKS_SOURCE
from gen_harness import Engine, ROOT, compile_harness, load_library
from genexpr_scope import validate_scope
from test_assistant_bleed import BleedEngine, features_for, shift
from test_assistant_grid import project


SOURCE = ROOT / 'src/vtm_assistant_timing_bands.genexpr'
LEVEL_SOURCE = ROOT / 'src/vtm_assistant_timing_band_levels.genexpr'
BASELINE_SOURCE = ROOT / 'src/vtm_assistant_attack_baseline.genexpr'
ATTACK_LOG_SOURCE = ROOT / 'src/vtm_assistant_attack_log.genexpr'
validate_scope(SOURCE.read_text(), inputs=13, outputs=13)
validate_scope(LEVEL_SOURCE.read_text(), inputs=4, outputs=8)
validate_scope(BASELINE_SOURCE.read_text(), inputs=11, outputs=13)
validate_scope(ATTACK_LOG_SOURCE.read_text(), inputs=6, outputs=26)
validate_scope(TIMING_ENERGY_ATTACKS_SOURCE.read_text(), inputs=14, outputs=17)
PARAMS = compile_harness(SOURCE, 'assistant_timing_bands_harness', inputs=13, outputs=13)
LEVEL_PARAMS = compile_harness(LEVEL_SOURCE, 'assistant_timing_band_levels_harness', inputs=4, outputs=8)
BASELINE_PARAMS = compile_harness(BASELINE_SOURCE, 'assistant_attack_baseline_harness', inputs=11, outputs=13)
ATTACK_LOG_PARAMS = compile_harness(ATTACK_LOG_SOURCE, 'assistant_attack_log_harness', inputs=6, outputs=26)
ENERGY_PARAMS = compile_harness(TIMING_ENERGY_ATTACKS_SOURCE, 'assistant_energy_attacks_harness', inputs=14, outputs=17)


class BandLevels(Engine):
    lib = load_library('assistant_timing_band_levels_harness', inputs=4)
    params = LEVEL_PARAMS
    output_count = 8

    def measure(self, mic, ref):
        return self.run(left=mic[0], right=mic[1], phase=ref[0], extra=(ref[1],))


class BandEngine(Engine):
    lib = load_library('assistant_timing_bands_harness', inputs=13)
    params = PARAMS
    output_count = 13

    def __init__(self, *, sr):
        super().__init__(sr=sr)
        self.levels = BandLevels(sr=sr)

    def run_probe(self, mic, ref, *, offset, stage, source=0, permit=1):
        levels = self.levels.measure(mic, ref)
        return self.fit(levels, offset=offset, stage=stage, source=source, permit=permit)

    def fit(self, levels, *, offset, stage, source=0, permit=1):
        mic_low, mic_mid, mic_high, *ref_and_clock = levels[:, :7].T
        return self.run(left=mic_low, right=mic_mid, phase=mic_high,
                        extra=(*ref_and_clock, permit, 1, offset, source, 0, stage))


class AttackBaseline(Engine):
    lib = load_library('assistant_attack_baseline_harness', inputs=11)
    params = BASELINE_PARAMS
    output_count = 13

    def run_probe(self, mic, ref, *, stage, source=0, reference_present=1):
        levels = BandLevels(sr=self.sr).measure(mic, ref)
        candidates = features_for(mic, self.sr, 91.2)[:, 0]
        return self.run(left=levels[:, 0], right=levels[:, 1], phase=levels[:, 2],
                        extra=(levels[:, 6], candidates, 1, 1, source, 0, stage, reference_present))


class AttackLog(Engine):
    lib = load_library('assistant_attack_log_harness', inputs=6)
    params = ATTACK_LOG_PARAMS
    output_count = 26

    def capture(self, projected, *, onsets_ms, clock, stage, baseline_state):
        return self.run(left=projected[:, 0], right=projected[:, 1], phase=onsets_ms,
                        extra=(clock, stage, baseline_state))


class EnergyAttacks(Engine):
    lib = load_library('assistant_energy_attacks_harness', inputs=14)
    params = ENERGY_PARAMS
    output_count = 17


def changed_waveform_beat(sr, offset, *, voice=False):
    t = np.arange(8*sr) / sr
    envelopes = []
    rng = np.random.default_rng(884)
    for band in range(3):
        env = np.zeros_like(t)
        for seconds in np.arange(.25, 7.8, .25):
            start = round((seconds+.004*band)*sr)
            a = np.arange(round(.12*sr))/sr
            env[start:start+len(a)] = rng.uniform(.55, 1) * (1 - np.exp(-a/.006)) * np.exp(-a/.05)
        envelopes.append(env)
    ref = sum(.14*env*np.sin(2*np.pi*freq*t)
              for env, freq in zip(envelopes, (101, 628, 2317)))
    mic = sum(level*env*np.sin(2*np.pi*freq*t)
              for env, freq, level in zip(envelopes, (170, 910, 3421), (.028, .045, .037)))
    mic = shift(mic, sr, offset)
    voice_at = round((6 + offset/1000) * sr)
    if voice:
        a = np.arange(round(.072*sr))/sr
        added = .063*(np.sin(2*np.pi*287*a) + .43*np.sin(2*np.pi*1131*a))*np.exp(-7*a)
        mic[voice_at:voice_at+len(a)] += added
    return (mic, .86*mic), (ref, .92*ref), voice_at


class TimingBandsTests(unittest.TestCase):
    def test_band_model_assigns_peek_reads_before_using_them_in_expressions(self):
        source = re.sub(r'//[^\n]*', '', SOURCE.read_text())
        calls = re.findall(r'\bpeek\s*\(', source)
        direct_reads = re.findall(r'^\s*\w+\s*=\s*peek\([^();\n]*\);\s*$', source, re.MULTILINE)
        self.assertTrue(calls)
        self.assertEqual(len(calls), len(direct_reads))

    def test_matches_changed_waveform_beat_and_preserves_an_overlapping_onset(self):
        sr = 44100
        for offset in (91.2, -91.2):
            with self.subTest(offset=offset):
                mic, ref, voice_at = changed_waveform_beat(sr, offset, voice=True)
                features = features_for(mic, sr, offset)
                band_filter = BandEngine(sr=sr)
                timing = BleedEngine(sr=sr, learningstage=2)
                split = 5*sr
                measured = []
                for start, end, stage in ((0, split, 2), (split, len(mic[0]), 3)):
                    timing.set(learningstage=stage)
                    m = tuple(ch[start:end] for ch in mic)
                    r = tuple(ch[start:end] for ch in ref)
                    bands = band_filter.run_probe(m, r, offset=offset, stage=stage)
                    chunk = timing.run_probe(m, r, features[start:end], offset=offset,
                                             bands=bands[:, :4].T)
                    self.assertEqual(bands[-1, 3], 2)
                    self.assertEqual(bands[-1, 4], 7)
                    self.assertGreater(min(bands[-1, 6:9]), .45)
                    measured.append(chunk)
                beat, speech = measured
                self.assertGreater(beat[-1, 20], 0)
                self.assertGreater(speech[-1, 21], 0)
                self.assertEqual(speech[-1, 19], speech[-1, 20]+speech[-1, 21])
                self.assertEqual(speech[-1, 4], sum(speech[-1, 5:7]) +
                                 np.count_nonzero(beat[:, 0]) + np.count_nonzero(speech[:, 0]))
                event_times = (np.flatnonzero(speech[:, 0]) + split) / sr
                self.assertTrue(np.any(np.abs(event_times - voice_at/sr) < .14))
                kept = speech[speech[:, 0] == 1]
                raw_phase = (voice_at / sr / .6) % 1
                phase_errors = (kept[:, 1] - raw_phase + .5) % 1 - .5
                self.assertTrue(np.any(np.abs(phase_errors) < .045))

    def test_unrelated_reference_and_changed_route_prevent_suppression(self):
        sr = 16000
        offset = 91.2
        mic, ref, _ = changed_waveform_beat(sr, offset)
        shifted = tuple(np.roll(ch, round(.12*sr)) for ch in mic)
        bands = BandEngine(sr=sr).run_probe(shifted, ref, offset=offset, stage=2)
        self.assertEqual(bands[-1, 3], 3)
        self.assertEqual(bands[-1, 4], 0)
        self.assertFalse(bands[:, 0].any())
        changed = np.arange(len(mic[0])) >= 4*sr
        bands = BandEngine(sr=sr).run_probe(mic, ref, offset=offset, stage=2, source=changed)
        self.assertEqual(bands[4*sr-1, 3], 2)
        self.assertEqual(bands[4*sr, 3], 3)
        self.assertFalse(bands[4*sr:, 0].any())

    def test_sampled_probe_stage_drives_fit_and_retains_report_after_stop(self):
        sr = 16000
        offset = 91.2
        mic, ref, _ = changed_waveform_beat(sr, offset)
        stages = np.repeat([1, 2, 3, 4, 5], [sr, 5*sr, sr, sr//2, sr//2])
        out = BandEngine(sr=sr).run_probe(mic, ref, offset=offset, stage=stages,
                                          permit=stages < 5)
        self.assertEqual(out[sr-1, 3], 0)
        self.assertEqual(out[sr, 3], 1)
        self.assertEqual(out[-1, 3], 2)
        self.assertEqual(out[-1, 9], 8000)
        self.assertGreater(out[-1, 10], 2400)
        self.assertEqual(out[-1, 11], 5)
        self.assertEqual(out[-1, 12], 1600)
        self.assertGreater(out[-1, 5], 850)
        np.testing.assert_array_equal(out[-1, 3:9], out[7*sr-1, 3:9])
        self.assertFalse(out[7*sr:, 0].any())

    def test_model_clock_distinguishes_an_input_without_frames_from_a_stopped_model(self):
        sr = 44100
        length = 2 * sr
        silent = np.zeros(length)
        levels = BandLevels(sr=sr).measure((silent, silent), (silent, silent))
        self.assertGreater(levels[-1, 7], 1990)
        self.assertEqual(np.count_nonzero(levels[:, 6]), length // 221)
        self.assertFalse(levels[:, :6].any())
        out = BandEngine(sr=sr).fit(np.zeros_like(levels), offset=0, stage=2)
        self.assertEqual(out[-1, 9], 2000)
        self.assertEqual(out[-1, 11], 2)
        self.assertEqual(out[-1, 12], 0)
        self.assertFalse(out[:, 0].any())


class AttackBaselineTests(unittest.TestCase):
    def test_extra_energy_is_observed_over_a_valid_beat_only_baseline(self):
        sr = 16000
        stages = np.repeat([2, 3, 5], [5*sr, 2*sr, sr])
        for voice in (False, True):
            with self.subTest(voice=voice):
                mic, ref, _ = changed_waveform_beat(sr, 91.2, voice=voice)
                out = AttackBaseline(sr=sr).run_probe(mic, ref, stage=stages)
                self.assertEqual(out[-1, 0], 2)
                self.assertGreaterEqual(out[-1, 3], 6)
                self.assertEqual(out[-1, 4], 0)
                self.assertGreater(out[-1, 5], 0)
                self.assertEqual(out[-1, 6], int(voice))
                self.assertEqual(np.count_nonzero(out[:, 9]), int(voice))
                # The probe results stay frozen while the envelope continues to track input.
                np.testing.assert_array_equal(out[-1, :10], out[7*sr-1, :10])

    def test_stronger_held_out_beat_disables_the_baseline(self):
        sr = 16000
        stages = np.repeat([2, 3], [5*sr, 3*sr])
        mic, ref, _ = changed_waveform_beat(sr, 91.2, voice=True)
        stronger = tuple(ch.copy() for ch in mic)
        for ch in stronger:
            ch[4*sr:5*sr] *= 2
        out = AttackBaseline(sr=sr).run_probe(stronger, ref, stage=stages)
        self.assertEqual(out[-1, 0], 3)
        self.assertGreater(out[-1, 4], 0)
        self.assertEqual(out[-1, 5], 0)

    def test_lost_reference_or_changed_routing_prevents_baseline_use(self):
        sr = 16000
        stages = np.repeat([2, 3], [5*sr, 3*sr])
        mic, ref, _ = changed_waveform_beat(sr, 91.2, voice=True)
        out = AttackBaseline(sr=sr).run_probe(mic, ref, stage=stages, reference_present=0)
        self.assertEqual(out[-1, 0], 3)
        self.assertEqual(out[-1, 1], 0)
        changed = np.arange(8*sr) >= round(5.7*sr)
        out = AttackBaseline(sr=sr).run_probe(mic, ref, stage=stages, source=changed)
        self.assertEqual(out[5*sr, 0], 2)
        self.assertEqual(out[-1, 0], 3)
        self.assertEqual(out[-1, 6], 0)


class EnergyAttackTests(unittest.TestCase):
    def probe(self, *, control_peak_ms=0, interrupted=False, mode=0, clip_at_ms=None, clip_mask=0,
              shortframes=0):
        sr = 8000
        t = np.arange(12 * sr) / sr
        stage = np.repeat([1, 2, 3, 5], [sr, 5*sr, 5*sr, sr])
        cue = np.where(stage == 3, 1 + np.floor((t - 6) / 1.25), 0)
        hop = sr // (500 if shortframes else 200)
        frame = np.arange(len(t)) % hop == hop-1
        level = np.full(len(t), .018)
        onsets = 6.2 + 1.25*np.arange(4)
        for onset in onsets:
            level[(t >= onset) & (t < onset+.055)] = .12
            level[(t >= onset+.08) & (t < onset+.13)] = .18
        if control_peak_ms:
            level[(t >= 4) & (t < 4+control_peak_ms/1000)] = .12
        old_candidates = (stage == 2) & (np.arange(len(t)) % (sr//5) == 0)
        permit = np.ones(len(t))
        clipping = np.zeros(len(t))
        if interrupted:
            # The gap overlaps a rise and returns while energy is still high.
            permit[(t >= onsets[1]-.01) & (t < onsets[1]+.04)] = 0
        if clip_at_ms is not None:
            # Full-scale saturation during a syllable closes the preflight gate.
            gap = (t >= onsets[3]+clip_at_ms/1000) & (t < onsets[3]+.14)
            permit[gap] = 0
            clipping[gap] = clip_mask
        mic = level * frame
        silence = np.zeros_like(mic)
        baseline = AttackBaseline(sr=sr, shortframes=shortframes).run(left=mic, right=silence, phase=silence,
            extra=(frame, old_candidates, permit, 1, 0, 0, stage, 1))
        clock = np.arange(len(t))
        phase = np.remainder(clock / (sr * .6), 1)
        result = EnergyAttacks(sr=sr, shortframes=shortframes).run(left=stage, right=cue, phase=baseline[:, 11],
            extra=(baseline[:, 12], frame, baseline[:, 7], baseline[:, 0], phase, 600, 225, clock,
                   mode, clipping != 0, clipping))
        grid = project(result[:, 12], event=result[:, 11], period=result[:, 13],
                       offset=result[:, 14], context=permit)
        log = AttackLog(sr=sr).capture(grid, onsets_ms=result[:, 15], clock=clock,
                                       stage=stage, baseline_state=result[:, 0])
        possible = result[result[:, 16] == 1, 15]
        return baseline[-1], result[-1], log[-1], possible

    def test_resolves_sustained_rises_without_old_candidates_or_duplicate_peaks(self):
        baseline, final, log, _ = self.probe()
        self.assertEqual(baseline[6], 0)
        self.assertEqual(final[0], 2)
        self.assertEqual(final[2], 0)
        np.testing.assert_array_equal(final[3:7], [1, 1, 1, 1])
        np.testing.assert_allclose(final[7:11], [200, 1450, 2700, 3950], atol=5)
        self.assertEqual(log[0], 4)
        self.assertEqual(log[1], 0)
        np.testing.assert_allclose(log[2:6], [200, 1450, 2700, 3950], atol=5)
        np.testing.assert_allclose(log[14:18], [-25, 25, 75, 125], atol=5)

    def test_rejects_the_new_method_when_beat_alone_triggers_it(self):
        baseline, final, log, _ = self.probe(control_peak_ms=90)
        self.assertEqual(baseline[0], 2)  # the older candidate limitation would pass
        self.assertEqual(final[0], 3)
        self.assertEqual(final[2], 1)
        self.assertFalse(final[3:7].any())
        self.assertEqual(log[0], 0)

    def test_rhythm_confirms_a_clean_onset_before_vowel_saturation(self):
        _, other_mode, _, _ = self.probe(clip_at_ms=12, clip_mask=1)
        _, rhythm, log, possible = self.probe(mode=2, clip_at_ms=12, clip_mask=1)
        self.assertEqual(other_mode[6], 0)
        self.assertEqual(rhythm[6], 1)
        self.assertAlmostEqual(log[5], 3950, delta=5)
        self.assertEqual(len(possible), 0)

    def test_short_detection_measures_an_onset_when_clipping_begins_after_five_ms(self):
        _, regular, _, _ = self.probe(mode=1, clip_at_ms=5, clip_mask=1)
        _, short, log, _ = self.probe(mode=1, shortframes=1, clip_at_ms=5, clip_mask=1)
        self.assertEqual(regular[6], 0)
        self.assertEqual(short[6], 1)
        self.assertAlmostEqual(log[5], 3950, delta=2)

    def test_short_detection_rejects_fast_control_hits_and_truncated_speech(self):
        _, rejected, log, _ = self.probe(mode=1, shortframes=1, control_peak_ms=4)
        self.assertEqual(rejected[0], 3)
        self.assertEqual(rejected[2], 1)
        self.assertEqual(log[0], 0)
        _, short, _, _ = self.probe(mode=1, shortframes=1, clip_at_ms=3, clip_mask=1)
        self.assertEqual(short[6], 0)

    def test_band_level_producer_uses_the_same_short_frame_duration(self):
        for rate, hop in ((44100, 88), (48000, 96)):
            silence = np.zeros(hop*3)
            levels = BandLevels(sr=rate, shortframes=1).measure((silence, silence), (silence, silence))
            np.testing.assert_array_equal(np.flatnonzero(levels[:, 6]), [hop-1, 2*hop-1, 3*hop-1])

    def test_rhythm_rejects_frames_cut_short_by_saturation(self):
        _, rhythm, log, possible = self.probe(mode=2, clip_at_ms=8, clip_mask=1)
        self.assertEqual(rhythm[6], 0)
        self.assertEqual(log[0], 3)
        np.testing.assert_allclose(possible, [9950], atol=5)

    def test_clipped_candidate_requires_a_clean_first_frame_and_a_microphone_only_pause(self):
        for args in ({'clip_at_ms': 3, 'clip_mask': 1}, {'clip_at_ms': 8, 'clip_mask': 2},
                     {'clip_at_ms': 8, 'clip_mask': 3}, {'clip_at_ms': 8, 'clip_mask': 0}):
            with self.subTest(args=args):
                _, _, _, possible = self.probe(mode=2, **args)
                self.assertEqual(len(possible), 0)

    def test_rhythm_requires_a_clean_beat_only_control_at_the_same_sensitivity(self):
        _, other_mode, _, _ = self.probe(control_peak_ms=10)
        _, rhythm, log, _ = self.probe(mode=2, control_peak_ms=10)
        self.assertEqual(other_mode[0], 2)
        self.assertEqual(rhythm[0], 3)
        self.assertEqual(rhythm[2], 1)
        self.assertEqual(log[0], 0)

    def test_resume_during_a_rise_does_not_fabricate_an_onset(self):
        _, final, log, _ = self.probe(interrupted=True)
        self.assertEqual(final[0], 2)
        np.testing.assert_array_equal(final[3:7], [1, 0, 1, 1])
        self.assertEqual(final[8], -1)
        self.assertEqual(log[0], 3)
        np.testing.assert_allclose(log[14:17], [-25, 75, 125], atol=5)


class AttackLogTests(unittest.TestCase):
    def test_above_baseline_onset_keeps_compensated_grid_and_prompt_time(self):
        sr = 16000
        offset = 91.2
        stages = np.repeat([2, 3, 5], [5*sr, 2*sr, sr])
        mic, ref, voice_at = changed_waveform_beat(sr, offset, voice=True)
        features = features_for(mic, sr, offset)
        baseline = AttackBaseline(sr=sr).run_probe(mic, ref, stage=stages)
        grid = project(features[:, 11], event=baseline[:, 9], period=features[:, 12],
                       offset=features[:, 13], context=features[:, 7])
        rows = AttackLog(sr=sr).capture(grid, onsets_ms=features[:, 2], clock=features[:, 10],
                                        stage=stages, baseline_state=baseline[:, 0])
        final = rows[-1]
        self.assertEqual(final[0], 1)
        self.assertAlmostEqual(final[2], 1000*(voice_at/sr - 5), delta=10.1)
        self.assertAlmostEqual(final[14], 0, delta=10.1)
        self.assertFalse(final[3:14].any())
        np.testing.assert_array_equal(final, rows[7*sr-1])

    def test_capacity_and_invalid_or_new_probe_clear_previous_measurements(self):
        sr = 16000
        positions = np.repeat([0, 150, -150], 5)
        offsets = (positions + 91.2) / 600 % 1
        grid = project(offsets, offset=91.2)
        log = AttackLog(sr=sr)
        row = log.capture(grid, onsets_ms=np.arange(len(grid))*100.,
                          clock=np.arange(len(grid)), stage=3, baseline_state=2)[-1]
        np.testing.assert_array_equal(row[:2], (12, 3))
        np.testing.assert_allclose(row[14:], positions[:12], atol=1e-10)
        np.testing.assert_array_equal(row[2:14], np.arange(12)*100.)
        stopped = log.capture(grid[:1], onsets_ms=[0], clock=[15], stage=5, baseline_state=2)
        np.testing.assert_array_equal(stopped[0], row)
        new = log.capture(grid[:1], onsets_ms=[0], clock=[16], stage=1, baseline_state=0)
        self.assertFalse(new.any())
        accepted = log.capture(grid[:1], onsets_ms=[0], clock=[17], stage=3, baseline_state=2)
        self.assertEqual(accepted[0, 0], 1)
        invalid = log.capture(grid[:1], onsets_ms=[0], clock=[18], stage=3, baseline_state=3)
        self.assertFalse(invalid.any())
