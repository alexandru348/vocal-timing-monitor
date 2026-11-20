"""Acoustic diagnostics and optional guided rhythm practice; build-time Python only.

Only voice-checked events in a guided recording can request a guided Stop.
"""
from pathlib import Path
import json
import build
from assistant_preflight import OUTPUTS as PREFLIGHT_OUTPUTS
from assistant_sources import make_source_patch
from assistant_calibration_profile import add_saved_calibration, verified_record
from automatic_calibration import add_diagnostic_calibration_retries
from studio_ui import PALETTES

ROOT = Path(__file__).resolve().parent
VERSION = '0.2.52'
NAME = 'Vocal_Timing_Monitor_Asistent_Ritm_Vocal_Semnal_v'+VERSION.replace('.', '_')
SOURCE = ROOT / 'src/vtm_assistant_clarity.genexpr'
TIMING_FEATURE_SOURCE = ROOT / 'src/vtm_assistant_features.genexpr'
TIMING_BLEED_SOURCE = ROOT / 'src/vtm_assistant_bleed.genexpr'
TIMING_BAND_LEVEL_SOURCE = ROOT / 'src/vtm_assistant_timing_band_levels.genexpr'
TIMING_ATTACK_BASELINE_SOURCE = ROOT / 'src/vtm_assistant_attack_baseline.genexpr'
TIMING_ENERGY_ATTACKS_SOURCE = ROOT / 'src/vtm_assistant_energy_attacks.genexpr'
TIMING_VOICED_ATTACKS_SOURCE = ROOT / 'src/vtm_assistant_voiced_attacks.genexpr'
TIMING_ENERGY_ATTACKS_FIELDS = (('state', 1), ('validation_ms', 1), ('validation_events', 1),
                               ('cue_counts', 4), ('first_after_prompt_ms', 4))
TIMING_ATTACK_LOG_SOURCE = ROOT / 'src/vtm_assistant_attack_log.genexpr'
TIMING_ATTACK_LOG_CAPACITY = 12
TIMING_SPEECH_CUE_SOURCE = ROOT / 'src/vtm_assistant_speech_cues.genexpr'
TIMING_SPEECH_CUE_FIELDS = ('valid_ms', 'mic_peak', 'candidates', 'candidate_peak', 'above_limit', 'clip_pause_ms')
TIMING_SPEECH_CUES = tuple(f'Spune „ta” o dată · {i}/4' for i in range(1, 5))
TIMING_BANDS_SOURCE = ROOT / 'src/vtm_assistant_timing_bands.genexpr'
TIMING_GUIDED_SOURCE = ROOT / 'src/vtm_assistant_bleed_probe.genexpr'
RHYTHM_CAPTURE_SOURCE = ROOT / 'src/vtm_assistant_rhythm_capture.genexpr'
RHYTHM_RESULTS_SOURCE = ROOT / 'src/vtm_assistant_rhythm_results.genexpr'
REFERENCE_TIMING_SOURCE = ROOT / 'src/vtm_assistant_reference_timing.genexpr'
RHYTHM_TEST_MARGIN_MS = 35
TIMING_GRID_SOURCE = ROOT / 'src/vtm_assistant_grid.genexpr'
TIMING_GRID_TEST_SOURCE = ROOT / 'src/vtm_assistant_grid_test.genexpr'
TIMING_GRID_TEST_RESULTS_SOURCE = ROOT / 'src/vtm_assistant_grid_test_results.genexpr'
OUTPUTS = ('state', 'envelope_match', 'unexplained_variation', 'input_level',
           'reference_level', 'window_ms', 'input_activity', 'epoch',
           'voice_confirmed', 'reference_like_windows', 'distinct_windows',
           'uncertain_windows', 'filled_frames', 'frame_samples', 'current_run_ms',
           'longest_run_ms', 'last_reset_reason', 'reset_episodes', 'lifetime_windows',
           'epoch_changes', 'offset_changes', 'permit_interruptions',
           'profile_changes', 'source_changes', 'sampleclock', 'reference_model',
           'comparison_lag_ms', 'band_match_low', 'band_match_mid',
           'band_match_high', 'usable_bands', 'input_variation', 'peak_reference_match',
           'band_input_level_low',
           'band_input_level_mid',
           'band_input_level_high',
           'band_reference_level_low',
           'band_reference_level_mid',
           'band_reference_level_high',
           'band_input_variation_low',
           'band_input_variation_mid',
           'band_input_variation_high',
           'band_reference_variation_low',
           'band_reference_variation_mid',
           'band_reference_variation_high',
           'band_weight_low',
           'band_weight_mid',
           'band_weight_high',
           'usable_band_mask',
           'reference_supported_band_mask',
           'partial_reference_windows',
           'band_reference_windows_low',
           'band_reference_windows_mid',
           'band_reference_windows_high',
           'background_state', 'background_request', 'background_frames',
           'background_duration_ms',
           'background_mean_low', 'background_mean_mid', 'background_mean_high',
           'background_variance_low', 'background_variance_mid', 'background_variance_high',
           'background_comparison_state',
           'background_comparison_frames',
           'background_comparison_duration_ms',
           'background_comparison_windows',
           'background_above_band_mask',
           'background_comparison_end_sampleclock',
           'background_current_mean_low',
           'background_current_mean_mid',
           'background_current_mean_high',
           'background_limit_low',
           'background_limit_mid',
           'background_limit_high',
           'background_above_fraction_low',
           'background_above_fraction_mid',
           'background_above_fraction_high',
           'background_ratio_valid_band_mask',
           'background_mean_ratio_low',
           'background_mean_ratio_mid',
           'background_mean_ratio_high',
           'background_within_windows',
           'background_above_windows',
           'background_uncertain_windows',
           'test_phase_state',
           'test_speakers_request',
           'test_audible_gate_sampleclock',
           'test_completed_phase_mask',
           'test_muted_windows',
           'test_muted_duration_ms',
           'test_muted_within_windows',
           'test_muted_above_windows',
           'test_muted_uncertain_windows',
           'test_muted_start_sampleclock',
           'test_muted_end_sampleclock',
           'test_muted_mean_low',
           'test_muted_mean_mid',
           'test_muted_mean_high',
           'test_muted_above_fraction_low',
           'test_muted_above_fraction_mid',
           'test_muted_above_fraction_high',
           'test_muted_above_windows_low',
           'test_muted_above_windows_mid',
           'test_muted_above_windows_high',
           'test_audible_windows',
           'test_audible_duration_ms',
           'test_audible_within_windows',
           'test_audible_above_windows',
           'test_audible_uncertain_windows',
           'test_audible_start_sampleclock',
           'test_audible_end_sampleclock',
           'test_audible_mean_low',
           'test_audible_mean_mid',
           'test_audible_mean_high',
           'test_audible_above_fraction_low',
           'test_audible_above_fraction_mid',
           'test_audible_above_fraction_high',
           'test_audible_above_windows_low',
           'test_audible_above_windows_mid',
           'test_audible_above_windows_high',
           'completed_result_available',
           'completed_result_sampleclock',
           'completed_result_epoch',
           'completed_result_offset_ms',
           'completed_result_samplerate',
           'completed_result_background_request',
           'completed_result_source_mode',
           'completed_result_profile_valid',
           'completed_result_completed_phase_mask',
           'completed_result_background_frames',
           'completed_result_background_duration_ms',
           'completed_result_background_mean_low',
           'completed_result_background_mean_mid',
           'completed_result_background_mean_high',
           'completed_result_background_variance_low',
           'completed_result_background_variance_mid',
           'completed_result_background_variance_high',
           'completed_result_background_limit_low',
           'completed_result_background_limit_mid',
           'completed_result_background_limit_high',
           'completed_result_muted_windows',
           'completed_result_muted_duration_ms',
           'completed_result_muted_within_windows',
           'completed_result_muted_above_windows',
           'completed_result_muted_uncertain_windows',
           'completed_result_muted_start_sampleclock',
           'completed_result_muted_end_sampleclock',
           'completed_result_muted_mean_low',
           'completed_result_muted_mean_mid',
           'completed_result_muted_mean_high',
           'completed_result_muted_above_fraction_low',
           'completed_result_muted_above_fraction_mid',
           'completed_result_muted_above_fraction_high',
           'completed_result_muted_above_windows_low',
           'completed_result_muted_above_windows_mid',
           'completed_result_muted_above_windows_high',
           'completed_result_audible_windows',
           'completed_result_audible_duration_ms',
           'completed_result_audible_within_windows',
           'completed_result_audible_above_windows',
           'completed_result_audible_uncertain_windows',
           'completed_result_audible_start_sampleclock',
           'completed_result_audible_end_sampleclock',
           'completed_result_audible_mean_low',
           'completed_result_audible_mean_mid',
           'completed_result_audible_mean_high',
           'completed_result_audible_above_fraction_low',
           'completed_result_audible_above_fraction_mid',
           'completed_result_audible_above_fraction_high',
           'completed_result_audible_above_windows_low',
           'completed_result_audible_above_windows_mid',
           'completed_result_audible_above_windows_high',
           )
