"""First-use scheduler only: existing estimator and all its guards are retained.

Default ON, saved with the Set. Valid saved compensation (including conclusive
zero) is reused. Nonzero legacy/manual compensation is recognized. At most one
attempt per playback; failures preserve values. No voice/grid-based learning.
"""


def apply_automatic_popup(u, parameter_attributes):
    b={w['box']['id']:w['box'] for w in u.p['boxes']}
    u.box('ac-valid','number',ins=1,outs=2,minimum=0,maximum=1,
          parameter_enable=1,parameter_mappable=0,varname='vtm_calibration_valid',
          saved_attribute_attributes=parameter_attributes('VTM Compensation valid',0,1,0,1,14))
    selectors=b['route']['text'].split()[1:]
    b['route']['text']+=' autocalvalid';b['route']['numoutlets']+=1
    u.wire('route','ac-valid',len(selectors))
    xs=[w['box']['patching_rect'][0] for w in u.p['boxes'] if w['box'].get('text')=='outlet']
    u.obj('ac-out','outlet',1,0,rect=[max(xs)+240,20,25,25])
    for id,tag,var in [('auto-calibrate','autocalenabled','vtm_auto_calibrate'),
                       ('ac-valid','autocalvalid','vtm_calibration_valid')]:
        name='ac-'+tag
        u.obj(name,'prepend '+tag);u.wire(id,name);u.wire(name,'ac-out')
        u.obj(name+'-replay','pattr @bindto '+var+' @thru 0 @autorestore 0',3,3,
              saved_object_attributes=dict(parameter_enable=0))
        u.obj(name+'-defer','deferlow');u.wire('initialize',name+'-defer')
        u.wire(name+'-defer',name+'-replay');u.wire(name+'-replay',name)
    help='Redă instrumentalul fără voce. REC și Oprire auto trebuie să fie OFF.'
    b['lat-help-0']['text']='set '+help.replace(',','\\,')
    b['calibration-help']['text']=help


def apply_automatic_parent(p):
    next(w['box'] for w in p.p['boxes'] if w['box']['id']=='popup')['numoutlets']=4
    for id,name in [('auto-calibrate','VTM Automatic calibration'),('ac-valid','VTM Compensation valid')]:
        p.p['parameters']['popup::'+id]=[name,name,0]
    p.obj('ac-control','route autocalenabled autocalvalid',1,3);p.wire('popup','ac-control',3)
    # preference / saved validity / native permit / digital peak / pending / attempted
    p.obj('ac-state','pak 1 0 0 0. 0 0',6,1)
    p.wire('ac-control','ac-state');p.wire('ac-control','ac-state',1,1)
    p.wire('lat-permit','ac-state',0,2);p.wire('beat-peak','ac-state',0,3)
    p.wire('lat-pending-on','ac-state',0,4);p.wire('lat-pending-off','ac-state',0,4)
    p.obj('ac-unpack','unpack 0 0 0 0. 0 0',1,6)
    p.obj('ac-eligible','expr ($i1 > 0) && ($i2 == 0) && ($i3 > 0) && ($f4 > 0.001) && ($i5 == 0) && ($i6 == 0)',6,1)
    p.wire('ac-state','ac-unpack')
    for i in range(6):p.wire('ac-unpack','ac-eligible',i,i)
    p.obj('ac-change','change -1',3,3);p.obj('ac-select','sel 0 1',1,3)
    p.wire('ac-eligible','ac-change');p.wire('ac-change','ac-select')
    p.obj('ac-delay','delay 1000',2,1);p.msg('ac-delay-cancel','stop')
    p.wire('ac-select','ac-delay-cancel');p.wire('ac-delay-cancel','ac-delay')
    p.wire('ac-select','ac-delay',1)
    p.obj('ac-launch-gate','gate 1 0',2,1)
    p.wire('ac-eligible','ac-launch-gate');p.wire('ac-delay','ac-launch-gate',0,1)
    p.obj('ac-launch','t b b b',1,3);p.wire('ac-launch-gate','ac-launch')
    p.msg('ac-attempted','1');p.msg('ac-retry','0')
    p.wire('ac-attempted','ac-state',0,5);p.wire('ac-retry','ac-state',0,5)
    p.wire('ac-launch','ac-attempted',2)
    p.msg('ac-active','1');p.msg('ac-inactive','0')
    p.obj('ac-cancel-active','gate 1 0',2,1)
    p.wire('ac-active','ac-cancel-active');p.wire('ac-inactive','ac-cancel-active')
    p.wire('ac-launch','ac-active',1);p.wire('ac-launch','lat-request-counter')
    # Disabling automatic mode cancels only its own request, not manual work.
    p.obj('ac-preference-change','change -1',3,3);p.obj('ac-preference-off','sel 0',1,2)
    p.wire('ac-control','ac-preference-change');p.wire('ac-preference-change','ac-retry')
    p.wire('ac-preference-change','ac-preference-off');p.wire('ac-preference-off','ac-cancel-active',0,1)
    p.msg('ac-cancel-code','19');p.wire('ac-cancel-active','ac-cancel-code')
    p.wire('ac-cancel-code','lat-cancel-bang');p.wire('ac-cancel-active','ac-inactive')
    p.wire('lat-commit-applied','ac-inactive')
    for i in range(3):p.wire('lat-terminal','ac-inactive',i)
    p.obj('ac-play-stopped','sel 0',1,2);p.wire('as-play-change','ac-play-stopped')
    p.wire('ac-play-stopped','ac-retry')
    p.obj('ac-manual','t b b',1,2);p.wire('popup','ac-manual',2)
    p.wire('ac-manual','ac-inactive',1);p.wire('ac-manual','ac-attempted')
    # Mark conclusive zeros as valid too. Nonzero legacy/manual values are reused.
    p.msg('ac-mark-valid','autocalvalid 1');p.wire('lat-commit-applied','ac-mark-valid')
    p.wire('ac-mark-valid','popup')
    p.obj('ac-nonzero','expr ($f1 < -0.000001) || ($f1 > 0.000001)')
    p.obj('ac-manual-valid','sel 1',1,2);p.wire('control-route','ac-nonzero',5)
    p.wire('ac-nonzero','ac-manual-valid');p.wire('ac-manual-valid','ac-mark-valid')


