"""Store acoustic calibration with the routing facts exposed by Live."""
import math

from build import parameter_attributes


PROFILE_NAME = 'VTM Measured calibration profile'
LABEL_FIELDS = ('track_type', 'track_channel', 'main_type', 'reference_type', 'reference_channel')
KEY_SIZE = 10 + len(LABEL_FIELDS)


def verified_record(report, test_setup):
    """Seed a personal build from a completed measurement of its test route."""
    if (report.get('session_profile_valid') != 1 or report.get('calibration_status') != 3 or
            report.get('path_readbacks_complete') != 1 or
            (report.get('calibration_automatic_requests', 0) + report.get('calibration_manual_requests', 0) < 1)):
        raise ValueError('The report must contain an applied calibration on a verified route')
    fingerprint = report.get('observed_path', [])
    offset = report.get('preflight_appliedoffsetms')
    config = fingerprint[6:9]
    if (len(fingerprint) != 10 or fingerprint[-1] != 1 or
            any(not isinstance(atom, str) or atom in ('', '__unknown__', 'none', 'None') for atom in fingerprint[:6]) or
            config != report.get('audio_config_sr_signal_io') or
            any(not isinstance(value, (int, float)) or not math.isfinite(value) or value <= 0 for value in config) or
            not isinstance(offset, (float, int)) or not math.isfinite(offset) or abs(offset) >= 398):
        raise ValueError('The report contains an invalid calibration fingerprint or offset')
    labels = []
    for field in LABEL_FIELDS:
        raw = report.get('raw_'+field, {})
        label = next(iter(raw.values()), {}).get('display_name') if isinstance(raw, dict) else None
        if label != test_setup['observed_labels'][field]:
            raise ValueError(f'Calibration route does not match the test setup: {field}')
        labels.append(label)
    return [*fingerprint, *labels, offset]