BACKGROUND_STATES = {
    0: 'Fundal nemăsurat',
    1: 'Măsor fundalul. Păstrează liniștea 5 secunde',
    2: 'Fundal măsurat. Urmează mesajul etapei',
    3: 'Măsurare invalidată. Reia cu redarea stabilă',
}
BACKGROUND_COMPARISON_STATES = {
    0: 'Comparația așteaptă măsurarea fundalului',
    1: 'Compar cu fundalul. Așteaptă o secundă',
    2: 'Fără depășiri persistente ale pragurilor fundalului',
    3: 'Nivel peste fundalul măsurat. Sursa rămâne neconfirmată',
    4: 'Depășiri intermitente ale fundalului. Sursa rămâne neconfirmată',
}
TEST_PHASE_STATES = {
    0: 'Proba așteaptă măsurarea fundalului',
    1: 'Etapa 1/2 · Lasă difuzoarele pe mut. Măsor 10 secunde',
    2: 'Etapa 1 gata. Pornește difuzoarele și apasă Continuă',
    3: 'Etapa 2/2 · Pregătesc măsurarea. Nu vorbi',
    4: 'Etapa 2/2 · Urmează indicația de mai jos',
    5: 'Proba încheiată. Poți opri și salva raportul',
    6: 'Proba invalidată. Reia măsurarea fundalului',
    7: 'Rezultat păstrat. Poți salva cu redarea oprită',
    8: 'Nivel prea ridicat pentru o probă completă',
}
GUIDED_CUES = {
    0: 'Lasă difuzoarele pe mut și rămâi în liniște pentru proba de fundal.',
    1: 'Rămâi în liniște.',
    2: 'Vorbește acum cu voce normală.',
    3: 'Oprește-te din vorbit și rămâi în liniște.',
    4: 'Raportul păstrează observațiile pe intervale.',
    5: 'Poți salva raportul pentru a vedea de unde vine vârful.',
}
STATES = {
    0: 'Aștept sursele și redarea stabilă',
    1: 'Ascult semnalul. Așteaptă câteva secunde',
    2: 'Semnal prea puternic. Evaluarea rămâne suspendată',
    3: 'Semnal slab la microfon. Aștept sunet',
    4: 'Aștept instrumentalul pentru comparație',
    5: 'Microfonul captează un semnal asemănător instrumentalului',
    6: 'Asemănare redusă cu instrumentalul. Originea sunetului este neconfirmată',
    7: 'Nu pot diferenția sigur semnalele în această porțiune',
    8: 'Calibrează întârzierea pe traseul actual',
    9: 'Această verificare este disponibilă pentru intrarea live',
    10: 'O parte din sunet seamănă cu instrumentalul. Restul rămâne neclar',
    11: 'Vârf audio. Continui automat când nivelul revine.',
}


RESULT_SOURCE = ROOT / 'src/vtm_completed_result.genexpr'
RESULT_START = OUTPUTS.index('completed_result_available')
RESULT_FIELDS = OUTPUTS[RESULT_START:RESULT_START+52]
JOINT_LIVE_FIELDS = ('joint_window_end_sampleclock', 'joint_band_codes', 'joint_above_counts')
JOINT_CATEGORIES = ('within', 'intermittent', 'above_reference', 'above_low_match', 'above_unusable')
JOINT_RESULT_FIELDS = ('completed_joint_available',) + tuple(
    'completed_joint_'+phase+'_'+suffix
    for phase in ('muted', 'audible')
    for suffix in ('observations', 'skipped', 'first_window_start_sampleclock',
                   'last_window_end_sampleclock') + tuple(
                       category+'_'+band for category in JOINT_CATEGORIES
                       for band in ('low', 'mid', 'high')))
GUIDED_INTERVALS = {'quiet_before': 4, 'speech_prompt': 6, 'quiet_after': 5}
GUIDED_FIELDS = ('observations', 'skipped') + tuple(
    metric+'_'+band for metric in ('persistent', 'low_match') for band in ('low', 'mid', 'high'))
GUIDED_RESULT_FIELDS = ('completed_guided_available',) + tuple(
    'completed_guided_'+interval+'_'+field
    for interval in GUIDED_INTERVALS for field in GUIDED_FIELDS)
GUIDED_OUTPUTS = ('guided_cue',) + GUIDED_RESULT_FIELDS
OUTPUTS += JOINT_LIVE_FIELDS + JOINT_RESULT_FIELDS + GUIDED_OUTPUTS
RAW_OUTPUTS = OUTPUTS[:RESULT_START] + ('source_mode', 'profile_valid') + JOINT_LIVE_FIELDS
# One analysis engine, one small synchronous history keeper. Never extend
# either codebox/gen~ or a message trigger into the failing high-port range.
RESULT_INPUTS = ('test_phase_state',) + tuple(
    name.removeprefix('completed_result_') for name in RESULT_FIELDS
    if name not in ('completed_result_available', 'completed_result_samplerate')) + JOINT_LIVE_FIELDS
KEEPER_OUTPUTS = RESULT_FIELDS + ('test_phase_state',) + JOINT_RESULT_FIELDS + GUIDED_OUTPUTS


def result_input_source(name):
    if name == 'offset_ms':
        return ('apf-engine', 11)
    raw = ('test_' + name if name.startswith(('muted_', 'audible_')) or
           name == 'completed_phase_mask' else name)
    return ('aq-engine', RAW_OUTPUTS.index(raw))


def telemetry_source(name):
    if name == 'test_phase_state':
        return ('aq-result-engine', len(RESULT_FIELDS))
    if name in RESULT_FIELDS:
        return ('aq-result-engine', RESULT_FIELDS.index(name))
    if name in JOINT_RESULT_FIELDS or name in GUIDED_OUTPUTS:
        return ('aq-result-engine', KEEPER_OUTPUTS.index(name))
    return ('aq-engine', RAW_OUTPUTS.index(name))


def gen_graph(*, result=False):
    return signal_graph(RESULT_SOURCE if result else SOURCE,
                        len(RESULT_INPUTS) if result else 8,
                        len(KEEPER_OUTPUTS) if result else len(RAW_OUTPUTS))


def signal_graph(source, inputs, outputs):
    from genexpr_scope import validate_scope
    code = source.read_text()
    validate_scope(code, inputs=inputs, outputs=outputs)
    g = build.Patch(900, 700, 'dsp.gen')
    g.p['openinpresentation'] = 0
    g.box('code', 'codebox', ins=inputs, outs=outputs,
          code=code,
          rect=[20, 20, 850, 650])
    for i in range(inputs):
        g.obj('in'+str(i+1), 'in '+str(i+1), 0, 1)
        g.wire('in'+str(i+1), 'code', 0, i)
    for i in range(outputs):
        g.obj('out'+str(i+1), 'out '+str(i+1), 1, 0)
        g.wire('code', 'out'+str(i+1), i)
    return g.p


