"""Private Arrangement recording test, using the existing Auto Stop executor."""
from pathlib import Path

from assistant_preflight import OUTPUTS as PREFLIGHT_OUTPUTS


ROOT = Path(__file__).resolve().parent


def isolate_recording_stop(p):
    recording = 'ast-recording'
    p.obj(recording, '== 1', 2, 1)
    p.obj(recording+'-signal', 'sig~ 0', 1, 1, outlettype=['signal'])
    p.wire('lat-observe-0', recording)
    p.wire(recording, recording+'-signal')

    # Isolate the test request from the legacy microphone Stop path.
    removed = {(('stop-select', 0), ('as-request-gate', 1)),
               (('stop-select', 0), ('as-note-gate', 1)),
               (('as-effective-change', 0), ('autostop-tag', 0)),
               (('safety', 0), ('as-commit', 2))}
    p.p['lines'] = [line for line in p.p['lines'] if
                    (tuple(line['patchline']['source']), tuple(line['patchline']['destination'])) not in removed]
    p.obj('ast-commit-inputs', 'pak 0 0', 2, 1)
    p.obj('ast-commit-unpack', 'unpack 0 0', 1, 2)
    p.obj('ast-commit-rec', 'expr ($i1 == 1) && ($i2 == 1)', 2, 1)
    p.wire('safety', 'ast-commit-inputs')
    p.wire(recording, 'ast-commit-inputs', 0, 1)
    p.wire('ast-commit-inputs', 'ast-commit-unpack')
    p.wire('ast-commit-unpack', 'ast-commit-rec', 1, 1)
    p.wire('ast-commit-unpack', 'ast-commit-rec')
    p.wire('ast-commit-rec', 'as-commit', 0, 2)
    p.obj('ast-rec-off', 'sel 0', 1, 2)
    p.wire(recording, 'ast-rec-off')
    p.wire('ast-rec-off', 'as-invalidate')

    return recording


def add_stop_test_readback(p, reset_source, reset_outlet, report_prefix):
    p.msg('ast-zero', '0')
    p.wire(reset_source, 'ast-zero', reset_outlet)
    p.obj('ast-call-count', 'i 0', 2, 1)
    p.obj('ast-count-next', '+ 1', 2, 1)
    p.obj('ast-call-bang', 't b')
    p.wire('stop-call', 'ast-call-bang')
    p.wire('ast-call-bang', 'ast-call-count')
    p.wire('ast-call-count', 'ast-count-next')
    p.wire('ast-count-next', 'ast-call-count', 0, 1)
    p.wire('ast-zero', 'ast-call-count', 0, 1)
    for field, sources in (('calls', ('ast-count-next',)), ('readback', ('stop-confirmed', 'stop-unconfirmed'))):
        node = 'ast-report-'+field
        p.obj(node, 'prepend replace '+report_prefix+field)
        for source in (*sources, 'ast-zero'):
            p.wire(source, node)
        p.wire(node, 'asrc-report')


