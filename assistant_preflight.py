"""Read-only protocol for the experimental preflight Gen engine.

This is development-time metadata, not a Python runtime dependency for Live.
No state below is an on/off-beat verdict or authorization to stop transport.
"""
from pathlib import Path

ROOT = Path(__file__).resolve().parent
SOURCE = ROOT / 'src/vtm_assistant_preflight.genexpr'
OUTPUTS = ('state', 'detectpermit', 'evaluatepermit', 'rawphase',
           'correctedphase', 'periodms', 'inputpresent', 'referencepresent',
           'clipping', 'epoch', 'sampleclock', 'appliedoffsetms', 'synced',
           'lastboundarymask', 'lastboundaryms', 'controlchanges', 'hostchanges',
           'sourcechanges', 'timingchanges', 'resetchanges', 'freshchanges',
           'syncchanges', 'clipchanges', 'periodchanges', 'tempochanges',
           'hostagems', 'maxpollgapms', 'polltimeouts', 'synclosses',
           'lastpermitmask', 'lastpermitlossms', 'lastpermitboundarymask',
           'clockfaults', 'lastfaultmask', 'lastfaultprevious', 'lastfaultphase',
           'lastfaultinc', 'lastfaultperiodms', 'lastfaultms',
           'lastfaultlengthsamples', 'maxfaultlengthsamples', 'lastrecoveryinc',
           'lastfaultplaying', 'lastfaultcountingin', 'lastrecoveryms',
           'endpoint_hold_active', 'endpoint_hold_episodes', 'endpoint_recoveries',
           'last_endpoint_lengthsamples', 'max_endpoint_lengthsamples',
           'timingready', 'last_endpoint_resumephase', 'last_endpoint_resumeinc',
           'endpoint_catchups', 'endpoint_resume_rejections',
           'last_endpoint_expectedinc', 'last_endpoint_error_samples',
           'probe_clip_pause', 'last_clip_input_mask', 'timing_probe_permit')
DIAGNOSTIC_OUTPUTS = OUTPUTS[13:]
STATES = {
    0: 'Asistent oprit',
    1: 'Dispozitiv inactiv',
    2: 'Aștept confirmarea stării Ableton',
    3: 'Pornește redarea în Ableton',
    4: 'Aștept sfârșitul numărătorii',
    5: 'Se verifică sincronizarea',
    6: 'Alege sau confirmă sursa vocală',
    7: 'Alege o sursă instrumentală clară',
    8: 'Sincronizarea sursei trebuie verificată',
    9: 'Intrarea este prea puternică pentru evaluare',
    10: 'Reperul instrumental este prea puternic',
    11: 'Claritatea semnalului nu este confirmată',
    12: 'Aștept semnalul instrumental',
    13: 'Aștept semnal pe intrarea vocală',
    14: 'Urmăresc intrarea live în timpul REC',
    15: 'Urmăresc intrarea live, fără REC',
    16: 'Urmăresc sursa vocală înregistrată',
    17: 'Oprește REC pentru verificarea sursei înregistrate',
}
HOST_PROPERTIES = ('is_playing', 'is_counting_in', 'record_mode',
                   'session_record', 'session_record_status')
HOST_PARAMS = ('playing', 'countingin', 'recording', 'sessionrecord', 'sessionstatus')
TELEMETRY = (('sampleclock', 10), ('synced', 12), ('periodms', 5),
             ('detectpermit', 1), ('inputpresent', 6), ('referencepresent', 7),
             ('clipping', 8), ('appliedoffsetms', 11),
             ('epoch', 9), ('eligible', 2), ('state', 0))
DIAGNOSTIC_TELEMETRY = tuple((name, OUTPUTS.index(name)) for name in DIAGNOSTIC_OUTPUTS)


def gen_graph(Patch):
    """Embedded native DSP graph; caller supplies observed facts, not guesses."""
    graph = Patch(900, 600, 'dsp.gen')
    graph.p['openinpresentation'] = 0
    graph.box('code', 'codebox', ins=5, outs=len(OUTPUTS),
              rect=[20, 20, 850, 500], code=SOURCE.read_text())
    for index in range(5):
        name = 'in' + str(index + 1)
        graph.obj(name, 'in ' + str(index + 1), 0, 1)
        graph.wire(name, 'code', 0, index)
    for index in range(len(OUTPUTS)):
        name = 'out' + str(index + 1)
        graph.obj(name, 'out ' + str(index + 1), 1, 0)
        graph.wire('code', name, index)
    return graph.p


