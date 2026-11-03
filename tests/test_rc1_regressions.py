"""Regression cases extracted from the RC1 errors observed in the user's Max.

These checks validate the corrected declaration forms and prevent the model
from silently accepting unsupported Max expr syntax. They are not a Max loader.
"""
import copy
from pathlib import Path
import re
import tempfile
import unittest
from unittest.mock import patch
import gen_harness
from max_event_model import Graph
from test_static import PATCH, walk, boxmap


class SyntaxRegressionTests(unittest.TestCase):
    def test_rejects_rc1_function_like_param_declaration(self):
        with tempfile.TemporaryDirectory() as d:
            f=Path(d)/'bad.genexpr'; f.write_text('Param(enabled, 1); out1 = enabled;')
            with patch.object(gen_harness,'SOURCE',f):
                with self.assertRaisesRegex(AssertionError,'Invalid Gen declaration'):
                    gen_harness.compile_harness()

    def test_rejects_rc1_function_like_history_declaration(self):
        with tempfile.TemporaryDirectory() as d:
            f=Path(d)/'bad.genexpr'; f.write_text('History(prevphase, 0); out1 = prevphase;')
            with patch.object(gen_harness,'SOURCE',f):
                with self.assertRaisesRegex(AssertionError,'Invalid Gen declaration'):
                    gen_harness.compile_harness()

    def test_all_gen_declarations_have_named_declaration_syntax(self):
        src=gen_harness.SOURCE.read_text()
        src=re.sub(r'//[^\n]*','',src)
        lines=[s.strip() for s in src.splitlines() if re.match(r'\s*(Param|History)\b',s)]
        self.assertEqual(len(lines),39)
        for line in lines:
            self.assertRegex(line,r'^(Param|History) [a-zA-Z_]\w*\([-+\d.eE]+\);$')

    def test_native_max_expr_has_no_c_ternary(self):
        for _,p in walk(PATCH['patcher']):
            for b in boxmap(p).values():
                if b.get('text','').startswith('expr '):
                    self.assertNotIn('?',b['text'])
                    self.assertNotIn(':',b['text'])

    def test_message_model_rejects_actual_rc1_expr(self):
        g=Graph()
        # Detach only this object: model fixtures must not mutate the patch.
        id='root/popup/grid-map'; g.boxes[id]=copy.deepcopy(g.boxes[id])
        g.boxes[id]['text']='expr ($i1 == 0) ? 4 : (($i1 == 1) ? 8 : 16)'
        with self.assertRaisesRegex(AssertionError,'Max expr'):
            g.send(id,(0,))

    def test_grid_values_via_actual_generated_arithmetic(self):
        g=Graph();g.initialize()
        for i,denom in enumerate([4,8,16]):
            g.send('root/popup/grid-ui',(i,))
            self.assertEqual(g.params['grid'],denom)

    def test_level_floor_and_log_receive_zero_safely(self):
        g=Graph();g.initialize()
        for level,expected in [(0,-100.),(.000001,-100.),(.1,-20.),(1.,0.)]:
            g.send('root/popup',('level',level))
            label=g.state['root/popup/level-text']['label'][0]
            self.assertEqual(label,'Nivel: %.1f dB'%expected)


if __name__=='__main__':unittest.main()