def add_transport_stop_test(p, ui, *, signal_graph, add_signal_list_export, reference_source, margin_ms):
    stimulus, review, results = 'ast-stimulus', 'ast-review', 'ast-results'
    recording = isolate_recording_stop(p)

    p.obj('ast-margin', f'sig~ {margin_ms}', 1, 1, outlettype=['signal'])
    paths = ROOT / 'src'
    engines = (
        (stimulus, paths/'vtm_assistant_stop_test.genexpr', 3,
         [(recording+'-signal', 0), ('apf-engine', PREFLIGHT_OUTPUTS.index('synced')),
          ('apf-engine', PREFLIGHT_OUTPUTS.index('timingready'))]),
        (review, reference_source, 3,
         [(stimulus, 1), ('silence', 0), (stimulus, 2), ('ast-margin', 0),
          (stimulus, 1), (stimulus, 1), (recording+'-signal', 0)]),
        (results, paths/'vtm_assistant_stop_test_results.genexpr', 8,
         [(stimulus, 0), (stimulus, 1), (review, 0), (review, 1), (review, 2)]),
    )
    for name, source, outlets, inputs in engines:
        p.obj(name, 'gen~', len(inputs), outlets, patcher=signal_graph(source, len(inputs), outlets),
              outlettype=['signal']*outlets)
        for inlet, (node, outlet) in enumerate(inputs):
            p.wire(node, name, outlet, inlet)

    add_signal_list_export(p, results, 'stop_test_', (
        ('stage', 1), ('count', 1), ('verdicts', 2), ('deviation_ms', 2), ('eligible', 1)))
    p.obj('ast-request-sample', 'snapshot~')
    p.obj('ast-request-edge', 'change 0', 3, 3)
    p.obj('ast-request-select', 'sel 1', 1, 2)
    p.obj('ast-request-rec', 'gate 1 0', 2, 1)
    p.obj('ast-request-current-test', 'gate 1 0', 2, 1)
    p.wire(results, 'ast-request-sample', 7)
    p.wire('poll', 'ast-request-sample')
    p.wire('ast-request-sample', 'ast-request-edge')
    p.wire('ast-request-edge', 'ast-request-select')
    p.wire(recording, 'ast-request-rec')
    p.wire('ast-request-select', 'ast-request-rec', 0, 1)
    p.wire('ast-request-rec', 'ast-request-current-test', 0, 1)
    p.wire('ast-request-current-test', 'as-request-gate', 0, 1)

    p.obj('ast-route', 'route transportstoptest', 1, 2)
    p.obj('ast-start', 't b b b b', 1, 4)
    p.wire('asrc-popup', 'ast-route')
    p.wire('ast-route', 'ast-start')
    p.wire('ast-start', 'as-invalidate', 3)
    # Close synchronously on a host/control transition, including before Gen
    # has processed the cancel message or produced its next snapshot.
    p.msg('ast-test-open', '1')
    p.msg('ast-test-close', '0')
    p.wire('ast-start', 'ast-test-open', 1)
    p.wire('as-invalidate', 'ast-test-close')
    p.wire('ast-test-open', 'ast-request-current-test')
    p.wire('ast-test-close', 'ast-request-current-test')
    for source, outlet, tag, targets in (('ast-start', 0, 'request', (stimulus,)),
                                         ('as-invalidate', 0, 'cancel', (stimulus, results))):
        p.obj('ast-'+tag+'-counter', 'counter 1 1000000000', 5, 4)
        p.obj('ast-'+tag, 'prepend '+tag)
        p.wire(source, 'ast-'+tag+'-counter', outlet)
        p.wire('ast-'+tag+'-counter', 'ast-'+tag)
        for target in targets:
            p.wire('ast-'+tag, target)

    add_stop_test_readback(p, 'ast-start', 2, 'stop_test_')

    p.obj('ast-stage-snapshot', 'snapshot~')
    p.obj('ast-stage-change', 'change 0', 3, 3)
    p.obj('ast-stage-tag', 'prepend transportstopstage')
    p.wire(results, 'ast-stage-snapshot')
    p.wire('poll', 'ast-stage-snapshot')
    p.wire('ast-stage-snapshot', 'ast-stage-change')
    p.wire('ast-stage-change', 'ast-stage-tag')
    p.wire('ast-stage-tag', 'asrc-popup')

    ui.p['rect'][3] = ui.p['openrect'][3] = 884.
    boxes = {item['box']['id']: item['box'] for item in ui.p['boxes']}
    boxes['window-config']['text'] = 'window flags float nogrow nozoom, window size 80 70 720 954, window exec'
    boxes['footer']['presentation_rect'][1] = 865.
    ui.button('ast-button', 'Test Stop', [20, 832, 95, 28])
    ui.label('ast-status', 'Pornește înregistrarea în Arrangement înainte de test.', [125, 836, 495, 21], 12)
    ui.obj('ast-bang', 't b')
    ui.msg('ast-command', 'transportstoptest')
    ui.wire('ast-button', 'ast-bang')
    ui.wire('ast-bang', 'ast-command')
    ui.wire('ast-command', 'out')
    ui.obj('ast-stage-route', 'route transportstopstage', 1, 2)
    ui.obj('ast-stage-select', 'sel 1 2 5 6', 1, 5)
    ui.wire('in', 'ast-stage-route')
    ui.wire('ast-stage-route', 'ast-stage-select')
    for index, message in enumerate(('Pornesc testul de oprire.', 'Test Stop în curs.',
                                    'Impulsuri evaluate. Salvează raportul.',
                                    'Test întrerupt. Verifică înregistrarea și redarea.')):
        node = 'ast-message-'+str(index)
        ui.msg(node, 'set '+message)
        ui.wire('ast-stage-select', node, index)
        ui.wire(node, 'ast-status')
