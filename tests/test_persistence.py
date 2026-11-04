"""RC3 graph/host-stub checks. These do NOT run Live's native serializer."""
import unittest
from max_event_model import Graph, parameter_enabled
from test_static import PATCH, boxmap

PREFIX='root/popup/'


def routing_saved(source='Reference Drums', channel='Post Mixer'):
    return {'VTM Instrumental type':('vtm '+source,),
            'VTM Instrumental channel':('vtm '+channel,)}


def choices(g, sources=('No Input','Reference Drums'), channels=('Pre FX','Post FX','Post Mixer')):
    g.emit('root/beat-router',sources,2)
    g.emit('root/beat-router',channels,3)


def commands(g):
    return [c for c in g.state['root/beat-router']['commands'] if c[0] in ['type','channel']]


class PersistenceTests(unittest.TestCase):
    def test_all_nine_saved_parameters_are_registered_stored_only(self):
        root=PATCH['patcher']; ui=boxmap(boxmap(root)['popup']['patcher'])
        registry={k:v for k,v in root['parameters'].items() if k!='inherited_shortname'}
        self.assertEqual(len(registry),10)
        for path,value in registry.items():
            b=ui[path.split('::')[1]]; a=b['saved_attribute_attributes']['valueof']
            self.assertEqual(parameter_enabled(b),1)
            self.assertEqual(a['parameter_invisible'],1)  # Stored Only
            self.assertEqual(value[:2],[a['parameter_longname']]*2)
            self.assertTrue(b['varname'].startswith('vtm_'))
        self.assertEqual(len({b['varname'] for b in ui.values() if parameter_enabled(b)}),10)

    def test_pattr_blob_attributes_use_native_wrapped_object_serialization(self):
        # Regression from the actual RC3 .als: the top-level flag + text
        # attribute produced default exposed Float parameters, both at zero.
        ui=boxmap(boxmap(PATCH['patcher'])['popup']['patcher'])
        for kind in ['type','channel']:
            b=ui['persist-'+kind]
            self.assertNotIn('@parameter_enable',b['text'])
            self.assertNotIn('parameter_enable',b)
            self.assertEqual(b['saved_object_attributes'],
                             {'parameter_enable':1,'parameter_mappable':0})
            attrs=b['saved_attribute_attributes']['valueof']
            self.assertEqual(attrs['parameter_type'],3)
            self.assertEqual(attrs['parameter_invisible'],1)
            self.assertEqual(attrs['parameter_linknames'],0)
            self.assertNotIn('parameter_initial_enable',attrs)
            self.assertEqual(b['restore'],['__vtm_unset__'])

    def test_fresh_defaults_and_actions_are_not_persisted(self):
        g=Graph();g.initialize()
        self.assertEqual(g.params['enabled'],1)
        self.assertEqual(g.params['redms'],100)
        self.assertEqual(g.params['offsetms'],0)
        self.assertAlmostEqual(g.params['gateamp'],10**(-32/20))
        ui=boxmap(boxmap(PATCH['patcher'])['popup']['patcher'])
        for name in ['autostop','reset','calibrate','test','settings','beat-refresh']:
            self.assertFalse(ui[name].get('parameter_enable'),name)
        self.assertFalse(g.calls)

    def test_modified_values_survive_simulated_save_reopen(self):
        g=Graph();g.initialize()
        changed={'enabled':0,'grid-ui':2,'redms':300,'offsetms':92.2,
                 'gatedb':-14.,'voice-gain':2.5,'beat-gain':4.}
        for id,value in changed.items():g.send(PREFIX+id,(value,))
        reopened=Graph();reopened.initialize(g.saved_parameters())
        for id,value in changed.items():self.assertEqual(reopened.state[PREFIX+id]['value'],value,id)
        for param,value in [('enabled',0),('grid',16),('redms',300),('offsetms',92.2)]:
            self.assertEqual(reopened.params[param],value)
        self.assertAlmostEqual(reopened.params['gateamp'],10**(-14/20))
        self.assertIn((1,(2.5,)),reopened.state[PREFIX+'voice-magnify']['controls'])
        self.assertFalse(reopened.calls)

    def test_analysis_off_replay_reads_even_silent_host_restore(self):
        g=Graph();g.restore_parameters({})
        # Some host operations may update a UI without an outlet message.
        g.send(PREFIX+'enabled',('set',0))
        g.emit('root/thisdevice');g.drain()
        self.assertEqual(g.params['enabled'],0)
        self.assertEqual(g.state[PREFIX+'enabled']['value'],0)

    def test_repeated_ready_bangs_preserve_saved_controls_and_disarm_stop(self):
        g=Graph();g.initialize({'VTM Compensation ms':92.2,'VTM Analysis':0})
        for _ in range(3):
            g.click('autostop');g.emit('root/thisdevice');g.drain()
            self.assertEqual(g.params['offsetms'],92.2)
            self.assertEqual(g.params['enabled'],0)
            self.assertEqual(g.params['autostop'],0)
        self.assertFalse(g.calls)

    def test_save_with_auto_stop_armed_does_not_rearm_after_reopen(self):
        g=Graph();g.initialize();g.click('autostop')
        self.assertEqual(g.params['autostop'],1)
        saved=g.saved_parameters()
        self.assertFalse(any('stop' in name.lower() for name in saved))
        fresh=Graph();fresh.initialize(saved)
        self.assertEqual(fresh.params['autostop'],0)
        fresh.emit('root/snapshot-2',(1,));fresh.drain();fresh.advance(200);fresh.drain()
        self.assertFalse(fresh.calls)

    def test_instances_keep_separate_values(self):
        a=Graph();a.initialize({'VTM Compensation ms':92.2,'VTM Detection dB':-14})
        b=Graph();b.initialize({'VTM Compensation ms':-21.5,'VTM Detection dB':-26})
        b.send(PREFIX+'offsetms',(12.,))
        self.assertEqual(a.saved_parameters()['VTM Compensation ms'],92.2)
        self.assertEqual(b.saved_parameters()['VTM Compensation ms'],12.)
        self.assertNotEqual(a.params['gateamp'],b.params['gateamp'])

    def test_calibration_updates_the_persistent_compensation(self):
        g=Graph();g.initialize()
        g.click('calibrate')
        token=g.state['root/lat-request-counter']['value']
        g.emit('root/lat-snapshot-1',(92.2,));g.emit('root/lat-snapshot-2',(.97,))
        g.emit('root/lat-snapshot-4',(token,));g.emit('root/lat-snapshot-0',(3,));g.drain()
        self.assertEqual(g.saved_parameters()['VTM Compensation ms'],92.2)

    def test_routing_capture_uses_confirmed_labels_not_menu_indices(self):
        g=Graph();g.initialize();choices(g);g.drain()
        g.send(PREFIX+'beat-type',(1,))
        g.emit('root/beat-router',(1,),0)
        g.emit('root/beat-router',(2,),1)
        saved=g.saved_parameters()
        self.assertEqual(saved['VTM Instrumental type'],('symbol','vtm Reference Drums'))
        self.assertEqual(saved['VTM Instrumental channel'],('symbol','vtm Post Mixer'))

    def test_actual_host_index_two_is_resolved_to_names_not_saved_as_vtm_two(self):
        g=Graph();g.initialize()
        choices(g,('No Input','Ext. In','Reference Drums'))
        g.drain();g.send(PREFIX+'beat-type',(2,))
        g.emit('root/beat-router',(2,),0);g.emit('root/beat-router',(2,),1)
        saved=g.saved_parameters()
        self.assertEqual(saved['VTM Instrumental type'],('symbol','vtm Reference Drums'))
        self.assertEqual(saved['VTM Instrumental channel'],('symbol','vtm Post Mixer'))
        self.assertNotEqual(saved['VTM Instrumental type'],('symbol','vtm 2'))

    def test_captured_native_indices_roundtrip_with_reordered_options(self):
        g=Graph();g.initialize();choices(g);g.drain()
        g.send(PREFIX+'beat-type',(1,))
        g.emit('root/beat-router',(1,),0);g.emit('root/beat-router',(2,),1)
        restored=Graph();restored.initialize(g.saved_parameters())
        choices(restored,('Reference Drums','No Input'),('Post Mixer','Pre FX','Post FX'))
        restored.drain()
        self.assertEqual(commands(restored),[('type',0),('channel',0)])

    def test_feedback_before_lists_preserves_index_and_recaptures_resolved_label(self):
        g=Graph();g.initialize();g.send(PREFIX+'beat-type',(2,))
        g.emit('root/beat-router',(2,),0);g.emit('root/beat-router',(2,),1)
        choices(g,('No Input','Ext. In','Reference Drums'));g.drain()
        for menu in ['beat-type','beat-channel']:
            self.assertEqual(g.state[PREFIX+menu]['value'],2)
        self.assertEqual(g.saved_parameters()['VTM Instrumental type'],('symbol','vtm Reference Drums'))
        self.assertEqual(g.saved_parameters()['VTM Instrumental channel'],('symbol','vtm Post Mixer'))
        self.assertEqual(commands(g),[('type',2)])

    def test_confirmed_index_feedback_updates_display_without_sending_a_command(self):
        g=Graph();g.initialize();choices(g);g.drain()
        before=list(commands(g));g.emit('root/beat-router',(1,),0)
        g.emit('root/beat-router',(2,),1)
        self.assertEqual(g.state[PREFIX+'beat-type']['value'],1)
        self.assertEqual(g.state[PREFIX+'beat-channel']['value'],2)
        self.assertEqual(commands(g),before)

    def test_invalid_confirmed_index_does_not_replace_a_valid_saved_name(self):
        g=Graph();g.initialize();choices(g);g.drain()
        g.send(PREFIX+'beat-type',(1,));g.emit('root/beat-router',(1,),0)
        g.emit('root/beat-router',(-1,),0)
        self.assertEqual(g.saved_parameters()['VTM Instrumental type'],('symbol','vtm Reference Drums'))

    def test_startup_feedback_cannot_overwrite_desired_source(self):
        saved=routing_saved();g=Graph();g.initialize(saved)
        g.emit('root/beat-router',(0,),0)
        g.emit('root/beat-router',(0,),1)
        self.assertEqual(g.saved_parameters()['VTM Instrumental type'],saved['VTM Instrumental type'])
        self.assertEqual(g.saved_parameters()['VTM Instrumental channel'],saved['VTM Instrumental channel'])

    def test_reordered_choices_restore_exact_source_and_channel(self):
        g=Graph();g.initialize(routing_saved())
        choices(g,('Reference Drums remix','No Input','Reference Drums'),('Post Mixer','Pre FX'))
        g.drain()
        self.assertEqual(commands(g),[('type',2),('channel',0)])

    def test_actual_rc3_2_saved_symbol_messages_replay_to_named_lookup(self):
        g=Graph();g.initialize({'VTM Instrumental type':('symbol','vtm Reference Drums'),
                               'VTM Instrumental channel':('symbol','vtm Post Mixer')})
        choices(g);g.drain()
        self.assertEqual(commands(g),[('type',1),('channel',2)])

    def test_unknown_and_prefix_only_source_do_not_select_unrelated_track(self):
        for saved in [{},routing_saved('Reference Drums deleted')]:
            g=Graph();g.initialize(saved);choices(g);g.drain()
            self.assertFalse([c for c in commands(g) if c[0]=='type'])

    def test_late_source_list_retries_and_channel_is_reapplied_after_type(self):
        g=Graph();g.initialize(routing_saved())
        choices(g,('No Input',));g.drain()
        self.assertNotIn(('type',1),commands(g))
        choices(g);g.drain()
        self.assertEqual(commands(g)[-2:],[('type',1),('channel',2)])

    def test_repeated_router_lists_do_not_reissue_routing_commands(self):
        g=Graph();g.initialize(routing_saved());choices(g);g.drain()
        before=list(commands(g))
        for _ in range(20):choices(g);g.drain()
        self.assertEqual(commands(g),before)

    def test_manual_selection_cancels_pending_restore(self):
        g=Graph();g.initialize(routing_saved());choices(g)
        g.send(PREFIX+'beat-type',(0,))
        g.emit('root/beat-router',(0,),0)
        g.drain()
        self.assertEqual(commands(g),[('type',0)])
        self.assertEqual(g.saved_parameters()['VTM Instrumental type'],('symbol','vtm No Input'))

    def test_ready_again_restores_route_even_when_index_is_unchanged(self):
        g=Graph();g.initialize(routing_saved());choices(g);g.drain()
        g.emit('root/thisdevice');g.drain();choices(g);g.drain()
        self.assertEqual(commands(g),[('type',1),('channel',2)]*2)

    def test_routing_state_has_no_global_file_or_persisted_live_id(self):
        ui=boxmap(boxmap(PATCH['patcher'])['popup']['patcher'])
        for kind in ['type','channel']:
            self.assertEqual(ui['persist-'+kind+'-map']['text'],'coll @embed 0')
            attrs=ui['persist-'+kind]['saved_attribute_attributes']['valueof']
            self.assertEqual(attrs['parameter_type'],3)
        self.assertNotIn('pattrstorage',str(ui))
        self.assertEqual(len(Graph().saved_parameters()),10)


if __name__=='__main__':unittest.main()
