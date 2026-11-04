"""Native Max presentation/appearance layer. No runtime scripts or DSP changes."""
import math

WIDTH, COMPACT_HEIGHT, SETTINGS_HEIGHT = 640, 370, 760
UI_FONT = 'Segoe UI'


def apply_readable_type(patcher):
    """System font and legible point sizes; global HiDPI is a Max preference."""
    sizes = dict(title=20, version=11, **{
        'state-text':21, 'clock-text':12, 'sign-caption':11,
        'enabled':12, 'autostop':12, 'reset':11, 'settings':12,
        'count-caption':10, 'voice-caption':12, 'beat-caption':12,
        'time-old':10, 'time-mid':10, 'time-now':10,
        'settings-heading':16, 'grid-ui':14, 'redms':14, 'gatedb':14,
        'mic-heading':14, 'beat-source-caption':13, 'beat-type':12,
        'beat-channel':12, 'meter-low':10, 'meter-high':10,
        'calibration-heading':14, 'offsetms':14, 'calibrate':12,
        'zoom-heading':13, 'voice-gain-caption':12, 'beat-gain-caption':12,
        'voice-gain':14, 'beat-gain':14, 'tests-text':10, 'limit-text':10})
    for wrapper in patcher['boxes']:
        obj=wrapper['box']
        if obj.get('presentation') and obj['maxclass'] in ('comment','textbutton','number','flonum','umenu','live.numbox'):
            size=sizes.get(obj['id'],max(11,math.ceil(obj.get('fontsize',12))))
            obj.update(fontname=UI_FONT,fontsize=float(size))
            if obj['maxclass']=='comment':
                # Native comments need room for ascenders/descenders and inset.
                rect=obj['presentation_rect']
                lines=obj.get('text','').count('\n')+1
                rect[3]=max(rect[3],math.ceil(size*1.2*lines+3))
        if 'patcher' in obj:apply_readable_type(obj['patcher'])


def rgba(s):
    return [int(s[i:i+2], 16)/255 for i in (0, 2, 4)] + [1.]


PALETTES = [
    {k: rgba(v) for k, v in dict(
        bg='111722', card='1B2432', field='111B28', border='344458',
        text='F1F5FB', muted='ADBACE', voice='68D7ED', beat='64D8AB',
        amber='FFCC78', red='FF8A9B', hover='2D3E53',
        selected='214957', selected_text='D9F8FF', stop_bg='514022', stop_text='FFDB9D'
    ).items()},
    {k: rgba(v) for k, v in dict(
        bg='EFF3F8', card='FFFFFF', field='E7EEF5', border='CEDAE6',
        text='172838', muted='526477', voice='006D83', beat='087252',
        amber='875000', red='B63149', hover='D9E5F0',
        selected='CDEAF2', selected_text='003C4D', stop_bg='FBE5BD', stop_text='754100'
    ).items()},
]

# Color is additional information; the labels distinguish all timing states.
STATES = [
    ('Analiză oprită', 'II', 'muted'),
    ('Pornește redarea', '>', 'muted'),
    ('Se sincronizează', '~', 'amber'),
    ('Pregătit să te asculte', '•', 'voice'),
    ('Aproape de grilă', 'OK', 'beat'),
    ('Decalaj moderat', '~', 'amber'),
    ('Peste toleranță', '!', 'red'),
    ('Test de afișare', 'OK', 'voice'),
    ('Pornește redarea', '>', 'amber'),
    ('Se oprește redarea', '!', 'red'),
    ('Verifică motorul audio', '!', 'amber'),
]


