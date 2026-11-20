"""Actual generated source graph under explicit Live/dictionary stubs.

No native Max parsing, audio routing, file dialog or hardware is executed.
"""
from collections import defaultdict
import json
import re
import struct
import unittest
from assistant_sources import make_source_patch, FIELDS, NAME
import build
from test_assistant_preflight import PreflightGraph
from test_static import PATCH, boxmap, edges, walk, chunk
from test_latency import result
from preflight_harness import Preflight


class SourceGraph(PreflightGraph):
    def __init__(self):
        super().__init__()
        self.boxes = {}
        self.wires = defaultdict(list)
        self._flatten(make_source_patch()['patcher'], 'root')
        self.dictionaries = {}
        # Live's native readbacks wrap the value in its property name.
        # Flat-only stubs previously hid the native integration failure.
        self.wrap_properties = True
        self.parent_class = 'Track'
        self.metadata = {
            201: dict(input_routing_type={'identifier': 'external', 'display_name': 'Ext. In'},
                      input_routing_channel={'identifier': 'input12', 'display_name': '1/2'}),
            202: dict(routing_type={'identifier': 'track-input', 'display_name': 'Pista curentă'},
                      routing_channel={'identifier': 'stereo', 'display_name': 'Stereo'}),
            203: dict(routing_type={'identifier': 'ref42', 'display_name': 'Instrumental'},
                      routing_channel={'identifier': 'post-mixer', 'display_name': 'Post Mixer'}),
        }

    def send(self, id, msg=('bang',), inlet=0):
        msg = tuple(msg)
        box = self.boxes[id]
        text = box.get('text', '')
        words = text.split()
        op = words[0] if words else ''
        if op == 'prepend' and words[1:2] == ['replace']:
            self.emit(id, tuple(words[1:])+msg)
            return
        if id.startswith('root/asrc-') and op == 'live.path':
            if msg[0] == 'path':
                number = 201 if 'canonical_parent' in msg else 202 if msg[-1] == 0 else 203
                self.emit(id, ('id', number), 1)
            return
        if id.startswith('root/asrc-') and op == 'live.object':
            if inlet == 1:
                self.state[id]['id'] = msg[1]
            elif msg[0] == 'gettype':
                number = self.state[id].get('id', 0)
                if number:
                    self.emit(id, ('type', self.parent_class if number == 201 else 'DeviceIO'))
            return
        if id.startswith('root/asrc-') and op == 'live.observer':
            state = self.state[id]
            if inlet == 1: state['id'] = msg[1]
            elif msg[0] == 'property': state['property'] = msg[1]
            number, prop = state.get('id', 0), state.get('property')
            if number and prop and self.auto_api_readback:
                payload = self.metadata.get(number, {}).get(prop)
                if payload is not None:
                    if self.wrap_properties:
                        payload = {prop: payload}
                    self.deferred.append((id, (json.dumps(payload, ensure_ascii=False),)))
            return
        if op == 'dict.deserialize':
            try:
                parsed = json.loads(' '.join(map(str, msg)))
            except (ValueError, TypeError):
                return  # Native parse failure yields no new verified facts.
            name = 'synthetic-dictionary-'+str(len(self.dictionaries))
            self.dictionaries[name] = parsed
            self.emit(id, ('dictionary', name))
            return
        if op == 'dict.unpack':
            payload = self.dictionaries.get(msg[1], {}) if msg[0] == 'dictionary' else {}
            keys = [word[:-1] for word in words[1:] if word.endswith(':')]
            for index in reversed(range(len(keys))):
                if keys[index] in payload:
                    value = payload[keys[index]]
                    if isinstance(value, dict):
                        name = 'synthetic-dictionary-'+str(len(self.dictionaries))
                        self.dictionaries[name] = value
                        self.emit(id, ('dictionary', name), index)
                    else:
                        self.emit(id, (value,), index)
            return
        if op == 'dict':
            state = self.state[id]
            if msg[0] == 'replace': state.setdefault('data', {})[msg[1]] = msg[2:]
            elif msg[0] == 'export': state['export_requested'] = True
            return
        super().send(id, msg, inlet)

    def initialized(self):
        self.initialize()
        self.emit('root/wave-samplerate', (44100.,), 1)
        self.emit('root/wave-samplerate', (64,), 2)
        self.emit('root/wave-samplerate', (256,), 3)
        self.send('root/asrc-popup/mode', (1,))
        self.drain()
        return self