def add_timing_probe(p, ui):
    """Observe attack timing on a fixed quarter-note grid during the live probe."""
    preflight = {name: ('apf-engine', PREFLIGHT_OUTPUTS.index(name)) for name in
                 ('rawphase', 'timing_probe_permit', 'epoch', 'periodms', 'appliedoffsetms')}
    for name, source, inputs, outputs in (('features', TIMING_FEATURE_SOURCE, 7, 14),
                                          ('band-levels', TIMING_BAND_LEVEL_SOURCE, 4, 8),
                                          ('attack-baseline', TIMING_ATTACK_BASELINE_SOURCE, 11, 13),
                                          ('bands', TIMING_BANDS_SOURCE, 13, 13),
                                          ('bleed', TIMING_BLEED_SOURCE, 17, 22),
                                          ('grid', TIMING_GRID_SOURCE, 5, 5)):
        p.obj('aq-timing-'+name, 'gen~', inputs, outputs,
              patcher=signal_graph(source, inputs, outputs), outlettype=['signal']*outputs)
    inputs = [('plugin', 0), ('plugin', 1), *preflight.values()]
    for i, (source, outlet) in enumerate(inputs):
        p.wire(source, 'aq-timing-features', outlet, i)
    p.msg('aq-timing-use-preflight', 'hostcontext 1')
    p.wire('ready-defer', 'aq-timing-use-preflight')
    p.wire('aq-timing-use-preflight', 'aq-timing-features')
    audio = [('plugin', 0), ('plugin', 1), ('beat-plugin', 0), ('beat-plugin', 1)]
    analysis_context = [('apf-engine', PREFLIGHT_OUTPUTS.index(name)) for name in
                        ('timing_probe_permit', 'epoch', 'appliedoffsetms', 'sourcechanges', 'timingchanges')]
    for i, (source, outlet) in enumerate(audio):
        p.wire(source, 'aq-timing-band-levels', outlet, i)
    model_inputs = [('aq-timing-band-levels', i) for i in range(7)] + analysis_context
    for i, (source, outlet) in enumerate(model_inputs):
        p.wire(source, 'aq-timing-bands', outlet, i)
    wire_attack_baseline(p, 'aq-timing-band-levels', 'aq-timing-attack-baseline')
    bleed_inputs = audio.copy()
    bleed_inputs.extend(('aq-timing-features', outlet) for outlet in (0, 11, 12, 13))
    bleed_inputs.extend(analysis_context)
    bleed_inputs.extend(('aq-timing-bands', outlet) for outlet in range(4))
    for i, (source, outlet) in enumerate(bleed_inputs):
        p.wire(source, 'aq-timing-bleed', outlet, i)
    for i in range(4):
        p.wire('aq-timing-bleed', 'aq-timing-grid', i, i)
    source, outlet = preflight['timing_probe_permit']
    p.wire(source, 'aq-timing-grid', outlet, 4)

    fields = {'count': ('aq-timing-grid', 3), 'last_ms': ('aq-timing-grid', 4),
              'ready': preflight['timing_probe_permit'],
              'candidates': ('aq-timing-bleed', 4), 'reference_rejected': ('aq-timing-bleed', 5),
              'uncertain': ('aq-timing-bleed', 6),
              **{field: ('aq-timing-bleed', i) for i, field in enumerate((
                  'model_state', 'model_validation_reduction', 'model_validation_ms',
                  'model_rejected', 'model_beat_rejected', 'model_speech_rejected',
                  'model_gain_fit_ms', 'model_gain_left', 'model_gain_right',
                  'model_unscaled_validation_power_ratio', 'band_rejected',
                  'band_beat_rejected', 'band_speech_rejected'), start=9)},
              **{field: ('aq-timing-bands', i) for i, field in enumerate((
                  'band_state', 'band_supported_mask', 'band_validation_ms',
                  'band_score_low', 'band_score_mid', 'band_score_high',
                  'band_processed_ms', 'band_fit_ms', 'band_input_stage', 'band_frames_received'), start=3)},
              'band_envelope_processed_ms': ('aq-timing-band-levels', 7),
              'band_requested_stage': ('aq-guided-timing-band-stage', 0)}
    baseline_fields = {f'attack_baseline_{field}': ('aq-timing-attack-baseline', i)
                       for i, field in enumerate(('state', 'fit_ms', 'validation_ms',
                                                  'validation_candidates', 'validation_above',
                                                  'speech_candidates', 'speech_above',
                                                  'level_limit', 'speech_peak'))}
    for poll, group in (('aq-timing-poll', fields), ('aq-timing-baseline-poll', baseline_fields)):
        p.obj(poll, 't'+' b'*len(group), 1, len(group))
        p.wire('poll', poll)
        for i, (name, (source, outlet)) in enumerate(group.items()):
            label = 'aq-timing-'+name
            p.obj(label, 'snapshot~')
            p.wire(source, label, outlet)
            p.wire(poll, label, len(group)-1-i)
            p.obj(label+'-report', 'prepend replace timing_probe_'+name)
            p.wire(label, label+'-report')
            p.wire(label+'-report', 'asrc-report')
            if name in ('count', 'last_ms', 'ready'):
                p.obj(label+'-tag', 'prepend timing_'+name)
                p.wire(label, label+'-tag')
                p.wire(label+'-tag', 'asrc-popup')

    ui.label('aq-timing-status', 'Probă ritmică pe grila 1/4 · în așteptare', [20, 502, 600, 19], 12)
    ui.label('aq-timing-count', 'Atacuri măsurate după filtrare: 0', [20, 524, 280, 21], 12)
    ui.label('aq-timing-last', 'Ultima abatere: —', [312, 524, 308, 21], 12)
    ui.obj('aq-timing-route', 'route timing_count timing_last_ms timing_ready', 1, 4)
    ui.wire('in', 'aq-timing-route')
    for field, fmt in (('count', 'Atacuri măsurate după filtrare: %ld'),
                       ('last', 'Ultima abatere: %+.1f ms')):
        ui.obj('aq-timing-'+field+'-format', 'sprintf '+fmt)
        ui.obj('aq-timing-'+field+'-set', 'prepend set')
        ui.wire('aq-timing-'+field+'-format', 'aq-timing-'+field+'-set')
        ui.wire('aq-timing-'+field+'-set', 'aq-timing-'+field)
    ui.wire('aq-timing-route', 'aq-timing-count-format')
    ui.obj('aq-timing-has-count', '> 0', 2)
    ui.obj('aq-timing-last-gate', 'gate 1 0', 2)
    ui.wire('aq-timing-route', 'aq-timing-has-count')
    ui.wire('aq-timing-has-count', 'aq-timing-last-gate')
    ui.wire('aq-timing-route', 'aq-timing-last-gate', 1, 1)
    ui.wire('aq-timing-last-gate', 'aq-timing-last-format')
    ui.obj('aq-timing-ready-change', 'change -1', 3, 3)
    ui.obj('aq-timing-ready-select', 'sel 0 1', 1, 3)
    ui.wire('aq-timing-route', 'aq-timing-ready-change', 2)
    ui.wire('aq-timing-ready-change', 'aq-timing-ready-select')
    for i, text in enumerate(('în așteptare', 'ascultă intrarea')):
        id = 'aq-timing-status-'+str(i)
        ui.msg(id, 'set Probă ritmică pe grila 1/4 · '+text)
        ui.wire('aq-timing-ready-select', id, i)
        ui.wire(id, 'aq-timing-status')


def wire_attack_baseline(p, levels, baseline):
    context = ('timing_probe_permit', 'epoch', 'sourcechanges', 'timingchanges')
    inputs = [*((levels, outlet) for outlet in (0, 1, 2, 6)), ('aq-timing-features', 0),
              *(('apf-engine', PREFLIGHT_OUTPUTS.index(name)) for name in context),
              ('aq-guided-timing-engine', 0), ('apf-engine', PREFLIGHT_OUTPUTS.index('referencepresent'))]
    for i, (source, outlet) in enumerate(inputs):
        p.wire(source, baseline, outlet, i)


def add_timing_attack_log(p):
    """Reuse the grid projection and snapshot the event log only on export."""
    features = 'aq-timing-features'
    baseline = 'aq-timing-attack-baseline'
    grid_inputs = [(baseline, 9), *((features, outlet) for outlet in (11, 12, 13, 7))]
    attack_clock = [(features, 2), (features, 10)]
    add_attack_timing_log(p, 'aq-timing-attack', grid_inputs, attack_clock, (baseline, 0),
                          'timing_probe_above_limit_')


def add_attack_timing_log(p, name, projection, clocks, state, report_prefix, *,
                          stage=('aq-guided-timing-engine', 0)):
    grid, log = name+'-grid', name+'-log'
    capacity = TIMING_ATTACK_LOG_CAPACITY
    width = 2 + 2 * capacity
    p.obj(grid, 'gen~', 5, 5, patcher=signal_graph(TIMING_GRID_SOURCE, 5, 5),
          outlettype=['signal']*5)
    for inlet, (source, outlet) in enumerate(projection):
        p.wire(source, grid, outlet, inlet)
    p.obj(log, 'gen~', 6, width, patcher=signal_graph(TIMING_ATTACK_LOG_SOURCE, 6, width),
          outlettype=['signal']*width)
    for inlet, (source, outlet) in enumerate([
            (grid, 0), (grid, 1), *clocks, stage, state]):
        p.wire(source, log, outlet, inlet)

    fields = ('count', 'overflow', 'after_prompt_ms', 'quarter_note_delta_ms')
    add_signal_list_export(p, log, report_prefix, zip(fields, (1, 1, capacity, capacity)))


def add_signal_list_export(p, engine, prefix, fields):
    fields = list(fields)
    width = sum(size for _, size in fields)
    poll = engine+'-poll'
    p.obj(poll, 't'+' b'*width, 1, width)
    p.wire('aq-export-capture', poll, 7)
    for outlet in range(width):
        snapshot = engine+'-sample-'+str(outlet)
        p.obj(snapshot, 'snapshot~')
        p.wire(engine, snapshot, outlet)
        p.wire(poll, snapshot, outlet)
    outlet = 0
    for field, size in fields:
        report = engine+'-report-'+field
        p.obj(report, 'prepend replace '+prefix+field)
        p.wire(report, 'asrc-report')
        if size == 1:
            p.wire(engine+'-sample-'+str(outlet), report)
        else:
            pack = engine+'-pack-'+field
            p.obj(pack, 'pack'+' 0.'*size, size, 1)
            for i in range(size):
                p.wire(engine+'-sample-'+str(outlet+i), pack, 0, i)
            p.wire(pack, report)
        outlet += size


TIMING_GUIDED_FIELDS = ('stage', 'calibrated_offset_ms', 'acoustic_lag_ms',
                        'envelope_match', 'envelope_alternative', 'alignment_pairs') + tuple(
    phase + '_' + field for phase in ('beat', 'speech') for field in
    ('valid_ms', 'candidates', 'measured', 'reference_rejected', 'uncertain',
     'waveform_compared', 'mean_waveform_match')) + (
    'beat_mic_level', 'beat_reference_level', 'envelope_at_calibrated_offset', 'phrase_mode', 'speech_window_ms')
TIMING_PHRASE_CUE = 'Spune fraza în ritmul tău · 12 secunde.'
TIMING_GUIDED_MESSAGES = (
    'Pornește instrumentalul la volumul obișnuit pentru probă.',
    'Pregătire · rămâi în liniște.',
    'Rămâi în liniște. Lasă instrumentalul să cânte.',
    'Ascult microfonul.',
    'Calculez rezultatul. Poți opri redarea.',
    'Probă terminată. Apasă Salvează raportul.',
    'Proba s-a întrerupt. Pornește redarea stabilă și încearcă din nou.',
)