def apply_studio_ui(u, parameter_attributes):
    """Reuse all existing action/value objects; change presentation and UI paths."""
    def boxes(): return {w['box']['id']: w['box'] for w in u.p['boxes']}
    b = boxes()
    # Re-layout the same controls; their IDs/varnames/value metadata stay stable.
    for obj in b.values():
        obj.pop('presentation', None)
        obj.pop('presentation_rect', None)
    u.p.update(title='Vocal Timing Monitor | 0.9 RC1.6 Studio',
               rect=[60., 50., WIDTH, COMPACT_HEIGHT],
               openrect=[60., 50., WIDTH, COMPACT_HEIGHT], bgcolor=PALETTES[0]['bg'])
    b['window-config']['text'] = ('window flags float nogrow nozoom, '
        f'window size 60 50 {60 + WIDTH} {50 + COMPACT_HEIGHT}, window exec')
    b['settings-height']['text'] = f'expr {COMPACT_HEIGHT} + {SETTINGS_HEIGHT - COMPACT_HEIGHT} * $i1'
    b['window-right']['text'] = '+ 640'
    b['window-bottom']['text'] = f'+ {COMPACT_HEIGHT}'
    basic, advanced = [], []

    def place(id, rect, size=None, text=None, page=None):
        obj = b[id]
        obj.update(presentation=1, presentation_rect=list(map(float, rect)))
        if size is not None: obj['fontsize'] = float(size)
        if text is not None: obj['text'] = text
        obj.setdefault('varname', 'vtm_ui_'+id.replace('-', '_'))
        if page:
            (basic if page == 'basic' else advanced).append(id)
            obj['hidden'] = int(page == 'advanced')
        return obj

    def label(id, text, rect, size=11, page=None, bold=False):
        u.label(id, text, rect, size, PALETTES[0]['muted'], fontface=int(bold))
        b[id] = u.p['boxes'][-1]['box']
        return place(id, rect, page=page)

    def card(id, rect, page=None):
        u.panel(id, rect); b[id] = u.p['boxes'][-1]['box']
        return place(id, rect, page=page)

    def button(id, text, rect, on=None):
        u.button(id, text, rect, on)
        b[id] = u.p['boxes'][-1]['box']
        return place(id, rect)

    canvas = card('studio-canvas', [0, 0, WIDTH, SETTINGS_HEIGHT])
    canvas['rounded'] = 0
    # The full-window canvas must be below the other background panels.
    u.p['boxes'].remove(next(w for w in u.p['boxes'] if w['box']['id']=='studio-canvas'))
    u.p['boxes'].insert(0, {'box': canvas})
    place('title', [16, 10, 350, 27], 18, 'Vocal Timing Monitor')
    place('version', [17, 37, 320, 14], 10, '0.9 RC1.6  ·  reper ritmic în timp real')
    button('theme', 'Temă: întunecată', [386, 12, 144, 30], 'Temă: luminoasă')
    b['theme'].update(parameter_enable=1, parameter_mappable=0, varname='vtm_theme',
                      saved_attribute_attributes=parameter_attributes('VTM Theme', 0, 1, 0, 1, 12),
                      hint='Schimbă tema. Alegerea se salvează cu proiectul Live (Ctrl+S).')
    place('settings', [540, 12, 84, 30], 11, 'Setări')
    b['settings']['texton'] = 'Închide'

    place('state-card', [16, 60, 608, 80])
    label('status-mark', '>', [29, 77, 28, 23], 14, bold=True)
    place('state-text', [65, 72, 343, 29], 20, 'Pornește redarea')
    place('clock-text', [32, 109, 365, 18], 11, 'Pornește redarea în Ableton')
    place('delta-text', [420, 65, 188, 43], 28)
    b['delta-text']['textjustification'] = 2
    place('sign-caption', [404, 113, 204, 17], 10, 'Față de grila din Ableton')
    b['sign-caption']['textjustification'] = 2
    place('enabled', [16, 150, 140, 30], 11, 'Analiză oprită')
    b['enabled']['texton'] = 'Analiză activă'
    place('autostop', [166, 150, 166, 30], 11, 'Oprire auto: OFF')
    b['autostop']['texton'] = 'Oprire auto: ON'
    b['autostop']['hint'] = ('După sincronizare, activează pentru încercarea dorită. '
        'La prima abatere peste toleranță, oprește redarea și înregistrarea; clipul rămâne. '
        'Revine OFF după oprire și la încărcare.')
    place('reset', [342, 150, 166, 30], 10.5, 'Resetează măsurătorile')
    b['reset']['texton'] = b['reset']['text']
    b['reset']['hint'] = 'Resetează contorul și rezultatul. Setările rămân; oprirea automată este dezarmată.'
    place('count-caption', [524, 146, 100, 15], 10, 'ATACURI')
    b['count-caption']['textjustification'] = 2
    place('count-text', [524, 161, 100, 24], 16)
    b['count-text']['textjustification'] = 2
    card('voice-card', [16, 190, 608, 80])
    place('voice-caption', [28, 195, 250, 16], 11, 'Microfon')
    place('level-text', [388, 195, 224, 16], 10)
    b['level-text']['textjustification'] = 2
    place('voice-scope', [28, 216, 584, 38])
    place('grid-scope', [28, 258, 584, 8])
    card('beat-card', [16, 278, 608, 64])
    place('beat-caption', [28, 282, 250, 16], 11, 'Instrumental')
    place('beat-level', [388, 282, 224, 16], 10)
    b['beat-level']['textjustification'] = 2
    place('beat-scope', [28, 303, 584, 34])
    place('time-old', [16, 343, 80, 15], 10, 'Acum 6 s')
    place('time-mid', [292, 343, 80, 15], 10, 'Acum 3 s')
    place('time-now', [578, 343, 46, 15], 10, 'Acum')

    label('settings-heading', 'Setări uzuale', [16, 376, 420, 22], 15, bold=True)
    button('advanced', 'Avansat', [472, 372, 152, 30], 'Înapoi la setări')
    b['advanced']['hint'] = 'Compensare, calibrare, mărire vizuală și diagnostic.'
    card('rhythm-card', [16, 410, 608, 80], 'basic')
    place('grid-caption', [32, 423, 128, 16], 10, 'Grilă ritmică', 'basic')
    place('grid-ui', [32, 446, 128, 29], 13, page='basic')
    place('redms-label', [184, 423, 126, 16], 10, 'Toleranță (±ms)', 'basic')
    place('redms', [184, 446, 100, 29], 13, page='basic')
    label('rhythm-hint', 'Abaterea permisă față de grilă.',
          [316, 429, 288, 42], 10.5, 'basic')
    b['redms']['hint'] = 'Abaterea permisă în milisecunde. Controlează și oprirea automată.'
    card('mic-card', [16, 502, 608, 124], 'basic')
    label('mic-heading', 'Microfon și detecție', [32, 512, 350, 20], 13, 'basic', True)
    place('gatedb-label', [32, 540, 140, 16], 10, 'Prag de detecție (dB)', 'basic')
    place('gatedb', [32, 561, 104, 29], 13, page='basic')
    label('gate-help', 'Mai negativ =\nmai sensibil', [32, 595, 130, 26], 9.5, 'basic')
    label('meter-caption', 'Nivel brut și prag ales · reper vizual', [174, 536, 432, 16], 10, 'basic')
    for id, rect, style in [('input-meter', [174, 558, 432, 13], 1),
                            ('threshold-meter', [174, 576, 432, 6], 0)]:
        u.box(id, 'multislider', ins=1, outs=2, pres=rect,
              size=1, listresize=0, settype=1, setstyle=style, orientation=0,
              setminmax=[-60., 0.], slidercolor=PALETTES[0]['voice' if style else 'amber'],
              bgcolor=PALETTES[0]['field'], thickness=2, signed=0,
              parameter_enable=0, ignoreclick=1)
        b[id] = u.p['boxes'][-1]['box']; place(id, rect, page='basic')
        b[id]['hint'] = ('Nivel brut de vârf pe 600 ms; marcajul arată pragul ales. '
            'Detectorul folosește și filtrare, anvelopă, zgomot și rearmare. '
            'Depășirea marcajului nu garantează un atac.')
    label('meter-low', '−60 dB', [174, 585, 72, 13], 9, 'basic')
    label('meter-high', '0 dB', [572, 585, 34, 13], 9, 'basic')
    label('level-feedback', 'Nivel sub pragul ales', [174, 605, 432, 16], 10, 'basic')
    card('source-card', [16, 638, 608, 82], 'basic')
    place('beat-source-caption', [32, 649, 450, 18], 12, 'Instrumental · pista și punctul de preluare', 'basic')
    place('beat-type', [32, 678, 292, 28], 11, page='basic')
    place('beat-channel', [336, 678, 164, 28], 11, page='basic')
    place('beat-refresh', [512, 678, 96, 28], 10, 'Actualizează', 'basic')
    b['beat-refresh']['texton'] = 'Actualizează'

    card('calibration-card', [16, 410, 608, 144], 'advanced')
    label('calibration-heading', 'Compensare și calibrare', [32, 422, 500, 20], 13, 'advanced', True)
    place('offsetms-label', [32, 452, 200, 16], 10, 'Compensarea întârzierii (ms)', 'advanced')
    place('offsetms', [32, 476, 124, 30], 13, page='advanced')
    place('calibrate', [180, 476, 204, 30], 11, 'Preia întârzierea', 'advanced')
    b['calibrate']['texton'] = 'Preia întârzierea'
    label('calibration-help', 'Folosește un impuls cunoscut pe grila 1/4.\nCompensarea schimbă rezultatul numeric; nu mută înregistrarea.',
          [32, 516, 560, 29], 10, 'advanced')
    card('zoom-card', [16, 566, 608, 80], 'advanced')
    label('zoom-heading', 'Mărire vizuală · sunetul rămâne neschimbat', [32, 575, 560, 20], 12, 'advanced', True)
    place('voice-gain-caption', [32, 611, 120, 16], 10, 'Microfon', 'advanced')
    place('voice-gain', [160, 604, 72, 29], 12, page='advanced')
    place('beat-gain-caption', [320, 611, 140, 16], 10, 'Instrumental', 'advanced')
    place('beat-gain', [474, 604, 72, 29], 12, page='advanced')
    for id in ('voice-gain','beat-gain'):
        # Display units inside the editable native field; DSP still gets floats.
        obj=b[id]
        obj.update(maxclass='live.numbox',numinlets=1,numoutlets=2,
                   outlettype=['','float'],appearance=4,active=1,textjustification=1)
        for old_attr in ('format','minimum','maximum','triangle','bgcolor'):
            obj.pop(old_attr,None)
        obj['saved_attribute_attributes']['valueof'].update(
            parameter_unitstyle=9,parameter_units='%g×')
        obj['hint']='Mărire vizuală de la 1× la 8×. Acceptă și 2.5×. Nu schimbă sunetul sau detecția.'
    card('diagnostic-card', [16, 658, 608, 62], 'advanced')
    place('api-text', [32, 670, 440, 16], 10, page='advanced')
    place('test', [488, 668, 120, 28], 10, 'Test afișare', 'advanced')
    b['test']['texton'] = 'Test afișare'
    place('tests-text', [32, 696, 110, 15], 9, page='advanced')
    place('limit-text', [154, 696, 454, 15], 9, page='advanced')
    place('footer2', [16, 734, 608, 17], 10, 'Setările se păstrează în proiect cu Ctrl+S. Oprirea automată pornește OFF.')
    b['footer2']['textjustification'] = 1

    # Clearer labels without changing engine state codes or stop diagnostics.
    b['sync-0']['text'] = 'set Pornește redarea în Ableton'
    b['sync-1']['text'] = 'set Redarea este sincronizată'
    b['level-format']['text'] = 'sprintf Nivel: %.1f dB'
    b['beat-level-format']['text'] = 'sprintf Nivel: %.1f dB'
    b['maxdev-format']['text'] = 'sprintf Abatere maximă a grilei: ±%.0f ms'
    b['tests-format']['text'] = 'sprintf Teste: %ld'
    for i, (label_text, mark, role) in enumerate(STATES):
        b['status-'+str(i)]['text'] = 'set '+label_text
        u.msg('mark-'+str(i), 'set '+mark)
        u.wire('state-select', 'mark-'+str(i), i)
        u.wire('mark-'+str(i), 'status-mark')
    # The sign explanation follows the measured sign, gated by existing validity.
    u.obj('ui-sign', 'expr ($f1 > 0.05) - ($f1 < -0.05)')
    u.obj('ui-sign-select', 'sel -1 0 1', 1, 4)
    u.wire('delta-gate', 'ui-sign'); u.wire('ui-sign', 'ui-sign-select')
    for i, text in enumerate(['Mai devreme față de grilă', 'Pe reperul grilei', 'Mai târziu față de grilă']):
        u.msg('ui-sign-'+str(i), 'set '+text)
        u.wire('ui-sign-select', 'ui-sign-'+str(i), i);u.wire('ui-sign-'+str(i), 'sign-caption')
    u.msg('ui-sign-clear', 'set Față de grila din Ableton')
    u.wire('hasdelta-select', 'ui-sign-clear');u.wire('ui-sign-clear', 'sign-caption')

    # UI-only level comparison: NEVER connected to engine, routing or Auto Stop.
    u.obj('ui-level-clip', 'clip -60. 0.', 3, 1)
    u.obj('ui-level-set', 'prepend setlist')
    u.wire('level-db', 'ui-level-clip');u.wire('ui-level-clip', 'ui-level-set');u.wire('ui-level-set', 'input-meter')
    u.obj('ui-threshold-set', 'prepend setlist');u.wire('gatedb', 'ui-threshold-set');u.wire('ui-threshold-set', 'threshold-meter')
    u.obj('ui-level-pak', 'pak -100. -32.', 2, 1)
    u.obj('ui-level-unpack', 'unpack 0. 0.', 1, 2)
    u.obj('ui-level-class', 'expr ($f1 >= 0.) * 2 + ($f1 < 0.) * ($f1 >= $f2)', 2, 1)
    u.obj('ui-level-change', 'change -1', 3, 3)
    u.obj('ui-level-select', 'sel 0 1 2', 1, 4)
    u.wire('level-db', 'ui-level-pak');u.wire('gatedb', 'ui-level-pak', 0, 1)
    u.wire('ui-level-pak', 'ui-level-unpack');u.wire('ui-level-unpack', 'ui-level-class')
    u.wire('ui-level-unpack', 'ui-level-class', 1, 1);u.wire('ui-level-class', 'ui-level-change')
    u.wire('ui-level-change', 'ui-level-select')
    for i, text in enumerate(['Nivel sub pragul ales', 'Nivel peste prag · atacul este verificat separat', 'Nivel prea mare · redu intrarea microfonului']):
        u.msg('ui-level-label-'+str(i), 'set '+text)
        u.wire('ui-level-select', 'ui-level-label-'+str(i), i);u.wire('ui-level-label-'+str(i), 'level-feedback')

    # Flag impossible tolerance next to its control, not only in diagnostics.
    u.obj('ui-tolerance-pak', 'pak 100. 300.', 2, 1)
    u.obj('ui-tolerance-unpack', 'unpack 0. 0.', 1, 2)
    u.obj('ui-tolerance-invalid', 'expr $f1 > $f2', 2, 1)
    u.obj('ui-tolerance-select', 'sel 0 1', 1, 3)
    u.wire('redms', 'ui-tolerance-pak');u.wire('route', 'ui-tolerance-pak', 7, 1)
    u.wire('ui-tolerance-pak', 'ui-tolerance-unpack');u.wire('ui-tolerance-unpack', 'ui-tolerance-invalid')
    u.wire('ui-tolerance-unpack', 'ui-tolerance-invalid', 1, 1);u.wire('ui-tolerance-invalid', 'ui-tolerance-select')
    for i, text in enumerate(['Abaterea permisă față de grilă.', 'Depășește limita grilei. Scade toleranța.']):
        u.msg('ui-tolerance-label-'+str(i), 'set '+text)
        u.wire('ui-tolerance-select', 'ui-tolerance-label-'+str(i), i);u.wire('ui-tolerance-label-'+str(i), 'rhythm-hint')

    # Page switch only shows/hides existing UI objects using local scripting names.
    u.obj('ui-page-select', 'sel 0 1', 1, 3);u.wire('advanced', 'ui-page-select')
    for index, mode in enumerate(['basic', 'advanced']):
        cmds = ['script '+('show' if (id in basic)==(mode=='basic') else 'hide')+' '+b[id]['varname'] for id in basic+advanced]
        u.msg('ui-page-'+str(index), ', '.join(cmds));u.wire('ui-page-select', 'ui-page-'+str(index), index)
        u.wire('ui-page-'+str(index), 'window')
        u.msg('ui-page-title-'+str(index), 'set '+('Setări uzuale' if index==0 else 'Setări avansate'))
        u.wire('ui-page-select', 'ui-page-title-'+str(index), index);u.wire('ui-page-title-'+str(index), 'settings-heading')
    # Remember latest engine state so theme changes immediately recolor it.
    u.p['lines'] = [w for w in u.p['lines'] if not (w['patchline']['source']==['route',0] and w['patchline']['destination']==['state-select',0])]
    u.obj('ui-state-trigger', 't i i', 1, 2);u.obj('ui-state-memory', 'i 1', 2, 1)
    u.wire('route', 'ui-state-trigger');u.wire('ui-state-trigger', 'ui-state-memory', 1, 1)
    u.wire('ui-state-trigger', 'state-select');u.wire('ui-state-memory', 'state-select')
    # Apply palettes, then repaint the current timing state. Attribute messages
    # never send numeric values through controls and never emit control actions.
    u.obj('ui-theme-trigger', 't b i', 1, 2)
    u.obj('ui-theme-select', 'sel 0 1', 1, 3)
    u.wire('theme', 'ui-theme-trigger');u.wire('ui-theme-trigger', 'ui-theme-select', 1)
    # Dedicated local UI outlet: never share the engine-control outlet.
    # Max orders regular outlets by their patching x coordinate.
    u.obj('ui-device-theme-out', 'outlet', 1, 0,
          rect=[b['out']['patching_rect'][0] + 240, 900, 25, 25])
    u.wire('ui-theme-trigger', 'ui-device-theme-out', 1)
    u.wire('ui-theme-trigger', 'ui-state-memory')
    u.obj('ui-theme-replay', 'pattr @bindto vtm_theme @thru 0 @autorestore 0', 3, 3,
          saved_object_attributes=dict(parameter_enable=0))
    u.wire('initialize', 'ui-theme-replay', 6);u.wire('ui-theme-replay', 'ui-theme-trigger')
    # Reopen initialized views consistently without replaying action toggles.
    u.msg('ui-view-initial', 'set 0');u.wire('initialize', 'ui-view-initial', 6)
    u.wire('ui-view-initial', 'settings');u.wire('ui-view-initial', 'advanced')
    u.msg('ui-page-initial', '0');u.wire('initialize', 'ui-page-initial', 6);u.wire('ui-page-initial', 'ui-page-select');u.wire('ui-page-initial','settings-trigger')

    b = boxes()
    for i, (_, _, role) in enumerate(STATES):
        # Replace original state->fixed-color edge with state->theme lookup.
        u.p['lines'] = [w for w in u.p['lines'] if not (w['patchline']['source']==['state-select',i] and w['patchline']['destination']==['color-'+str(i),0])]
        u.obj('ui-state-theme-'+str(i), 'i 0', 2, 1)
        u.obj('ui-state-color-select-'+str(i), 'sel 0 1', 1, 3)
        u.wire('state-select', 'ui-state-theme-'+str(i), i)
        u.wire('ui-theme-trigger', 'ui-state-theme-'+str(i), 1, 1)
        u.wire('ui-state-theme-'+str(i), 'ui-state-color-select-'+str(i))
        for theme in (0, 1):
            mid = 'color-'+str(i) if theme==0 else 'ui-light-color-'+str(i)
            text = 'textcolor '+' '.join(map(str, PALETTES[theme][role]))
            if theme==0:b[mid]['text']=text
            else:u.msg(mid, text)
            u.wire('ui-state-color-select-'+str(i), mid, theme)
            if theme:
                u.wire(mid, 'state-text');u.wire(mid, 'delta-text')
            u.wire(mid, 'status-mark')
    # Per-object roles; fields and buttons have their own contrasting fills.
    apply_readable_type(u.p)
    b = boxes()
    muted = {'version','clock-text','sign-caption','count-caption','level-text','beat-level',
             'time-old','time-mid','time-now','grid-caption','redms-label','rhythm-hint',
             'gatedb-label','gate-help','meter-caption','meter-low','meter-high','level-feedback',
             'offsetms-label','calibration-help','voice-gain-caption','beat-gain-caption',
             'api-text','tests-text','limit-text','footer2'}
    for theme, palette in enumerate(PALETTES):
        cmds = []
        def attr(obj, name, value):
            b[obj][name] = value if theme==0 else b[obj].get(name, value)
            cmds.append('script send '+b[obj]['varname']+' '+name+' '+' '.join(map(str,value)))
        for id, obj in b.items():
            if not obj.get('presentation'):continue
            cls=obj['maxclass']
            if cls=='panel':attr(id,'bgcolor',palette['bg' if id=='studio-canvas' else 'card'])
            elif cls=='comment':
                role='voice' if id=='voice-caption' else 'beat' if id=='beat-caption' else 'muted' if id in muted else 'text'
                attr(id,'textcolor',palette[role])
            elif cls=='live.scope~':
                role={'voice-scope':'voice','beat-scope':'beat','grid-scope':'amber'}[id]
                for name in ['bgcolor','activebgcolor']:attr(id,name,palette['card'])
                for name in ['linecolor','activelinecolor']:attr(id,name,palette[role])
            elif cls in ['number','flonum','umenu','textbutton']:
                attr(id,'bgcolor',palette['field']);attr(id,'textcolor',palette['text'])
                if cls=='textbutton':
                    obj.update(usegradient=0, rounded=8., usetextovercolor=1)
                    attr(id,'textovercolor',palette['text'])
                    attr(id,'bgoncolor',palette['stop_bg' if id=='autostop' else 'selected' if id in ['enabled','settings','advanced','theme'] else 'field'])
                    attr(id,'textoncolor',palette['stop_text' if id=='autostop' else 'selected_text' if id in ['enabled','settings','advanced','theme'] else 'text'])
            elif cls=='live.numbox':
                for name in ('activebgcolor','lcdbgcolor'):attr(id,name,palette['field'])
                for name in ('textcolor','lcdcolor','inactivelcdcolor'):attr(id,name,palette['text'])
                attr(id,'bordercolor',palette['border'])
                attr(id,'focusbordercolor',palette['voice'])
            elif cls=='multislider':
                attr(id,'bgcolor',palette['field']);attr(id,'slidercolor',palette['voice' if id=='input-meter' else 'amber'])
        u.msg('ui-palette-'+str(theme), ', '.join(cmds))
        u.wire('ui-theme-select','ui-palette-'+str(theme),theme);u.wire('ui-palette-'+str(theme),'window')
    # Use documented per-object colors, rather than changing global Max styles.
    # Input overload updates only UI messages. Theme replay recalculates level
    # feedback even if no new level packet arrives.
    u.obj('ui-level-memory', 'f -100.', 2, 1)
    u.wire('level-db','ui-level-memory',0,1)
    u.obj('ui-level-refresh','t b b',1,2)
    u.msg('ui-level-refresh-reset','set -1')
    u.wire('ui-theme-trigger','ui-level-refresh')
    u.wire('ui-level-refresh','ui-level-refresh-reset',1)
    u.wire('ui-level-refresh-reset','ui-level-change')
    u.wire('ui-level-refresh','ui-level-memory')
    u.wire('ui-level-memory','ui-level-pak')
    for i in range(3):
        u.obj('ui-level-theme-'+str(i),'i 0',2,1)
        u.obj('ui-level-color-select-'+str(i),'sel 0 1',1,3)
        u.wire('ui-level-select','ui-level-theme-'+str(i),i)
        u.wire('ui-theme-trigger','ui-level-theme-'+str(i),1,1)
        u.wire('ui-level-theme-'+str(i),'ui-level-color-select-'+str(i))
        for theme in (0,1):
            role=('muted','voice','red')[i]
            u.msg('ui-level-color-'+str(i)+'-'+str(theme),'textcolor '+' '.join(map(str,PALETTES[theme][role])))
            u.wire('ui-level-color-select-'+str(i),'ui-level-color-'+str(i)+'-'+str(theme),theme)
            u.wire('ui-level-color-'+str(i)+'-'+str(theme),'level-feedback')
            u.wire('ui-level-color-'+str(i)+'-'+str(theme),'level-text')
            u.msg('ui-meter-color-'+str(i)+'-'+str(theme),'slidercolor '+' '.join(map(str,PALETTES[theme]['red' if i==2 else 'voice'])))
            u.wire('ui-level-color-select-'+str(i),'ui-meter-color-'+str(i)+'-'+str(theme),theme)
            u.wire('ui-meter-color-'+str(i)+'-'+str(theme),'input-meter')
    # Recalculate classes on theme repaint instead of change suppressing them.

    # Root display additions cannot introduce a signal or output path.


