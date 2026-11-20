"""Reject lexical defects before hoisted arithmetic can mask native errors."""
from pathlib import Path
from types import SimpleNamespace
import unittest
from unittest.mock import patch
import assistant_clarity
from genexpr_scope import validate_scope, ScopeError

FIXTURES = Path(__file__).with_name('fixtures')


def codeboxes(graph):
    for wrapped in graph['boxes']:
        b=wrapped['box']
        if b['maxclass']=='codebox':yield b
        if 'patcher' in b:yield from codeboxes(b['patcher'])


def frozen_main_code(version='0215'):
    return (FIXTURES / f'assistant_{version}_main.genexpr').read_text(encoding='utf-8')


class GenExprScopeTests(unittest.TestCase):
    def test_native_0215_failure_is_reproduced_on_the_exact_frozen_codebox(self):
        with self.assertRaisesRegex(ScopeError,'jexceed0 is not defined'):
            validate_scope(frozen_main_code(),inputs=7,outputs=127)

    def test_both_current_analysis_codeboxes_pass_scope_validation(self):
        for result in (False,True):
            for b in codeboxes(assistant_clarity.gen_graph(result=result)):
                validate_scope(b['code'],inputs=b['numinlets'],outputs=b['numoutlets'])

    def test_loop_local_value_cannot_be_read_after_its_loop(self):
        with self.assertRaisesRegex(ScopeError,'count is not defined'):
            validate_scope('for (i=0;i<3;i=i+1) { count=0; count=count+1; } out1=count;',inputs=0,outputs=1)

    def test_outer_definition_survives_nested_updates_and_subsequent_read(self):
        validate_scope('count=0; for (i=0;i<3;i=i+1) { count=0; for (k=0;k<2;k=k+1) { count=count+1; } } out1=count;',inputs=0,outputs=1)

    def test_branch_and_sibling_block_locals_cannot_escape(self):
        for code in ('if (in1>0) { x=1; } out1=x;',
                     'if (in1>0) { x=1; } else { out1=x; }'):
            with self.assertRaisesRegex(ScopeError,'x is not defined'):
                validate_scope(code,inputs=1,outputs=1)

    def test_assignment_does_not_hide_an_undefined_rhs_or_self_reference(self):
        for code in ('x=x+1; out1=x;','x=missing; out1=x;'):
            with self.assertRaises(ScopeError):validate_scope(code,inputs=0,outputs=1)

    def test_assignment_cannot_shadow_gen_pi_constant(self):
        for name in ('pi', 'PI'):
            with self.subTest(name=name), self.assertRaisesRegex(ScopeError, 'built-in'):
                validate_scope(f'{name}=1; out1={name};', inputs=0, outputs=1)

    def test_declared_histories_comments_numbers_and_nested_conditions_are_supported(self):
        validate_scope('''// Unknown names and braces } here are comments.
History sum(0); Data values(256); Param gain(1);
x=1e-12; /* if (missing) { } */
if (in1>0) { sum=sum+gain; } else if (in1<0) { sum=0; } else { x=2; }
poke(values,x,0); out1=sum+peek(values,0);
''',inputs=1,outputs=1)
        with self.assertRaisesRegex(ScopeError,'Unsupported'):
            validate_scope('out1 = [1];',inputs=0,outputs=1)

    def test_generator_refuses_the_failed_source_before_it_can_be_packaged(self):
        failed=SimpleNamespace(read_text=lambda:frozen_main_code())
        with patch.object(assistant_clarity,'SOURCE',failed):
            with self.assertRaisesRegex(ScopeError,'jexceed0 is not defined'):
                assistant_clarity.make_clarity_patch()

    def test_scope_fix_adds_only_the_enclosing_definitions_to_the_dsp_source(self):
        added='''        // GenExpr locals belong to their defining block. These counters are
        // also read AFTER the loops, so define them in that enclosing block.
        jexceed0 = 0; jexceed1 = 0; jexceed2 = 0;
'''
        corrected=frozen_main_code('0216')
        self.assertEqual(corrected.count(added),1)
        self.assertEqual(corrected.replace(added,'',1),frozen_main_code())


if __name__=='__main__':unittest.main()
