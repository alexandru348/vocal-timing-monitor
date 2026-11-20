"""Native graph simulation of preconfigured test copies, not a Live host test."""
from collections import defaultdict
from copy import deepcopy
import unittest
from assistant_clarity import make_clarity_patch
from assistant_calibration_profile import KEY_SIZE, LABEL_FIELDS, PROFILE_NAME, verified_record
from assistant_test_setup import load_test_setup
from test_assistant_clarity import ClarityGraph
from test_persistence import choices, commands
from test_static import boxmap, edges, walk
from test_latency import result


class TestSetupGraph(ClarityGraph):
    def __init__(self, matching=True, calibration_report=None):
        super().__init__()
        self.boxes={};self.wires=defaultdict(list)
        self._flatten(make_clarity_patch(test_setup=load_test_setup(),
                                         calibration_report=calibration_report)['patcher'],'root')
        if matching:
            self.metadata[202]['routing_type']['display_name']='No Input'
            self.metadata[203]['routing_type']['display_name']='Test Reference Beat'

    def start(self, saved=None, io_vector=64):
        self.initialize(saved)
        for outlet,value in ((1,44100.),(2,64),(3,io_vector)):
            self.emit('root/wave-samplerate',(value,),outlet)
        self.drain()
        return self

    def advance_audio(self, milliseconds):
        # The native DSP heartbeat keeps running while the scheduler waits.
        # A silent stub would expire at 250 ms and correctly cancel the test.
        for i in range(milliseconds//100):
            self.audio_clock=getattr(self,'audio_clock',4410)+4410
            self.emit('root/heartbeat-snapshot',(self.audio_clock,))
            self.advance(100);self.drain()


class PreconfiguredSetupTests(unittest.TestCase):
    def test_exact_instrumental_and_post_mixer_defaults_restore_against_current_lists(self):
        g=TestSetupGraph().start()
        choices(g,('No Input','Other','Test Reference Beat'),('Post FX','Post Mixer','Pre FX'))
        g.drain()
        self.assertEqual(commands(g),[('type',2),('channel',1)])
        self.assertEqual(g.saved_parameters()['VTM Instrumental type'],('vtm Test Reference Beat',))

    def test_missing_named_instrumental_never_falls_back_to_a_different_track(self):
        g=TestSetupGraph(matching=False).start()
        choices(g,('No Input','Other'),('Post FX','Post Mixer'))
        g.drain()
        self.assertFalse(any(c[0]=='type' for c in commands(g)))
        self.assertEqual(g.preflight_params['sourcemode'],0)
        g.emit('root/beat-peak',(.1,));g.advance_audio(2000)
        self.assertNotIn('value',g.state['root/lat-request-counter'])

    def test_live_mode_and_visible_menu_are_set_without_a_user_click(self):
        g=TestSetupGraph().start()
        self.assertEqual(g.preflight_params['sourcemode'],1)
        self.assertEqual(g.state['root/asrc-popup/mode']['value'],1)
        self.assertEqual(g.state['root/asrc-report']['data']['test_setup_ready'],(1,))
        self.assertFalse(g.calls)

    def test_missing_or_different_external_input_does_not_invent_live_confirmation(self):
        for field,value in (('input_routing_type','Resampling'),('input_routing_channel','1')):
            g=TestSetupGraph()
            g.metadata[201][field]['display_name']=value
            g.start()
            self.assertEqual(g.preflight_params['sourcemode'],0)
            self.assertEqual(g.state['root/asrc-report']['data']['test_setup_ready'],(0,))

    def test_latest_measured_value_is_retained_but_its_validity_is_not_forged(self):
        g=TestSetupGraph().start()
        self.assertAlmostEqual(g.params['offsetms'],91.25)
        self.assertEqual(g.preflight_params['calibrationvalid'],0)
        self.assertEqual(g.clarity_params['profilevalid'],0)
        self.assertEqual(g.state['root/ac-state']['values'][1],0)
        self.assertEqual(g.params['autostop'],0)

    def test_automatic_calibration_launches_and_binds_current_path_without_menu_actions(self):
        g=TestSetupGraph().start()
        g.emit('root/beat-peak',(.1,));g.advance_audio(1100)
        self.assertGreater(g.state['root/lat-request-counter'].get('value',0),0)
        result(g,91.1)
        self.assertEqual(g.preflight_params['calibrationvalid'],1)
        self.assertEqual(g.clarity_params['profilevalid'],1)
        self.assertAlmostEqual(g.params['offsetms'],91.1)
        self.assertFalse(g.calls)

    def test_reuses_measured_offset_on_the_same_route_without_instrumental_peak(self):
        first = TestSetupGraph().start()
        first.emit('root/beat-peak', (.1,))
        first.advance_audio(1100)
        result(first, 91.7)
        saved = first.saved_parameters()
        self.assertEqual(len(saved[PROFILE_NAME]), KEY_SIZE+1)
        self.assertEqual(saved[PROFILE_NAME][-1], 91.7)
        self.assertEqual(first.state['root/asrc-report']['data']['calibration_origin'], ('measured',))
        reused = TestSetupGraph().start(saved)
        self.assertEqual(reused.preflight_params['calibrationvalid'], 1)
        self.assertEqual(reused.preflight_params['calibratedrevision'], reused.preflight_params['audiorevision'])
        self.assertAlmostEqual(reused.params['offsetms'], 91.7)
        self.assertNotIn('value', reused.state['root/lat-request-counter'])
        self.assertEqual(reused.state['root/asrc-report']['data']['calibration_origin'], ('saved',))

        changed = TestSetupGraph().start(saved, io_vector=128)
        self.assertEqual(changed.preflight_params['calibrationvalid'], 0)
        self.assertEqual(changed.state['root/asrc-report']['data']['calibration_origin'], ('pending',))
        changed.emit('root/beat-peak', (.1,))
        changed.advance_audio(1100)
        self.assertEqual(changed.state['root/lat-request-counter']['value'], 1)
        result(changed, 94.)
        self.assertEqual(changed.saved_parameters()[PROFILE_NAME][-1], 94.)

    def test_seed_from_completed_report_uses_matching_facts_and_rejects_other_routes(self):
        g = TestSetupGraph().start()
        setup = load_test_setup()
        config = [44100., 64, 64]
        report = dict(observed_path=list(g.state['root/asrc-report']['data']['observed_path']),
                      audio_config_sr_signal_io=config, path_readbacks_complete=1,
                      session_profile_valid=1, calibration_status=3,
                      calibration_manual_requests=1, preflight_appliedoffsetms=91.23)
        for field in LABEL_FIELDS:
            report['raw_'+field] = {'route': {'display_name': setup['observed_labels'][field]}}
        seeded = TestSetupGraph(calibration_report=report).start()
        self.assertEqual(seeded.preflight_params['calibrationvalid'], 1)
        self.assertAlmostEqual(seeded.params['offsetms'], 91.23)
        self.assertNotIn('value', seeded.state['root/lat-request-counter'])
        mismatch = TestSetupGraph(calibration_report=report).start(io_vector=128)
        self.assertEqual(mismatch.preflight_params['calibrationvalid'], 0)
        off = TestSetupGraph(calibration_report=report).start({'VTM Automatic calibration': 0})
        self.assertEqual(off.preflight_params['calibrationvalid'], 0)
        report['calibration_status'] = 0
        with self.assertRaises(ValueError):
            verified_record(report, setup)

    def test_automatic_calibration_retries_after_a_failed_capture_during_playback(self):
        g = TestSetupGraph().start()
        g.emit('root/beat-peak', (.1,))
        g.advance_audio(1100)
        result(g, 0., status=4)
        g.advance_audio(2900)
        self.assertEqual(g.state['root/lat-request-counter']['value'], 1)
        g.advance_audio(1200)
        self.assertEqual(g.state['root/lat-request-counter']['value'], 2)
        result(g, 91.3)
        g.advance_audio(5000)
        self.assertEqual(g.state['root/lat-request-counter']['value'], 2)
        self.assertAlmostEqual(g.params['offsetms'], 91.3)
        self.assertEqual(g.preflight_params['calibrationvalid'], 1)
        g.send('root/asrc-popup/export', (1,))
        report = g.state['root/aq-export-dict']['data']
        self.assertEqual(report['calibration_automatic_requests'], (2,))
        self.assertEqual(report['calibration_manual_requests'], (0,))
        self.assertEqual(report['calibration_status'], (3,))

    def test_automatic_retry_is_bounded_and_waits_for_permitted_signal(self):
        g = TestSetupGraph().start()
        g.emit('root/beat-peak', (.1,))
        g.advance_audio(1100)
        result(g, 0., status=6)
        g.emit('root/lat-observe-0', (1,))
        g.advance_audio(5000)
        self.assertEqual(g.state['root/lat-request-counter']['value'], 1)
        g.emit('root/lat-observe-0', (0,))
        for expected in (2, 3):
            g.advance_audio(4100)
            self.assertEqual(g.state['root/lat-request-counter']['value'], expected)
            result(g, 0., status=4)
        g.advance_audio(6000)
        self.assertEqual(g.state['root/lat-request-counter']['value'], 3)
        self.assertEqual(g.preflight_params['calibrationvalid'], 0)

    def test_manual_calibration_cancels_retry_and_does_not_rearm_on_failure(self):
        g = TestSetupGraph().start()
        g.emit('root/beat-peak', (.1,))
        g.advance_audio(1100)
        result(g, 0., status=4)
        g.click('calibrate')
        result(g, 0., status=4)
        g.advance_audio(5000)
        self.assertEqual(g.state['root/lat-request-counter']['value'], 2)
        report = g.state['root/asrc-report']['data']
        self.assertEqual(report['calibration_automatic_requests'], (1,))
        self.assertEqual(report['calibration_manual_requests'], (1,))

    def test_recording_and_auto_stop_still_prevent_automatic_calibration(self):
        for field,value in (('lat-observe-0',1),('lat-observe-1',1),('lat-observe-3',0)):
            g=TestSetupGraph().start()
            g.emit('root/'+field,(value,))
            g.emit('root/beat-peak',(.1,));g.advance_audio(2000)
            self.assertNotIn('value',g.state['root/lat-request-counter'])
        g=TestSetupGraph().start();g.toggle_stop_at_idle_poll()
        g.emit('root/beat-peak',(.1,));g.advance_audio(2000)
        self.assertNotIn('value',g.state['root/lat-request-counter'])

    def test_saved_user_values_override_packaged_preferences_on_set_reopen(self):
        g=TestSetupGraph().start({'VTM Voice zoom':2.,'VTM Analysis':0,'VTM Compensation ms':88.})
        self.assertEqual(g.params['enabled'],0)
        self.assertEqual(g.params['offsetms'],88.)
        self.assertEqual(g.state['root/popup/voice-gain']['value'],2.)
        self.assertEqual(g.params['autostop'],0)

    def test_source_change_invalidates_profile_and_returning_to_it_recalls_measurement(self):
        g=TestSetupGraph().start()
        g.emit('root/beat-peak',(.1,));g.advance_audio(1100);result(g,91.1)
        changed=deepcopy(g.metadata[203]['routing_type'])
        changed.update(identifier='different',display_name='Other')
        import json
        g.emit('root/asrc-reference-observer-0',(json.dumps({'routing_type':changed}),))
        self.assertEqual(g.preflight_params['sourcemode'],0)
        self.assertEqual(g.clarity_params['profilevalid'],0)
        self.assertEqual(g.state['root/ac-state']['values'][1],0)
        self.assertEqual(g.state['root/ac-state']['values'][6],0)
        g.emit('root/asrc-reference-observer-0',(json.dumps({'routing_type':g.metadata[203]['routing_type']}),))
        g.drain()
        self.assertEqual(g.preflight_params['sourcemode'],1)
        self.assertEqual(g.clarity_params['profilevalid'],1)
        self.assertAlmostEqual(g.params['offsetms'],91.1)
        self.assertEqual(g.state['root/lat-request-counter']['value'],1)
        self.assertEqual(g.state['root/asrc-report']['data']['calibration_origin'],('saved',))

    def test_deferred_mode_selection_discards_a_request_if_sources_change_again(self):
        import json
        g=TestSetupGraph().start()
        original=g.metadata[203]['routing_type']
        different=dict(original,identifier='different',display_name='Other')
        for payload in (different,original,different):
            g.emit('root/asrc-reference-observer-0',(json.dumps({'routing_type':payload}),))
        g.drain()
        self.assertEqual(g.preflight_params['sourcemode'],0)
        self.assertEqual(g.state['root/asrc-report']['data']['test_setup_ready'],(0,))

    def test_generic_diagnostic_generation_is_unchanged_and_preset_has_no_live_ids(self):
        generic=make_clarity_patch()['patcher']
        preset=make_clarity_patch(test_setup=load_test_setup())['patcher']
        before=boxmap(boxmap(generic)['popup']['patcher'])
        after=boxmap(boxmap(preset)['popup']['patcher'])
        self.assertEqual(before['persist-type']['restore'],['__vtm_unset__'])
        self.assertEqual(after['persist-type']['restore'],['vtm Test Reference Beat'])
        for kind,label in (('type','Test Reference Beat'),('channel','Post Mixer')):
            attrs=after['persist-'+kind]['saved_attribute_attributes']['valueof']
            self.assertEqual(attrs['parameter_type'],3)
            self.assertEqual(attrs['parameter_initial_enable'],1)
            self.assertEqual(attrs['parameter_initial'],['vtm '+label])
            self.assertNotIn('parameter_initial_enable',before['persist-'+kind]['saved_attribute_attributes']['valueof'])
        self.assertEqual(generic['parameters'],preset['parameters'])
        for path,graph in walk(preset):
            boxes=boxmap(graph)
            self.assertEqual(len(boxes),len(graph['boxes']))
            self.assertEqual(len(edges(graph)),len(set(edges(graph))))
            for src,dst in edges(graph):
                self.assertLess(src[1],boxes[src[0]]['numoutlets'])
                self.assertLess(dst[1],boxes[dst[0]]['numinlets'])
            for id,box in boxes.items():
                if id.startswith('test-'):
                    self.assertNotIn('live.object',box.get('text',''))
                    self.assertNotIn('id 5',box.get('text',''))


if __name__=='__main__':unittest.main()
