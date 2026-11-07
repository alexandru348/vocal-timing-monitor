"""Native calibration bindings; keep the onset engine and presentation controls."""
from pathlib import Path

ROOT = Path(__file__).resolve().parent

def text_message(text):
    # Max message punctuation is executable syntax, even inside a set message.
    return 'set '+text.replace('\\','\\\\').replace(',','\\,').replace(';','\\;').replace('\n',' ')

def apply_latency_popup(u):
    b={w['box']['id']:w['box'] for w in u.p['boxes']}
    removed={'raw-store','cal-pak','cal-unpack','cal-valid','cal-gate','cal-active','cal-bang'}
    u.p['boxes']=[w for w in u.p['boxes'] if w['box']['id'] not in removed]
    u.p['lines']=[w for w in u.p['lines'] if w['patchline']['source'][0] not in removed and w['patchline']['destination'][0] not in removed]
    # Append selectors, preserving every existing selector index.
    selectors=b['route']['text'].split()[1:]
    b['route']['text']+=' latencyoffset latencystatus latencyreason latencydiagnostics latencycancelreason'
    b['route']['numoutlets']+=5
    u.wire('route','offsetms',len(selectors))
    u.obj('lat-status-select','sel 0 1 2 3 4 5 6 7',1,9)
    u.wire('route','lat-status-select',len(selectors)+1)
    labels=[
        'Redă instrumentalul și păstrează liniștea.\nApasă Preia întârzierea pentru măsurare automată.',
        'Măsor întârzierea din instrumental.\nPăstrează liniștea până la rezultatul final.',
        'Verific dacă măsurarea este concludentă.\nPăstrează liniștea.',
        'Calibrare aplicată. Salvează proiectul cu Ctrl+S.\nCompensarea corectează măsurarea; nu mută clipul.',
        'Reper neconcludent; valoarea existentă este păstrată.\nReîncearcă într-un pasaj variat, fără voce.',
        'Calibrare anulată; valoarea existentă este păstrată.\nReia cu redarea pornită, REC și Oprire auto OFF.',
        'Pornește redarea, cu REC și Oprire auto OFF.\nAșteaptă sincronizarea, apoi reîncearcă.',
        'Reconfirm întârzierea printr-o captură nouă. Păstrează liniștea și redarea pornită.'
    ]
    for i,label in enumerate(labels):
        # Native message newlines are whitespace; the comment wraps naturally.
        u.msg('lat-help-'+str(i),text_message(label))
        if i not in (4,5,6):u.wire('lat-status-select','lat-help-'+str(i),i)
        u.wire('lat-help-'+str(i),'calibration-help')
    # A terminal rejection uses diagnostics from the same token/poll cycle.
    # Store quietly; only state 4 renders them, so stale packets cannot overwrite
    # the current measuring/cancelled/applied help text.
    u.obj('lat-diagnostic-store','zl reg',2,2)
    u.wire('route','lat-diagnostic-store',len(selectors)+3,1)
    u.wire('lat-status-select','lat-diagnostic-store',4)
    u.obj('lat-diagnostic-route','route 1 2 3 4 5 6 7 8 9 10',1,11)
    u.wire('lat-diagnostic-store','lat-diagnostic-route')
    labels_reject=[
        'Instrumental fără variație măsurabilă.',
        'Microfon fără reper măsurabil.',
        'Potrivire insuficientă între semnale.',
        'Mai multe întârzieri plauzibile.',
        'Întârziere instabilă între ferestre.',
        'Candidat la limita intervalului.',
        'Confirmare insuficientă între benzi.',
        'Benzile indică întârzieri diferite.',
        'Reconfirmare neconcludentă.',
        'Întârzierea diferă între capturi.'
    ]
    for i,label in enumerate(labels_reject):
        # List enters inlet 0 and fills all eight sprintf placeholders atomically.
        fmt='sprintf symout '+label+' Compensare păstrată. C=%.2f candidat=%.0fms A/B=%.2f/%.2f M=%.2f D=%.0fms N=%.0f S=%.1fms'
        u.obj('lat-diagnostic-format-'+str(i),fmt,8,1)
        u.wire('lat-diagnostic-route','lat-diagnostic-format-'+str(i),i)
        u.obj('lat-diagnostic-set-'+str(i),'prepend set')
        u.wire('lat-diagnostic-format-'+str(i),'lat-diagnostic-set-'+str(i))
        u.wire('lat-diagnostic-set-'+str(i),'calibration-help')
    u.wire('lat-diagnostic-route','lat-help-4',10)
    # DSP cancellation causes and final commit guard failures share a compact
    # explanation in the existing help area. Updates are cold until status 5.
    cancel_labels={
        100:'Cauza anulării nu a fost identificată.',
        101:'Pragul microfonului s-a schimbat.',102:'Starea analizei s-a schimbat.',
        103:'Oprirea automată s-a schimbat.',104:'Grila ritmică s-a schimbat.',
        105:'Toleranța s-a schimbat.',106:'Compensarea a fost modificată.',107:'Reset a fost apăsat.',
        108:'Sursa instrumentalului a fost schimbată.',109:'Canalul instrumentalului a fost schimbat.',
        110:'Actualizarea surselor a fost cerută.',111:'Ableton a schimbat sursa instrumentalului.',
        112:'Ableton a schimbat canalul instrumentalului.',113:'Dispozitivul a fost reinițializat.',
        114:'Condițiile de calibrare s-au schimbat.',115:'Starea procesării audio s-a schimbat.',
        116:'Rata de eșantionare s-a schimbat.',117:'Vectorul DSP s-a schimbat.',118:'Vectorul audio I/O s-a schimbat.',
        119:'Calibrarea automată a fost dezactivată.',
        200:'Condițiile de calibrare s-au schimbat fără un motiv disponibil.',
        201:'Analiza a fost oprită.',202:'Oprirea automată a fost activată.',
        203:'Redarea a fost oprită.',204:'Conexiunea cu Ableton s-a întrerupt.',
        205:'Dispozitivul a fost dezactivat.',206:'Activitatea audio s-a întrerupt.',
        207:'Starea REC nu mai este confirmată.',208:'REC a fost activat.',
        209:'Starea Session Record nu mai este confirmată.',210:'Session Record a fost activat.',
        211:'Starea înregistrării Session nu mai este confirmată.',212:'Înregistrarea Session a fost activată.',213:'Starea redării nu mai este confirmată.',
        300:'Ceasul audio a pierdut sincronizarea.',301:'Rata de eșantionare s-a schimbat în DSP.',
        302:'Semnalul de sincronizare a rămas invalid.',303:'Poziția ritmică a făcut un salt mare.',
        400:'Aplicarea rezultatului nu a fost confirmată.',401:'Condițiile Ableton s-au schimbat înaintea aplicării.',
        402:'Cererea nu mai era activă la aplicare.',403:'Rezultatul aparține altei cereri.',
        404:'Calitatea rezultatului nu era confirmată la aplicare.',405:'Rezultatul depășea intervalul permis.'}
    u.obj('lat-cancel-reason-store','i 100',2,1)
    u.wire('route','lat-cancel-reason-store',len(selectors)+4,1)
    u.wire('lat-status-select','lat-cancel-reason-store',5)
    u.obj('lat-cancel-reason-select','sel '+' '.join(str(i) for i in cancel_labels),1,len(cancel_labels)+1)
    u.wire('lat-cancel-reason-store','lat-cancel-reason-select')
    for outlet,(code,label) in enumerate(cancel_labels.items()):
        u.msg('lat-cancel-help-'+str(code),text_message('Calibrare anulată: '+label+' Valoarea existentă este păstrată. [C'+str(code)+']'))
        u.wire('lat-cancel-reason-select','lat-cancel-help-'+str(code),outlet)
        u.wire('lat-cancel-help-'+str(code),'calibration-help')
    u.wire('lat-cancel-reason-select','lat-help-5',len(cancel_labels))
    # A refused start must report the current failed guard, not assume Stop.
    reasons=[
        'Calibrare nepornită. Așteaptă stabilizarea și reîncearcă.',
        'Activează analiza pentru calibrare.',
        'Lasă Oprire auto OFF în timpul calibrării.',
        'Pornește redarea și așteaptă sincronizarea.',
        'Aștept conexiunea cu Ableton pentru calibrare.',
        'Activează dispozitivul pentru calibrare.',
        'Aștept procesarea audio pentru calibrare.',
        'Aștept confirmarea stării REC din Ableton.',
        'Oprește REC pentru calibrare.',
        'Aștept confirmarea stării Session Record din Ableton.',
        'Oprește Session Record pentru calibrare.',
        'Aștept confirmarea stării de înregistrare Session.',
        'Înregistrarea Session este activă. Oprește-o pentru calibrare.',
        'Aștept confirmarea redării din Ableton.'
    ]
    u.obj('lat-reason-store','i 4',2,1);u.wire('route','lat-reason-store',len(selectors)+2,1)
    u.wire('lat-status-select','lat-reason-store',6)
    u.obj('lat-reason-select','sel '+' '.join(str(i) for i in range(len(reasons))),1,len(reasons)+1)
    u.wire('lat-reason-store','lat-reason-select')
    for i,label in enumerate(reasons):
        u.msg('lat-reason-'+str(i),text_message(label));u.wire('lat-reason-select','lat-reason-'+str(i),i)
        u.wire('lat-reason-'+str(i),'calibration-help')
    b['calibration-help']['text']=labels[0]
    b['calibrate']['active']=1
    b['calibrate']['hint']='Măsoară diferența dintre instrumentalul digital și cel captat de microfon, fără voce. Necesită difuzoare audibile în microfon. Nu deduce latența din ritmul vocii.'
    # Third local outlet: old control and theme outlet positions stay unchanged.
    xs=[w['box']['patching_rect'][0] for w in u.p['boxes'] if w['box'].get('text')=='outlet']
    u.obj('lat-request-out','outlet',1,0,rect=[max(xs)+240,20,25,25])
    u.obj('lat-click','t b');u.wire('calibrate','lat-click');u.wire('lat-click','lat-request-out')