def add_guided_timing_probe(p, ui, *, guided_stop=False, voice_stop_test=False):
    engine = 'aq-guided-timing-engine'
    cue_outlet = len(TIMING_GUIDED_FIELDS)
    prompt_outlet = cue_outlet + 1
    width = prompt_outlet + 1
    p.obj(engine, 'gen~', 12, width, patcher=signal_graph(TIMING_GUIDED_SOURCE, 12, width),
          outlettype=['signal']*width)
    inputs = [('plugin', 0), ('plugin', 1), ('beat-plugin', 0), ('beat-plugin', 1),
              ('apf-engine', PREFLIGHT_OUTPUTS.index('timing_probe_permit')),
              ('apf-engine', PREFLIGHT_OUTPUTS.index('appliedoffsetms')),
              ('aq-timing-bleed', 4), ('aq-timing-grid', 3), ('aq-timing-bleed', 5),
              ('aq-timing-bleed', 6), ('aq-timing-bleed', 7), ('aq-timing-bleed', 8)]
    for inlet, (source, outlet) in enumerate(inputs):
        p.wire(source, engine, outlet, inlet)
    p.obj('aq-guided-timing-command', 'route timingprobe phraseprobe rhythmprobe', 1, 4)
    p.obj('aq-guided-timing-counter', 'counter 1 1000000000', 5, 4)
    p.obj('aq-guided-timing-request', 'prepend proberequest')
    p.obj('aq-guided-phrase-counter', 'counter 1 1000000000', 5, 4)
    p.obj('aq-guided-phrase-request', 'prepend phraserequest')
    p.obj('aq-guided-rhythm-counter', 'counter 1 1000000000', 5, 4)
    p.obj('aq-guided-rhythm-request', 'prepend rhythmrequest')
    p.wire('asrc-popup', 'aq-guided-timing-command')
    p.wire('aq-guided-timing-command', 'aq-guided-timing-counter')
    p.wire('aq-guided-timing-counter', 'aq-guided-timing-request')
    p.wire('aq-guided-timing-request', engine)
    p.wire('aq-guided-timing-command', 'aq-guided-phrase-counter', 1)
    p.wire('aq-guided-phrase-counter', 'aq-guided-phrase-request')
    p.wire('aq-guided-phrase-request', engine)
    p.wire('aq-guided-timing-command', 'aq-guided-rhythm-counter', 2)
    p.wire('aq-guided-rhythm-counter', 'aq-guided-rhythm-request')
    p.wire('aq-guided-rhythm-request', engine)

    count = len(TIMING_GUIDED_FIELDS)
    p.obj('aq-guided-timing-export', 't'+' b'*count, 1, count)
    for outlet, field in enumerate(TIMING_GUIDED_FIELDS):
        node = 'aq-guided-timing-' + field
        p.obj(node, 'snapshot~')
        p.obj(node+'-report', 'prepend replace timing_guided_' + field)
        p.wire(engine, node, outlet)
        p.wire('aq-guided-timing-export', node, count-1-outlet)
        p.wire(node, node+'-report')
        p.wire(node+'-report', 'asrc-report')
    p.obj('aq-guided-timing-change', 'change -1', 3, 3)
    p.obj('aq-guided-timing-tag', 'prepend timingstage')
    p.obj('aq-guided-timing-learning', 'prepend learningstage')
    p.obj('aq-guided-timing-band-stage', 'sig~ 0', 1, 1, outlettype=['signal'])
    p.wire('poll', 'aq-guided-timing-stage')
    p.wire('aq-guided-timing-stage', 'aq-guided-timing-change')
    p.wire('aq-guided-timing-change', 'aq-guided-timing-tag')
    p.wire('aq-guided-timing-change', 'aq-guided-timing-learning')
    p.wire('aq-guided-timing-learning', 'aq-timing-bleed')
    p.wire('aq-guided-timing-change', 'aq-guided-timing-band-stage')
    p.wire('aq-guided-timing-band-stage', 'aq-timing-bands', 0, 12)
    p.wire('aq-guided-timing-tag', 'asrc-popup')

    ui.button('aq-guided-timing-start', 'Voce și beat', [20, 732, 98, 32])
    ui.button('aq-guided-phrase-start', 'Probă frază', [124, 732, 86, 32])
    ui.label('aq-guided-timing-note', TIMING_GUIDED_MESSAGES[0], [20, 770, 462, 20], 13)
    ui.obj('aq-guided-timing-bang', 't b')
    ui.msg('aq-guided-timing-command', 'timingprobe')
    ui.wire('aq-guided-timing-start', 'aq-guided-timing-bang')
    ui.wire('aq-guided-timing-bang', 'aq-guided-timing-command')
    ui.wire('aq-guided-timing-command', 'out')
    ui.obj('aq-guided-phrase-bang', 't b')
    ui.msg('aq-guided-phrase-command', 'phraseprobe')
    ui.wire('aq-guided-phrase-start', 'aq-guided-phrase-bang')
    ui.wire('aq-guided-phrase-bang', 'aq-guided-phrase-command')
    ui.wire('aq-guided-phrase-command', 'out')
    ui.obj('aq-guided-timing-route', 'route timingstage', 1, 2)
    codes = tuple(range(len(TIMING_GUIDED_MESSAGES)))
    ui.obj('aq-guided-timing-select', 'sel ' + ' '.join(map(str, codes)), 1, len(codes)+1)
    ui.wire('in', 'aq-guided-timing-route')
    ui.wire('aq-guided-timing-route', 'aq-guided-timing-select')
    for code, message in enumerate(TIMING_GUIDED_MESSAGES):
        node = 'aq-guided-timing-note-' + str(code)
        ui.msg(node, 'set '+message)
        ui.wire('aq-guided-timing-select', node, code)
        ui.wire(node, 'aq-guided-timing-note')
    add_speech_cues(p, ui, engine, cue_outlet, prompt_outlet)
    add_energy_attacks(p, engine, cue_outlet)
    add_energy_attacks(p, engine, cue_outlet, short=True)
    add_voiced_attacks(p, engine)
    add_rhythm_probe(p, ui, engine, guided_stop=guided_stop, voice_stop_test=voice_stop_test)


def add_energy_attacks(p, guided, cue_outlet, *, short=False):
    stem = 'aq-timing-short-' if short else 'aq-timing-'
    report_stem = 'timing_probe_short_' if short else 'timing_probe_'
    engine = stem+'energy-attacks'
    baseline = stem+'attack-baseline'
    levels = stem+'band-levels'
    if short:
        for name, source, inputs, outputs in ((levels, TIMING_BAND_LEVEL_SOURCE, 4, 8),
                                              (baseline, TIMING_ATTACK_BASELINE_SOURCE, 11, 13)):
            p.obj(name, 'gen~', inputs, outputs, patcher=signal_graph(source, inputs, outputs),
                  outlettype=['signal']*outputs)
        for inlet, (source, outlet) in enumerate((('plugin', 0), ('plugin', 1),
                                                  ('beat-plugin', 0), ('beat-plugin', 1))):
            p.wire(source, levels, outlet, inlet)
        wire_attack_baseline(p, levels, baseline)
    preflight = {name: ('apf-engine', PREFLIGHT_OUTPUTS.index(name)) for name in
                 ('rawphase', 'periodms', 'appliedoffsetms', 'sampleclock', 'timing_probe_permit',
                  'probe_clip_pause', 'clipping')}
    sources = [(guided, 0), (guided, cue_outlet), (baseline, 11), (baseline, 12),
               (levels, 6), (baseline, 7), (baseline, 0),
               *(preflight[name] for name in ('rawphase', 'periodms', 'appliedoffsetms', 'sampleclock')),
               (guided, TIMING_GUIDED_FIELDS.index('phrase_mode')),
               preflight['probe_clip_pause'], preflight['clipping']]
    add_energy_detector(p, engine, sources, preflight['timing_probe_permit'],
                        report_stem+'energy_attacks_', stem+'energy-attack',
                        report_stem+'energy_attack_timing_')
    if short:
        p.msg(stem+'init', 'shortframes 1')
        p.wire('ready-defer', stem+'init')
        for node in (levels, baseline, engine):
            p.wire(stem+'init', node)
        p.obj(stem+'limit', 'snapshot~')
        p.obj(stem+'limit-report', 'prepend replace '+report_stem+'attack_baseline_level_limit')
        p.wire(baseline, stem+'limit', 7)
        p.wire('aq-export-capture', stem+'limit', 7)
        p.wire(stem+'limit', stem+'limit-report')
        p.wire(stem+'limit-report', 'asrc-report')


def add_energy_detector(p, engine, sources, permit, data_prefix, timing_node, timing_prefix):
    width = sum(size for _, size in TIMING_ENERGY_ATTACKS_FIELDS)
    outputs = width+6
    p.obj(engine, 'gen~', len(sources), outputs,
          patcher=signal_graph(TIMING_ENERGY_ATTACKS_SOURCE, len(sources), outputs),
          outlettype=['signal']*outputs)
    for inlet, (source, outlet) in enumerate(sources):
        p.wire(source, engine, outlet, inlet)
    add_signal_list_export(p, engine, data_prefix, TIMING_ENERGY_ATTACKS_FIELDS)
    projection = [*((engine, width+i) for i in range(4)), permit]
    clocks = [(engine, width+4), sources[10]]
    add_attack_timing_log(p, timing_node, projection, clocks, (engine, 0), timing_prefix,
                          stage=sources[0])


def add_voiced_attacks(p, guided):
    engine = 'aq-timing-voiced-attacks'
    short = 'aq-timing-short-energy-attacks'
    event = sum(size for _, size in TIMING_ENERGY_ATTACKS_FIELDS)
    preflight = {name: ('apf-engine', PREFLIGHT_OUTPUTS.index(name)) for name in
                 ('timing_probe_permit', 'probe_clip_pause', 'last_clip_input_mask', 'sampleclock')}
    sources = [('plugin', 0), ('plugin', 1), (guided, 0), (short, 0),
               preflight['timing_probe_permit'], preflight['probe_clip_pause'],
               preflight['last_clip_input_mask'], *((short, event + i) for i in range(5))]
    p.obj(engine, 'gen~', len(sources), 8,
          patcher=signal_graph(TIMING_VOICED_ATTACKS_SOURCE, len(sources), 8), outlettype=['signal']*8)
    for inlet, (source, outlet) in enumerate(sources):
        p.wire(source, engine, outlet, inlet)

    # Confirmation may observe a saturated vowel, while the retained timing
    # always comes from the clean onset. This projection is report-only.
    projection = [*((engine, i) for i in range(4)), (engine, 0)]
    clocks = [(engine, 4), preflight['sampleclock']]
    add_attack_timing_log(p, 'aq-timing-voiced-attack', projection, clocks, (short, 0),
                          'timing_probe_voiced_attack_timing_', stage=(guided, 0))
    for outlet, field in ((5, 'unconfirmed_count'), (6, 'confirmed_with_clip_count')):
        node = engine+'-'+field
        p.obj(node, 'snapshot~')
        p.obj(node+'-report', 'prepend replace timing_probe_voiced_attack_'+field)
        p.wire(engine, node, outlet)
        p.wire('aq-export-capture', node, 7)
        p.wire(node, node+'-report')
        p.wire(node+'-report', 'asrc-report')


