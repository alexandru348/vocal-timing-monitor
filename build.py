#!/usr/bin/env python3
"""Deterministic native-only Max patch + AMXD collective builder.

Container layout is reconstructed from the user's working v0.5 AMXD, not
produced by Max Freeze. tests/test_static.py parses every chunk independently.
There is one JSON entry, no external scripts, images, abstractions or samples.
"""
from pathlib import Path
import json
import struct
from latency_patch import apply_latency_popup, apply_latency_parent
from studio_ui import apply_studio_ui, apply_readable_type, apply_device_theme

ROOT = Path(__file__).resolve().parent
NAME = 'Vocal_Timing_Monitor_v0_9_RC1_6_Studio'
BG = [0.055, 0.071, 0.098, 1.]
CARD = [0.094, 0.118, 0.157, 1.]
TEXT = [0.91, 0.94, 0.98, 1.]
MUTED = [0.59, 0.67, 0.77, 1.]
CYAN = [0.29, 0.79, 0.91, 1.]
GREEN = [0.35, 0.84, 0.64, 1.]
RED = [1., 0.38, 0.43, 1.]
AMBER = [1., 0.73, 0.30, 1.]


class Patch:
    def __init__(self, width=900, height=400, namespace='box'):
        self.p = dict(fileversion=1, appversion=dict(major=8, minor=6, revision=0,
            architecture='x64', modernui=1), classnamespace=namespace,
            rect=[100., 100., float(width), float(height)],
            openinpresentation=1, default_fontname='Arial', default_fontsize=12.,
            bgcolor=BG, editing_bgcolor=BG, locked_bgcolor=BG,
            toolbarvisible=0, boxes=[], lines=[], autosave=0)
        self.auto = 0

    def box(self, id, cls='newobj', text=None, ins=1, outs=1, rect=None, pres=None, **kw):
        if rect is None:
            rect = [20. + (self.auto % 6) * 200, 460. + (self.auto // 6) * 45, 185., 22.]
            self.auto += 1
        b = dict(id=id, maxclass=cls, numinlets=ins, numoutlets=outs,
            patching_rect=[float(v) for v in rect], **kw)
        if text is not None:
            b['text'] = text
        if pres is not None:
            b.update(presentation=1, presentation_rect=[float(v) for v in pres])
        self.p['boxes'].append({'box': b})
        return id

    def obj(self, id, text, ins=1, outs=1, **kw):
        return self.box(id, text=text, ins=ins, outs=outs, **kw)

    def msg(self, id, text, **kw):
        return self.box(id, 'message', text, ins=2, outs=1, **kw)

    def wire(self, src, dst, so=0, di=0, order=None):
        pl = dict(source=[src, so], destination=[dst, di])
        if order is not None:
            pl['order'] = order
        self.p['lines'].append({'patchline': pl})

    def label(self, id, text, rect, size=12, color=TEXT, **kw):
        return self.box(id, 'comment', text, outs=0, pres=rect,
            fontsize=float(size), textcolor=color, **kw)

    def panel(self, id, rect):
        return self.box(id, 'panel', outs=0, pres=rect, bgcolor=CARD,
            border=0, rounded=12, background=1, ignoreclick=1)

    def button(self, id, text, rect, on=None, accent=False):
        # Toggle mode emits exactly one value per click. For actions both states
        # have identical labels/colors and the integer is converted to one bang.
        return self.box(id, 'textbutton', text, ins=1, outs=3, pres=rect,
            texton=on or text, mode=1, parameter_enable=0, rounded=7.,
            fontsize=12., fontface=1, textcolor=CYAN if accent else TEXT,
            textoncolor=TEXT, bgcolor=[0.12, 0.17, 0.22, 1.],
            bgoncolor=[0.10, 0.31, 0.38, 1.] if on else [0.12, 0.17, 0.22, 1.],
            usegradient=0, usebgoncolor=1, outputmode=1)


def popup():
    u = Patch(900, 720)
    u.p['title'] = 'Vocal Timing Monitor | 0.7 RC1'
    u.p['openrect'] = [60., 50., 960., 770.]
    u.box('in', 'inlet', ins=0, outs=1, index=1, rect=[20, 20, 25, 25])
    u.obj('out', 'outlet', 1, 0)
    tags = ['state', 'delta', 'count', 'level', 'tests', 'raw', 'sync', 'maxdev', 'disarm', 'init', 'api', 'hasdelta', 'stopnote',
            'wave_type', 'wave_channel', 'wave_types', 'wave_channels', 'wave_samples', 'beatlevel']
    u.obj('route', 'route ' + ' '.join(tags), 1, len(tags) + 1)
    u.wire('in', 'route')
    u.obj('load', 'loadbang', 0, 1)
    u.msg('window-config', 'window flags float, window size 60 50 960 770, window exec')
    u.obj('window', 'thispatcher', 1, 2)
    u.wire('load', 'window-config'); u.wire('window-config', 'window')

    u.label('title', 'VOCAL TIMING MONITOR', [24, 16, 560, 30], 22, CYAN, fontface=1)
    u.label('version', '0.7 RC1  /  MAX FOR LIVE', [655, 25, 220, 20], 11, MUTED)
    u.label('subtitle', 'Reper ritmic in timp real. Flow-ul si creativitatea raman ale tale.', [24, 49, 840, 22], 12, MUTED)
    u.panel('state-card', [20, 86, 390, 132])
    u.panel('delta-card', [424, 86, 235, 132])
    u.panel('count-card', [673, 86, 207, 132])
    u.label('state-caption', 'STARE', [36, 100, 340, 18], 10, MUTED)
    u.label('state-text', 'INITIALIZARE', [36, 127, 360, 30], 19, MUTED, fontface=1)
    u.label('clock-text', 'Ceas audio: --', [36, 165, 350, 19], 11, MUTED)
    u.label('api-text', 'Auto Stop: initializare conexiune', [36, 188, 350, 18], 10, MUTED)
    u.label('delta-caption', 'ULTIMA ABATERE', [440, 100, 200, 18], 10, MUTED)
    u.label('delta-text', '--', [440, 126, 200, 45], 31, TEXT, fontface=1)
    u.label('sign-caption', 'minus: devreme  /  plus: tarziu', [440, 185, 208, 18], 10, MUTED)
    u.label('count-caption', 'IMPULSURI AUDIO', [689, 100, 180, 18], 10, MUTED)
    u.label('count-text', '0', [689, 126, 170, 42], 31, TEXT, fontface=1)
    u.label('tests-text', 'Teste: 0', [689, 185, 170, 18], 11, MUTED)

    u.button('enabled', 'ANALIZA OFF', [24, 234, 160, 33], 'ANALIZA ON')
    u.button('autostop', 'AUTO STOP OFF', [198, 234, 170, 33], 'AUTO STOP ON')
    u.button('test', 'TEST IMPULS', [382, 234, 156, 33], accent=True)
    u.button('reset', 'RESET', [552, 234, 100, 33])
    u.label('level-text', 'Intrare: -- dB', [676, 239, 200, 24], 12, MUTED,
        hint='Varful audio brut pe ultimele 600 ms, inaintea detectorului.')

    u.label('grid-caption', 'GRILA', [24, 285, 140, 18], 10, MUTED)
    u.box('grid-ui', 'umenu', ins=1, outs=3, pres=[24, 307, 108, 26],
        items=['1/4', ',', '1/8', ',', '1/16'], bgcolor=CARD, textcolor=TEXT,
        parameter_enable=0)
    u.obj('grid-map', 'expr 4 * (1 + ($i1 == 1) + 3 * ($i1 == 2))')
    u.obj('grid-tag', 'prepend grid')
    u.wire('grid-ui', 'grid-map'); u.wire('grid-map', 'grid-tag'); u.wire('grid-tag', 'out')

    def number(id, label, x, value, lo, hi, integer=False):
        u.label(id + '-label', label, [x, 285, 180, 18], 10, MUTED)
        u.box(id, 'number' if integer else 'flonum', ins=1, outs=2,
            pres=[x, 307, 100, 26], minimum=lo, maximum=hi,
            bgcolor=CARD, textcolor=TEXT, triangle=0, parameter_enable=0,
            format=6 if not integer else 0)
        u.obj(id + '-tag', 'prepend ' + id)
        u.wire(id, id + '-tag'); u.wire(id + '-tag', 'out')
        return id

    number('redms', 'ABATERE MARE +/- ms', 152, 100, 10, 300, True)
    number('offsetms', 'COMPENSARE ms', 340, 0, -500, 500)
    # dB conversion is in the engine's parent to keep the control explicit.
    number('gatedb', 'DETECTIE dB', 520, -32, -60, -6)
    u.button('calibrate', 'PREIA ABATEREA', [684, 306, 190, 29])
    u.label('cal-hint', 'Calibrare: impuls cunoscut, grila 1/4.', [684, 340, 195, 32], 10, MUTED)
    u.label('limit-text', 'Limita grilei: -- ms', [24, 342, 620, 22], 11, MUTED)
    u.label('footer', 'Microfonul nu este redat la iesire cat timp dispozitivul este activ. Auto Stop: OFF la incarcare.', [24, 676, 850, 18], 10, MUTED)
    u.label('footer2', 'Undele arata semnalele primite. Timing-ul este calculat fata de grila Live, nu fata de forma beat-ului.', [24, 696, 855, 18], 10, MUTED)

    # Status conversion is native Max and independent from window visibility.
    u.obj('state-select', 'sel 0 1 2 3 4 5 6 7 8 9 10', 1, 12)
    u.wire('route', 'state-select', tags.index('state'))
    states = [
        ('ANALIZA OPRITA', MUTED), ('ASTEPT CEAS AUDIO', MUTED),
        ('STABILIZEZ CEASUL', AMBER), ('ASCULT / SYNC OK', CYAN),
        ('APROAPE DE GRILA', GREEN), ('ABATERE MICA', AMBER),
        ('ABATERE MARE', RED), ('TEST OK', CYAN),
        ('TEST: FARA SYNC LA CLICK', AMBER), ('CERERE STOP', RED),
        ('FARA PROCESARE AUDIO', AMBER)]
    for i, (label, color) in enumerate(states):
        u.msg('status-' + str(i), 'set ' + label)
        u.msg('color-' + str(i), 'textcolor ' + ' '.join(map(str, color)))
        u.wire('state-select', 'status-' + str(i), i)
        u.wire('state-select', 'color-' + str(i), i)
        u.wire('status-' + str(i), 'state-text')
        u.wire('color-' + str(i), 'state-text')
        u.wire('color-' + str(i), 'delta-text')

    def formatted(tag, fmt, dest):
        u.obj(tag + '-format', 'sprintf ' + fmt)
        u.obj(tag + '-set', 'prepend set')
        u.wire('route', tag + '-format', tags.index(tag))
        u.wire(tag + '-format', tag + '-set')
        u.wire(tag + '-set', dest)

    u.obj('delta-gate', 'gate 1 0', 2, 1)
    u.obj('delta-format', 'sprintf %+.1f ms')
    u.obj('delta-set', 'prepend set')
    u.wire('route', 'delta-gate', tags.index('hasdelta'))
    u.wire('route', 'delta-gate', tags.index('delta'), 1)
    u.wire('delta-gate', 'delta-format'); u.wire('delta-format', 'delta-set'); u.wire('delta-set', 'delta-text')
    u.obj('hasdelta-select', 'sel 0', 1, 2)
    u.msg('no-delta', 'set --')
    u.wire('route', 'hasdelta-select', tags.index('hasdelta'))
    u.wire('hasdelta-select', 'no-delta'); u.wire('no-delta', 'delta-text')
    formatted('count', '%ld', 'count-text')
    formatted('tests', 'Teste: %ld', 'tests-text')
    u.obj('level-floor', 'maximum 0.00001', 2, 1)
    u.obj('level-db', 'expr 20. * log10($f1)')
    u.obj('level-format', 'sprintf Intrare: %.1f dB')
    u.obj('level-set', 'prepend set')
    u.wire('route', 'level-floor', tags.index('level')); u.wire('level-floor', 'level-db'); u.wire('level-db', 'level-format')
    u.wire('level-format', 'level-set'); u.wire('level-set', 'level-text')
    formatted('maxdev', 'Limita grilei: +/- %.1f ms (pragul mai mare nu poate fi atins)', 'limit-text')
    u.obj('sync-select', 'sel 0 1', 1, 3)
    u.wire('route', 'sync-select', tags.index('sync'))
    for i, s in enumerate(['set Ceas audio: indisponibil / oprit', 'set Ceas audio: sincronizat']):
        u.msg('sync-' + str(i), s); u.wire('sync-select', 'sync-' + str(i), i); u.wire('sync-' + str(i), 'clock-text')
    u.obj('api-select', 'sel 0 1', 1, 3); u.wire('route', 'api-select', tags.index('api'))
    for i, s in enumerate(['set Auto Stop: conexiune indisponibila', 'set Auto Stop: conexiune pregatita']):
        u.msg('api-' + str(i), s); u.wire('api-select', 'api-' + str(i), i); u.wire('api-' + str(i), 'api-text')

    # A request result stays visible after the user-facing toggle disarms.
    # Preview itself is not a refusal reason: Cycling74 documents API support
    # in preview. Explicit user intent, verified binding and actual clock guard Stop.
    stopnotes = {
        0: 'Auto Stop: verific cererea', 1: 'Ultimul Stop: blocat - fara conexiune',
        3: 'Ultimul Stop: blocat - dispozitiv inactiv',
        4: 'Ultimul Stop: blocat - fara ceas', 5: 'Ultimul Stop: blocat - fara procesare audio',
        6: 'Ultimul Stop: blocat - analiza OFF', 7: 'Ultimul Stop: anulat - comutator OFF',
        8: 'Ultimul Stop: comanda trimisa', 9: 'Ultimul Stop: oprire confirmata de Live',
        10: 'Ultimul Stop: Live inca reda'}
    u.obj('stopnote-select', 'sel '+' '.join(map(str,stopnotes)), 1, len(stopnotes)+1)
    u.wire('route', 'stopnote-select', tags.index('stopnote'))
    for outlet, (code, note) in enumerate(stopnotes.items()):
        u.msg('stopnote-'+str(code), 'set '+note)
        u.wire('stopnote-select', 'stopnote-'+str(code), outlet)
        u.wire('stopnote-'+str(code), 'api-text')

    # Last raw value can only be applied after an AUDIO event, on quarter grid.
    u.obj('raw-store', 'f 0.', 2, 1); u.wire('route', 'raw-store', tags.index('raw'), 1)
    u.obj('cal-pak', 'pak 0 0', 2, 1)
    u.obj('cal-unpack', 'unpack 0 0', 1, 2)
    u.obj('cal-valid', 'expr ($i1 > 0) && ($i2 == 0)', 2, 1)
    u.wire('route', 'cal-pak', tags.index('count')); u.wire('grid-ui', 'cal-pak', 0, 1)
    u.wire('cal-pak', 'cal-unpack'); u.wire('cal-unpack', 'cal-valid'); u.wire('cal-unpack', 'cal-valid', 1, 1)
    u.obj('cal-gate', 'gate 1 0', 2, 1); u.wire('cal-valid', 'cal-gate')
    u.obj('cal-active', 'prepend active'); u.wire('cal-valid', 'cal-active'); u.wire('cal-active', 'calibrate')
    next(b['box'] for b in u.p['boxes'] if b['box']['id'] == 'calibrate')['active'] = 0
    u.obj('cal-bang', 't b'); u.wire('calibrate', 'cal-bang'); u.wire('cal-bang', 'cal-gate', 0, 1)
    u.wire('cal-gate', 'raw-store'); u.wire('raw-store', 'offsetms')

    for id, param in [('enabled', 'enabled'), ('autostop', 'autostop')]:
        u.obj(id + '-tag', 'prepend ' + param)
        u.wire(id, id + '-tag'); u.wire(id + '-tag', 'out')
    for id, param in [('test', 'testseq'), ('reset', 'resetseq')]:
        u.obj(id + '-bang', 't b'); u.obj(id + '-counter', 'counter 1 1000000000', 5, 4)
        u.obj(id + '-tag', 'prepend ' + param)
        u.wire(id, id + '-bang'); u.wire(id + '-bang', id + '-counter')
        u.wire(id + '-counter', id + '-tag'); u.wire(id + '-tag', 'out')
    u.msg('off', '0'); u.wire('route', 'off', tags.index('disarm')); u.wire('off', 'autostop')
    u.obj('initialize', 't b b b b b b b', 1, 7)
    u.wire('route', 'initialize', tags.index('init'))
    for i, (dest, value) in enumerate([('enabled', '1'), ('autostop', '0'), ('grid-ui', '0'),
        ('redms', '100'), ('offsetms', '0.'), ('gatedb', '-32.'), ('delta-text', 'set --')]):
        u.msg('initial-' + str(i), value); u.wire('initialize', 'initial-' + str(i), i); u.wire('initial-' + str(i), dest)
    add_waveform_popup(u, tags)
    compact_popup(u)
    add_persistent_controls(u, tags)
    apply_studio_ui(u, parameter_attributes)
    apply_latency_popup(u)
    return u.p


PERSISTENT_CONTROLS = [
    ('enabled', 'VTM Analysis', 1, 0, 1, 1),
    ('grid-ui', 'VTM Grid', 0, 0, 2, 1),
    ('redms', 'VTM Threshold ms', 100, 10, 300, 0),
    ('offsetms', 'VTM Compensation ms', 0., -500, 500, 0),
    ('gatedb', 'VTM Detection dB', -32., -60, -6, 0),
    ('voice-gain', 'VTM Voice zoom', 1., 1, 8, 0),
    ('beat-gain', 'VTM Beat zoom', 1., 1, 8, 0),
]


def parameter_attributes(name, initial, ptype=0, low=None, high=None, order=0):
    attrs = dict(parameter_longname=name, parameter_shortname=name,
                 parameter_type=ptype, parameter_invisible=1,
                 parameter_initial_enable=1, parameter_initial=[initial],
                 parameter_order=order)
    if low is not None: attrs['parameter_mmin'] = float(low)
    if high is not None: attrs['parameter_mmax'] = float(high)
    return {'valueof': attrs}


def add_persistent_controls(u, tags):
    """Live-owned per-instance parameters; no external preset files.

    Replay restored values only after live.thisdevice. Never replay Auto Stop
    intent or action buttons. Routing labels are matched exactly against the
    host's current lists; indices and volatile Live ids are never persisted.
    """
    b = {w['box']['id']: w['box'] for w in u.p['boxes']}
    for order, (id, name, initial, low, high, ptype) in enumerate(PERSISTENT_CONTROLS):
        b[id].update(parameter_enable=1, parameter_mappable=0,
                     varname='vtm_'+id.replace('-', '_'),
                     saved_attribute_attributes=parameter_attributes(
                         name, initial, ptype, low, high, order))
    # Threshold exceeds the 0..255 integer parameter range: store as Float,
    # while the original number box continues to display an integer.
    b['redms']['saved_attribute_attributes']['valueof']['parameter_unitstyle'] = 0
    # Old init messages overwrote the Live-restored values. Bang numeric UIs;
    # textbutton bang would toggle it: query the bound UI value via pattr.
    for i in (0, 2, 3, 4, 5): b['initial-'+str(i)]['text'] = 'bang'
    u.p['lines'] = [w for w in u.p['lines'] if not (
        w['patchline']['source'] == ['initial-0', 0] and
        w['patchline']['destination'] == ['enabled', 0])]
    u.obj('enabled-replay', 'pattr @bindto vtm_enabled @thru 0 @autorestore 0',
          3, 3, saved_object_attributes=dict(parameter_enable=0))
    u.wire('initial-0', 'enabled-replay')
    u.wire('enabled-replay', 'enabled-tag')
    for name in ('voice', 'beat'):
        u.p['lines'] = [w for w in u.p['lines'] if w['patchline']['source'] != [name+'-initial-gain', 0]
                        and w['patchline']['destination'] != [name+'-initial-gain', 0]]
        b[name+'-initial-gain']['text'] = 'bang'
        u.wire('initialize', name+'-initial-gain', 6)
        u.wire(name+'-initial-gain', name+'-gain')
    u.obj('persist-reset', 't b b', 1, 2)
    u.msg('persist-restore-on', '1'); u.msg('persist-capture-off', '0')
    u.wire('initialize', 'persist-reset', 6)
    u.wire('persist-reset', 'persist-restore-on', 1)
    u.wire('persist-reset', 'persist-capture-off')
    u.msg('persist-retry', 'set -1')
    u.wire('persist-reset', 'persist-retry', 1)
    u.obj('persist-manual', 't b b', 1, 2)
    u.msg('persist-restore-off', '0'); u.msg('persist-capture-on', '1')
    u.wire('persist-manual', 'persist-restore-off', 1)
    u.wire('persist-manual', 'persist-capture-on')
    for kind, selected, choices in [('type','wave_type','wave_types'),
                                    ('channel','wave_channel','wave_channels')]:
        prefix = 'persist-'+kind
        name = 'VTM Instrumental '+kind
        attrs = parameter_attributes(name, '__vtm_unset__', 3,
                                     order=10 if kind=='type' else 11)
        # newobj's parameters belong to the wrapped object's attributes.
        # Enabling only through @parameter_enable in its text created default
        # Float parameters in the RC3 host test; symbolic values were lost.
        # Use native pattr serialization so Blob/Stored Only metadata is loaded.
        attrs['valueof'].pop('parameter_initial_enable')
        attrs['valueof'].pop('parameter_initial')
        attrs['valueof']['parameter_linknames'] = 0
        u.obj(prefix, 'pattr vtm_beat_'+kind+' @thru 0 @autorestore 0',
              3, 3,
              saved_object_attributes=dict(parameter_enable=1, parameter_mappable=0),
              restore=['__vtm_unset__'],
              varname='vtm_saved_beat_'+kind,
              saved_attribute_attributes=attrs)
        # Native feedback is a selected INDEX, not a label (confirmed in the
        # owner's RC3.1 ALS: both former symbolic captures contained "vtm 2").
        # Resolve that index through the current list before storing its label.
        # Startup feedback cannot replace the restored desired labels.
        u.obj(prefix+'-capture', 'gate 1 0', 2, 1)
        u.wire('beat-'+kind+'-selected-index', prefix+'-capture', 0, 1)
        u.wire('persist-capture-off', prefix+'-capture')
        u.wire('persist-capture-on', prefix+'-capture')
        u.obj(prefix+'-index-map', 'coll @embed 0', 1, 4)
        u.wire(prefix+'-capture', prefix+'-index-map')
        u.wire(prefix+'-index-map', prefix)
        menu = 'beat-'+kind
        u.p['lines'] = [w for w in u.p['lines'] if not (
            w['patchline']['source'] == [menu,0] and
            w['patchline']['destination'] == [menu+'-command',0])]
        u.obj(prefix+'-manual', 't i b', 1, 2)
        u.wire(menu, prefix+'-manual'); u.wire(prefix+'-manual', 'persist-manual', 1)
        u.wire(prefix+'-manual', menu+'-command')
        # Exact label -> current index table. No prefix match or global coll name.
        u.obj(prefix+'-list', 't b l b', 1, 3)
        u.wire('route', prefix+'-list', tags.index(choices))
        u.obj(prefix+'-map', 'coll @embed 0', 1, 4)
        u.msg(prefix+'-clear', 'clear'); u.msg(prefix+'-zero', 'set 0')
        u.wire(prefix+'-list', prefix+'-clear', 2); u.wire(prefix+'-clear', prefix+'-map')
        u.wire(prefix+'-clear', prefix+'-index-map')
        u.wire(prefix+'-list', prefix+'-zero', 2)
        u.obj(prefix+'-iter', 'iter'); u.obj(prefix+'-list-key', 'prepend vtm')
        u.obj(prefix+'-list-symbol', 'tosymbol'); u.obj(prefix+'-entry', 't s b', 1, 2)
        u.obj(prefix+'-index', 'counter 0 1000000000', 5, 4)
        u.wire(prefix+'-zero', prefix+'-index')
        u.obj(prefix+'-pair', 'pack s 0', 2, 1); u.obj(prefix+'-store', 'prepend store')
        u.obj(prefix+'-reverse', 'zl rev', 2, 2)
        u.wire(prefix+'-list', prefix+'-iter', 1)
        u.wire(prefix+'-iter', prefix+'-list-key'); u.wire(prefix+'-list-key', prefix+'-list-symbol')
        u.wire(prefix+'-list-symbol', prefix+'-entry')
        u.wire(prefix+'-entry', prefix+'-index', 1)
        u.wire(prefix+'-index', prefix+'-pair', 0, 1)
        u.wire(prefix+'-entry', prefix+'-pair')
        u.wire(prefix+'-pair', prefix+'-store'); u.wire(prefix+'-store', prefix+'-map')
        u.wire(prefix+'-pair', prefix+'-reverse')
        # A numeric-leading list is coll's documented numeric-address store.
        u.wire(prefix+'-reverse', prefix+'-index-map')
        # If confirmed feedback preceded the list, resolve it after rebuilding
        # the map too. Capture is still closed throughout startup restoration.
        u.wire(prefix+'-list', 'beat-'+kind+'-selected-index')
        u.obj(prefix+'-defer', 'deferlow'); u.obj(prefix+'-restore', 'gate 1 1', 2, 1)
        u.wire(prefix+'-list', prefix+'-defer')
        u.wire(prefix+'-defer', prefix+'-restore', 0, 1)
        u.wire('persist-restore-on', prefix+'-restore'); u.wire('persist-restore-off', prefix+'-restore')
        u.wire(prefix+'-restore', prefix); u.wire(prefix, prefix+'-map')
        u.obj(prefix+'-change', 'change -1', 3, 3)
        u.wire('persist-retry', prefix+'-change')
        u.wire(prefix+'-map', prefix+'-change')
        if kind == 'type':
            u.obj(prefix+'-apply', 't i b', 1, 2)
            u.msg('persist-channel-retry', 'set -1')
            u.wire(prefix+'-change', prefix+'-apply')
            u.wire(prefix+'-apply', 'persist-channel-retry', 1)
            u.wire('persist-channel-retry', 'persist-channel-change')
            u.wire(prefix+'-apply', menu+'-command')
        else: u.wire(prefix+'-change', menu+'-command')
    u.p['title'] = 'Vocal Timing Monitor | 0.7 RC3.3 Persistent'
    b['version']['text'] = '0.7 RC3.3 / SALVARE'
    b['footer2']['text'] = 'Setari in proiect (Ctrl+S). Auto Stop se activeaza manual. Iesire microfon muta.'


def compact_popup(u):
    """Presentation-only layout; all established control/audio paths stay intact.

    Settings live below the compact viewport. Expand at the current window
    origin using thispatcher's documented getsize/size protocol, never by
    resizing the scopes or changing the audio history.
    """
    u.p.update(title='Vocal Timing Monitor | 0.7 RC2 Compact',
               rect=[60., 50., 600., 340.], openrect=[60., 50., 600., 340.])
    b = {w['box']['id']: w['box'] for w in u.p['boxes']}
    for obj in b.values():
        obj.pop('presentation', None)
        obj.pop('presentation_rect', None)

    def place(id, rect, size=None, text=None):
        obj = b[id]
        obj.update(presentation=1, presentation_rect=list(map(float, rect)))
        if size is not None: obj['fontsize'] = float(size)
        if text is not None: obj['text'] = text

    b['window-config']['text'] = ('window flags float nogrow nozoom, '
        'window size 60 50 660 390, window exec')
    place('title', [16, 10, 350, 25], 16)
    place('version', [367, 17, 112, 15], 9, '0.7 RC2 / COMPACT')
    place('state-card', [12, 46, 576, 60])
    place('state-text', [24, 54, 384, 26], 19)
    place('delta-text', [424, 49, 154, 34], 27)
    place('clock-text', [24, 83, 382, 16], 10)
    place('sign-caption', [424, 85, 154, 15], 9, '- devreme / + tarziu')
    place('enabled', [16, 116, 100, 28], 10)
    place('autostop', [124, 116, 156, 28], 11)
    place('reset', [288, 116, 70, 28], 11)
    place('count-caption', [376, 122, 112, 17], 10, 'ATACURI AUDIO')
    place('count-text', [493, 116, 85, 28], 21)
    place('voice-caption', [16, 154, 330, 16], 10, 'VOCE / INTRAREA PISTEI')
    place('level-text', [366, 154, 218, 16], 10)
    place('voice-scope', [16, 173, 568, 53])
    place('grid-scope', [16, 230, 568, 14])
    place('beat-caption', [16, 250, 330, 16], 10, 'INSTRUMENTAL')
    place('beat-level', [366, 250, 218, 16], 10)
    place('beat-scope', [16, 269, 568, 49])
    place('time-old', [16, 320, 60, 14], 9)
    place('time-mid', [285, 320, 60, 14], 9)
    place('time-now', [538, 320, 46, 14], 9)

    # Labels reflect the EXISTING three timing bands; only the red band stops.
    for i, label in {3: 'ASCULT / SYNC OK', 4: 'ON BEAT',
                     5: 'USOR DECALAT', 6: 'OFF BEAT', 9: 'OPRIRE...'}.items():
        b['status-'+str(i)]['text'] = 'set '+label
    b['state-text']['hint'] = ('Ultimul atac fata de grila Live. Verde: aproape; '
        'galben: decalaj moderat; rosu: pragul Auto Stop atins. Nu e evaluarea flow-ului.')
    b['autostop']['hint'] = ('Activare explicita dupa sincronizare. La prima abatere '
        'care atinge pragul, opreste Live si inregistrarea in curs; apoi revine OFF.')
    b['autostop']['bgoncolor'] = [0.32, 0.22, 0.09, 1.]
    b['autostop']['textoncolor'] = AMBER
    b['grid-scope']['hint'] = 'Reperele grilei Live, pe aceeasi axa de 6 secunde.'

    u.panel('settings-card', [12, 350, 576, 258])
    place('beat-source-caption', [24, 357, 400, 17], 11, 'SURSA INSTRUMENTALULUI')
    place('beat-type', [24, 379, 304, 26], 11)
    place('beat-channel', [338, 379, 154, 26], 11)
    place('beat-refresh', [502, 379, 74, 26], 10, 'REFRESH')
    b['beat-refresh']['texton'] = 'REFRESH'
    for id, caption, x, width in [('grid-ui', 'GRILA', 24, 80),
        ('redms', 'PRAG +/- ms', 120, 100), ('offsetms', 'COMPENSARE ms', 236, 108),
        ('gatedb', 'DETECTIE dB', 360, 100)]:
        labelid = 'grid-caption' if id == 'grid-ui' else id+'-label'
        place(labelid, [x, 417, width+10, 16], 9, caption)
        place(id, [x, 438, width, 26], 11)
    place('calibrate', [476, 438, 100, 26], 10, 'CALIBREAZA')
    b['calibrate']['texton'] = 'CALIBREAZA'
    b['calibrate']['hint'] = 'Preia ultima abatere audio bruta; doar impuls cunoscut pe grila 1/4.'
    place('voice-gain-caption', [24, 481, 118, 17], 10, 'MARIRE VOCE x')
    place('voice-gain', [148, 477, 60, 25], 11)
    place('beat-gain-caption', [234, 481, 112, 17], 10, 'MARIRE BEAT x')
    place('beat-gain', [350, 477, 60, 25], 11)
    place('test', [452, 477, 124, 25], 10)
    place('api-text', [24, 516, 552, 19], 10)
    place('tests-text', [24, 542, 130, 17], 10)
    place('limit-text', [24, 566, 552, 17], 9)
    place('wave-hint', [176, 542, 400, 17], 9, 'Marirea vizuala nu schimba sunetul sau detectia.')
    place('footer2', [24, 588, 552, 16], 9, 'Timing fata de grila Live. Auto Stop opreste si redarea. Iesire microfon muta.')

    # The settings button has no connection to analysis, routing or Auto Stop.
    u.button('settings', 'SETARI', [490, 10, 94, 26], 'ASCUNDE')
    u.obj('settings-trigger', 't b i', 1, 2)
    u.obj('settings-height', 'expr 340 + 280 * $i1')
    u.msg('settings-query', 'window getsize')
    u.obj('window-route', 'route window', 1, 2)
    u.obj('window-size-route', 'route size', 1, 2)
    u.obj('window-unpack', 'unpack 0 0 0 0', 1, 4)
    u.obj('window-left', 't i i', 1, 2)
    u.obj('window-right', '+ 600', 2, 1)
    u.obj('window-bottom', '+ 340', 2, 1)
    u.obj('window-pack', 'pack 0 0 0 0', 4, 1)
    u.msg('window-resize', 'window size $1 $2 $3 $4, window exec')
    u.wire('settings', 'settings-trigger')
    u.wire('settings-trigger', 'settings-height', 1)
    u.wire('settings-height', 'window-bottom', 0, 1)
    u.wire('settings-trigger', 'settings-query')
    u.wire('settings-query', 'window')
    u.wire('window', 'window-route')
    u.wire('window-route', 'window-size-route')
    u.wire('window-size-route', 'window-unpack')
    u.wire('window-unpack', 'window-bottom', 1)
    u.wire('window-unpack', 'window-pack', 1, 1)
    u.wire('window-bottom', 'window-pack', 0, 3)
    u.wire('window-unpack', 'window-left')
    u.wire('window-left', 'window-right', 1)
    u.wire('window-right', 'window-pack', 0, 2)
    u.wire('window-left', 'window-pack')
    u.wire('window-pack', 'window-resize')
    u.wire('window-resize', 'window')


def add_waveform_popup(u, tags):
    """Native history displays only; no transport/analysis or recording ownership."""
    u.label('voice-caption', 'VOCE / INTRAREA PISTEI', [24, 380, 380, 20], 12, CYAN, fontface=1)
    u.label('history-caption', 'Istoric comun: 6 secunde', [390, 382, 230, 18], 10, MUTED)
    u.label('voice-gain-caption', 'MARIRE VIZUALA x', [654, 382, 144, 18], 10, MUTED)
    u.label('grid-wave-caption', 'REPERE GRILA LIVE', [24, 476, 250, 17], 9, AMBER)
    u.label('grid-wave-hint', 'Reperele se deplaseaza impreuna cu undele', [540, 476, 335, 17], 9, MUTED)
    u.label('beat-caption', 'INSTRUMENTAL', [24, 518, 260, 20], 12, GREEN, fontface=1)
    u.label('beat-level', 'Beat: -- dB', [320, 520, 260, 18], 10, MUTED)
    u.label('beat-gain-caption', 'MARIRE VIZUALA x', [654, 520, 144, 18], 10, MUTED)
    for name, y, h, color, limits in [
        ('voice', 405, 67, CYAN, [-1., 1.]),
        ('grid', 494, 18, AMBER, [0., 1.15]),
        ('beat', 542, 67, GREEN, [-1., 1.])]:
        u.box(name+'-signal', 'inlet', ins=0, outs=1, index={'voice':2, 'beat':3, 'grid':4}[name],
              rect=[{'voice':60,'beat':100,'grid':140}[name],20,25,25], outlettype=['signal'])
        u.box(name+'-scope', 'live.scope~', ins=2, outs=0, pres=[24,y,852,h],
              active=1, mode=0, samples=264600., interval=40., range=limits,
              smooth=0, decay_time=0., grid=0, line_width=1., rounded=5.,
              bgcolor=CARD, activebgcolor=CARD, linecolor=color, activelinecolor=color,
              parameter_enable=0, ignoreclick=1)
        if name != 'grid':
            u.box(name+'-gain', 'flonum', ins=1, outs=2, pres=[802,y-25,72,21],
                  minimum=1., maximum=8., bgcolor=CARD, textcolor=TEXT,
                  parameter_enable=0, triangle=0, format=6)
            u.obj(name+'-magnify', '*~ 1.', 2, 1, outlettype=['signal'])
            u.wire(name+'-signal', name+'-magnify'); u.wire(name+'-gain', name+'-magnify', 0, 1)
            u.wire(name+'-magnify', name+'-scope')
            u.msg(name+'-initial-gain', '1.'); u.wire('load', name+'-initial-gain'); u.wire(name+'-initial-gain', name+'-gain')
        else:
            u.wire(name+'-signal', name+'-scope')
    u.obj('wave-samples-message', 'prepend samples')
    u.wire('route','wave-samples-message',tags.index('wave_samples'))
    for name in ('voice', 'beat', 'grid'):u.wire('wave-samples-message',name+'-scope')
    u.label('time-old', '-6 s', [24,610,70,15], 9, MUTED)
    u.label('time-mid', '-3 s', [437,610,70,15], 9, MUTED)
    u.label('time-now', 'ACUM', [827,610,50,15], 9, MUTED)
    u.label('beat-source-caption', 'Instrumental din:', [24,633,125,20], 11, MUTED)
    for name,x,w,selected,choices in [
        ('beat-type',154,320,'wave_type','wave_types'),
        ('beat-channel',488,195,'wave_channel','wave_channels')]:
        u.box(name,'umenu',ins=1,outs=3,pres=[x,630,w,26],
              items=['(alege sursa)'], parameter_enable=0, bgcolor=CARD,textcolor=TEXT)
        # Native outlet 0/1 sends selected indices, outlet 2/3 symbol lists.
        # Silent set renders an index without producing another routing command.
        u.obj(name+'-selected-index','i 0',2,1)
        u.wire('route',name+'-selected-index',tags.index(selected))
        u.obj(name+'-select','prepend set')
        u.wire(name+'-selected-index',name+'-select');u.wire(name+'-select',name)
        u.obj(name+'-list','t l clear',1,2);u.wire('route',name+'-list',tags.index(choices))
        u.obj(name+'-iter','iter');u.obj(name+'-append','prepend append')
        u.wire(name+'-list',name,1);u.wire(name+'-list',name+'-iter')
        u.wire(name+'-iter',name+'-append');u.wire(name+'-append',name)
        # Repaint after clear/append even when selected-index feedback arrived
        # before the available-options list.
        u.obj(name+'-reselect','t b')
        u.wire(name+'-list',name+'-reselect')
        u.wire(name+'-reselect',name+'-selected-index')
        u.obj(name+'-command','prepend '+name.replace('-','_'));u.wire(name,name+'-command');u.wire(name+'-command','out')
    u.button('beat-refresh','ACTUALIZEAZA SURSE',[699,630,175,27])
    u.obj('beat-refresh-bang','t b');u.msg('beat-refresh-command','beat_refresh')
    u.wire('beat-refresh','beat-refresh-bang');u.wire('beat-refresh-bang','beat-refresh-command');u.wire('beat-refresh-command','out')
    u.label('wave-hint','Unde brute. Compensarea se aplica numai abaterii. Marirea vizuala x nu schimba sunetul sau detectorul.',[24,657,855,17],9,MUTED)
    u.obj('beat-level-floor','maximum 0.00001',2,1);u.wire('route','beat-level-floor',tags.index('beatlevel'))
    u.obj('beat-level-db','expr 20. * log10($f1)');u.obj('beat-level-format','sprintf Beat: %.1f dB');u.obj('beat-level-set','prepend set')
    u.wire('beat-level-floor','beat-level-db');u.wire('beat-level-db','beat-level-format');u.wire('beat-level-format','beat-level-set');u.wire('beat-level-set','beat-level')


def add_waveform_parent(p):
    """Two separate host buses; the extra bus has no path into the onset engine."""
    b={w['box']['id']:w['box'] for w in p.p['boxes']}
    b['plugin']['text']='plugin~ 1 2'
    b['popup']['numinlets']=4
    p.obj('beat-plugin','plugin~ 3 4',2,2,outlettype=['signal','signal'])
    # Select the signed sample with larger absolute amplitude. Mono/right-only
    # and opposite-polarity stereo signals remain visible without summing them.
    for name,source in [('voice','plugin'),('beat','beat-plugin')]:
        p.obj(name+'-display-abs-l','abs~',1,1,outlettype=['signal'])
        p.obj(name+'-display-abs-r','abs~',1,1,outlettype=['signal'])
        p.obj(name+'-display-choose','>=~',2,1,outlettype=['signal'])
        p.obj(name+'-display-index','+~ 1',2,1,outlettype=['signal'])
        p.obj(name+'-display-select','selector~ 2 1',3,1,outlettype=['signal'])
        p.wire(source,name+'-display-abs-l');p.wire(source,name+'-display-abs-r',1)
        p.wire(name+'-display-abs-l',name+'-display-choose');p.wire(name+'-display-abs-r',name+'-display-choose',0,1)
        p.wire(name+'-display-choose',name+'-display-index');p.wire(name+'-display-index',name+'-display-select')
        p.wire(source,name+'-display-select',0,2);p.wire(source,name+'-display-select',1,1)
        p.wire(name+'-display-select','popup',0,1 if name=='voice' else 2)
    p.obj('beat-peak-max','maximum~',2,1,outlettype=['signal'])
    p.wire('beat-display-abs-l','beat-peak-max');p.wire('beat-display-abs-r','beat-peak-max',0,1)
    p.obj('beat-peak','peakamp~ 600');p.obj('beat-level-ui-tag','prepend beatlevel')
    p.wire('beat-peak-max','beat-peak');p.wire('beat-peak','beat-level-ui-tag');p.wire('beat-level-ui-tag','popup')
    # These UI-only commands are peeled off BEFORE the original core protocol.
    p.obj('wave-control-route','route beat_type beat_channel beat_refresh',1,4)
    p.p['lines']=[w for w in p.p['lines'] if not (w['patchline']['source']==['popup',0] and w['patchline']['destination']==['control-route',0])]
    p.wire('popup','wave-control-route');p.wire('wave-control-route','control-route',3)
    p.obj('beat-router','live.routing @port audio_inputs @index 1',1,5)
    p.obj('beat-type-command','prepend type');p.obj('beat-channel-command','prepend channel')
    p.wire('wave-control-route','beat-type-command');p.wire('wave-control-route','beat-channel-command',1)
    p.wire('beat-type-command','beat-router');p.wire('beat-channel-command','beat-router')
    p.msg('beat-router-port','port audio_inputs');p.msg('beat-router-index','index 1')
    p.obj('beat-router-init','t b b',1,2);p.wire('ready-defer','beat-router-init')
    p.wire('beat-router-init','beat-router-port',1);p.wire('beat-router-init','beat-router-index')
    p.wire('beat-router-port','beat-router');p.wire('beat-router-index','beat-router')
    p.wire('wave-control-route','beat-router-index',2)
    for i,tag in enumerate(['wave_type','wave_channel','wave_types','wave_channels']):
        p.obj(tag+'-ui-tag','prepend '+tag);p.wire('beat-router',tag+'-ui-tag',i);p.wire(tag+'-ui-tag','popup')
    # dspstate~ is used ONLY for a display duration conversion. Its on/off
    # outlet is deliberately unconnected; RC6's DSP heartbeat is authoritative.
    p.obj('wave-samplerate','dspstate~',1,4);p.wire('plugin','wave-samplerate')
    p.obj('wave-rate-query','t b');p.wire('ready-defer','wave-rate-query');p.wire('retry','wave-rate-query')
    p.wire('wave-rate-query','wave-samplerate')
    p.obj('wave-rate-change','change 0.',3,3);p.wire('wave-samplerate','wave-rate-change',1)
    p.obj('wave-duration','* 6.',2,1);p.obj('wave-samples-ui-tag','prepend wave_samples')
    p.wire('wave-rate-change','wave-duration');p.wire('wave-duration','wave-samples-ui-tag');p.wire('wave-samples-ui-tag','popup')
    # Grid pulses come from the same plugphasor~ as RC6, independently of
    # the beat source. A ribbon of actual pulses avoids fixed false beat lines.
    p.obj('wave-grid-div','/ 4.',2,1);p.wire('control-route','wave-grid-div',3)
    p.obj('wave-grid-scale','*~ 1.',2,1,outlettype=['signal']);p.wire('phasor','wave-grid-scale');p.wire('wave-grid-div','wave-grid-scale',0,1)
    p.obj('wave-grid-wrap','%~ 1.',2,1,outlettype=['signal']);p.wire('wave-grid-scale','wave-grid-wrap')
    p.obj('wave-grid-pulse','<~ 0.025',2,1,outlettype=['signal']);p.wire('wave-grid-wrap','wave-grid-pulse')
    p.obj('wave-grid-valid','*~ 0.',2,1,outlettype=['signal']);p.wire('wave-grid-pulse','wave-grid-valid')
    p.wire('sync-render-change','wave-grid-valid',0,1);p.wire('wave-grid-valid','popup',0,3)


def engine():
    g = Patch(900, 600, 'dsp.gen')
    g.p['openinpresentation'] = 0
    g.box('code', 'codebox', ins=3, outs=11, rect=[20, 20, 850, 500],
          code=(ROOT / 'src/vtm_engine.genexpr').read_text())
    for i in range(1, 4):
        g.obj('in' + str(i), 'in ' + str(i), 0, 1)
        g.wire('in' + str(i), 'code', 0, i - 1)
    for i in range(1, 12):
        g.obj('out' + str(i), 'out ' + str(i), 1, 0)
        g.wire('code', 'out' + str(i), i - 1)
    return g.p


def make_patch():
    p = Patch(360, 169)
    p.p.update(devicewidth=360., description='Audio onset grid proximity monitor',
        digest='Vocal Timing Monitor 0.9 RC1.6 Studio - native embedded engine',
        tags='audio timing monitor', latency=0, is_mpe=0,
        minimum_live_version='12.0.0', minimum_max_version='8.6.0',
        dependency_cache=[], parameters={'inherited_shortname': 1})
    p.label('title', 'VOCAL TIMING MONITOR', [16, 11, 330, 26], 17, CYAN, fontface=1)
    p.label('version', '0.7 RC3.3 Persistent | fereastra separata', [16, 40, 330, 18], 11, MUTED)
    p.button('open', 'Deschide monitorul', [16, 69, 328, 34], accent=True)
    p.label('note1', 'Setări în proiect · oprire automată OFF la încărcare', [16, 113, 330, 18], 10, MUTED)
    p.label('note2', 'Pistă pentru analiză · ieșire audio mută', [16, 135, 330, 18], 11, MUTED)
    p.obj('open-bang', 't b'); p.msg('open-message', 'open'); p.obj('pcontrol', 'pcontrol')
    p.obj('popup', 'p VTM_Monitor', 1, 1, patcher=popup())
    p.wire('open', 'open-bang'); p.wire('open-bang', 'open-message'); p.wire('open-message', 'pcontrol'); p.wire('pcontrol', 'popup')
    p.obj('plugin', 'plugin~', 1, 2, outlettype=['signal', 'signal'])
    p.obj('phasor', 'plugphasor~', 0, 1, outlettype=['signal'])
    p.obj('engine', 'gen~', 3, 11, patcher=engine(), outlettype=['signal'] * 11)
    p.wire('plugin', 'engine'); p.wire('plugin', 'engine', 1, 1); p.wire('phasor', 'engine', 0, 2)
    # Raw input probe is independent from the Gen detector and uses block peaks.
    p.obj('input-abs-l', 'abs~', 1, 1, outlettype=['signal'])
    p.obj('input-abs-r', 'abs~', 1, 1, outlettype=['signal'])
    p.obj('input-max', 'maximum~', 2, 1, outlettype=['signal'])
    p.obj('input-peak', 'peakamp~ 600', 1, 1)
    p.wire('plugin', 'input-abs-l'); p.wire('plugin', 'input-abs-r', 1)
    p.wire('input-abs-l', 'input-max'); p.wire('input-abs-r', 'input-max', 0, 1)
    p.wire('input-max', 'input-peak'); p.wire('input-peak', 'level-ui-tag')
    p.obj('silence', 'sig~ 0', 1, 1, outlettype=['signal'])
    p.obj('plugout', 'plugout~', 2, 0)
    p.wire('silence', 'plugout'); p.wire('silence', 'plugout', 0, 1)
    p.obj('control-route', 'route gatedb enabled autostop grid redms offsetms resetseq', 1, 8)
    p.wire('popup', 'control-route')
    p.obj('db-linear', 'expr exp($f1 * 0.11512925464970229)')
    p.obj('gateamp-tag', 'prepend gateamp'); p.wire('control-route', 'db-linear')
    p.wire('db-linear', 'gateamp-tag'); p.wire('gateamp-tag', 'engine')
    for i, tag in enumerate(['enabled', 'autostop', 'grid', 'redms', 'offsetms', 'resetseq'], 1):
        p.obj(tag + '-tag', 'prepend ' + tag); p.wire('control-route', tag + '-tag', i); p.wire(tag + '-tag', 'engine')
    p.wire('control-route', 'engine', 7)

    # All lifetime work is in the parent, never governed by popup open/close.
    p.obj('thisdevice', 'live.thisdevice', 1, 3)
    p.obj('load', 'loadbang', 0, 1)
    p.msg('start-qmetro', '1'); p.obj('qmetro', 'qmetro 20', 2, 1)
    p.wire('load', 'start-qmetro'); p.wire('start-qmetro', 'qmetro')
    p.obj('ready-defer', 'deferlow'); p.wire('thisdevice', 'ready-defer')
    p.obj('ready-trigger', 't b b b', 1, 3); p.wire('ready-defer', 'ready-trigger')
    p.msg('init-ui', 'init'); p.wire('ready-trigger', 'init-ui', 2); p.wire('init-ui', 'popup')
    p.msg('reset-dsp', 'resetseq -1'); p.wire('ready-trigger', 'reset-dsp', 1); p.wire('reset-dsp', 'engine')
    p.msg('path-message', 'path live_set'); p.obj('live-path', 'live.path', 1, 3)
    p.wire('ready-trigger', 'path-message'); p.wire('path-message', 'live-path')
    p.obj('stop-object', 'live.object', 2, 1)
    # Numeric IDs are re-tagged explicitly. Readiness requires readback from
    # the very live.object which will execute Stop, not a path-only assumption.
    p.obj('id-route', 'route id', 1, 2); p.wire('live-path', 'id-route', 1)
    p.obj('path-trigger', 't b i i', 1, 3); p.wire('id-route', 'path-trigger')
    p.obj('bind-id', 'prepend id'); p.wire('path-trigger', 'bind-id', 1)
    p.wire('bind-id', 'stop-object', 0, 1)
    p.obj('ack-valid', 'expr ($i1 > 0) && ($i1 == $i2)', 2, 1)
    p.wire('path-trigger', 'ack-valid', 2, 1)
    p.msg('api-clear', '0'); p.wire('path-trigger', 'api-clear', 2)
    p.obj('api-valid', 'change -1', 3, 3); p.wire('api-clear', 'api-valid')
    p.obj('bind-defer', 'deferlow'); p.msg('bind-getid', 'getid')
    p.wire('path-trigger', 'bind-defer'); p.wire('bind-defer', 'bind-getid')
    p.wire('bind-getid', 'stop-object')
    p.obj('object-response', 'route id is_playing', 1, 3)
    p.wire('stop-object', 'object-response'); p.wire('object-response', 'ack-valid')
    p.wire('ack-valid', 'api-valid')
    p.obj('api-tag', 'prepend apiready'); p.wire('api-valid', 'api-tag'); p.wire('api-tag', 'engine')
    p.obj('api-ui-tag', 'prepend api'); p.wire('api-valid', 'api-ui-tag'); p.wire('api-ui-tag', 'popup')
    # Retry a missing path once per second. No get/call against invalid ids.
    p.obj('retry', 'metro 1000', 2, 1); p.wire('start-qmetro', 'retry')
    p.obj('retry-gate', 'gate 1 0', 2, 1); p.obj('api-not', '== 0', 2, 1)
    p.msg('enable-retry', '1'); p.wire('ready-trigger', 'enable-retry', 2); p.wire('enable-retry', 'retry-gate')
    p.wire('api-valid', 'api-not'); p.wire('api-not', 'retry-gate'); p.wire('retry', 'retry-gate', 0, 1)
    p.wire('retry-gate', 'path-message')

    # Lifecycle flags guard ONLY side effects. Analysis follows plugphasor~.
    p.obj('deviceon-change', 'sel 0', 1, 2)
    p.wire('thisdevice', 'deviceon-change', 1)
    p.msg('disarm-ui', 'disarm'); p.wire('disarm-ui', 'popup')
    p.wire('deviceon-change', 'disarm-ui')
    p.obj('stopped-select', 'sel 0', 1, 2); p.wire('sync-change', 'stopped-select'); p.wire('stopped-select', 'disarm-ui')
    p.obj('api-lost', 'sel 0', 1, 2); p.wire('api-valid', 'api-lost'); p.wire('api-lost', 'disarm-ui')
    p.obj('enabled-off', 'sel 0', 1, 2); p.wire('control-route', 'enabled-off', 1); p.wire('enabled-off', 'disarm-ui')
    # Reset and changes to timing settings also disarm instead of retaining an old intent.
    for i in [3, 4, 5, 6]:
        p.wire('control-route', 'disarm-ui', i)

    # Deferred stop gate rechecks CURRENT controls, including OFF after a request.
    p.obj('safety', 'expr ($i1 > 0) && ($i2 > 0) && ($i3 > 0) && ($i4 > 0) && ($i5 > 0) && ($i6 > 0)', 6, 1)
    # pak makes every input hot; expr is evaluated from one coherent control list.
    p.obj('safety-pak', 'pak 0 1 0 1 0 0', 6, 1)
    p.wire('control-route', 'safety-pak', 2, 0)
    p.wire('control-route', 'safety-pak', 1, 1)
    p.wire('api-valid', 'safety-pak', 0, 2)
    p.wire('thisdevice', 'safety-pak', 1, 3)
    p.obj('safety-unpack', 'unpack 0 0 0 0 0 0', 1, 6)
    p.wire('safety-pak', 'safety-unpack')
    for i in range(6):
        p.wire('safety-unpack', 'safety', i, i)
    # Latch the first failed CURRENT guard for display on each request.
    # Values: 0=allowed, 1=API, 3=bypass, 4=clock,
    # 5=local DSP, 6=analysis OFF, 7=user disarmed.
    p.obj('stop-reason', 'expr ($i3 <= 0) + ($i3 > 0) * (3 * ($i4 <= 0) + ($i4 > 0) * (4 * ($i5 <= 0) + ($i5 > 0) * (5 * ($i6 <= 0) + ($i6 > 0) * (6 * ($i2 <= 0) + ($i2 > 0) * 7 * ($i1 <= 0)))))', 6, 1)
    for i in range(6):
        p.wire('safety-unpack', 'stop-reason', i, i)
    p.obj('stop-reason-store', 'i 1', 2, 1)
    p.wire('stop-reason', 'stop-reason-store', 0, 1)
    p.obj('stopnote-ui-tag', 'prepend stopnote'); p.wire('stopnote-ui-tag', 'popup')
    p.wire('stop-reason-store', 'stopnote-ui-tag')
    p.obj('stop-defer', 'deferlow'); p.obj('stop-gate', 'gate 1 0', 2, 1)
    # Consume each request once, even when the native safety gate rejects it.
    # A rejected request must not remain latched and fire after a later recovery.
    p.obj('stop-finalize', 't b b b', 1, 3)
    p.wire('safety', 'stop-gate'); p.wire('stop-defer', 'stop-finalize')
    p.wire('stop-finalize', 'stop-reason-store', 2)
    p.wire('stop-finalize', 'stop-gate', 1, 1)
    p.wire('stop-finalize', 'disarm-ui')
    p.obj('stop-trigger', 't b b', 1, 2); p.wire('stop-gate', 'stop-trigger')
    p.wire('stop-trigger', 'disarm-ui', 1)
    p.msg('stop-call', 'call stop_playing'); p.wire('stop-trigger', 'stop-call'); p.wire('stop-call', 'stop-object')

    p.msg('stop-sent', '8'); p.wire('stop-call', 'stop-sent'); p.wire('stop-sent', 'stopnote-ui-tag')
    # Read the host's actual is_playing property after one command. No retries
    # of Stop and no claims of success merely because the toggle returned OFF.
    p.obj('stop-check-bang', 't b'); p.wire('stop-call', 'stop-check-bang')
    p.obj('stop-check-delay', 'delay 150', 2, 1); p.wire('stop-check-bang', 'stop-check-delay')
    p.obj('stop-check-gate', 'gate 1 0', 2, 1); p.wire('api-valid', 'stop-check-gate')
    p.wire('stop-check-delay', 'stop-check-gate', 0, 1)
    p.msg('stop-check-get', 'get is_playing'); p.wire('stop-check-gate', 'stop-check-get')
    p.wire('stop-check-get', 'stop-object')
    p.obj('stop-check-select', 'sel 0 1', 1, 3); p.wire('object-response', 'stop-check-select', 1)
    p.msg('stop-confirmed', '9'); p.msg('stop-unconfirmed', '10')
    p.wire('stop-check-select', 'stop-confirmed'); p.wire('stop-check-select', 'stop-unconfirmed', 1)
    p.wire('stop-confirmed', 'stopnote-ui-tag'); p.wire('stop-unconfirmed', 'stopnote-ui-tag')
    p.msg('stop-check-cancel', 'stop'); p.wire('api-lost', 'stop-check-cancel'); p.wire('stop-check-cancel', 'stop-check-delay')

    # If lifecycle/clock loss disarms before a detector request, retain that
    # cause too. Capture it BEFORE disarm closes this gate. Once already OFF,
    # subsequent transport changes cannot overwrite the result of the last Stop.
    p.obj('disarm-reason-gate', 'gate 1 0', 2, 1)
    p.wire('control-route', 'disarm-reason-gate', 2)
    p.wire('disarm-reason-gate', 'stopnote-ui-tag')
    for source, code in [('api-lost', 1),
                         ('deviceon-change', 3), ('stopped-select', 4),
                         ('audio-lost', 5), ('enabled-off', 6)]:
        p.p['lines'] = [wrapped for wrapped in p.p['lines']
                       if not (wrapped['patchline']['source'] == [source, 0]
                               and wrapped['patchline']['destination'] == ['disarm-ui', 0])]
        message = source + '-reason'
        p.msg(message, str(code)); p.wire(source, message)
        p.wire(message, 'disarm-reason-gate', 0, 1)
        p.wire(source, 'disarm-ui')

    p.obj('poll', 't b b', 1, 2); p.wire('qmetro', 'poll')
    p.obj('snapshot-trigger', 't b b b b b b b b b b', 1, 10)
    p.wire('poll', 'snapshot-trigger', 1)
    tags = ['delta', 'count', None, 'state', 'level', 'tests', 'raw', 'sync', 'maxdev', 'hasdelta']
    for i, tag in enumerate(tags):
        sn = 'snapshot-' + str(i)
        p.obj(sn, 'snapshot~', 1, 1); p.wire('engine', sn, i)
        # Trigger fires right-to-left: validity, delta, count, stop, status...
        p.wire('snapshot-trigger', sn, 9 if i == 9 else 8-i)
        if tag:
            prev = sn
            if tag in ['count', 'state', 'tests', 'sync', 'hasdelta']:
                p.obj(tag + '-int', 'i', 2, 1); p.wire(prev, tag + '-int'); prev = tag + '-int'
            if tag not in ['level', 'delta']:
                p.obj(tag + '-change', 'change 0.' if tag in ['raw', 'maxdev'] else 'change -1' if tag == 'state' else 'change', 3, 3); p.wire(prev, tag + '-change'); prev = tag + '-change'
            p.obj(tag + '-ui-tag', 'prepend ' + tag); p.wire(tag + '-ui-tag', 'popup')
            if tag == 'state':
                p.wire(prev, 'state-pak')
            elif tag == 'sync':
                p.wire(prev, 'sync-pak')
            elif tag != 'level':
                p.wire(prev, tag + '-ui-tag')
            if tag == 'sync':
                p.wire(prev, 'safety-pak', 0, 4)
        else:
            p.obj('stop-change', 'change', 3, 3); p.obj('stop-select', 'sel 1', 1, 2)
            p.wire(sn, 'stop-change'); p.wire('stop-change', 'stop-select'); p.wire('stop-select', 'stop-defer')
    # A counter advances ONLY when the device's Gen DSP executes. A stalled
    # counter for 250 ms invalidates activity, even if snapshots hold old values.
    p.obj('heartbeat-snapshot', 'snapshot~', 1, 1)
    p.wire('engine', 'heartbeat-snapshot', 10); p.wire('poll', 'heartbeat-snapshot')
    p.obj('heartbeat-change', 'change 0.', 3, 3); p.wire('heartbeat-snapshot', 'heartbeat-change')
    p.obj('heartbeat-trigger', 't b b b', 1, 3); p.wire('heartbeat-change', 'heartbeat-trigger')
    p.msg('heartbeat-cancel', 'stop'); p.obj('heartbeat-timeout', 'delay 250', 2, 1)
    p.wire('heartbeat-trigger', 'heartbeat-cancel', 2); p.wire('heartbeat-cancel', 'heartbeat-timeout')
    p.wire('heartbeat-trigger', 'heartbeat-timeout', 1)
    p.msg('audio-on', '1'); p.msg('audio-off', '0')
    p.wire('heartbeat-trigger', 'audio-on'); p.wire('heartbeat-timeout', 'audio-off')
    p.obj('audio-alive', 'change -1', 3, 3)
    p.wire('audio-on', 'audio-alive'); p.wire('audio-off', 'audio-alive')
    p.msg('audio-initial', '0'); p.wire('load', 'audio-initial'); p.wire('audio-initial', 'audio-alive')
    p.wire('audio-alive', 'safety-pak', 0, 5)
    p.obj('audio-lost', 'sel 0', 1, 2); p.wire('audio-alive', 'audio-lost')
    p.msg('zero-level', 'level 0.'); p.wire('audio-lost', 'zero-level'); p.wire('zero-level', 'popup')
    for tag in ['state', 'sync']:
        p.obj(tag + '-pak', 'pak 1 0' if tag == 'state' else 'pak 0 0', 2, 1)
        p.obj(tag + '-unpack', 'unpack 0 0', 1, 2)
        expression = 'expr $i1 * ($i2 > 0) + 10 * ($i2 == 0)' if tag == 'state' else 'expr ($i1 > 0) && ($i2 > 0)'
        p.obj(tag + '-render', expression, 2, 1)
        p.obj(tag + '-render-change', 'change -1', 3, 3)
        p.wire('audio-alive', tag + '-pak', 0, 1)
        p.wire(tag + '-pak', tag + '-unpack')
        p.wire(tag + '-unpack', tag + '-render'); p.wire(tag + '-unpack', tag + '-render', 1, 1)
        p.wire(tag + '-render', tag + '-render-change'); p.wire(tag + '-render-change', tag + '-ui-tag')
    p.p['project'] = dict(version=1, amxdtype=1633771873, readonly=0,
        contents={'patchers': {}, 'code': {}}, searchpath={}, detailsvisible=0,
        autoorganize=1, hideprojectwindow=1, showdependencies=1, autolocalize=0)
    add_waveform_parent(p)
    for id, name, initial, *_ in PERSISTENT_CONTROLS:
        p.p['parameters']['popup::'+id] = [name, name, 0]
    for kind in ('type', 'channel'):
        name = 'VTM Instrumental '+kind
        p.p['parameters']['popup::persist-'+kind] = [name, name, 0]
    p.p['parameters']['popup::theme'] = ['VTM Theme', 'VTM Theme', 0]
    for item in p.p['boxes']:
        if item['box']['id']=='version':item['box']['text']='0.9 RC1.6 Studio | teme și setări salvate'
    def explicit_fanout(patcher):
        groups = {}
        for wrapped in patcher['lines']:
            line = wrapped['patchline']
            groups.setdefault(tuple(line['source']), []).append(line)
        if patcher['classnamespace'] == 'box':
            for lines in groups.values():
                if len(lines) > 1:
                    for index, line in enumerate(lines):
                        line['order'] = index
        for wrapped in patcher['boxes']:
            if 'patcher' in wrapped['box']:
                explicit_fanout(wrapped['box']['patcher'])
    apply_readable_type(p.p)
    apply_device_theme(p)
    apply_latency_parent(p, Patch)
    explicit_fanout(p.p)
    return {'patcher': p.p}


def be_chunk(tag, data):
    assert len(tag) == 4
    return tag + struct.pack('>I', len(data) + 8) + data


def amxd_bytes(patch, filename):
    payload = json.dumps(patch, ensure_ascii=False, indent=2).encode('utf-8')
    # Single-entry collective: mx@c header, JSON bytes, directory at aligned end.
    directory_offset = 16 + len(payload)
    pad = b'\0' * (-directory_offset % 4)
    directory_offset += len(pad)
    fn = filename.encode('utf-8') + b'\0'
    fn += b'\0' * (-(len(fn) + 8) % 4)
    entry = b''.join([
        be_chunk(b'type', b'JSON'), be_chunk(b'fnam', fn),
        be_chunk(b'sz32', struct.pack('>I', len(payload))),
        be_chunk(b'of32', struct.pack('>I', 16)),
        be_chunk(b'vers', struct.pack('>I', 0)),
        be_chunk(b'flag', struct.pack('>I', 17)),
        be_chunk(b'mdat', struct.pack('>I', 0xE70CA773))])
    collective = b'mx@c' + struct.pack('>III', 16, 0, directory_offset)
    collective += payload + pad + be_chunk(b'dlst', be_chunk(b'dire', entry))
    return b'ampf' + struct.pack('<I', 4) + b'aaaa' + b'meta' + struct.pack('<II', 4, 7) + b'ptch' + struct.pack('<I', len(collective)) + collective


if __name__ == '__main__':
    patch = make_patch()
    out = ROOT / 'dist'; out.mkdir(exist_ok=True)
    (out / (NAME + '.maxpat')).write_text(json.dumps(patch, ensure_ascii=False, indent=2), encoding='utf-8')
    (out / (NAME + '.amxd')).write_bytes(amxd_bytes(patch, NAME + '.amxd'))
    print(json.dumps({'amxd': str(out / (NAME + '.amxd')), 'bytes': (out / (NAME + '.amxd')).stat().st_size}))
