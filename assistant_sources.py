"""Experimental native source readbacks and session-scoped calibration binding.

Build-time Python only. The AMXD contains native Max objects, not this module.
No musical classification or assistant Stop is implemented here.
"""
from pathlib import Path
import json
import build
from assistant_preflight import make_experimental_patch, STATES, DIAGNOSTIC_OUTPUTS
from studio_ui import PALETTES

ROOT = Path(__file__).resolve().parent
NAME = 'Vocal_Timing_Monitor_Asistent_Ritm_Vocal_Surse_v0_1_2'
FIELDS = (
    ('track_type', 'input_routing_type', 'track', 'Intrarea pistei'),
    ('track_channel', 'input_routing_channel', 'track', 'Canalul pistei'),
    ('main_type', 'routing_type', 'main', 'Intrarea dispozitivului'),
    ('main_channel', 'routing_channel', 'main', 'Canalul dispozitivului'),
    ('reference_type', 'routing_type', 'reference', 'Reper instrumental'),
    ('reference_channel', 'routing_channel', 'reference', 'Punct de preluare'),
)


def diagnostic_popup():
    u = build.Patch(640, 510)
    palette = PALETTES[0]
    u.p.update(title='Vocal Timing Monitor | Asistent de ritm vocal — surse 0.1.2',
               openrect=[80., 70., 640., 510.], bgcolor=palette['bg'])
    u.box('in', 'inlet', ins=0, outs=1, index=1)
    u.obj('out', 'outlet', 1, 0)
    tags = ['state', 'theme', 'profile', 'modeclear'] + [field[0] for field in FIELDS]
    u.obj('route', 'route '+' '.join(tags), 1, len(tags)+1)
    u.wire('in', 'route')
    u.label('heading', 'Surse și sincronizare', [20, 15, 600, 28], 19)
    u.label('subtitle', 'Diagnostic 0.1.2 · verificare experimentală, fără verdict ritmic', [20, 48, 600, 20], 11)
    u.label('state', 'Aștept informațiile din Ableton', [20, 82, 600, 36], 15)
    u.obj('state-select', 'sel '+' '.join(map(str, STATES)), 1, len(STATES)+1)
    u.wire('route', 'state-select', 0)
    for index, (code, label) in enumerate(STATES.items()):
        u.msg('state-'+str(code), 'set '+label)
        u.wire('state-select', 'state-'+str(code), index)
        u.wire('state-'+str(code), 'state')
    u.label('mode-label', 'Ce semnal primește intrarea de analiză?', [20, 130, 600, 20], 12)
    u.box('mode', 'umenu', ins=1, outs=3, pres=[20, 157, 600, 30],
          items=['Neconfirmat', ',', 'Intrare live', ',', 'Voce înregistrată'],
          parameter_enable=0, bgcolor=palette['field'], textcolor=palette['text'])
    u.obj('mode-tag', 'prepend mode')
    u.wire('mode', 'mode-tag'); u.wire('mode-tag', 'out')
    u.msg('clear-mode', 'set 0'); u.wire('route', 'clear-mode', tags.index('modeclear'))
    u.wire('clear-mode', 'mode')
    for index, (key, _, _, label) in enumerate(FIELDS):
        y = 210 + index*30
        u.label(key+'-caption', label, [20, y, 210, 22], 11)
        u.label(key, 'Aștept date', [232, y, 388, 24], 11)
        u.obj(key+'-set', 'prepend set')
        u.wire('route', key+'-set', tags.index(key)); u.wire(key+'-set', key)
    u.label('profile', 'Compensare: neconfirmată pentru acest traseu', [20, 398, 600, 26], 11)
    u.obj('profile-select', 'sel 0 1', 1, 3)
    u.wire('route', 'profile-select', tags.index('profile'))
    for index, text in enumerate(['Compensare: necesită calibrare pe traseul actual',
                                   'Compensare: legată de traseul actual în această sesiune']):
        u.msg('profile-'+str(index), 'set '+text)
        u.wire('profile-select', 'profile-'+str(index), index)
        u.wire('profile-'+str(index), 'profile')
    for id, text, rect, tag in [
        ('refresh', 'Recitește sursele', [20, 438, 280, 32], 'refresh'),
        ('export', 'Salvează raportul', [312, 438, 308, 32], 'export')]:
        u.button(id, text, rect)
        u.obj(id+'-bang', 't b'); u.msg(id+'-tag', tag)
        u.wire(id, id+'-bang'); u.wire(id+'-bang', id+'-tag'); u.wire(id+'-tag', 'out')
    u.label('footer', 'Raport local cu rutări și stări · fără înregistrări audio', [20, 480, 600, 18], 10)
    u.obj('window', 'thispatcher', 1, 2)
    u.obj('load', 'loadbang', 0, 1)
    u.msg('window-config', 'window flags float nogrow nozoom, window size 80 70 720 580, window exec')
    u.wire('load', 'window-config'); u.wire('window-config', 'window')
    u.obj('theme-select', 'sel 0 1', 1, 3); u.wire('route', 'theme-select', 1)
    for wrapped in u.p['boxes']:
        box = wrapped['box']
        if box.get('presentation'):
            box['varname'] = 'asrc_ui_'+box['id']
            if box['maxclass'] == 'comment': box['textcolor'] = palette['text']
    for theme, colors in enumerate(PALETTES):
        commands = ['bgcolor '+' '.join(map(str, colors['bg']))]
        for wrapped in u.p['boxes']:
            box = wrapped['box']
            if box.get('presentation'):
                attributes = [('textcolor', 'text')]
                if box['maxclass'] in ('umenu', 'textbutton'):
                    attributes += [('bgcolor', 'field')]
                for attribute, role in attributes:
                    commands.append('script send '+box['varname']+' '+attribute+' '+' '.join(map(str, colors[role])))
        u.msg('palette-'+str(theme), ', '.join(commands))
        u.wire('theme-select', 'palette-'+str(theme), theme)
        u.wire('palette-'+str(theme), 'window')
    return u.p