def add_rhythm_probe(p, ui, guided, *, guided_stop=False, voice_stop_test=False):
    capture = 'aq-rhythm-capture'
    review = 'aq-rhythm-review'
    results = 'aq-rhythm-results'
    mode = (guided, TIMING_GUIDED_FIELDS.index('phrase_mode'))
    stage = (guided, 0)
    voiced_review = guided_stop or voice_stop_test
    detector = 'aq-timing-short-energy-attacks' if voiced_review else 'aq-timing-energy-attacks'
    event = sum(size for _, size in TIMING_ENERGY_ATTACKS_FIELDS)
    voiced = 'aq-timing-voiced-attacks'
    onset = [(voiced, 0), (voiced, 4), (voiced, 3)] if voiced_review else [
        (detector, event), (detector, event+4), (detector, event+3)]
    clock_fields = ('rawphase', 'periodms', 'synced', 'timing_probe_permit', 'sampleclock')
    preflight = [('apf-engine', PREFLIGHT_OUTPUTS.index(name)) for name in clock_fields]
    clip_context = [('apf-engine', PREFLIGHT_OUTPUTS.index(name)) for name in
                    ('probe_clip_pause', 'last_clip_input_mask', 'clipping')] if voiced_review else []
    p.obj('aq-rhythm-margin', f'sig~ {RHYTHM_TEST_MARGIN_MS}', 1, 1, outlettype=['signal'])
    engines = (
        (capture, RHYTHM_CAPTURE_SOURCE, 17, 12,
         [stage, mode, *preflight, *onset,
          (detector, 0), (detector, event+5), (detector, event+4), (detector, event+3), *clip_context]),
        (review, REFERENCE_TIMING_SOURCE, 7, 3,
         [(capture, 1), (capture, 2), (capture, 3), ('aq-rhythm-margin', 0), (capture, 5), (capture, 6)]),
        (results, RHYTHM_RESULTS_SOURCE, 10, 26,
         [(capture, 0), stage, mode, (capture, 1), (capture, 4), (review, 0), (review, 1), (capture, 8),
          (capture, 9), (capture, 10)]),
    )
    for name, source, inputs, outputs, wires in engines:
        p.obj(name, 'gen~', inputs, outputs, patcher=signal_graph(source, inputs, outputs),
              outlettype=['signal']*outputs)
        for inlet, (node, outlet) in enumerate(wires):
            p.wire(node, name, outlet, inlet)
    if voiced_review:
        from assistant_voice_stop_test import add_guided_voice_stop
        add_guided_voice_stop(p, ui, stage, mode, capture, review, voiced,
                              test_cue=voice_stop_test, signal_graph=signal_graph,
                              add_signal_list_export=add_signal_list_export)
    fields = (
        ('state', 1), ('extra_attacks', 1), ('slot_counts', 4), ('slot_verdicts', 4), ('slot_deviation_ms', 4),
        ('anchor_after_prompt_ms', 1), ('extra_clipped_candidates', 1), ('slot_clipped_candidates', 4),
        ('slot_clipped_estimate_ms', 4))
    add_signal_list_export(p, results, 'rhythm_probe_', fields)
    progress_outlet = sum(width for _, width in fields)
    for field, value in (('reference_ms', '1800. 3300. 4800. 6300.'),
                         ('tolerance_ms', '100.'), ('margin_ms', f'{RHYTHM_TEST_MARGIN_MS}.')):
        node = 'aq-rhythm-spec-'+field
        p.msg(node, 'replace rhythm_probe_'+field+' '+value)
        p.wire('aq-export-capture', node, 7)
        p.wire(node, 'asrc-report')

    ui.button('aq-guided-rhythm-start', 'Probă ritm', [216, 732, 86, 32])
    ui.obj('aq-guided-rhythm-bang', 't b')
    ui.msg('aq-guided-rhythm-command', 'rhythmprobe')
    ui.wire('aq-guided-rhythm-start', 'aq-guided-rhythm-bang')
    ui.wire('aq-guided-rhythm-bang', 'aq-guided-rhythm-command')
    ui.wire('aq-guided-rhythm-command', 'out')

    p.obj('aq-rhythm-cue', 'snapshot~')
    p.obj('aq-rhythm-cue-change', 'change -1', 3, 3)
    p.obj('aq-rhythm-cue-tag', 'prepend rhythmcapturecue')
    p.wire(capture, 'aq-rhythm-cue', 7)
    p.wire('poll', 'aq-rhythm-cue')
    p.wire('aq-rhythm-cue', 'aq-rhythm-cue-change')
    p.wire('aq-rhythm-cue-change', 'aq-rhythm-cue-tag')
    p.wire('aq-rhythm-cue-tag', 'asrc-popup')
    cues = (*(f'Pregătește-te · reper {i}/4' for i in range(1, 5)),
            *(f'TA · reper {i}/4' for i in range(1, 5)),
            'Aștept reperul la 100 BPM…', 'Rămâi în liniște până se termină proba.',
            'Proba de ritm nu poate fi evaluată. Verifică redarea la 100 BPM.',
            *(f'Reper {i}/4 · {count}' for i in range(1, 5) for count in (3, 2, 1)))
    ui.obj('aq-rhythm-cue-route', 'route rhythmcapturecue', 1, 2)
    ui.obj('aq-rhythm-cue-select', 'sel '+' '.join(map(str, range(1, len(cues)+1))), 1, len(cues)+1)
    ui.wire('in', 'aq-rhythm-cue-route')
    ui.wire('aq-rhythm-cue-route', 'aq-rhythm-cue-select')
    for i, message in enumerate(cues):
        node = 'aq-rhythm-cue-note-'+str(i)
        ui.msg(node, 'set '+message)
        ui.wire('aq-rhythm-cue-select', node, i)
        ui.wire(node, 'aq-guided-timing-note')

    progress = 'aq-rhythm-progress'
    p.obj(progress, 'snapshot~')
    p.obj(progress+'-change', 'change -2', 3, 3)
    p.obj(progress+'-tag', 'prepend rhythmmatches')
    p.wire(results, progress, progress_outlet)
    p.wire('poll', progress)
    p.wire(progress, progress+'-change')
    p.wire(progress+'-change', progress+'-tag')
    p.wire(progress+'-tag', 'asrc-popup')
    ui.label(progress, '', [488, 770, 132, 20], 12)
    ui.obj(progress+'-route', 'route rhythmmatches', 1, 2)
    ui.obj(progress+'-select', 'sel -1 0 1 2 3 4', 1, 7)
    ui.wire('in', progress+'-route')
    ui.wire(progress+'-route', progress+'-select')
    for i, message in enumerate(('set', *(f'set Repere · {n}/4' for n in range(5)))):
        node = progress+'-note-'+str(i)
        ui.msg(node, message)
        ui.wire(progress+'-select', node, i)
        ui.wire(node, progress)

    warning = 'aq-rhythm-clip-warning'
    p.obj(warning, 'snapshot~')
    p.obj(warning+'-change', 'change -1', 3, 3)
    p.obj(warning+'-tag', 'prepend rhythmclipwarning')
    p.wire(results, warning, progress_outlet+1)
    p.wire('poll', warning)
    p.wire(warning, warning+'-change')
    p.wire(warning+'-change', warning+'-tag')
    p.wire(warning+'-tag', 'asrc-popup')
    ui.label(warning, '', [20, 810, 600, 19], 13)
    ui.obj(warning+'-route', 'route rhythmclipwarning', 1, 2)
    ui.obj(warning+'-select', 'sel 0 1', 1, 3)
    ui.wire('in', warning+'-route')
    ui.wire(warning+'-route', warning+'-select')
    for i, message in enumerate(('set', 'set Microfon saturat · atac posibil și neconfirmat')):
        node = warning+'-note-'+str(i)
        ui.msg(node, message)
        ui.wire(warning+'-select', node, i)
        ui.wire(node, warning)