class SourceAdapterTests(unittest.TestCase):
    def test_report_includes_clock_telemetry_and_host_readbacks(self):
        g = SourceGraph().initialized()
        values = dict(sampleclock=44100., synced=1., periodms=600., detectpermit=1.,
                      inputpresent=1., referencepresent=1., clipping=0., appliedoffsetms=83., epoch=3.)
        for name, value in values.items():
            g.emit('root/apf-'+name, (value,))
        g.emit('root/lat-observe-3', (1,))
        g.emit('root/apf-count-observer', (0,))
        data = g.state['root/asrc-report']['data']
        for name, value in values.items():
            self.assertEqual(data['preflight_'+name], (value,))
        self.assertEqual(data['host_playing'], (1,))
        self.assertEqual(data['host_countingin'], (0,))
        self.assertFalse(g.calls)

    def test_wrapped_native_dictionary_with_numeric_identifiers(self):
        g = SourceGraph().initialized()
        for key, prop, bus, _ in FIELDS:
            with self.subTest(field=key):
                payload = {prop: {'identifier': 42, 'display_name': 'Sursă de test'}}
                g.dictionaries['native-wrapped'] = payload
                observer = 'root/asrc-'+bus+'-observer-'+str(0 if key.endswith('type') else 1)
                g.emit(observer, ('dictionary', 'native-wrapped'))
                self.assertEqual(g.state['root/asrc-report']['data'][key+'_identifier'], ('42',))
                self.assertEqual(g.state['root/asrc-popup/'+key]['label'], ('Sursă de test',))

    def test_flat_readbacks_are_still_supported(self):
        g = SourceGraph()
        g.wrap_properties = False
        g.initialized()
        self.assertEqual(g.preflight_params['voicebinding'], 1)
        self.assertEqual(g.state['root/asrc-report']['data']['reference_type_identifier'], ('ref42',))

    def test_readback_completeness_is_separate_from_user_declaration(self):
        g = SourceGraph()
        g.initialize()
        data = g.state['root/asrc-report']['data']
        self.assertEqual(data['path_readbacks_complete'], (1,))
        self.assertEqual(data['declared_path_ready'], (0,))
        self.assertEqual(g.preflight_params['sourcemode'], 0)

    def test_wrong_wrapper_and_missing_nested_identifier_stay_unconfirmed(self):
        for payload in ({'wrong_property': {'identifier': 42, 'display_name': 'Test'}},
                        {'routing_type': {'display_name': 'Test'}}):
            g = SourceGraph().initialized()
            g.emit('root/asrc-reference-observer-0', (json.dumps(payload),))
            self.assertEqual(g.preflight_params['referencebinding'], 0)

    def test_observed_identifiers_are_distinct_from_display_names(self):
        g = SourceGraph().initialized()
        data = g.state['root/asrc-report']['data']
        self.assertEqual(data['track_type_identifier'], ('external',))
        self.assertEqual(data['reference_channel_identifier'], ('post-mixer',))
        self.assertEqual(g.state['root/asrc-popup/reference_channel']['label'], ('Post Mixer',))
        self.assertEqual(g.preflight_params['voicebinding'], 1)
        self.assertEqual(g.preflight_params['referencebinding'], 1)
        self.assertEqual(g.preflight_params['sourcemode'], 1)
        self.assertNotIn('quality', g.preflight_params)

    def test_source_mode_is_never_inferred_from_names_or_levels(self):
        g = SourceGraph()
        g.initialize()
        self.assertEqual(g.preflight_params['sourcemode'], 0)
        g.emit('root/input-peak', (.9,))
        g.emit('root/beat-peak', (.9,))
        self.assertEqual(g.preflight_params['sourcemode'], 0)
        self.assertEqual(g.preflight_params['voicebinding'], 0)

    def test_json_and_native_dictionary_callbacks_both_parse(self):
        g = SourceGraph().initialized()
        payload = {'identifier': 'ref43', 'display_name': 'Alt instrumental'}
        g.dictionaries['native-test'] = payload
        g.emit('root/asrc-reference-observer-0', ('dictionary', 'native-test'))
        self.assertEqual(g.state['root/asrc-report']['data']['reference_type_identifier'], ('ref43',))
        self.assertEqual(g.preflight_params['sourcemode'], 0)

    def test_missing_identifier_and_malformed_data_remain_unconfirmed(self):
        for payload in ('not JSON', json.dumps({'display_name': 'Voce'})):
            g = SourceGraph().initialized()
            g.emit('root/asrc-reference-observer-0', (payload,))
            self.assertEqual(g.preflight_params['referencebinding'], 0)
            self.assertEqual(g.preflight_params['voicebinding'], 0)

    def test_rack_parent_does_not_get_track_only_property_queries(self):
        g = SourceGraph()
        g.parent_class = 'Chain'
        g.initialized()
        for index in (0, 1):
            state = g.state['root/asrc-track-observer-'+str(index)]
            self.assertEqual(state.get('id', 0), 0)
        self.assertEqual(g.preflight_params['voicebinding'], 0)

    def test_mode_and_profile_revoke_when_any_observed_path_fact_changes(self):
        for source, msg, outlet in [
            ('root/asrc-track-observer-1', (json.dumps({'identifier': 'input3', 'display_name': '3'}),), 0),
            ('root/asrc-main-observer-0', (json.dumps({'identifier': 'other', 'display_name': 'Altă sursă'}),), 0),
            ('root/wave-samplerate', (48000.,), 1),
            ('root/wave-samplerate', (512,), 3),
        ]:
            g = SourceGraph().initialized()
            g.emit(source, msg, outlet)
            self.assertEqual(g.preflight_params['sourcemode'], 0)
            self.assertEqual(g.preflight_params['calibrationvalid'], 0)
            self.assertEqual(g.state['root/asrc-popup/mode']['value'], 0)

    def test_duplicate_readback_preserves_declaration(self):
        g = SourceGraph().initialized()
        payload = g.metadata[203]['routing_channel']
        g.emit('root/asrc-reference-observer-1', (json.dumps(payload),))
        self.assertEqual(g.preflight_params['sourcemode'], 1)
        self.assertEqual(g.preflight_params['voicebinding'], 1)

    def test_calibration_binds_only_after_a_success_on_the_declared_live_path(self):
        g = SourceGraph().initialized()
        g.click('calibrate')
        result(g, 83.)
        self.assertEqual(g.preflight_params['calibrationvalid'], 1)
        self.assertEqual(g.preflight_params['calibratedrevision'], g.preflight_params['audiorevision'])
        self.assertEqual(g.params['offsetms'], 83.)

    def test_incomplete_sources_at_request_cannot_be_promoted_afterward(self):
        g = SourceGraph().initialized()
        g.send('root/asrc-popup/mode', (0,))
        g.click('calibrate')
        g.send('root/asrc-popup/mode', (1,))
        result(g, 83.)
        self.assertEqual(g.preflight_params['calibrationvalid'], 0)

    def test_change_away_and_back_during_calibration_rejects_original_scope(self):
        g = SourceGraph().initialized()
        g.click('calibrate')
        g.send('root/asrc-popup/mode', (2,))
        g.send('root/asrc-popup/mode', (1,))
        result(g, 83.)
        self.assertEqual(g.preflight_params['calibrationvalid'], 0)
        self.assertEqual(g.params['offsetms'], 0.)

    def test_profile_does_not_rearm_on_a_control_echo_without_a_commit(self):
        g = SourceGraph().initialized()
        g.click('calibrate'); result(g, 83.)
        self.assertEqual(g.preflight_params['calibrationvalid'], 1)
        g.emit('root/audio-lost')
        self.assertEqual(g.preflight_params['calibrationvalid'], 0)
        g.send('root/asrc-popup/mode', (1,))
        self.assertEqual(g.preflight_params['calibrationvalid'], 0)

    def test_manual_offset_edit_and_dsp_stop_revoke_session_profile(self):
        for source, msg, outlet in [('root/control-route', (100.,), 5),
                                    ('root/wave-samplerate', (0,), 0)]:
            g = SourceGraph().initialized()
            g.click('calibrate'); result(g, 83.)
            g.emit(source, msg, outlet)
            self.assertEqual(g.preflight_params['calibrationvalid'], 0)

    def test_recorded_mode_never_reuses_microphone_timing_implicitly(self):
        g = SourceGraph().initialized()
        g.send('root/asrc-popup/mode', (2,))
        self.assertEqual(g.preflight_params['sourcemode'], 2)
        self.assertEqual(g.preflight_params['timingpolicy'], 0)
        g.click('calibrate'); result(g, 83.)
        self.assertEqual(g.preflight_params['calibrationvalid'], 0)

    def test_report_export_is_explicit_and_does_not_start_recording_or_stop(self):
        g = SourceGraph().initialized()
        self.assertNotIn('export_requested', g.state['root/asrc-report'])
        g.send('root/asrc-popup/export', (1,))
        self.assertTrue(g.state['root/asrc-report']['export_requested'])
        self.assertFalse(g.calls)

    def test_fresh_instance_does_not_trust_previous_unfingerprinted_value(self):
        g = SourceGraph()
        g.initialize({'VTM Compensation ms': 83.})
        self.assertEqual(g.params['offsetms'], 83.)
        self.assertEqual(g.preflight_params['calibrationvalid'], 0)

    def test_collected_context_never_claims_voice_quality_from_metadata(self):
        g = SourceGraph().initialized()
        g.click('calibrate'); result(g, 83.)
        engine = Preflight(**g.preflight_params)
        out = engine.signal()
        self.assertEqual(out[-1, 0], 11)
        self.assertEqual(out[-1, 2], 0)

    def test_actual_api_rebinding_queries_sources_again_without_manual_refresh(self):
        g = SourceGraph().initialized()
        g.emit('root/api-clear', (0,))
        g.emit('root/api-valid', (1,))
        g.drain()
        self.assertEqual(g.state['root/asrc-all-fields']['values'], [1]*6)
        self.assertEqual(g.preflight_params['sourcemode'], 0)

    def test_diagnostic_theme_follows_existing_choice(self):
        g = SourceGraph().initialized()
        g.click('theme')
        self.assertIn('bgcolor', g.state['root/asrc-popup/window']['commands'][0])
        self.assertFalse(g.calls)