def attach_sources(p):
    p.obj('asrc-popup', 'p VTM_Assistant_Sources', 1, 1, patcher=diagnostic_popup())
    p.button('asrc-open', 'Surse · Asistent de ritm vocal', [16, 135, 328, 26])
    p.obj('asrc-open-bang', 't b'); p.msg('asrc-open-msg', 'open'); p.obj('asrc-pcontrol', 'pcontrol')
    p.wire('asrc-open', 'asrc-open-bang'); p.wire('asrc-open-bang', 'asrc-open-msg')
    p.wire('asrc-open-msg', 'asrc-pcontrol'); p.wire('asrc-pcontrol', 'asrc-popup')
    b = {w['box']['id']: w['box'] for w in p.p['boxes']}
    # Fit the existing 360x169 device body; the original full monitor keeps all
    # its controls. Replace only a static root caption with the Sources action.
    b['note2'].pop('presentation', None)
    b['note2'].pop('presentation_rect', None)
    b['version']['text'] = 'Asistent de ritm vocal · diagnostic surse 0.1.2'
    p.obj('asrc-theme', 'prepend theme'); p.wire('popup', 'asrc-theme', 1); p.wire('asrc-theme', 'asrc-popup')
    b['asrc-open'] = next(w['box'] for w in p.p['boxes'] if w['box']['id']=='asrc-open')
    b['asrc-open']['varname'] = 'vtm_assistant_sources_open'
    p.obj('asrc-root-theme', 'sel 0 1', 1, 3)
    p.obj('asrc-root-window', 'thispatcher', 1, 2)
    p.wire('popup', 'asrc-root-theme', 1)
    for theme, colors in enumerate(PALETTES):
        attributes = [('bgcolor', 'field'), ('textcolor', 'text'),
                      ('textoncolor', 'text'), ('bgoncolor', 'field')]
        commands = ['script send vtm_assistant_sources_open '+attribute+' '+' '.join(map(str, colors[role]))
                    for attribute, role in attributes]
        p.msg('asrc-root-palette-'+str(theme), ', '.join(commands))
        p.wire('asrc-root-theme', 'asrc-root-palette-'+str(theme), theme)
        p.wire('asrc-root-palette-'+str(theme), 'asrc-root-window')
    p.obj('asrc-state', 'prepend state'); p.wire('apf-state', 'asrc-state'); p.wire('asrc-state', 'asrc-popup')
    p.obj('asrc-ui-route', 'route mode refresh export', 1, 4); p.wire('asrc-popup', 'asrc-ui-route')
    p.obj('asrc-report', 'dict #0_vtm_source_report @embed 0', 2, 4)
    p.msg('asrc-export', 'export'); p.wire('asrc-ui-route', 'asrc-export', 2); p.wire('asrc-export', 'asrc-report')
    p.msg('asrc-report-format', 'replace format vtm-assistant-sources-0.1.2')
    p.wire('ready-defer', 'asrc-report-format'); p.wire('asrc-report-format', 'asrc-report')

    def report(id, key, source, outlet=0):
        p.obj(id, 'prepend replace '+key); p.wire(source, id, outlet); p.wire(id, 'asrc-report')

    def engine(id, param, source, outlet=0):
        p.obj(id, 'prepend '+param); p.wire(source, id, outlet); p.wire(id, 'apf-engine')

    p.obj('asrc-refresh', 't b b', 1, 2)
    p.wire('ready-defer', 'asrc-refresh'); p.wire('asrc-ui-route', 'asrc-refresh', 1)
    p.obj('asrc-api-refresh-defer', 'deferlow')
    p.obj('asrc-api-refresh-gate', 'gate 1 0', 2, 1)
    p.wire('lat-api-bound', 'asrc-api-refresh-defer')
    p.wire('api-valid', 'asrc-api-refresh-gate')
    p.wire('asrc-api-refresh-defer', 'asrc-api-refresh-gate', 0, 1)
    p.wire('asrc-api-refresh-gate', 'asrc-refresh')
    # Reset facts BEFORE issuing asynchronous paths/queries. No old dictionary
    # value can stand in for a missing response after rebinding.
    p.msg('asrc-unknown', '__unknown__')
    p.msg('asrc-invalid', '0')
    p.wire('asrc-refresh', 'asrc-unknown', 1)
    p.wire('asrc-refresh', 'asrc-invalid', 1)
    p.wire('api-clear', 'asrc-unknown'); p.wire('api-clear', 'asrc-invalid')
    p.msg('asrc-clear-mode', 'modeclear'); p.wire('asrc-invalid', 'asrc-clear-mode'); p.wire('asrc-clear-mode', 'asrc-popup')
    p.wire('asrc-invalid', 'asrc-mode')
    p.obj('asrc-mode', 'i 0', 2, 1); p.wire('asrc-ui-route', 'asrc-mode')
    engine('asrc-mode-tag', 'sourcemode', 'asrc-mode')
    report('asrc-report-mode', 'declared_source_mode', 'asrc-mode')
    # Full list, not delimiter-joined text: identifiers can contain spaces.
    p.obj('asrc-fingerprint', 'pak __unknown__ __unknown__ __unknown__ __unknown__ __unknown__ __unknown__ 0. 0 0 0', 10, 1)
    p.obj('asrc-fingerprint-change', 'zl change', 2, 2)
    p.wire('asrc-fingerprint', 'asrc-fingerprint-change')
    p.obj('asrc-identity', 'pak __unknown__ __unknown__ __unknown__ __unknown__ __unknown__ __unknown__ 0. 0 0', 9, 1)
    p.obj('asrc-identity-change', 'zl change', 2, 2)
    p.wire('asrc-identity', 'asrc-identity-change')
    p.msg('asrc-mode-zero', '0')
    p.wire('asrc-identity-change', 'asrc-mode-zero')
    p.wire('asrc-mode-zero', 'asrc-mode')
    p.wire('asrc-mode-zero', 'asrc-clear-mode')
    p.obj('asrc-current', 'zl reg', 2, 2)
    p.wire('asrc-fingerprint-change', 'asrc-current', 0, 1)
    p.wire('asrc-mode', 'asrc-fingerprint', 0, 9)
    report('asrc-report-fingerprint', 'observed_path', 'asrc-fingerprint-change')
    p.obj('asrc-all-fields', 'pak 0 0 0 0 0 0', 6, 1)
    p.obj('asrc-fields-unpack', 'unpack 0 0 0 0 0 0', 1, 6)
    p.obj('asrc-fields-ready', 'expr ($i1 > 0) && ($i2 > 0) && ($i3 > 0) && ($i4 > 0) && ($i5 > 0) && ($i6 > 0)', 6, 1)
    p.wire('asrc-all-fields', 'asrc-fields-unpack')
    for i in range(6): p.wire('asrc-fields-unpack', 'asrc-fields-ready', i, i)
    p.obj('asrc-context', 'pak 0 0 0', 3, 1)
    p.obj('asrc-context-unpack', 'unpack 0 0 0', 1, 3)
    p.obj('asrc-ready', 'expr ($i1 > 0) && ($i2 > 0) && (($i3 == 1) || ($i3 == 2))', 3, 1)
    p.wire('asrc-fields-ready', 'asrc-context')
    p.wire('asrc-mode', 'asrc-context', 0, 2)
    p.wire('asrc-context', 'asrc-context-unpack')
    for i in range(3): p.wire('asrc-context-unpack', 'asrc-ready', i, i)
    engine('asrc-voice-binding', 'voicebinding', 'asrc-ready')
    engine('asrc-ref-binding', 'referencebinding', 'asrc-ready')
    report('asrc-report-readbacks', 'path_readbacks_complete', 'asrc-fields-ready')
    report('asrc-report-ready', 'declared_path_ready', 'asrc-ready')
    # A fact about routing is not a voice/noise classifier: quality stays 0.

    for bus, path, props in [
        ('track', 'this_device canonical_parent', ['input_routing_type', 'input_routing_channel']),
        ('main', 'this_device audio_inputs 0', ['routing_type', 'routing_channel']),
        ('reference', 'this_device audio_inputs 1', ['routing_type', 'routing_channel']),
    ]:
        prefix = 'asrc-'+bus
        p.msg(prefix+'-path-msg', 'path '+path); p.obj(prefix+'-path', 'live.path', 1, 3)
        p.wire('asrc-refresh', prefix+'-path-msg'); p.wire(prefix+'-path-msg', prefix+'-path')
        p.obj(prefix+'-bind-defer', 'deferlow'); p.wire(prefix+'-path', prefix+'-bind-defer', 1)
        p.obj(prefix+'-bind', 't b l', 1, 2); p.wire(prefix+'-bind-defer', prefix+'-bind')
        p.obj(prefix+'-object', 'live.object', 2, 1)
        p.wire(prefix+'-bind', prefix+'-object', 1, 1)
        p.obj(prefix+'-id-store', 'zl reg', 2, 2)
        p.wire(prefix+'-bind', prefix+'-id-store', 1, 1)
        p.obj(prefix+'-query-defer', 'deferlow'); p.wire(prefix+'-bind', prefix+'-query-defer')
        p.msg(prefix+'-gettype', 'gettype'); p.wire(prefix+'-query-defer', prefix+'-gettype')
        p.wire(prefix+'-gettype', prefix+'-object')
        p.obj(prefix+'-type-route', 'route type', 1, 2); p.wire(prefix+'-object', prefix+'-type-route')
        report(prefix+'-class-report', bus+'_object_class', prefix+'-type-route')
        p.obj(prefix+'-class', 'sel '+('Track' if bus=='track' else 'DeviceIO'), 1, 2)
        p.wire(prefix+'-type-route', prefix+'-class')
        # Rack/Chain parents remain unresolved; never query Track-only fields.
        p.obj(prefix+'-confirmed', 't b b', 1, 2); p.wire(prefix+'-class', prefix+'-confirmed')
        p.wire(prefix+'-confirmed', prefix+'-id-store', 1)
        p.obj(prefix+'-query', 't b b', 1, 2); p.wire(prefix+'-confirmed', prefix+'-query')
        for index, prop in enumerate(props):
            p.obj(prefix+'-observer-'+str(index), 'live.observer '+prop, 2, 2)
            p.wire(prefix+'-id-store', prefix+'-observer-'+str(index), 0, 1)
            p.msg(prefix+'-unbind-'+str(index), 'id 0')
            p.wire('asrc-invalid', prefix+'-unbind-'+str(index))
            p.wire(prefix+'-unbind-'+str(index), prefix+'-observer-'+str(index), 0, 1)
            p.msg(prefix+'-property-'+str(index), 'property '+prop)
            p.wire(prefix+'-query', prefix+'-property-'+str(index), index)
            p.wire(prefix+'-property-'+str(index), prefix+'-observer-'+str(index))
            # Constructor is deliberately property-less until gettype confirms
            # the class. Bind ID first, then select only a supported property.
            next(w['box'] for w in p.p['boxes'] if w['box']['id']==prefix+'-observer-'+str(index))['text']='live.observer'
            key = next(field[0] for field in FIELDS if field[1]==prop and field[2]==bus)
            field_index = [field[0] for field in FIELDS].index(key)
            stem = 'asrc-field-'+key
            p.obj(stem+'-raw', 't l b', 1, 2)
            p.wire(prefix+'-observer-'+str(index), stem+'-raw')
            p.msg(stem+'-zero', '0'); p.wire(stem+'-raw', stem+'-zero', 1)
            p.wire(stem+'-zero', 'asrc-all-fields', 0, field_index)
            p.wire('asrc-invalid', 'asrc-all-fields', 0, field_index)
            report(stem+'-report', 'raw_'+key, stem+'-raw')
            p.wire('asrc-unknown', stem+'-report')
            p.obj(stem+'-route', 'route dictionary', 1, 2); p.wire(stem+'-raw', stem+'-route')
            p.obj(stem+'-dictionary', 'prepend dictionary'); p.wire(stem+'-route', stem+'-dictionary')
            p.obj(stem+'-deserialize', 'dict.deserialize', 1, 1); p.wire(stem+'-route', stem+'-deserialize', 1)
            p.obj(stem+'-unpack', 'dict.unpack identifier: display_name: @unmatched 0', 1, 2)
            p.wire(stem+'-dictionary', stem+'-unpack'); p.wire(stem+'-deserialize', stem+'-unpack')
            # Native Live responses include a property wrapper, e.g.
            # {routing_type: {identifier: ..., display_name: ...}}. Extract
            # that subdictionary first. Keep flat JSON/dictionaries supported
            # as well; unsupported/missing keys produce no verified facts.
            p.obj(stem+'-property-unpack', 'dict.unpack '+prop+': @unmatched 0', 1, 1)
            p.wire(stem+'-dictionary', stem+'-property-unpack')
            p.wire(stem+'-deserialize', stem+'-property-unpack')
            p.wire(stem+'-property-unpack', stem+'-unpack')
            p.obj(stem+'-identifier', 'tosymbol'); p.wire(stem+'-unpack', stem+'-identifier')
            p.wire(stem+'-identifier', 'asrc-fingerprint', 0, field_index)
            p.wire('asrc-unknown', 'asrc-fingerprint', 0, field_index)
            p.wire(stem+'-identifier', 'asrc-identity', 0, field_index)
            p.wire('asrc-unknown', 'asrc-identity', 0, field_index)
            p.obj(stem+'-reject', 'sel __unknown__ none None', 1, 4)
            p.wire(stem+'-identifier', stem+'-reject')
            p.msg(stem+'-one', '1'); p.wire(stem+'-reject', stem+'-one', 3)
            p.wire(stem+'-one', 'asrc-all-fields', 0, field_index)
            p.obj(stem+'-ui', 'prepend '+key); p.wire(stem+'-unpack', stem+'-ui', 1)
            p.wire(stem+'-ui', 'asrc-popup'); p.wire('asrc-unknown', stem+'-ui')
            report(stem+'-id-report', key+'_identifier', stem+'-identifier')
            p.wire('asrc-unknown', stem+'-id-report')

    p.obj('asrc-audio-config', 'pak 0. 0 0', 3, 1)
    p.obj('asrc-audio-unpack', 'unpack 0. 0 0', 1, 3)
    p.obj('asrc-audio-ready', 'expr ($f1 > 0) && ($i2 > 0) && ($i3 > 0)', 3, 1)
    p.wire('asrc-audio-config', 'asrc-audio-unpack')
    for i in range(3):
        p.wire('wave-samplerate', 'asrc-audio-config', i+1, i)
        p.wire('wave-samplerate', 'asrc-fingerprint', i+1, i+6)
        p.wire('wave-samplerate', 'asrc-identity', i+1, i+6)
        p.wire('asrc-audio-unpack', 'asrc-audio-ready', i, i)
    p.wire('asrc-audio-ready', 'asrc-context', 0, 1)
    report('asrc-report-audio', 'audio_config_sr_signal_io', 'asrc-audio-config')
    report('asrc-report-state', 'preflight_state_code', 'apf-state')
    report('asrc-report-eligibility', 'evaluation_preconditions', 'apf-eligible')
    for name in ('sampleclock', 'synced', 'periodms', 'detectpermit',
                 'inputpresent', 'referencepresent', 'clipping', 'appliedoffsetms', 'epoch') + DIAGNOSTIC_OUTPUTS:
        report('asrc-report-clock-'+name, 'preflight_'+name, 'apf-'+name)
    for name, source in (('playing', 'lat-observe-3'),
                         ('countingin', 'apf-count-observer'),
                         ('recording', 'lat-observe-0'),
                         ('sessionrecord', 'lat-observe-1'),
                         ('sessionstatus', 'lat-observe-2')):
        report('asrc-report-host-'+name, 'host_'+name, source)

    # Session-only profile: accessible routing + rate/vector facts, not an
    # assertion about every external driver or hardware preference.
    p.obj('asrc-generation', 'counter 1 1000000000', 5, 4)
    p.obj('asrc-path-transition', 't b b', 1, 2)
    p.wire('asrc-fingerprint-change', 'asrc-path-transition')
    # Also cancel an in-flight legacy calibration. The pre-existing estimator
    # must not write a result measured across two different source contexts.
    p.msg('asrc-cancel-scope', '14')
    p.wire('asrc-path-transition', 'asrc-cancel-scope', 1)
    p.wire('asrc-cancel-scope', 'lat-cancel-bang')
    p.wire('asrc-path-transition', 'asrc-generation')
    p.wire('asrc-path-transition', 'apf-audio-revision')
    p.obj('asrc-profile-armed', 'i 0', 2, 1)
    p.msg('asrc-profile-off', '0')
    p.wire('asrc-path-transition', 'asrc-profile-off', 1)
    for source in ('asrc-invalid', 'audio-lost', 'api-clear'):
        p.wire(source, 'asrc-profile-off')
    p.obj('asrc-dsp-change', 'change -1', 3, 3)
    p.obj('asrc-dsp-off', 'sel 0', 1, 2)
    p.wire('wave-samplerate', 'asrc-dsp-change')
    p.wire('asrc-dsp-change', 'asrc-dsp-off'); p.wire('asrc-dsp-off', 'asrc-profile-off')
    p.obj('asrc-offset-change', 'change -999999.', 3, 3)
    p.wire('control-route', 'asrc-offset-change', 5)
    p.wire('asrc-offset-change', 'asrc-profile-off')
    p.wire('asrc-profile-off', 'asrc-profile-armed')
    p.obj('asrc-generation-store', 'i 0', 2, 1); p.wire('asrc-generation', 'asrc-generation-store', 0, 1)
    p.obj('asrc-request-generation', 'i -1', 2, 1)
    p.obj('asrc-request-check', 'expr $i1 == $i2', 2, 1)
    p.obj('asrc-request-capture', 't b b', 1, 2); p.wire('lat-request-counter', 'asrc-request-capture')
    p.msg('asrc-request-invalid', '-1')
    p.wire('asrc-request-capture', 'asrc-request-invalid', 1)
    p.wire('asrc-request-invalid', 'asrc-request-generation', 0, 1)
    p.obj('asrc-capture-gate', 'gate 1 0', 2, 1); p.wire('asrc-ready', 'asrc-capture-gate')
    p.wire('asrc-request-capture', 'asrc-capture-gate', 0, 1)
    p.obj('asrc-generation-read', 'i 0', 2, 1); p.wire('asrc-generation', 'asrc-generation-read', 0, 1)
    p.wire('asrc-capture-gate', 'asrc-generation-read')
    p.wire('asrc-generation-read', 'asrc-request-generation', 0, 1)
    p.wire('asrc-request-generation', 'asrc-request-check', 0, 1)
    p.obj('asrc-commit', 't b b b', 1, 3); p.wire('lat-commit-applied', 'asrc-commit')
    p.wire('asrc-commit', 'asrc-request-generation', 2)
    p.wire('asrc-commit', 'asrc-generation-store', 1)
    p.wire('asrc-generation-store', 'asrc-request-check')
    p.obj('asrc-profile-context', 'pak 0 0 0', 3, 1)
    p.wire('asrc-request-check', 'asrc-profile-context')
    p.wire('asrc-ready', 'asrc-profile-context', 0, 1)
    p.wire('asrc-mode', 'asrc-profile-context', 0, 2)
    p.obj('asrc-profile-unpack', 'unpack 0 0 0', 1, 3)
    p.obj('asrc-profile-permit', 'expr ($i1 == 1) && ($i2 == 1) && ($i3 == 1)', 3, 1)
    p.wire('asrc-profile-context', 'asrc-profile-unpack')
    for i in range(3): p.wire('asrc-profile-unpack', 'asrc-profile-permit', i, i)
    p.obj('asrc-commit-permit', 'i 0', 2, 1)
    p.wire('asrc-profile-permit', 'asrc-commit-permit', 0, 1)
    p.wire('asrc-commit', 'asrc-commit-permit')
    p.obj('asrc-apply-profile', 'sel 1', 1, 2); p.wire('asrc-commit-permit', 'asrc-apply-profile')
    p.msg('asrc-profile-on', '1'); p.wire('asrc-apply-profile', 'asrc-profile-on')
    p.wire('asrc-profile-on', 'asrc-profile-armed')
    engine('asrc-profile-valid', 'calibrationvalid', 'asrc-profile-armed')
    p.obj('asrc-profile-ui', 'prepend profile'); p.wire('asrc-profile-armed', 'asrc-profile-ui'); p.wire('asrc-profile-ui', 'asrc-popup')
    report('asrc-report-profile', 'session_profile_valid', 'asrc-profile-armed')
    # Policy 1 is explicit for the declared live path. Recorded-source alignment
    # stays unknown; do not subtract a microphone offset from a clip by default.
    p.obj('asrc-policy', '== 1', 2, 1); p.wire('asrc-mode', 'asrc-policy')
    engine('asrc-policy-tag', 'timingpolicy', 'asrc-policy')
    p.obj('asrc-current-revision', 'i 0', 2, 1)
    p.wire('apf-audio-revision', 'asrc-current-revision', 0, 1)
    p.wire('asrc-profile-on', 'asrc-revision-bang')
    p.obj('asrc-revision-bang', 't b'); p.wire('asrc-revision-bang', 'asrc-current-revision')
    engine('asrc-calibrated-revision', 'calibratedrevision', 'asrc-current-revision')


def make_source_patch():
    p = build.Patch()
    p.p = make_experimental_patch()['patcher']
    attach_sources(p)
    # Original popup, controls and audio-output graph stay in place.
    def order(patch):
        groups = {}
        for wrapped in patch['lines']:
            line = wrapped['patchline']
            groups.setdefault(tuple(line['source']), []).append(line)
        if patch['classnamespace'] == 'box':
            for lines in groups.values():
                if len(lines)>1:
                    for index, line in enumerate(lines): line['order'] = index
        for wrapped in patch['boxes']:
            if 'patcher' in wrapped['box']: order(wrapped['box']['patcher'])
    order(p.p)
    return {'patcher': p.p}


def write_diagnostic():
    patch = make_source_patch()
    output = ROOT/'dist'
    output.mkdir(exist_ok=True)
    (output/(NAME+'.maxpat')).write_text(json.dumps(patch, ensure_ascii=False, indent=2))
    destination = output/(NAME+'.amxd')
    destination.write_bytes(build.amxd_bytes(patch, NAME+'.amxd'))
    return destination


if __name__ == '__main__':
    print(write_diagnostic())