def add_grid_test(p, ui):
    stimulus = 'aq-grid-test'
    bands = stimulus+'-bands'
    clock_inputs = ('rawphase', 'periodms', 'synced', 'timingready', 'sampleclock')
    preflight = {name: ('apf-engine', PREFLIGHT_OUTPUTS.index(name)) for name in clock_inputs}
    p.obj(stimulus, 'gen~', 5, 5, patcher=signal_graph(TIMING_GRID_TEST_SOURCE, 5, 5),
          outlettype=['signal']*5)
    for inlet, (source, outlet) in enumerate(preflight[name] for name in clock_inputs):
        p.wire(source, stimulus, outlet, inlet)
    p.obj(bands, 'gen~', 4, 8, patcher=signal_graph(TIMING_BAND_LEVEL_SOURCE, 4, 8),
          outlettype=['signal']*8)
    p.wire(stimulus, bands, 2)
    p.obj(stimulus+'-low-mid', '+~', 2, 1, outlettype=['signal'])
    p.obj(stimulus+'-level', '+~', 2, 1, outlettype=['signal'])
    p.wire(bands, stimulus+'-low-mid', 0, 0)
    p.wire(bands, stimulus+'-low-mid', 1, 1)
    p.wire(stimulus+'-low-mid', stimulus+'-level', 0, 0)
    p.wire(bands, stimulus+'-level', 2, 1)
    for name, value in (('one', 1), ('baseline', 2), ('threshold', .02), ('delay', 90), ('mode', 0)):
        p.obj(stimulus+'-'+name, f'sig~ {value}', 1, 1, outlettype=['signal'])
    sources = [(stimulus, 0), (stimulus+'-one', 0), (stimulus+'-one', 0),
               (stimulus+'-level', 0), (bands, 6), (stimulus+'-threshold', 0),
               (stimulus+'-baseline', 0), preflight['rawphase'], preflight['periodms'],
               (stimulus+'-delay', 0), preflight['sampleclock'], *[(stimulus+'-mode', 0)]*3]
    add_energy_detector(p, stimulus+'-attacks', sources, preflight['timingready'],
                        'timing_grid_test_attacks_', stimulus+'-attack', 'timing_grid_test_')
    source_projection = [(stimulus, 3), preflight['rawphase'], preflight['periodms'],
                         (stimulus+'-delay', 0), (stimulus+'-one', 0)]
    add_attack_timing_log(p, stimulus+'-stimulus', source_projection,
                          [(stimulus, 4), preflight['sampleclock']], (stimulus+'-baseline', 0),
                          'timing_grid_test_stimulus_', stage=(stimulus, 0))
    add_signal_list_export(p, stimulus, 'timing_grid_test_',
                           (('stage', 1), ('max_clock_error_ms', 1)))
    results = add_grid_test_review(p, stimulus)
    # Export the independent test specification and clock agreement alongside detections.
    for name, value in (('expected_ms', '-150. 0. 150. -150. 0. 150.'),
                        ('injected_delay_ms', '90.')):
        node = stimulus+'-report-'+name
        p.msg(node, 'replace timing_grid_test_'+name+' '+value)
        p.wire('aq-export-capture', node, 7)
        p.wire(node, 'asrc-report')

    p.obj(stimulus+'-route', 'route gridtest', 1, 2)
    p.obj(stimulus+'-counter', 'counter 1 1000000000', 5, 4)
    p.obj(stimulus+'-request', 'prepend request')
    p.wire('asrc-popup', stimulus+'-route')
    p.wire(stimulus+'-route', stimulus+'-counter')
    p.wire(stimulus+'-counter', stimulus+'-request')
    p.wire(stimulus+'-request', stimulus)
    p.obj(stimulus+'-status-sample', 'snapshot~')
    p.obj(stimulus+'-change', 'change -1', 3, 3)
    p.obj(stimulus+'-tag', 'prepend gridteststage')
    p.wire(results, stimulus+'-status-sample')
    p.wire('poll', stimulus+'-status-sample')
    p.wire(stimulus+'-status-sample', stimulus+'-change')
    p.wire(stimulus+'-change', stimulus+'-tag')
    p.wire(stimulus+'-tag', 'asrc-popup')

    messages = {
        0: 'Probă internă la 100 BPM.',
        1: 'Aștept grila stabilă la 100 BPM…',
        2: 'Verific intervalul fără impulsuri…',
        3: 'Măsor impulsurile interne…',
        5: 'Test reușit · 6 impulsuri verificate. Salvează raportul.',
        6: 'Test întrerupt. Pornește redarea la 100 BPM și reia.',
        7: 'Test încheiat cu diferențe. Salvează raportul.',
    }
    ui.button(stimulus+'-start', 'Test grilă', [308, 732, 84, 32])
    ui.label(stimulus+'-status', messages[0], [20, 790, 600, 19], 13)
    ui.obj(stimulus+'-bang', 't b')
    ui.msg(stimulus+'-command', 'gridtest')
    ui.wire(stimulus+'-start', stimulus+'-bang')
    ui.wire(stimulus+'-bang', stimulus+'-command')
    ui.wire(stimulus+'-command', 'out')
    ui.obj(stimulus+'-route', 'route gridteststage', 1, 2)
    ui.obj(stimulus+'-select', 'sel '+' '.join(map(str, messages)), 1, len(messages)+1)
    ui.wire('in', stimulus+'-route')
    ui.wire(stimulus+'-route', stimulus+'-select')
    for index, (code, message) in enumerate(messages.items()):
        node = stimulus+'-message-'+str(code)
        ui.msg(node, 'set '+message)
        ui.wire(stimulus+'-select', node, index)
        ui.wire(node, stimulus+'-status')


def add_grid_test_review(p, stimulus):
    projection = stimulus+'-attack-grid'
    review = stimulus+'-review'
    results = stimulus+'-results'
    p.obj(stimulus+'-margin', f'sig~ {RHYTHM_TEST_MARGIN_MS}', 1, 1, outlettype=['signal'])
    # The grid projection is already relative to the nearest quarter. The
    # synthetic pulses are within 150 ms of their intended quarter at 100 BPM.
    # Simulated recording and Stop eligibility stay entirely inside this test.
    engines = (
        (review, REFERENCE_TIMING_SOURCE, 3,
         [(projection, 0), (stimulus+'-mode', 0), (projection, 1), (stimulus+'-margin', 0),
          (projection, 0), (projection, 0), (stimulus+'-one', 0)]),
        (results, TIMING_GRID_TEST_RESULTS_SOURCE, 10,
         [(stimulus, 0), (projection, 0), (review, 0), (review, 1), (review, 2)]),
    )
    for name, source, outputs, wires in engines:
        p.obj(name, 'gen~', len(wires), outputs, patcher=signal_graph(source, len(wires), outputs),
              outlettype=['signal']*outputs)
        for inlet, (node, outlet) in enumerate(wires):
            p.wire(node, name, outlet, inlet)
    add_signal_list_export(p, results, 'timing_grid_test_review_', (
        ('state', 1), ('count', 1), ('max_error_ms', 1), ('first_simulated_stop_index', 1), ('verdicts', 6)))
    return results


def add_speech_cues(p, ui, guided, cue_outlet, prompt_outlet):
    engine = 'aq-timing-speech-cues'
    baseline = 'aq-timing-attack-baseline'
    inputs = [(guided, 0), (guided, cue_outlet),
              ('apf-engine', PREFLIGHT_OUTPUTS.index('timing_probe_permit')),
              (baseline, 10), ('aq-timing-band-levels', 6),
              ('aq-timing-features', 0), (baseline, 9),
              ('apf-engine', PREFLIGHT_OUTPUTS.index('probe_clip_pause'))]
    fields = [(field, len(TIMING_SPEECH_CUES)) for field in TIMING_SPEECH_CUE_FIELDS]
    width = sum(size for _, size in fields)
    p.obj(engine, 'gen~', len(inputs), width,
          patcher=signal_graph(TIMING_SPEECH_CUE_SOURCE, len(inputs), width),
          outlettype=['signal']*width)
    for inlet, (source, outlet) in enumerate(inputs):
        p.wire(source, engine, outlet, inlet)
    add_signal_list_export(p, engine, 'timing_probe_speech_cue_', fields)

    p.obj('aq-timing-speech-cue', 'snapshot~')
    p.obj('aq-timing-speech-cue-change', 'change -1', 3, 3)
    p.obj('aq-timing-speech-cue-tag', 'prepend timingcue')
    p.wire(guided, 'aq-timing-speech-cue', prompt_outlet)
    p.wire('poll', 'aq-timing-speech-cue')
    p.wire('aq-timing-speech-cue', 'aq-timing-speech-cue-change')
    p.wire('aq-timing-speech-cue-change', 'aq-timing-speech-cue-tag')
    p.wire('aq-timing-speech-cue-tag', 'asrc-popup')
    ui.obj('aq-timing-speech-cue-route', 'route timingcue', 1, 2)
    ui.obj('aq-timing-speech-cue-select', 'sel 1 2 3 4 5', 1, 6)
    ui.wire('in', 'aq-timing-speech-cue-route')
    ui.wire('aq-timing-speech-cue-route', 'aq-timing-speech-cue-select')
    for i, message in enumerate((*TIMING_SPEECH_CUES, TIMING_PHRASE_CUE)):
        node = f'aq-timing-speech-cue-note-{i}'
        ui.msg(node, 'set '+message)
        ui.wire('aq-timing-speech-cue-select', node, i)
        ui.wire(node, 'aq-guided-timing-note')