def calibration_graph(Patch):
    g=Patch(900,600,'dsp.gen')
    g.p['openinpresentation']=0
    g.box('code','codebox',ins=5,outs=13,rect=[20,20,850,500],code=(ROOT/'src/vtm_latency.genexpr').read_text())
    for i in range(5):
        g.obj('in'+str(i+1),'in '+str(i+1),0,1);g.wire('in'+str(i+1),'code',0,i)
    for i in range(13):
        g.obj('out'+str(i+1),'out '+str(i+1),1,0);g.wire('code','out'+str(i+1),i)
    return g.p

def apply_latency_parent(p,Patch):
    b={w['box']['id']:w['box'] for w in p.p['boxes']}
    b['popup']['numoutlets']=3
    p.obj('lat-engine','gen~',5,13,patcher=calibration_graph(Patch),outlettype=['signal']*13)
    for source,outlet,inlet in [('plugin',0,0),('plugin',1,1),('beat-plugin',0,2),('beat-plugin',1,3),('phasor',0,4)]:
        p.wire(source,'lat-engine',outlet,inlet)
    # Fail closed until all three host recording observers report explicit zero.
    p.obj('lat-permit-pak','pak 1 0 0 0 1 0 -1 -1 -1',9,1)
    for source,outlet,inlet in [('control-route',1,0),('control-route',2,1),('api-valid',0,3),('thisdevice',1,4),('audio-alive',0,5)]:
        p.wire(source,'lat-permit-pak',outlet,inlet)
    p.obj('lat-permit-unpack','unpack 0 0 0 0 0 0 0 0 0',1,9)
    p.obj('lat-permit-expr','expr ($i1 > 0) && ($i2 == 0) && ($i3 > 0) && ($i4 > 0) && ($i5 > 0) && ($i6 > 0) && ($i7 == 0) && ($i8 == 0) && ($i9 == 0)',9,1)
    p.wire('lat-permit-pak','lat-permit-unpack')
    for i in range(9):p.wire('lat-permit-unpack','lat-permit-expr',i,i)
    # One coherent priority-ordered explanation for the same permit predicate.
    conditions=[('$i1 <= 0',1),('$i2 != 0',2),('$i3 < 0',13),('$i3 == 0',3),('$i4 <= 0',4),('$i5 <= 0',5),('$i6 <= 0',6),
                ('$i7 < 0',7),('$i7 > 0',8),('$i8 < 0',9),('$i8 > 0',10),('$i9 < 0',11),('$i9 > 0',12)]
    expr='0'
    for condition,code in reversed(conditions):expr=f'({condition}) * {code} + (!({condition})) * ({expr})'
    p.obj('lat-reason-expr','expr '+expr,9,1)
    for i in range(9):p.wire('lat-permit-unpack','lat-reason-expr',i,i)
    p.obj('lat-reason-tag','prepend latencyreason');p.wire('lat-reason-expr','lat-reason-tag');p.wire('lat-reason-tag','popup')
    p.obj('lat-guard-reason-tag','prepend guardreason');p.wire('lat-reason-expr','lat-guard-reason-tag');p.wire('lat-guard-reason-tag','lat-engine')
    p.obj('lat-permit','change -1',3,3);p.wire('lat-permit-expr','lat-permit')
    p.obj('lat-permit-tag','prepend permit');p.wire('lat-permit','lat-permit-tag');p.wire('lat-permit-tag','lat-engine')
    p.msg('lat-unknown','-1');p.wire('api-clear','lat-unknown');p.wire('api-lost','lat-unknown')
    for i,(prop,inlet) in enumerate([('record_mode',6),('session_record',7),('session_record_status',8),('is_playing',2)]):
        id='lat-observe-'+str(i)
        # The documented constructor takes the property as a positional
        # argument. Also select it explicitly after the binding is confirmed.
        p.obj(id,'live.observer '+prop,2,2)
        p.wire('bind-id',id,0,1)
        p.wire(id,'lat-permit-pak',0,inlet)
        p.wire('lat-unknown','lat-permit-pak',0,inlet)
    p.obj('lat-api-bound','sel 1',1,2);p.wire('api-valid','lat-api-bound')
    p.obj('lat-requery-defer','deferlow');p.wire('lat-api-bound','lat-requery-defer')
    p.obj('lat-requery-gate','gate 1 0',2,1);p.wire('api-valid','lat-requery-gate');p.wire('lat-requery-defer','lat-requery-gate',0,1)
    p.obj('lat-requery-trigger','t b b b b',1,4);p.wire('lat-requery-gate','lat-requery-trigger')
    for i,prop in enumerate(['record_mode','session_record','session_record_status','is_playing']):
        p.msg('lat-property-'+str(i),'property '+prop)
        p.wire('lat-requery-trigger','lat-property-'+str(i),i)
        p.wire('lat-property-'+str(i),'lat-observe-'+str(i))
    # A blocked attempt reports a reason but does not change analysis/Auto Stop.
    p.obj('lat-request-counter','counter 1 1000000000',5,4)
    p.wire('popup','lat-request-counter',2)
    p.obj('lat-request-trigger','t i i b',1,3)
    p.wire('lat-request-counter','lat-request-trigger')
    p.msg('lat-pending-on','1');p.wire('lat-request-trigger','lat-pending-on',2)
    p.obj('lat-request-tag','prepend requestseq');p.wire('lat-request-trigger','lat-request-tag');p.wire('lat-request-tag','lat-engine')
    # Cancel on configuration/routing changes, DSP restart, or invalid guards.
    p.obj('lat-cancel-counter','counter 1 1000000000',5,4)
    p.obj('lat-cancel-tag','prepend cancelseq');p.wire('lat-cancel-counter','lat-cancel-tag');p.wire('lat-cancel-tag','lat-engine')
    p.obj('lat-cancel-bang','t b i',1,2)
    p.wire('lat-cancel-bang','lat-cancel-counter')
    p.obj('lat-cancel-reason-tag','prepend cancelreason');p.wire('lat-cancel-bang','lat-cancel-reason-tag',1);p.wire('lat-cancel-reason-tag','lat-engine')
    # A value echo is not a configuration change. Reset/refresh/lifecycle are
    # explicit actions; recording/API/clock/DSP guards continue to fail closed.
    sources=[('control-route',i,i+1,'numeric' if i<6 else None) for i in range(7)]
    sources += [('wave-control-route',0,8,'list'),('wave-control-route',1,9,'list'),('wave-control-route',2,10,None),
                ('beat-router',0,11,'list'),('beat-router',1,12,'list'),('ready-defer',0,13,None)]
    for source,outlet,code,kind in sources:
        upstream=source;out=outlet
        if kind:
            id='lat-cancel-filter-'+str(code)
            p.obj(id,'change -999999.' if kind=='numeric' else 'zl change',3 if kind=='numeric' else 2,3 if kind=='numeric' else 2)
            p.wire(source,id,outlet);upstream=id;out=0
        id='lat-cancel-code-'+str(code);p.msg(id,str(code));p.wire(upstream,id,out);p.wire(id,'lat-cancel-bang')
    p.obj('lat-disallowed','sel 0',1,2);p.wire('lat-permit','lat-disallowed')
    p.msg('lat-cancel-code-14','14');p.wire('lat-disallowed','lat-cancel-code-14');p.wire('lat-cancel-code-14','lat-cancel-bang')
    for i in range(4):
        id='lat-dsp-change-'+str(i);p.obj(id,'change -1',3,3)
        code='lat-cancel-code-'+str(15+i);p.msg(code,str(15+i))
        p.wire('wave-samplerate',id,i);p.wire(id,code);p.wire(code,'lat-cancel-bang')
    # Results are sampled coherently (lag, quality and token before state), then
    # applied only to the existing compensation value after deferred recheck.
    p.obj('lat-poll','t '+' '.join(['b']*12),1,12);p.wire('poll','lat-poll')
    for inlet,outlet in enumerate([0,5,4,2,1,6,7,8,9,10,11,12]):
        id='lat-snapshot-'+str(outlet)
        p.obj(id,'snapshot~',1,1);p.wire('lat-engine',id,outlet)
        p.wire('lat-poll',id,inlet)
    # Metrics are sampled before reason (hot inlet), then status is last.
    p.obj('lat-diagnostic-pack','pack 0 0. 0. 0. 0. 0. 0. 0. 0.',9,1)
    for outlet,inlet in [(5,0),(2,1),(6,2),(7,3),(8,4),(9,5),(10,6),(11,7),(12,8)]:
        p.wire('lat-snapshot-'+str(outlet),'lat-diagnostic-pack',0,inlet)
    p.obj('lat-cancel-ui-tag','prepend latencycancelreason');p.wire('lat-snapshot-5','lat-cancel-ui-tag');p.wire('lat-cancel-ui-tag','popup')
    p.obj('lat-diagnostic-tag','prepend latencydiagnostics')
    p.wire('lat-diagnostic-pack','lat-diagnostic-tag');p.wire('lat-diagnostic-tag','popup')
    p.obj('lat-result-store','f 0.',2,1);p.wire('lat-snapshot-1','lat-result-store',0,1)
    p.obj('lat-status-int','i',2,1);p.obj('lat-status-change','change -1',3,3)
    p.obj('lat-status-token-pak','pak 0 0',2,1)
    p.wire('lat-snapshot-4','lat-status-token-pak')
    p.wire('lat-request-trigger','lat-status-token-pak',1,1)
    p.obj('lat-status-token-unpack','unpack 0 0',1,2)
    p.obj('lat-status-token-expr','expr $i1 == $i2',2,1)
    p.wire('lat-status-token-pak','lat-status-token-unpack')
    p.wire('lat-status-token-unpack','lat-status-token-expr')
    p.wire('lat-status-token-unpack','lat-status-token-expr',1,1)
    p.obj('lat-status-token-gate','gate 1 1',2,1)
    p.wire('lat-status-token-expr','lat-status-token-gate')
    p.wire('lat-snapshot-0','lat-status-token-gate',0,1)
    p.wire('lat-status-token-gate','lat-status-int');p.wire('lat-status-int','lat-status-change')
    # Repeated blocked attempts still show their current reason, while an old
    # terminal packet cannot consume a newer request before DSP sees its token.
    p.msg('lat-status-reset','set -1');p.wire('lat-request-trigger','lat-status-reset',2)
    p.wire('lat-status-reset','lat-status-change')
    p.obj('lat-status-tag','prepend latencystatus');p.wire('lat-status-tag','popup')
    p.obj('lat-success','sel 3',1,2);p.wire('lat-status-change','lat-success')
    # A DSP estimate is not yet an applied compensation. Announce success only
    # after the current-token/host-guard check and the actual parameter write.
    p.wire('lat-success','lat-status-tag',1)
    p.obj('lat-accept-defer','deferlow');p.wire('lat-success','lat-accept-defer')
    p.obj('lat-accept-pak','pak 0 0 0 0 0. 0.',6,1)
    for source,outlet,inlet in [('lat-permit',0,0),('lat-pending-on',0,1),('lat-snapshot-4',0,2),('lat-request-trigger',1,3),('lat-snapshot-2',0,4),('lat-snapshot-1',0,5)]:
        p.wire(source,'lat-accept-pak',outlet,inlet)
    p.obj('lat-accept-unpack','unpack 0 0 0 0 0. 0.',1,6)
    conditions=[('$i1 <= 0',401),('$i2 <= 0',402),('($i3 != $i4) || ($i4 <= 0)',403),('$f5 < 0.85',404),('($f6 <= -398.) || ($f6 >= 398.)',405)]
    expr='400'
    for condition,code in reversed(conditions):expr=f'({condition}) * {code} + (!({condition})) * ({expr})'
    p.obj('lat-commit-reason-expr','expr '+expr,6,1)
    p.obj('lat-commit-reason-store','i 400',2,1)
    for i in range(6):p.wire('lat-accept-unpack','lat-commit-reason-expr',i,i)
    p.wire('lat-commit-reason-expr','lat-commit-reason-store',0,1)
    p.wire('lat-commit-reason-store','lat-cancel-ui-tag')
    p.obj('lat-accept-expr','expr ($i1 > 0) && ($i2 > 0) && ($i3 == $i4) && ($i4 > 0) && ($f5 >= 0.85) && ($f6 > -398.) && ($f6 < 398.)',6,1)
    p.wire('lat-accept-pak','lat-accept-unpack')
    for i in range(6):p.wire('lat-accept-unpack','lat-accept-expr',i,i)
    p.obj('lat-accept-gate','gate 1 0',2,1);p.wire('lat-accept-expr','lat-accept-gate')
    p.obj('lat-commit-check','i 0',2,1);p.wire('lat-accept-expr','lat-commit-check',0,1)
    p.wire('lat-accept-defer','lat-commit-check')
    p.obj('lat-commit-select','sel 0 1',1,3);p.wire('lat-commit-check','lat-commit-select')
    p.obj('lat-commit-failure','t b b',1,2);p.wire('lat-commit-select','lat-commit-failure');p.wire('lat-commit-failure','lat-commit-reason-store',1)
    p.msg('lat-commit-rejected','5');p.wire('lat-commit-failure','lat-commit-rejected');p.wire('lat-commit-rejected','lat-status-tag')
    p.wire('lat-commit-select','lat-accept-gate',1,1)
    p.obj('lat-accept-once','t b b b',1,3);p.wire('lat-accept-gate','lat-accept-once')
    p.msg('lat-pending-off','0');p.wire('lat-accept-once','lat-pending-off',2)
    p.obj('lat-terminal','sel 4 5 6',1,4);p.wire('lat-status-change','lat-terminal')
    for i in range(3):p.wire('lat-terminal','lat-pending-off',i)
    p.wire('lat-cancel-bang','lat-pending-off');p.wire('lat-pending-off','lat-accept-pak',0,1)
    p.wire('lat-accept-once','lat-result-store',1)
    p.msg('lat-commit-applied','3');p.wire('lat-accept-once','lat-commit-applied');p.wire('lat-commit-applied','lat-status-tag')
    p.obj('lat-offset-tag','prepend latencyoffset');p.wire('lat-result-store','lat-offset-tag');p.wire('lat-offset-tag','popup')