def add_diagnostic_calibration_retries(p):
    """Give the diagnostic up to three automatic requests per playback/context."""
    p.obj('ac-attempt-count', 'i 0', 2, 1)
    p.obj('ac-increment-attempt', '+ 1', 2, 1)
    p.obj('ac-retry-available', 'expr $i1 < 3', 1, 1)
    p.wire('ac-launch', 'ac-attempt-count', 2)
    p.wire('ac-attempt-count', 'ac-increment-attempt')
    p.wire('ac-increment-attempt', 'ac-attempt-count', 0, 1)
    p.wire('ac-increment-attempt', 'ac-retry-available')
    p.wire('ac-retry', 'ac-attempt-count', 0, 1)
    p.wire('ac-retry', 'ac-retry-available')

    # A terminal event may rearm only a measurement started by the automatic
    # scheduler. Read its ownership before clearing it for the next request.
    p.obj('ac-failure', 't b b', 1, 2)
    for wrapped in p.p['lines']:
        line = wrapped['patchline']
        if line['source'][0] == 'lat-terminal' and line['destination'] == ['ac-inactive', 0]:
            line['destination'] = ['ac-failure', 0]
    p.wire('ac-failure', 'ac-inactive')
    p.obj('ac-failure-owner', 'gate 1 0', 2, 1)
    p.wire('ac-active', 'ac-failure-owner')
    p.wire('ac-inactive', 'ac-failure-owner')
    p.wire('ac-failure', 'ac-failure-owner', 1, 1)
    p.obj('ac-failure-budget', 'gate 1 0', 2, 1)
    p.wire('ac-failure-owner', 'ac-failure-budget', 0, 1)
    p.wire('ac-retry-available', 'ac-failure-budget')
    p.obj('ac-retry-delay', 'delay 3000', 2, 1)
    p.wire('ac-failure-budget', 'ac-retry-delay')
    p.msg('ac-rearm', '0')
    p.wire('ac-retry-delay', 'ac-rearm')
    p.wire('ac-rearm', 'ac-state', 0, 5)
    p.msg('ac-stop-retry', 'stop')
    for source, outlet in (('ac-retry', 0), ('ac-manual', 1), ('lat-commit-applied', 0)):
        p.wire(source, 'ac-stop-retry', outlet)
    p.wire('ac-stop-retry', 'ac-retry-delay')

    for kind, source, outlet in (('automatic', 'ac-launch', 0), ('manual', 'ac-manual', 0)):
        count = 'ac-'+kind+'-requests'
        p.obj(count, 'counter 1 1000000000', 5, 4)
        p.wire(source, count, outlet)
        p.obj(count+'-store', 'i 0', 2, 1)
        p.wire(count, count+'-store')
        p.wire('aq-export-capture', count+'-store', 7)
    for key, source, outlet in (
            ('automatic_requests', 'ac-automatic-requests-store', 0),
            ('manual_requests', 'ac-manual-requests-store', 0),
            ('automatic_enabled', 'ac-control', 0),
            ('status', 'lat-status-tag', 0),
            ('reason', 'lat-snapshot-5', 0)):
        node = 'ac-report-'+key
        if key == 'status':
            p.obj('ac-report-status-route', 'route latencystatus', 1, 2)
            p.wire(source, 'ac-report-status-route', outlet)
            source = 'ac-report-status-route'
        p.obj(node, 'prepend replace calibration_'+key)
        p.wire(source, node, outlet)
        p.wire(node, 'asrc-report')
