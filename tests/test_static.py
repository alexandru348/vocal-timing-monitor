import copy
import importlib.util
import json
from pathlib import Path
import re
import struct
import unittest

ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location('vtm_build', ROOT / 'build.py')
build = importlib.util.module_from_spec(spec); spec.loader.exec_module(build)
PATCH = build.make_patch()


def walk(p, name='root'):
    yield name, p
    for wrapped in p['boxes']:
        b = wrapped['box']
        if 'patcher' in b:
            yield from walk(b['patcher'], name + '/' + b['id'])


def boxmap(p):
    return {b['box']['id']: b['box'] for b in p['boxes']}


def edges(p):
    return [(tuple(l['patchline']['source']), tuple(l['patchline']['destination'])) for l in p['lines']]


def chunk(data, pos, expected=None):
    tag = data[pos:pos+4]; size = struct.unpack_from('>I', data, pos+4)[0]
    if expected is not None:
        assert tag == expected, (tag, expected)
    assert size >= 8 and pos + size <= len(data)
    return tag, data[pos+8:pos+size], pos+size


class StaticTests(unittest.TestCase):
    def test_ids_and_all_connections(self):
        for name, p in walk(PATCH['patcher']):
            with self.subTest(patcher=name):
                boxes = boxmap(p)
                self.assertEqual(len(boxes), len(p['boxes']))
                connections = edges(p)
                self.assertEqual(len(connections), len(set(connections)), 'duplicate patchline')
                for src, dst in edges(p):
                    self.assertIn(src[0], boxes); self.assertIn(dst[0], boxes)
                    self.assertTrue(0 <= src[1] < boxes[src[0]]['numoutlets'], src)
                    self.assertTrue(0 <= dst[1] < boxes[dst[0]]['numinlets'], dst)

    def test_no_unescaped_message_separators_in_object_expressions(self):
        for _, p in walk(PATCH['patcher']):
            for b in boxmap(p).values():
                if b['maxclass'] == 'newobj':
                    self.assertNotRegex(b.get('text', ''), r'(?<!\\)[,;]')

    def test_no_external_runtime_dependencies(self):
        forbidden = re.compile(r'\b(js|jsui|v8|node.script|poly~|bpatcher|jweb|buffer~)\b')
        for _, p in walk(PATCH['patcher']):
            for b in boxmap(p).values():
                if b['maxclass'] == 'newobj':
                    self.assertIsNone(forbidden.search(b.get('text', '')))
                self.assertNotIn('filename', b)
        self.assertEqual(PATCH['patcher']['dependency_cache'], [])

    def test_audio_graph_and_silent_output(self):
        p = PATCH['patcher']; e = edges(p)
        self.assertIn((('plugin', 0), ('engine', 0)), e)
        self.assertIn((('plugin', 1), ('engine', 1)), e)
        self.assertIn((('phasor', 0), ('engine', 2)), e)
        self.assertEqual([s for s, d in e if d[0] == 'plugout'], [('silence', 0), ('silence', 0)])
        self.assertEqual(boxmap(p)['silence']['text'], 'sig~ 0')

    def test_analysis_is_parent_owned_and_popup_has_readonly_displays(self):
        p = PATCH['patcher']; b = boxmap(p)
        self.assertIn('engine', b); self.assertIn('qmetro', b)
        popup = b['popup']['patcher']
        # Only display gain may process a signal in this UI. The analysis
        # engine and host Stop executor remain in the always-running parent.
        self.assertEqual([x['text'] for x in boxmap(popup).values()
                          if '~' in x.get('text', '')], ['*~ 1.', '*~ 1.'])
        self.assertFalse(any(x.get('text') in ['gen~','live.object','plugout~'] for x in boxmap(popup).values()))
        self.assertIn((('pcontrol', 0), ('popup', 0)), edges(p))
        self.assertFalse(any(x.get('text', '').startswith(('mute', 'enable')) for x in boxmap(popup).values() if x['maxclass'] == 'message'))

    def test_documented_sync_contract(self):
        p = PATCH['patcher']; b = boxmap(p)
        self.assertEqual(b['phasor']['text'], 'plugphasor~')
        # One audio clock for analysis and native Stop safety; no separate Play flag.
        self.assertNotIn('hostsync', b)
        self.assertFalse(any(x.get('text') == 'plugsync~' for x in b.values()))
        self.assertNotIn('transport', [x.get('text') for x in b.values()])

    def test_initialized_native_live_api_and_deferred_stop(self):
        p = PATCH['patcher']; e = edges(p); b = boxmap(p)
        self.assertIn((('thisdevice', 0), ('ready-defer', 0)), e)
        self.assertIn((('live-path', 1), ('id-route', 0)), e)
        self.assertIn((('id-route', 0), ('path-trigger', 0)), e)
        self.assertIn((('bind-id', 0), ('stop-object', 1)), e)
        self.assertIn((('stop-object', 0), ('object-response', 0)), e)
        self.assertIn((('object-response', 0), ('ack-valid', 0)), e)
        self.assertEqual(b['path-trigger']['text'], 't b i i')
        self.assertIn((('stop-select', 0), ('stop-defer', 0)), e)
        self.assertIn((('stop-defer', 0), ('stop-finalize', 0)), e)
        self.assertIn((('stop-finalize', 1), ('stop-gate', 1)), e)
        self.assertIn((('stop-finalize', 0), ('disarm-ui', 0)), e)
        self.assertIn((('stop-gate', 0), ('stop-trigger', 0)), e)
        self.assertIn((('stop-trigger', 1), ('disarm-ui', 0)), e)
        self.assertIn((('stop-trigger', 0), ('stop-call', 0)), e)
        self.assertEqual(b['stop-call']['text'], 'call stop_playing')
        self.assertEqual(b['retry-gate']['text'], 'gate 1 0')

    def test_popup_defaults_and_action_buttons(self):
        u = boxmap(PATCH['patcher'])['popup']['patcher']; b = boxmap(u)
        self.assertEqual(b['initial-0']['text'], '1')  # analysis
        self.assertEqual(b['initial-1']['text'], '0')  # Auto Stop
        self.assertEqual(b['initial-2']['text'], '0')  # grid index 0=quarter
        self.assertEqual(b['initial-3']['text'], '100')
        for id in ['test', 'reset', 'calibrate']:
            self.assertEqual(b[id]['mode'], 1)
            self.assertEqual(b[id]['texton'], b[id]['text'])
        self.assertEqual(b['autostop']['parameter_enable'], 0)

    def test_ui_and_dsp_protocol_agree(self):
        p = PATCH['patcher']; u = boxmap(p)['popup']['patcher']
        params = set(re.findall(r'\bParam\s+(\w+)\(', (ROOT/'src/vtm_engine.genexpr').read_text()))
        expected = {'enabled', 'autostop', 'grid', 'redms', 'offsetms', 'gateamp', 'testseq', 'resetseq', 'apiready'}
        self.assertEqual(params, expected)
        for x in boxmap(p).values():
            if x.get('text', '').startswith('prepend ') and x['id'].endswith('-tag') and not x['id'].endswith('ui-tag'):
                tag = x['text'].split()[1]
                if x['id'] != 'api-ui-tag':
                    self.assertIn(tag, params)
        ui_tags = boxmap(u)['route']['text'].split()[1:]
        for x in boxmap(p).values():
            if x['id'].endswith('ui-tag'):
                self.assertIn(x['text'].split()[1], ui_tags)

    def test_embedded_gen_source_exact(self):
        p = boxmap(PATCH['patcher'])['engine']['patcher']
        code = boxmap(p)['code']
        self.assertEqual(code['code'], (ROOT/'src/vtm_engine.genexpr').read_text())
        self.assertEqual(code['numinlets'], 3); self.assertEqual(code['numoutlets'], 11)
        self.assertEqual(p['classnamespace'], 'dsp.gen')
        self.assertEqual(len([x for x in boxmap(p).values() if x.get('text', '').startswith('out ')]), 11)

    def test_amxd_container_roundtrip(self):
        data = build.amxd_bytes(PATCH, build.NAME + '.amxd')
        self.assertEqual(data[:4], b'ampf')
        self.assertEqual(struct.unpack_from('<I', data, 4)[0], 4)
        self.assertEqual(data[8:16], b'aaaameta')
        self.assertEqual(data[24:28], b'ptch')
        self.assertEqual(struct.unpack_from('<I', data, 28)[0], len(data)-32)
        col = data[32:]; self.assertEqual(col[:4], b'mx@c')
        offset = struct.unpack_from('>I', col, 12)[0]
        _, dirs, end = chunk(col, offset, b'dlst')
        self.assertEqual(end, len(col))
        _, entry, end = chunk(dirs, 0, b'dire'); self.assertEqual(end, len(dirs))
        pos = 0; fields = {}
        while pos < len(entry):
            tag, value, pos = chunk(entry, pos); fields[tag] = value
        self.assertEqual(fields[b'type'], b'JSON')
        self.assertEqual(fields[b'fnam'].rstrip(b'\0').decode(), build.NAME+'.amxd')
        size = struct.unpack('>I', fields[b'sz32'])[0]; off = struct.unpack('>I', fields[b'of32'])[0]
        self.assertEqual(off, 16); self.assertLessEqual(off+size, offset)
        self.assertEqual(json.loads(col[off:off+size]), PATCH)

    def test_presentation_bounds(self):
        for name, p in walk(PATCH['patcher']):
            if p['classnamespace'] == 'dsp.gen':
                continue
            width, height = p['rect'][2:]
            if name == 'root/popup':
                # The collapsed viewport is 340px; settings expand to 620px.
                height = 620
            for b in boxmap(p).values():
                if b.get('presentation'):
                    x, y, w, h = b['presentation_rect']
                    self.assertGreater(w, 0); self.assertGreater(h, 0)
                    self.assertTrue(x >= 0 and y >= 0 and x+w <= width and y+h <= height, (name, b['id']))

    def test_snapshot_validity_precedes_delta(self):
        p = PATCH['patcher']
        es = [(s[1], d[0]) for s, d in edges(p) if s[0] == 'snapshot-trigger']
        order = [name for outlet, name in sorted(es, reverse=True)]
        self.assertLess(order.index('snapshot-9'), order.index('snapshot-0'))

    def test_deterministic_build(self):
        self.assertEqual(build.amxd_bytes(PATCH, build.NAME+'.amxd'), build.amxd_bytes(build.make_patch(), build.NAME+'.amxd'))

    def test_fanout_order_is_explicit(self):
        for _, p in walk(PATCH['patcher']):
            if p['classnamespace'] != 'box':
                continue
            groups={}
            for wrapped in p['lines']:
                l=wrapped['patchline'];groups.setdefault(tuple(l['source']),[]).append(l)
            for lines in groups.values():
                if len(lines)>1:
                    self.assertEqual(sorted(l['order'] for l in lines),list(range(len(lines))))


if __name__ == '__main__':
    unittest.main()
