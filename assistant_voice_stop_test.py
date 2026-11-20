"""Guided vocal timing with the existing Arrangement Stop executor."""
from pathlib import Path

from assistant_preflight import OUTPUTS as PREFLIGHT_OUTPUTS
from assistant_stop_test import add_stop_test_readback, isolate_recording_stop


SOURCE = Path(__file__).resolve().parent / 'src/vtm_assistant_voice_stop_test.genexpr'
SECOND_CUE_DELAY_MS = 180


def add_guided_voice_stop(p, ui, stage, mode, capture, review, voiced, *, test_cue,
                          signal_graph, add_signal_list_export):
    recording = isolate_recording_stop(p)
    engine = 'voice-stop-test'
    permit = ('apf-engine', PREFLIGHT_OUTPUTS.index('timing_probe_permit'))
    inputs = [stage, mode, (recording+'-signal', 0), permit, (capture, 1), (capture, 9),
              (capture, 4), (review, 0), (review, 1), (voiced, 7), (review, 2), (capture, 11)]
    p.obj(engine, 'gen~', len(inputs), 7, patcher=signal_graph(SOURCE, len(inputs), 7), outlettype=['signal']*7)
    for inlet, (source, outlet) in enumerate(inputs):
        p.wire(source, engine, outlet, inlet)
    p.wire(recording+'-signal', review, 0, 6)
    p.msg('voice-stop-mask-rails', 'maskrails 1')
    p.wire('ready-defer', 'voice-stop-mask-rails')
    p.wire('voice-stop-mask-rails', voiced)

    p.obj('voice-stop-generation', 'prepend generation')
    p.wire('as-generation', 'voice-stop-generation')
    p.wire('voice-stop-generation', engine)
    p.obj('voice-stop-sample', 'snapshot~')
    p.obj('voice-stop-change', 'change 0', 3, 3)
    p.obj('voice-stop-current', 'expr ($i1 > 0) && ($i1 == $i2)', 2, 1)
    p.obj('voice-stop-select', 'sel 1', 1, 2)
    p.obj('voice-stop-rec-gate', 'gate 1 0', 2, 1)
    p.wire(engine, 'voice-stop-sample', 4)
    p.wire('poll', 'voice-stop-sample')
    p.wire('voice-stop-sample', 'voice-stop-change')
    p.wire('voice-stop-change', 'voice-stop-current')
    p.wire('as-generation', 'voice-stop-current', 0, 1)
    p.wire('voice-stop-current', 'voice-stop-select')
    p.wire(recording, 'voice-stop-rec-gate')
    p.wire('voice-stop-select', 'voice-stop-rec-gate', 0, 1)
    p.wire('voice-stop-rec-gate', 'as-request-gate', 0, 1)

    add_signal_list_export(p, engine, 'voice_stop_test_', (
        ('reviewed', 1), ('first_slot', 1), ('first_verdict', 1), ('first_deviation_ms', 1)))
    p.obj('voice-stop-expired', 'snapshot~')
    p.obj('voice-stop-expired-report', 'prepend replace voice_stop_test_clip_timeouts')
    p.wire(engine, 'voice-stop-expired', 6)
    p.wire('aq-export-capture', 'voice-stop-expired', 7)
    p.wire('voice-stop-expired', 'voice-stop-expired-report')
    p.wire('voice-stop-expired-report', 'asrc-report')
    p.obj('voice-stop-start-sample', 'snapshot~')
    p.obj('voice-stop-start-change', 'change 0', 3, 3)
    p.obj('voice-stop-start', 'sel 1', 1, 2)
    p.wire(engine, 'voice-stop-start-sample', 5)
    p.wire('poll', 'voice-stop-start-sample')
    p.wire('voice-stop-start-sample', 'voice-stop-start-change')
    p.wire('voice-stop-start-change', 'voice-stop-start')
    add_stop_test_readback(p, 'voice-stop-start', 0, 'voice_stop_test_')

    if test_cue:
        p.msg('voice-stop-visual-delay', f'secondcuedelayms {SECOND_CUE_DELAY_MS}')
        p.wire('ready-defer', 'voice-stop-visual-delay')
        p.wire('voice-stop-visual-delay', capture)
        p.msg('voice-stop-visual-delay-report', f'replace voice_stop_test_second_cue_delay_ms {SECOND_CUE_DELAY_MS}')
        p.wire('aq-export-capture', 'voice-stop-visual-delay-report', 7)
        p.wire('voice-stop-visual-delay-report', 'asrc-report')

    ui.p['rect'][3] = ui.p['openrect'][3] = 884.
    boxes = {item['box']['id']: item['box'] for item in ui.p['boxes']}
    boxes['window-config']['text'] = 'window flags float nogrow nozoom, window size 80 70 720 954, window exec'
    boxes['footer']['presentation_rect'][1] = 865.
    hint = ('Test Stop · pornește REC în Arrangement, apoi Probă ritm.' if test_cue else
            'Oprire auto se aplică în Probă ritm, cu REC în Arrangement.')
    ui.label('voice-stop-test-hint', hint, [20, 835, 600, 21], 13)
    p.msg('voice-stop-status', 'voicestopconfirmed')
    p.wire('stop-confirmed', 'voice-stop-status')
    p.wire('voice-stop-status', 'asrc-popup')
    ui.obj('voice-stop-status-route', 'route voicestopconfirmed', 1, 2)
    ui.msg('voice-stop-status-label', 'set Ableton a confirmat oprirea automată.')
    ui.msg('voice-stop-hint-reset', 'set '+hint)
    ui.wire('in', 'voice-stop-status-route')
    ui.wire('voice-stop-status-route', 'voice-stop-status-label')
    ui.wire('voice-stop-status-label', 'voice-stop-test-hint')
    ui.wire('aq-guided-rhythm-bang', 'voice-stop-hint-reset')
    ui.wire('voice-stop-hint-reset', 'voice-stop-test-hint')