def add_saved_calibration(p, ui, record=None):
    """Recall a measurement after routing, guard, and stored key agree."""
    attrs = parameter_attributes(PROFILE_NAME, '__unset__', 3, order=15)
    attrs['valueof']['parameter_linknames'] = 0
    initial = record if record is not None else ['__unset__']
    attrs['valueof']['parameter_initial'] = initial
    p.obj('ac-profile-persist', 'pattr vtm_measured_calibration @thru 0 @autorestore 0', 3, 3,
          saved_object_attributes=dict(parameter_enable=1, parameter_mappable=0),
          restore=initial, varname='vtm_measured_calibration',
          saved_attribute_attributes=attrs)
    p.p['parameters']['ac-profile-persist'] = [PROFILE_NAME, PROFILE_NAME, 0]

    # An offset by itself carries no evidence that the current route matches.
    p.p['lines'] = [line for line in p.p['lines'] if not (
        line['patchline']['source'] == ['control-route', 5] and
        line['patchline']['destination'] == ['ac-nonzero', 0])]
    p.msg('ac-profile-unverified', 'autocalvalid 0')
    p.wire('asrc-profile-off', 'ac-profile-unverified')
    p.wire('ac-profile-unverified', 'popup')

    p.obj('ac-profile-labels', 'pak '+' '.join(['s']*len(LABEL_FIELDS)), len(LABEL_FIELDS), 1)
    for inlet, field in enumerate(LABEL_FIELDS):
        node = 'ac-profile-label-'+field
        p.obj(node, 'tosymbol')
        p.wire('asrc-field-'+field+'-unpack', node, 1)
        p.wire('asrc-unknown', node)
        p.wire(node, 'ac-profile-labels', 0, inlet)
    p.obj('ac-profile-key', 'zl join', 2, 2)
    p.wire('asrc-current', 'ac-profile-key')
    p.wire('ac-profile-labels', 'ac-profile-key', 0, 1)

    p.obj('ac-profile-capture', 't b b b', 1, 3)
    p.wire('asrc-profile-on', 'ac-profile-capture')
    p.msg('ac-profile-capture-on', '1')
    p.msg('ac-profile-capture-off', '0')
    p.obj('ac-profile-capture-gate', 'gate 1 0', 2, 1)
    for index, node in enumerate(('ac-profile-capture-off', 'asrc-current', 'ac-profile-capture-on')):
        p.wire('ac-profile-capture', node, index)
    p.wire('ac-profile-capture-on', 'ac-profile-capture-gate')
    p.wire('ac-profile-capture-off', 'ac-profile-capture-gate')
    p.wire('ac-profile-key', 'ac-profile-capture-gate', 0, 1)
    p.obj('ac-profile-record', 'zl join', 2, 2)
    p.wire('ac-profile-capture-gate', 'ac-profile-record')
    p.wire('control-route', 'ac-profile-record', 5, 1)
    p.wire('ac-profile-record', 'ac-profile-persist')

    # Readiness is independent of instrumental amplitude, and still excludes
    # recording, unresolved paths and a calibration already in progress.
    p.obj('ac-profile-facts', 'pak 0 0 0 0 0 0', 6, 1)
    for inlet, (source, outlet) in enumerate((
            ('asrc-ready', 0), ('asrc-mode', 0), ('ac-control', 0), ('lat-permit', 0),
            ('asrc-profile-armed', 0), ('lat-pending-on', 0))):
        p.wire(source, 'ac-profile-facts', outlet, inlet)
    p.wire('lat-pending-off', 'ac-profile-facts', 0, 5)
    p.obj('ac-profile-facts-unpack', 'unpack 0 0 0 0 0 0', 1, 6)
    p.obj('ac-profile-ready', 'expr ($i1 == 1) && ($i2 == 1) && ($i3 == 1) && '
          '($i4 == 1) && ($i5 == 0) && ($i6 == 0)', 6, 1)
    p.wire('ac-profile-facts', 'ac-profile-facts-unpack')
    for i in range(6):
        p.wire('ac-profile-facts-unpack', 'ac-profile-ready', i, i)
    p.obj('ac-profile-check-change', 'change -1', 3, 3)
    p.obj('ac-profile-check-select', 'sel 1', 1, 2)
    p.obj('ac-profile-check-defer', 'deferlow')
    p.obj('ac-profile-resolve-gate', 'gate 1 0', 2, 1)
    p.wire('ac-profile-ready', 'ac-profile-resolve-gate')
    p.wire('ac-profile-ready', 'ac-profile-check-change')
    p.wire('ac-profile-check-change', 'ac-profile-check-select')
    p.wire('ac-profile-check-select', 'ac-profile-check-defer')
    p.wire('ac-profile-check-defer', 'ac-profile-resolve-gate', 0, 1)
    p.obj('ac-profile-lookup', 't b b', 1, 2)
    p.wire('ac-profile-resolve-gate', 'ac-profile-lookup')
    p.wire('ac-profile-lookup', 'ac-profile-persist', 1)
    p.wire('ac-profile-lookup', 'asrc-current')
    p.obj('ac-profile-split', f'zl slice {KEY_SIZE}', 2, 2)
    p.obj('ac-profile-compare', 'zl compare', 2, 2)
    p.obj('ac-profile-offset', 'f 0.', 2, 1)
    p.obj('ac-profile-decode', 't l l', 1, 2)
    p.obj('ac-profile-record-length', 'zl len', 2, 2)
    p.obj('ac-profile-record-valid', f'expr ($i1 == {KEY_SIZE + 1}) && ($f2 > -398.) && ($f2 < 398.)', 2, 1)
    p.wire('ac-profile-persist', 'ac-profile-decode')
    p.wire('ac-profile-decode', 'ac-profile-split', 1)
    p.wire('ac-profile-decode', 'ac-profile-record-length')
    p.wire('ac-profile-split', 'ac-profile-compare', 0, 1)
    p.wire('ac-profile-split', 'ac-profile-offset', 1, 1)
    p.wire('ac-profile-split', 'ac-profile-record-valid', 1, 1)
    p.wire('ac-profile-record-length', 'ac-profile-record-valid')
    p.wire('ac-profile-key', 'ac-profile-compare')
    p.obj('ac-profile-match', 'sel 1', 1, 2)
    p.obj('ac-profile-apply-gate', 'gate 1 0', 2, 1)
    p.obj('ac-profile-record-gate', 'gate 1 0', 2, 1)
    p.wire('ac-profile-compare', 'ac-profile-match')
    p.wire('ac-profile-match', 'ac-profile-apply-gate', 0, 1)
    p.wire('ac-profile-ready', 'ac-profile-apply-gate')
    p.wire('ac-profile-apply-gate', 'ac-profile-record-gate', 0, 1)
    p.wire('ac-profile-record-valid', 'ac-profile-record-gate')
    p.wire('ac-profile-record-gate', 'ac-profile-offset')
    p.obj('ac-profile-apply', 't b f', 1, 2)
    p.wire('ac-profile-offset', 'ac-profile-apply')
    p.wire('ac-profile-apply', 'lat-offset-tag', 1)
    p.msg('ac-profile-reused', '1')
    p.wire('ac-profile-apply', 'ac-profile-reused')
    p.wire('ac-profile-reused', 'asrc-profile-armed')
    p.wire('ac-profile-reused', 'asrc-revision-bang')
    p.wire('ac-profile-reused', 'ac-mark-valid')
    p.msg('ac-profile-reused-tag', 'savedcompensation')
    p.wire('ac-profile-reused', 'ac-profile-reused-tag')
    p.wire('ac-profile-reused-tag', 'asrc-popup')
    ui.obj('saved-compensation-route', 'route savedcompensation', 1, 2)
    ui.msg('saved-compensation-label', 'set Compensare reutilizată de pe traseul măsurat')
    ui.wire('in', 'saved-compensation-route')
    ui.wire('saved-compensation-route', 'saved-compensation-label')
    ui.wire('saved-compensation-label', 'profile')

    p.obj('ac-profile-origin', 'prepend replace calibration_origin')
    p.wire('ac-profile-origin', 'asrc-report')
    for value, source in (('saved', 'ac-profile-reused'), ('measured', 'asrc-profile-on'),
                          ('pending', 'asrc-profile-off')):
        node = 'ac-profile-origin-'+value
        p.msg(node, value)
        p.wire(source, node)
        p.wire(node, 'ac-profile-origin')