class SourceStructureTests(unittest.TestCase):
    def test_full_graph_connections_unique_and_in_bounds(self):
        for name, patch in walk(make_source_patch()['patcher']):
            boxes = boxmap(patch)
            self.assertEqual(len(boxes), len(patch['boxes']), name)
            connections = edges(patch)
            self.assertEqual(len(connections), len(set(connections)))
            for src, dst in connections:
                self.assertIn(src[0], boxes); self.assertIn(dst[0], boxes)
                self.assertTrue(0 <= src[1] < boxes[src[0]]['numoutlets'])
                self.assertTrue(0 <= dst[1] < boxes[dst[0]]['numinlets'])
            if name in ('root', 'root/asrc-popup'):
                width, height = (360, 169) if name == 'root' else (640, 510)
                for box in boxes.values():
                    if box.get('presentation'):
                        x, y, w, h = box['presentation_rect']
                        self.assertTrue(x >= 0 and y >= 0 and x+w <= width and y+h <= height)

    def test_existing_monitor_and_stored_parameter_identities_are_unchanged(self):
        patch = make_source_patch()['patcher']
        self.assertEqual(boxmap(patch)['popup'], boxmap(PATCH['patcher'])['popup'])
        self.assertEqual(patch['parameters'], PATCH['patcher']['parameters'])
        self.assertEqual([src for src, dst in edges(patch) if dst[0] == 'plugout'],
                         [('silence', 0), ('silence', 0)])

    def test_source_queries_never_set_live_properties_or_change_routing(self):
        patch = make_source_patch()['patcher']
        boxes = boxmap(patch)
        for id, box in boxes.items():
            if not id.startswith('asrc-'): continue
            text = box.get('text', '')
            self.assertFalse(text.startswith(('set ', 'call ', 'live.routing')),
                             (id, text))
        for src, dst in edges(patch):
            if src[0].startswith('asrc-'):
                self.assertNotIn(dst[0], ('stop-call', 'stop-defer', 'stop-object', 'beat-router'))

    def test_diagnostic_collective_roundtrips_without_external_dependencies(self):
        patch = make_source_patch()
        data = build.amxd_bytes(patch, NAME+'.amxd')
        self.assertEqual(data[:4], b'ampf')
        self.assertEqual(struct.unpack_from('<I', data, 28)[0], len(data)-32)
        collective = data[32:]
        offset = struct.unpack_from('>I', collective, 12)[0]
        _, directory, _ = chunk(collective, offset, b'dlst')
        _, entry, _ = chunk(directory, 0, b'dire')
        fields = {}
        pos = 0
        while pos < len(entry):
            tag, value, pos = chunk(entry, pos)
            fields[tag] = value
        self.assertEqual(fields[b'fnam'].rstrip(b'\0').decode(), NAME+'.amxd')
        start = struct.unpack('>I', fields[b'of32'])[0]
        size = struct.unpack('>I', fields[b'sz32'])[0]
        self.assertEqual(json.loads(collective[start:start+size]), patch)
        self.assertEqual(patch['patcher']['dependency_cache'], [])
        for _, nested in walk(patch['patcher']):
            for box in boxmap(nested).values():
                self.assertNotIn('filename', box)
                self.assertIsNone(re.search(r'\b(js|jsui|v8|node.script|bpatcher|jweb)\b', box.get('text', '')))


if __name__ == '__main__':
    unittest.main()
