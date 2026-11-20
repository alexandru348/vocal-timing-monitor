"""Owner-approved test defaults, embedded as native Max objects at build time.

No volatile Live IDs or global settings file are used by the running device.
The old measured offset is a value, not evidence of a current calibration.
"""
import json
import math
from pathlib import Path
import build

PROFILE = Path(__file__).with_name('test_setup_profile.json')


def load_test_setup(path=None):
    return json.loads((Path(path) if path is not None else PROFILE).read_text())


def apply_test_setup(patch, profile):
    """Apply only to new diagnostic copies, leaving the stable generator intact."""
    offset = profile['last_measured_offset_ms']
    if not isinstance(offset, (float, int)) or not math.isfinite(offset) or abs(offset) > 500:
        raise ValueError('Invalid measured compensation')
    for label in [profile['instrumental'], profile['channel'], *profile['observed_labels'].values()]:
        if not isinstance(label, str) or not label or any(c in label for c in ',;\n\r$\\'):
            raise ValueError('Unsupported preset label')
    if profile['observed_labels'].get('reference_type') != profile['instrumental'] or profile['observed_labels'].get('reference_channel') != profile['channel']:
        raise ValueError('Preset reference labels disagree')

    p = build.Patch(); p.p = patch['patcher']
    boxes = {w['box']['id']: w['box'] for w in p.p['boxes']}
    ui = boxes['popup']['patcher']
    controls = {w['box']['id']: w['box'] for w in ui['boxes']}
    for kind, label in [('type', profile['instrumental']), ('channel', profile['channel'])]:
        # Fresh Live parameters need an enabled parameter initial value, not
        # only a patcher restore payload (@autorestore is deliberately off).
        # Saved Set values continue to override this first-instance default.
        control = controls['persist-'+kind]
        control['restore'] = ['vtm '+label]
        control['saved_attribute_attributes']['valueof'].update(
            parameter_initial_enable=1, parameter_initial=['vtm '+label])
    initial = dict(profile['controls'], offsetms=offset, **{'ac-valid': 0})
    allowed = {'enabled', 'voice-gain', 'beat-gain', 'auto-calibrate', 'offsetms', 'ac-valid'}
    if not set(initial) <= allowed:
        raise ValueError('Unsupported test control')
    for id, value in initial.items():
        controls[id]['saved_attribute_attributes']['valueof']['parameter_initial'] = [value]
    # A nonzero initial value must not bypass fresh path validation/calibration.
    removed = ((('control-route', 5), ('ac-nonzero', 0)))
    p.p['lines'] = [w for w in p.p['lines'] if
                    (tuple(w['patchline']['source']), tuple(w['patchline']['destination'])) != removed]

    # Set the visible mode without making a programmatic update look like a
    # user selection. The runtime declaration still goes through asrc-mode.
    source_ui = build.Patch(); source_ui.p = boxes['asrc-popup']['patcher']
    source_boxes = {w['box']['id']: w['box'] for w in source_ui.p['boxes']}
    route = source_boxes['route']
    index = route['numoutlets'] - 1
    route['text'] += ' presetmode'; route['numoutlets'] += 1
    source_ui.obj('test-mode-set', 'prepend set')
    source_ui.wire('route', 'test-mode-set', index)
    source_ui.wire('test-mode-set', 'mode')

    # Independent exact-label checks must all match current readbacks before
    # declaring this known external input to be the requested live test path.
    # Labels are matched as single symbols via a local coll; no IDs are copied.
    labels = profile['observed_labels']
    count = len(labels) + 2
    p.obj('test-setup-facts', 'pak '+' '.join(['0']*count), count, 1)
    p.obj('test-setup-unpack', 'unpack '+' '.join(['0']*count), 1, count)
    p.obj('test-setup-ready', 'expr '+' && '.join('($i'+str(i+1)+' == 1)' for i in range(count)), count, 1)
    p.wire('test-setup-facts', 'test-setup-unpack')
    for i in range(count): p.wire('test-setup-unpack', 'test-setup-ready', i, i)
    for i, (field, label) in enumerate(labels.items()):
        name = 'test-setup-'+field
        p.msg(name+'-expected', label)
        p.obj(name+'-symbol', 'tosymbol')
        p.obj(name+'-pair', 'pack s 1', 2, 1)
        p.obj(name+'-store', 'prepend store')
        p.obj(name+'-map', 'coll @embed 0', 1, 4)
        p.obj(name+'-actual', 'tosymbol')
        p.wire('ready-defer', name+'-expected')
        p.wire(name+'-expected', name+'-symbol')
        p.wire(name+'-symbol', name+'-pair')
        p.wire(name+'-pair', name+'-store')
        p.wire(name+'-store', name+'-map')
        p.wire('asrc-field-'+field+'-unpack', name+'-actual', 1)
        p.wire(name+'-actual', name+'-map')
        p.wire(name+'-map', 'test-setup-facts', 0, i)
        p.wire('asrc-field-'+field+'-zero', 'test-setup-facts', 0, i)
        p.wire('asrc-invalid', 'test-setup-facts', 0, i)
    p.wire('asrc-fields-ready', 'test-setup-facts', 0, len(labels))
    p.wire('asrc-audio-ready', 'test-setup-facts', 0, len(labels)+1)
    p.obj('test-setup-change', 'change -1', 3, 3)
    p.obj('test-setup-select', 'sel 1', 1, 2)
    p.obj('test-setup-mode-defer', 'deferlow')
    p.obj('test-setup-mode-gate', 'gate 1 0', 2, 1)
    p.msg('test-setup-live', '1')
    p.obj('test-setup-ui-mode', 'prepend presetmode')
    p.wire('test-setup-ready', 'test-setup-change')
    p.wire('test-setup-change', 'test-setup-select')
    # Identity invalidation happens in the same readback fan-out. Apply the
    # preference afterwards and recheck readiness to discard stale requests.
    p.wire('test-setup-select', 'test-setup-mode-defer')
    p.wire('test-setup-ready', 'test-setup-mode-gate')
    p.wire('test-setup-mode-defer', 'test-setup-mode-gate', 0, 1)
    p.wire('test-setup-mode-gate', 'test-setup-live')
    p.wire('test-setup-live', 'asrc-mode')
    p.wire('test-setup-live', 'test-setup-ui-mode')
    p.wire('test-setup-ui-mode', 'asrc-popup')

    # Add current path readiness to the EXISTING automatic first-use scheduler.
    # Existing REC / Auto Stop / host / peak / pending / one-attempt guards stay.
    boxes['ac-state']['text'] += ' 0'; boxes['ac-state']['numinlets'] += 1
    boxes['ac-unpack']['text'] += ' 0'; boxes['ac-unpack']['numoutlets'] += 1
    boxes['ac-eligible']['text'] += ' && ($i7 == 1)'; boxes['ac-eligible']['numinlets'] += 1
    p.wire('test-setup-ready', 'ac-state', 0, 6)
    p.wire('ac-unpack', 'ac-eligible', 6, 6)
    p.msg('test-setup-calibration-pending', 'autocalvalid 0')
    p.wire('asrc-path-transition', 'test-setup-calibration-pending', 1)
    p.wire('test-setup-calibration-pending', 'popup')
    p.wire('asrc-path-transition', 'ac-retry', 1)
    p.obj('test-setup-report-tag', 'prepend replace test_setup_ready')
    p.wire('test-setup-ready', 'test-setup-report-tag')
    p.wire('test-setup-report-tag', 'asrc-report')
    # Show each routing stage in one report: current options, desired saved
    # names and actual requested indices. Readbacks above remain authoritative.
    routing = boxes['wave-control-route']
    old_unmatched = routing['numoutlets'] - 1
    routing['text'] += ' test_setup_type_target test_setup_channel_target'
    routing['numoutlets'] += 2
    for wrapped in p.p['lines']:
        source = wrapped['patchline']['source']
        if source == ['wave-control-route', old_unmatched]: source[1] += 2
    popup = build.Patch(); popup.p = ui
    for i, kind in enumerate(('type', 'channel')):
        tag = 'test_setup_'+kind+'_target'
        popup.obj('test-setup-'+kind+'-target', 'prepend '+tag)
        popup.wire('persist-'+kind, 'test-setup-'+kind+'-target')
        popup.wire('test-setup-'+kind+'-target', 'out')
        p.obj('test-setup-'+kind+'-target-report', 'prepend replace '+tag)
        p.wire('wave-control-route', 'test-setup-'+kind+'-target-report', old_unmatched+i)
        p.wire('test-setup-'+kind+'-target-report', 'asrc-report')
        for suffix, source, outlet in (
                ('options', 'beat-router', i+2),
                ('command', 'wave-control-route', i)):
            name = 'test-setup-'+kind+'-'+suffix+'-report'
            p.obj(name, 'prepend replace test_setup_'+kind+'_'+suffix)
            p.wire(source, name, outlet)
            p.wire(name, 'asrc-report')
    p.p['description'] += '; preconfigured live test, automatic path verification and calibration'
    return patch