def apply_device_theme(p):
    """Keep the embedded device body in sync with this instance's monitor."""
    b = {w['box']['id']: w['box'] for w in p.p['boxes']}
    b['popup']['numoutlets'] = 2
    p.panel('ui-device-canvas', [0, 0, 360, 169])
    canvas = p.p['boxes'].pop()
    canvas['box'].pop('bgcolor', None)
    canvas['box'].update(rounded=0, varname='vtm_device_canvas',
                         bgfillcolor=dict(type='color', color=PALETTES[0]['bg']))
    p.p['boxes'].insert(0, canvas)
    b['ui-device-canvas'] = canvas['box']
    for id in ('title', 'version', 'open', 'note1', 'note2'):
        b[id]['varname'] = 'vtm_device_' + id
    # The Live-owned title bar/frame keeps Live's own theme. Only our body is
    # painted; no global send/receive, Live preference or new stored control.
    p.obj('ui-device-theme-select', 'sel 0 1', 1, 3)
    p.obj('ui-device-window', 'thispatcher', 1, 2)
    p.wire('popup', 'ui-device-theme-select', 1)
    for theme, palette in enumerate(PALETTES):
        commands = []
        def attr(id, name, role):
            value = palette[role]
            if theme == 0 and name != 'bgfillcolor':
                b[id][name] = value
            commands.append('script send ' + b[id]['varname'] + ' ' + name
                            + ' ' + ' '.join(map(str, value)))
        attr('ui-device-canvas', 'bgfillcolor', 'bg')
        for id in ('title', 'version', 'note1', 'note2'):
            attr(id, 'textcolor', 'voice' if id == 'title' else 'muted')
        for name, role in (('bgcolor', 'field'), ('textcolor', 'text'),
                           ('bgoncolor', 'selected'), ('textoncolor', 'selected_text'),
                           ('textovercolor', 'text')):
            attr('open', name, role)
        b['open'].update(usegradient=0, usetextovercolor=1)
        p.msg('ui-device-palette-' + str(theme), ', '.join(commands))
        p.wire('ui-device-theme-select', 'ui-device-palette-' + str(theme), theme)
        p.wire('ui-device-palette-' + str(theme), 'ui-device-window')