def apply_preflight_parent(p, Patch):
    """Read-only experimental wiring on a copy of the baseline device.

    Source identity, quality and timing-policy confirmation remain unknown
    until a source adapter supplies evidence. Do not guess from signal level
    or reuse the legacy calibration-valid bit as a path fingerprint.
    """
    p.obj('apf-engine', 'gen~', 5, len(OUTPUTS),
          patcher=gen_graph(Patch), outlettype=['signal']*len(OUTPUTS))
    for source, outlet, inlet in [('plugin', 0, 0), ('plugin', 1, 1),
                                  ('beat-plugin', 0, 2), ('beat-plugin', 1, 3),
                                  ('phasor', 0, 4)]:
        p.wire(source, 'apf-engine', outlet, inlet)

    def tag(id, param, source, outlet=0):
        p.obj(id, 'prepend '+param)
        p.wire(source, id, outlet)
        p.wire(id, 'apf-engine')

    for index in (0, 2, 3, 4):
        tag('apf-host-'+HOST_PARAMS[index], HOST_PARAMS[index],
            'lat-observe-'+str({0: 3, 2: 0, 3: 1, 4: 2}[index]))
    # A single new observer; reuse the existing reference audio port/router.
    p.obj('apf-count-observer', 'live.observer is_counting_in', 2, 2)
    p.wire('bind-id', 'apf-count-observer', 0, 1)
    tag('apf-host-countingin', 'countingin', 'apf-count-observer')
    p.msg('apf-host-unknown', '-1')
    p.wire('api-clear', 'apf-host-unknown')
    p.wire('api-lost', 'apf-host-unknown')
    p.wire('ready-defer', 'apf-host-unknown')
    for param in HOST_PARAMS:
        p.wire('apf-host-unknown', 'apf-host-'+param)
    p.obj('apf-count-query-defer', 'deferlow')
    p.obj('apf-count-query-gate', 'gate 1 0', 2, 1)
    p.msg('apf-count-query', 'property is_counting_in')
    p.wire('lat-api-bound', 'apf-count-query-defer')
    p.wire('api-valid', 'apf-count-query-gate')
    p.wire('apf-count-query-defer', 'apf-count-query-gate', 0, 1)
    p.wire('apf-count-query-gate', 'apf-count-query')
    p.wire('apf-count-query', 'apf-count-observer')
    tag('apf-api', 'apiready', 'api-valid')
    tag('apf-deviceon', 'deviceon', 'thisdevice', 1)
    tag('apf-enabled', 'enabled', 'control-route', 1)
    tag('apf-offset', 'offsetms', 'control-route', 5)
    tag('apf-reset', 'resetseq', 'control-route', 6)
    p.obj('apf-host-counter', 'counter 1 1000000000', 5, 4)
    p.wire('poll', 'apf-host-counter')
    tag('apf-host-lease', 'hostseq', 'apf-host-counter')
    # Session-local invalidation counter. Restoring a saved calibration needs
    # a durable path fingerprint check, not equality with this counter alone.
    p.obj('apf-audio-revision', 'counter 1 1000000000', 5, 4)
    p.msg('apf-reference-unconfirmed', 'referencebinding 0')
    p.wire('apf-reference-unconfirmed', 'apf-engine')
    # Selection/refresh invalidates a prior reference acceptance. A future
    # source adapter may re-accept only after matching actual route readback.
    for outlet in range(3):
        p.wire('wave-control-route', 'apf-reference-unconfirmed', outlet)
    p.wire('api-clear', 'apf-reference-unconfirmed')
    for index, (source, outlet, is_list) in enumerate([
        ('beat-router', 0, True), ('beat-router', 1, True),
        ('wave-samplerate', 1, False), ('wave-samplerate', 2, False),
        ('wave-samplerate', 3, False),
    ]):
        id = 'apf-path-change-'+str(index)
        p.obj(id, 'zl change' if is_list else 'change -1', 2 if is_list else 3, 2 if is_list else 3)
        p.wire(source, id, outlet)
        p.obj(id+'-bang', 't b')
        p.wire(id, id+'-bang')
        p.wire(id+'-bang', 'apf-audio-revision')
        p.wire(id+'-bang', 'apf-reference-unconfirmed')
    tag('apf-revision-tag', 'audiorevision', 'apf-audio-revision')
    # Coherent telemetry order: epoch, eligibility, state. Nothing is connected
    # to stop-defer/stop-call or to any original DSP/UI control destination.
    p.obj('apf-poll', 't '+' '.join(['b']*len(TELEMETRY)), 1, len(TELEMETRY))
    p.wire('poll', 'apf-poll')
    # Lifetime counters are maintained by DSP but read only on demand. Avoid
    # adding dictionary traffic to the 20 ms UI heartbeat under investigation.
    p.obj('apf-diagnostic-poll', 't '+' '.join(['b']*len(DIAGNOSTIC_TELEMETRY)),
          1, len(DIAGNOSTIC_TELEMETRY))
    for source, metrics in (('apf-poll', TELEMETRY),
                            ('apf-diagnostic-poll', DIAGNOSTIC_TELEMETRY)):
        for index, (name, output) in enumerate(metrics):
            trigger = len(metrics)-1-index
            p.obj('apf-'+name, 'snapshot~', 1, 1)
            p.wire('apf-engine', 'apf-'+name, output)
            p.wire(source, 'apf-'+name, trigger)


def make_experimental_patch():
    """Build graph for inspection/tests, without replacing any dist file."""
    import build
    p = build.Patch()
    p.p = build.make_patch()['patcher']
    apply_preflight_parent(p, build.Patch)
    p.p['description'] = 'Experimental assistant preflight, read-only diagnostics'
    # Re-establish deterministic, explicit fan-out for newly attached wires.
    def order(patch):
        groups = {}
        for wrapped in patch['lines']:
            line = wrapped['patchline']
            groups.setdefault(tuple(line['source']), []).append(line)
        if patch['classnamespace'] == 'box':
            for lines in groups.values():
                if len(lines) > 1:
                    for index, line in enumerate(lines):
                        line['order'] = index
        for wrapped in patch['boxes']:
            if 'patcher' in wrapped['box']:
                order(wrapped['box']['patcher'])
    order(p.p)
    return {'patcher': p.p}
