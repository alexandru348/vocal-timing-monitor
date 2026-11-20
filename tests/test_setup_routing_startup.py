"""Startup from No Input with explicit asynchronous router/observer stubs.

Executes the generated graph, not native Max loading or Ableton routing.
"""
from copy import deepcopy
import json
import unittest
from test_preconfigured_setup import TestSetupGraph
from test_persistence import commands
from test_latency import result


class RoutingStartupGraph(TestSetupGraph):
    def __init__(self, sources=('No Input', 'Other', 'Test Reference Beat')):
        super().__init__(matching=True)
        self.sources = sources
        self.source_index = sources.index('No Input')
        self.channel_index = 0
        self.set_reference('No Input', '')

    def set_reference(self, source, channel):
        self.metadata[203] = dict(
            routing_type=dict(identifier='source-'+source, display_name=source),
            routing_channel=dict(identifier='channel-'+channel, display_name=channel))

    def emit(self, id, msg=('bang',), outlet=0):
        if id == '__routing_event__':
            return super().emit('root/beat-router', msg[1:], int(msg[0]))
        return super().emit(id, msg, outlet)

    def send(self, id, msg=('bang',), inlet=0):
        super().send(id, msg, inlet)
        if id != 'root/beat-router': return
        msg = tuple(msg)
        source = self.sources[self.source_index]
        channels = ('',) if source == 'No Input' else ('Pre FX', 'Post FX', 'Post Mixer')
        if msg[0] == 'type':
            self.source_index = int(msg[1]); self.channel_index = 0
            source = self.sources[self.source_index]
            channels = ('',) if source == 'No Input' else ('Pre FX', 'Post FX', 'Post Mixer')
        elif msg[0] == 'channel':
            self.channel_index = int(msg[1])
            assert self.channel_index < len(channels), 'selected a stale channel index'
        elif msg[0] != 'index': return
        self.set_reference(source, channels[self.channel_index])
        # A router reply updates menus, then observers report the real route.
        # This deliberately never starts with the requested source selected.
        for outlet, values in ((0, (self.source_index,)), (1, (self.channel_index,)),
                               (2, self.sources), (3, channels)):
            self.deferred.append(('__routing_event__', (outlet,)+values))
        for i, prop in enumerate(('routing_type', 'routing_channel')):
            payload = {prop: deepcopy(self.metadata[203][prop])}
            self.deferred.append(('root/asrc-reference-observer-'+str(i),
                                  (json.dumps(payload),)))


class RoutingStartupTests(unittest.TestCase):
    def test_first_load_from_no_input_selects_route_then_calibrates(self):
        g = RoutingStartupGraph().start()
        self.assertEqual(commands(g), [('type', 2), ('channel', 2)])
        data = g.state['root/asrc-report']['data']
        self.assertEqual(data['test_setup_ready'], (1,))
        self.assertEqual(g.metadata[203]['routing_type']['display_name'], 'Test Reference Beat')
        self.assertEqual(g.metadata[203]['routing_channel']['display_name'], 'Post Mixer')
        self.assertEqual(g.preflight_params['calibrationvalid'], 0)
        g.emit('root/beat-peak', (.1,)); g.advance_audio(1100)
        self.assertGreater(g.state['root/lat-request-counter'].get('value', 0), 0)
        result(g, 91.1)
        self.assertEqual(g.preflight_params['calibrationvalid'], 1)
        self.assertEqual(g.clarity_params['profilevalid'], 1)
        self.assertFalse(g.calls)

    def test_reordered_sources_are_resolved_by_name(self):
        g = RoutingStartupGraph(('Test Reference Beat', 'No Input', 'Other')).start()
        self.assertEqual(commands(g), [('type', 0), ('channel', 2)])
        self.assertEqual(g.state['root/asrc-report']['data']['test_setup_ready'], (1,))

    def test_saved_different_source_overrides_packaged_default(self):
        g = RoutingStartupGraph().start({'VTM Instrumental type': ('symbol', 'vtm Other'),
                                        'VTM Instrumental channel': ('symbol', 'vtm Post FX')})
        self.assertEqual(commands(g), [('type', 1), ('channel', 1)])
        self.assertEqual(g.state['root/asrc-report']['data']['test_setup_ready'], (0,))
        g.emit('root/beat-peak', (.1,)); g.advance_audio(2000)
        self.assertNotIn('value', g.state['root/lat-request-counter'])

    def test_missing_or_prefix_only_instrumental_leaves_no_input(self):
        g = RoutingStartupGraph(('No Input', 'Test Reference Beat remix')).start()
        self.assertFalse(any(c[0] == 'type' for c in commands(g)))
        self.assertEqual(g.metadata[203]['routing_type']['display_name'], 'No Input')
        self.assertEqual(g.preflight_params['calibrationvalid'], 0)
        self.assertEqual(g.state['root/asrc-report']['data']['test_setup_ready'], (0,))

    def test_report_traces_targets_available_options_and_commands(self):
        g = RoutingStartupGraph().start()
        data = g.state['root/asrc-report']['data']
        self.assertEqual(data['test_setup_type_target'], ('vtm Test Reference Beat',))
        self.assertEqual(data['test_setup_channel_target'], ('vtm Post Mixer',))
        self.assertEqual(data['test_setup_type_options'], g.sources)
        self.assertEqual(data['test_setup_channel_options'], ('Pre FX', 'Post FX', 'Post Mixer'))
        self.assertEqual(data['test_setup_type_command'], (2,))
        self.assertEqual(data['test_setup_channel_command'], (2,))

    def test_old_restore_only_packaging_reproduces_missing_route_in_model(self):
        g = RoutingStartupGraph()
        for kind in ('type', 'channel'):
            # Copy attributes: don't mutate the builder or any other instance.
            box = g.boxes['root/popup/persist-'+kind]
            attrs = box['saved_attribute_attributes']['valueof']
            attrs.pop('parameter_initial_enable'); attrs.pop('parameter_initial')
        g.start()
        self.assertFalse(any(c[0] == 'type' for c in commands(g)))
        self.assertEqual(g.state['root/asrc-report']['data']['test_setup_ready'], (0,))
        self.assertEqual(g.preflight_params['calibrationvalid'], 0)

    def test_refreshes_do_not_repeat_route_commands_or_overwrite_manual_choice(self):
        g = RoutingStartupGraph().start()
        before = list(commands(g))
        for _ in range(5):
            g.send('root/beat-router', ('index', 1)); g.drain()
        self.assertEqual(commands(g), before)
        g.send('root/popup/beat-type', (0,)); g.drain()
        self.assertEqual(g.metadata[203]['routing_type']['display_name'], 'No Input')
        self.assertEqual(commands(g)[-1], ('type', 0))
        self.assertEqual(g.state['root/asrc-report']['data']['test_setup_ready'], (0,))
        self.assertEqual(g.preflight_params['calibrationvalid'], 0)


if __name__ == '__main__': unittest.main()
