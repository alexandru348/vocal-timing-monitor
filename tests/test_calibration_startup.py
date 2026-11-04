import re
import unittest
from max_event_model import Graph
from test_latency import result
from test_static import PATCH,boxmap,edges

class CalibrationStartupTests(unittest.TestCase):
    def test_observers_use_documented_argument_and_explicit_property_selection(self):
        b=boxmap(PATCH['patcher']);e=edges(PATCH['patcher'])
        for i,prop in enumerate(['record_mode','session_record','session_record_status']):
            self.assertEqual(b['lat-observe-'+str(i)]['text'],'live.observer '+prop)
            self.assertEqual(b['lat-property-'+str(i)]['text'],'property '+prop)
            self.assertIn((('lat-property-'+str(i),0),('lat-observe-'+str(i),0)),e)
            self.assertIn((('bind-id',0),('lat-observe-'+str(i),1)),e)
        self.assertIn((('lat-api-bound',0),('lat-requery-defer',0)),e)
        self.assertIn((('lat-requery-defer',0),('lat-requery-gate',1)),e)

    def test_no_property_selected_does_not_invent_a_recording_state(self):
        g=Graph();key='root/lat-observe-0'
        g.boxes[key]=dict(g.boxes[key],text='live.observer')
        g.send(key,('id',42),1);self.assertEqual(g.deferred,[])
        g.send(key,('property','record_mode'));self.assertEqual(g.deferred,[(key,(0,))])

    def test_safe_startup_confirms_all_host_properties_and_can_apply(self):
        g=Graph();g.initialize()
        self.assertEqual(g.state['root/lat-permit-pak']['values'],[1,0,1,1,1,1,0,0,0])
        g.click('calibrate');result(g,92.2)
        self.assertEqual(g.params['offsetms'],92.2)

    def test_unknown_recording_is_not_reported_as_stopped_playback(self):
        g=Graph();g.initialize();g.emit('root/lat-observe-0',(-1,))
        g.click('calibrate');result(g,0,status=6)
        label=' '.join(g.state['root/popup/calibration-help']['label'])
        self.assertIn('confirmarea stării REC',label)
        self.assertNotIn('Pornește redarea',label)
        self.assertEqual(g.params['offsetms'],0.)

    def test_repeat_refusal_uses_current_reason_even_when_status_code_is_unchanged(self):
        g=Graph();g.initialize();g.emit('root/lat-observe-0',(-1,))
        g.click('calibrate');result(g,0,status=6)
        g.emit('root/lat-observe-0',(0,));g.emit('root/lat-observe-1',(-1,))
        g.click('calibrate');result(g,0,status=6)
        self.assertIn('Session Record',' '.join(g.state['root/popup/calibration-help']['label']))

    def test_old_refused_packet_cannot_consume_new_request(self):
        g=Graph();g.initialize();g.click('calibrate')
        old=g.state['root/lat-request-counter']['value']
        g.click('calibrate');result(g,0,token=old,status=6)
        result(g,92.2,status=3)
        self.assertEqual(g.params['offsetms'],92.2)

    def test_help_text_is_literal_and_never_splits_message_or_sends_remotely(self):
        g=Graph();g.initialize();b=boxmap(boxmap(PATCH['patcher'])['popup']['patcher'])
        for id,item in b.items():
            if id.startswith(('lat-help-','lat-reason-')) and item['maxclass']=='message':
                self.assertIsNone(re.search(r'(?<!\\)[,;]',item['text']),id)
        g.send('root/popup/lat-help-4',('bang',))
        label=' '.join(g.state['root/popup/calibration-help']['label'])
        self.assertIn('valoarea existentă',label)
        self.assertIn('fără voce.',label)
        self.assertIn(';',label)
        g.send('root/popup/lat-help-6',('bang',))
        label=' '.join(g.state['root/popup/calibration-help']['label'])
        self.assertIn('cu REC și Oprire auto OFF',label)

if __name__=='__main__':unittest.main()