def make_clarity_patch(test_setup=None, calibration_report=None, *, transport_stop_test=False,
                       voice_stop_test=False, guided_stop=False):
    if calibration_report is not None and test_setup is None:
        raise ValueError('A calibration report can seed only a personal test build')
    if (transport_stop_test or voice_stop_test) and test_setup is None:
        raise ValueError('The transport Stop test requires a personal test build')
    if sum((transport_stop_test, voice_stop_test, guided_stop)) > 1:
        raise ValueError('Choose one Stop route')
    if guided_stop and test_setup is not None:
        raise ValueError('The distributable guided Stop build uses unconfigured audio routing')
    record = verified_record(calibration_report, test_setup) if calibration_report is not None else None
    patch = make_source_patch()
    p = build.Patch()
    p.p = patch['patcher']
    boxes = {w['box']['id']: w['box'] for w in p.p['boxes']}
    boxes['asrc-open']['text'] = boxes['asrc-open']['texton'] = 'Surse și claritatea semnalului'
    boxes['version']['text'] = 'Asistent de ritm vocal · diagnostic semnal '+VERSION
    # Extend only the diagnostic window. The original monitor and parameters
    # stay byte-for-byte identical to make_source_patch().
    ui = build.Patch()
    ui.p = boxes['asrc-popup']['patcher']
    ub = {w['box']['id']: w['box'] for w in ui.p['boxes']}
    ui.p.update(title='Asistent de ritm vocal | Surse și semnal '+VERSION,
                rect=[80., 70., 640., 852.], openrect=[80., 70., 640., 852.])
    ub['window-config']['text'] = 'window flags float nogrow nozoom, window size 80 70 720 922, window exec'
    ub['heading']['text'] = 'Surse și semnal'
    ub['subtitle']['text'] = 'Diagnostic '+VERSION+' · măsoară începuturi de sunet pe intrare'
    ub['refresh']['presentation_rect'] = [398., 732., 108., 32.]
    ub['export']['presentation_rect'] = [512., 732., 108., 32.]
    ub['footer']['presentation_rect'] = [20., 833., 600., 15.]
    ui.label('aq-heading', 'Semnal la microfon', [20, 432, 600, 24], 14)
    ui.label('aq-status', STATES[0], [20, 462, 600, 40], 13)
    add_timing_probe(p, ui)
    add_guided_timing_probe(p, ui, guided_stop=guided_stop, voice_stop_test=voice_stop_test)
    add_timing_attack_log(p)
    add_grid_test(p, ui)
    add_diagnostic_calibration_retries(p)
    add_saved_calibration(p, ui, record)
    ui.button('aq-background', 'Măsoară fundalul · 5 secunde', [20, 554, 280, 32])
    ui.label('aq-background-status', BACKGROUND_STATES[0], [312, 550, 308, 52], 12)
    ui.label('aq-guided-cue', GUIDED_CUES[0], [20, 694, 600, 34], 15, fontface=1)
    ui.obj('aq-guided-route', 'route guidedcue', 1, 2)
    ui.obj('aq-guided-select', 'sel '+' '.join(map(str, GUIDED_CUES)), 1, len(GUIDED_CUES)+1)
    ui.wire('in', 'aq-guided-route')
    ui.wire('aq-guided-route', 'aq-guided-select')
    for i, (code, text) in enumerate(GUIDED_CUES.items()):
        ui.msg('aq-guided-cue-'+str(code), 'set '+text)
        ui.wire('aq-guided-select', 'aq-guided-cue-'+str(code), i)
        ui.wire('aq-guided-cue-'+str(code), 'aq-guided-cue')
    ui.label('aq-background-comparison-status', BACKGROUND_COMPARISON_STATES[0],
             [20, 605, 600, 40], 12)
    ui.obj('aq-background-comparison-route', 'route backgroundcomparison', 1, 2)
    ui.obj('aq-background-comparison-select', 'sel '+' '.join(map(str, BACKGROUND_COMPARISON_STATES)),
           1, len(BACKGROUND_COMPARISON_STATES)+1)
    ui.wire('in', 'aq-background-comparison-route')
    ui.wire('aq-background-comparison-route', 'aq-background-comparison-select')
    for i, (code, text) in enumerate(BACKGROUND_COMPARISON_STATES.items()):
        ui.msg('aq-background-comparison-state-'+str(code), 'set '+text)
        ui.wire('aq-background-comparison-select', 'aq-background-comparison-state-'+str(code), i)
        ui.wire('aq-background-comparison-state-'+str(code), 'aq-background-comparison-status')
    ui.label('aq-test-phase-status', TEST_PHASE_STATES[0], [20, 650, 280, 40], 11)
    ui.button('aq-speakers', 'Difuzoare pornite · continuă', [312, 650, 308, 32])
    ui.obj('aq-test-phase-route', 'route testphase', 1, 2)
    ui.obj('aq-test-phase-select', 'sel '+' '.join(map(str, TEST_PHASE_STATES)), 1, len(TEST_PHASE_STATES)+1)
    ui.wire('in', 'aq-test-phase-route')
    ui.wire('aq-test-phase-route', 'aq-test-phase-select')
    for i, (code, text) in enumerate(TEST_PHASE_STATES.items()):
        ui.msg('aq-test-phase-state-'+str(code), 'set '+text)
        ui.wire('aq-test-phase-select', 'aq-test-phase-state-'+str(code), i)
        ui.wire('aq-test-phase-state-'+str(code), 'aq-test-phase-status')
    ui.obj('aq-speakers-bang', 't b')
    ui.msg('aq-speakers-command', 'speakers')
    ui.wire('aq-speakers', 'aq-speakers-bang')
    ui.wire('aq-speakers-bang', 'aq-speakers-command')
    ui.wire('aq-speakers-command', 'out')
    ui.obj('aq-background-bang', 't b')
    ui.msg('aq-background-command', 'background')
    ui.wire('aq-background', 'aq-background-bang')
    ui.wire('aq-background-bang', 'aq-background-command')
    ui.wire('aq-background-command', 'out')
    ui.obj('aq-background-route', 'route backgroundstate', 1, 2)
    ui.obj('aq-background-select', 'sel '+' '.join(map(str, BACKGROUND_STATES)), 1, len(BACKGROUND_STATES)+1)
    ui.wire('in', 'aq-background-route')
    ui.wire('aq-background-route', 'aq-background-select')
    for i, (code, text) in enumerate(BACKGROUND_STATES.items()):
        ui.msg('aq-background-state-'+str(code), 'set '+text)
        ui.wire('aq-background-select', 'aq-background-state-'+str(code), i)
        ui.wire('aq-background-state-'+str(code), 'aq-background-status')
    ui.obj('aq-route', 'route clarity', 1, 2)
    ui.wire('in', 'aq-route')
    ui.obj('aq-select', 'sel '+' '.join(map(str, STATES)), 1, len(STATES)+1)
    ui.wire('aq-route', 'aq-select')
    for i, (code, text) in enumerate(STATES.items()):
        ui.msg('aq-state-'+str(code), 'set '+text)
        ui.wire('aq-select', 'aq-state-'+str(code), i)
        ui.wire('aq-state-'+str(code), 'aq-status')
    # Existing theme selector also controls the new labels.
    probe_buttons = ('aq-background', 'aq-speakers', 'aq-guided-timing-start', 'aq-guided-phrase-start',
                     'aq-guided-rhythm-start',
                     'aq-grid-test-start')
    for id in (*probe_buttons, 'aq-heading', 'aq-status', 'aq-background-status', 'aq-guided-cue',
               'aq-background-comparison-status', 'aq-test-phase-status', 'aq-timing-status',
               'aq-timing-count', 'aq-timing-last', 'aq-guided-timing-note', 'aq-grid-test-status',
               'aq-rhythm-progress'):
        box = next(w['box'] for w in ui.p['boxes'] if w['box']['id'] == id)
        box['varname'] = 'asrc_ui_'+id
        box['textcolor'] = PALETTES[0]['text']
        for theme, colors in enumerate(PALETTES):
            ub['palette-'+str(theme)]['text'] += ', script send '+box['varname']+' textcolor '+' '.join(map(str, colors['text']))
            if id in probe_buttons:
                for attribute, role in (('bgcolor', 'field'), ('bgoncolor', 'field'), ('textoncolor', 'text')):
                    ub['palette-'+str(theme)]['text'] += ', script send '+box['varname']+' '+attribute+' '+' '.join(map(str, colors[role]))

    p.obj('aq-background-command', 'route background', 1, 2)
    p.obj('aq-background-counter', 'counter 1 1000000000', 5, 4)
    p.obj('aq-background-request', 'prepend backgroundrequest')
    p.wire('asrc-popup', 'aq-background-command')
    p.wire('aq-background-command', 'aq-background-counter')
    p.wire('aq-background-counter', 'aq-background-request')
    p.wire('aq-background-request', 'aq-engine')

    p.obj('aq-speakers-command', 'route speakers', 1, 2)
    p.obj('aq-speakers-counter', 'counter 1 1000000000', 5, 4)
    p.obj('aq-speakers-request', 'prepend speakersrequest')
    p.wire('asrc-popup', 'aq-speakers-command')
    p.wire('aq-speakers-command', 'aq-speakers-counter')
    p.wire('aq-speakers-counter', 'aq-speakers-request')
    p.wire('aq-speakers-request', 'aq-engine')

    p.obj('aq-engine', 'gen~', 8, len(RAW_OUTPUTS), patcher=gen_graph(),
          outlettype=['signal']*len(RAW_OUTPUTS))
    for source, outlet, inlet in [('plugin', 0, 0), ('plugin', 1, 1),
                                  ('beat-plugin', 0, 2), ('beat-plugin', 1, 3),
                                  ('apf-engine', 1, 4), ('apf-engine', 9, 5),
                                  ('apf-engine', 11, 6),
                                  ('apf-engine', PREFLIGHT_OUTPUTS.index('probe_clip_pause'), 7)]:
        p.wire(source, 'aq-engine', outlet, inlet)
    for param, source in [('profilevalid', 'asrc-profile-armed'),
                           ('sourcemode', 'asrc-mode')]:
        p.obj('aq-'+param, 'prepend '+param)
        p.wire(source, 'aq-'+param); p.wire('aq-'+param, 'aq-engine')
    p.obj('aq-result-engine', 'gen~', len(RESULT_INPUTS), len(KEEPER_OUTPUTS),
          patcher=gen_graph(result=True),
          outlettype=['signal']*len(KEEPER_OUTPUTS))
    for i, name in enumerate(RESULT_INPUTS):
        source, outlet = result_input_source(name)
        p.wire(source, 'aq-result-engine', outlet, i)
    live_names = OUTPUTS[:25] + ('background_state', 'background_comparison_state', 'test_phase_state', 'guided_cue')
    diagnostic_names = tuple(name for name in OUTPUTS if name not in live_names)
    live_outputs = len(live_names)
    p.obj('aq-poll', 't '+' '.join(['b']*live_outputs), 1, live_outputs)
    groups = [diagnostic_names[i:i+32] for i in range(0, len(diagnostic_names), 32)]
    p.obj('aq-diagnostic-poll', 't '+' '.join(['b']*len(groups)), 1, len(groups))
    for i, group in enumerate(groups):
        id = 'aq-diagnostic-poll-'+str(i)
        p.obj(id, 't '+' '.join(['b']*len(group)), 1, len(group))
        p.wire('aq-diagnostic-poll', id, len(groups)-1-i)
    p.wire('poll', 'aq-poll')
    for i, name in enumerate(OUTPUTS):
        p.obj('aq-'+name, 'snapshot~')
        source, outlet = telemetry_source(name)
        p.wire(source, 'aq-'+name, outlet)
        if name in live_names:
            p.wire('aq-poll', 'aq-'+name, live_outputs-1-live_names.index(name))
        else:
            group_index, position = divmod(diagnostic_names.index(name), 32)
            p.wire('aq-diagnostic-poll-'+str(group_index), 'aq-'+name,
                   len(groups[group_index])-1-position)
        p.obj('aq-report-'+name, 'prepend replace clarity_'+name)
        p.wire('aq-'+name, 'aq-report-'+name)
        p.wire('aq-report-'+name, 'asrc-report')
    p.obj('aq-state-change', 'change -1', 3, 3)
    p.obj('aq-state-tag', 'prepend clarity')
    p.wire('aq-state', 'aq-state-change'); p.wire('aq-state-change', 'aq-state-tag')
    p.wire('aq-state-tag', 'asrc-popup')
    p.obj('aq-background-state-change', 'change -1', 3, 3)
    p.obj('aq-background-state-tag', 'prepend backgroundstate')
    p.wire('aq-background_state', 'aq-background-state-change')
    p.wire('aq-background-state-change', 'aq-background-state-tag')
    p.wire('aq-background-state-tag', 'asrc-popup')
    p.obj('aq-background-comparison-change', 'change -1', 3, 3)
    p.obj('aq-background-comparison-tag', 'prepend backgroundcomparison')
    p.wire('aq-background_comparison_state', 'aq-background-comparison-change')
    p.wire('aq-background-comparison-change', 'aq-background-comparison-tag')
    p.wire('aq-background-comparison-tag', 'asrc-popup')
    p.obj('aq-test-phase-change', 'change -1', 3, 3)
    p.obj('aq-test-phase-tag', 'prepend testphase')
    p.wire('aq-test_phase_state', 'aq-test-phase-change')
    p.wire('aq-test-phase-change', 'aq-test-phase-tag')
    p.wire('aq-test-phase-tag', 'asrc-popup')
    p.obj('aq-guided-cue-change', 'change -1', 3, 3)
    p.obj('aq-guided-cue-tag', 'prepend guidedcue')
    p.wire('aq-guided_cue', 'aq-guided-cue-change')
    p.wire('aq-guided-cue-change', 'aq-guided-cue-tag')
    p.wire('aq-guided-cue-tag', 'asrc-popup')
    boxes['asrc-report-format']['text'] = 'replace format vtm-assistant-signal-'+VERSION
    # Capture before the modal file dialog. Live telemetry can continue to
    # mutate the working dict while the user chooses a destination.
    removed = {(('asrc-ui-route', 2), ('asrc-export', 0)),
               (('asrc-export', 0), ('asrc-report', 0))}
    p.p['lines'] = [w for w in p.p['lines']
                    if (tuple(w['patchline']['source']), tuple(w['patchline']['destination'])) not in removed]
    # Validate the VALUES RECEIVED by Max, after every diagnostic snapshot.
    # A surviving available flag alone is not sufficient evidence of export.
    checks = ('available', 'completed_phase_mask', 'muted_windows', 'audible_windows',
              'background_duration_ms', 'source_mode', 'profile_valid')
    p.obj('aq-result-export-valid',
          'expr ($f1 == 1) && ($f2 == 3) && ($f3 == 10) && ($f4 == 20) && '
          '($f5 >= 4999.999) && ($f6 == 1) && ($f7 == 1)', 7, 1)
    for i, suffix in enumerate(checks):
        p.wire('aq-completed_result_'+suffix, 'aq-result-export-valid', 0, i)
    p.obj('aq-result-export-valid-report', 'prepend replace clarity_completed_result_export_valid')
    p.wire('aq-result-export-valid', 'aq-result-export-valid-report')
    p.wire('aq-result-export-valid-report', 'asrc-report')
    guided_checks = ['completed_guided_available']
    guided_conditions = ['($f1 == 1)', '($f2 == 1)']
    for interval, expected in GUIDED_INTERVALS.items():
        obs = len(guided_checks)+2
        guided_checks.extend('completed_guided_'+interval+'_'+field
                             for field in ('observations', 'skipped'))
        guided_conditions.extend((f'($f{obs} > 0)',
                                  f'($f{obs} + $f{obs+1} == {expected})'))
    p.obj('aq-guided-export-valid', 'expr '+' && '.join(guided_conditions), 1+len(guided_checks), 1)
    p.wire('aq-result-export-valid', 'aq-guided-export-valid')
    for i, name in enumerate(guided_checks, start=1):
        p.wire('aq-'+name, 'aq-guided-export-valid', 0, i)
    p.obj('aq-guided-export-valid-report', 'prepend replace clarity_completed_guided_export_valid')
    p.wire('aq-guided-export-valid', 'aq-guided-export-valid-report')
    p.wire('aq-guided-export-valid-report', 'asrc-report')
    p.obj('aq-export-capture', 't b b b b b b b b', 1, 8)
    p.obj('aq-export-dict', 'dict #0_vtm_frozen_report @embed 0', 2, 4)
    p.msg('aq-export-clone', 'clone #0_vtm_source_report')
    p.wire('asrc-ui-route', 'aq-export-capture', 2)
    p.wire('aq-export-capture', 'aq-timing-poll', 7)
    p.wire('aq-export-capture', 'aq-timing-baseline-poll', 7)
    p.wire('aq-export-capture', 'aq-guided-timing-export', 7)
    p.wire('aq-export-capture', 'apf-poll', 6)
    p.wire('aq-export-capture', 'apf-diagnostic-poll', 5)
    p.wire('aq-export-capture', 'aq-poll', 4)
    p.wire('aq-export-capture', 'aq-diagnostic-poll', 3)
    p.wire('aq-export-capture', 'aq-completed_result_available', 2)
    p.wire('aq-export-capture', 'aq-export-clone', 1)
    p.wire('aq-export-clone', 'aq-export-dict')
    p.wire('aq-export-capture', 'asrc-export', 0)
    p.wire('asrc-export', 'aq-export-dict')
    p.p['description'] = 'Experimental source and acoustic-distinctness diagnostics; no speech or rhythm verdict'
    # Explicit deterministic fan-out after all attachments.
    def order(graph):
        groups = {}
        for wrapped in graph['lines']:
            line = wrapped['patchline']
            groups.setdefault(tuple(line['source']), []).append(line)
        if graph['classnamespace'] == 'box':
            for lines in groups.values():
                if len(lines) > 1:
                    for i, line in enumerate(lines): line['order'] = i
        for wrapped in graph['boxes']:
            if 'patcher' in wrapped['box']: order(wrapped['box']['patcher'])
    if test_setup is not None:
        from assistant_test_setup import apply_test_setup
        apply_test_setup({'patcher': p.p}, test_setup)
    if transport_stop_test:
        from assistant_stop_test import add_transport_stop_test
        add_transport_stop_test(p, ui, signal_graph=signal_graph,
                                add_signal_list_export=add_signal_list_export,
                                reference_source=REFERENCE_TIMING_SOURCE, margin_ms=RHYTHM_TEST_MARGIN_MS)
    order(p.p)
    return {'patcher': p.p}


def write_diagnostic(*, test_setup=None, calibration_report=None, output=None,
                     transport_stop_test=False, voice_stop_test=False, guided_stop=False):
    # Public output is generic by default. Personal test builds require an
    # explicit profile AND an output folder outside the repository.
    if test_setup is not None and (output is None or Path(output).resolve().is_relative_to(ROOT)):
        raise ValueError('Personal test builds must be written outside the repository')
    patch = make_clarity_patch(test_setup=test_setup, calibration_report=calibration_report,
                               transport_stop_test=transport_stop_test, voice_stop_test=voice_stop_test,
                               guided_stop=guided_stop)
    output = Path(output) if output is not None else ROOT/'dist'
    output.mkdir(parents=True, exist_ok=True)
    destination = output/(NAME+'.amxd')
    blob = build.amxd_bytes(patch, NAME+'.amxd')
    if destination.exists() and destination.read_bytes() != blob:
        raise FileExistsError('Preserve the previous diagnostic; choose a new version before building')
    (output/(NAME+'.maxpat')).write_text(json.dumps(patch, ensure_ascii=False, indent=2), encoding='utf-8')
    destination.write_bytes(blob)
    return destination


if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('--local-test-profile', type=Path)
    parser.add_argument('--local-calibration-report', type=Path)
    parser.add_argument('--local-stop-test', action='store_true')
    parser.add_argument('--local-voice-stop-test', action='store_true')
    parser.add_argument('--guided-stop', action='store_true')
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()
    profile = None
    if args.local_test_profile is not None:
        from assistant_test_setup import load_test_setup
        profile = load_test_setup(args.local_test_profile)
    report = None
    if args.local_calibration_report is not None:
        report = json.loads(args.local_calibration_report.read_text(encoding='utf-8-sig'))
    print(write_diagnostic(test_setup=profile, calibration_report=report, output=args.output,
                           transport_stop_test=args.local_stop_test, voice_stop_test=args.local_voice_stop_test,
                           guided_stop=args.guided_stop))
