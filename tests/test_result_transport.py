"""Deployed port wiring and export integrity, including the native 0.2.13 failure pattern."""
import json
from pathlib import Path
import unittest
import numpy as np
from assistant_clarity import make_clarity_patch, OUTPUTS, RESULT_FIELDS
from test_static import boxmap, edges, walk
from test_assistant_clarity import ClarityGraph, column
from test_completed_signal_result import complete


def port_violations(patch):
    found=[]
    for path, graph in walk(patch):
        for b in boxmap(graph).values():
            if path.startswith('root/aq-') or b['id'].startswith('aq-'):
                if b['numoutlets'] > 127 or b['numinlets'] > 64:
                    found.append((path,b['id']))
                if b.get('text','').startswith('t ') and b['numoutlets'] > 32:
                    found.append((path,b['id']))
    return found


class ResultTransportTests(unittest.TestCase):
    def test_previous_frozen_package_exceeds_the_new_port_budget(self):
        old = Path(__file__).with_name('fixtures') / 'assistant_0213_ports.json'
        violations = port_violations(json.loads(old.read_text(encoding='utf-8')))
        self.assertIn(('root','aq-engine'),violations)
        self.assertIn(('root','aq-diagnostic-poll'),violations)

    def test_all_current_codeboxes_engines_and_triggers_respect_port_budgets(self):
        self.assertFalse(port_violations(make_clarity_patch()['patcher']))

    def test_heavy_audio_analysis_is_single_and_keeper_only_receives_telemetry(self):
        p=make_clarity_patch()['patcher']; b=boxmap(p)
        self.assertEqual(b['aq-engine']['numoutlets'],127)
        self.assertEqual(b['aq-result-engine']['numoutlets'],118)
        self.assertEqual(b['aq-result-engine']['numinlets'],54)
        origins=[s for s,d in edges(p) if d[0]=='aq-result-engine']
        self.assertEqual(len(origins),54)
        self.assertEqual({s[0] for s in origins},{'aq-engine','apf-engine'})
        self.assertEqual([s for s in origins if s[0]=='apf-engine'],[('apf-engine',11)])
        code=boxmap(b['aq-result-engine']['patcher'])['code']['code']
        self.assertNotIn('Data ',code)
        self.assertNotIn('Param ',code)

    def test_every_report_field_has_one_signal_origin_and_one_poll_path(self):
        p=make_clarity_patch()['patcher']; e=edges(p); b=boxmap(p)
        for name in OUTPUTS:
            incoming=[s for s,d in e if d==('aq-'+name,0)]
            signal=[s for s in incoming if s[0] in ('aq-engine','aq-result-engine')]
            polls=[s for s in incoming if 'poll' in s[0]]
            self.assertEqual(len(signal),1,name)
            self.assertEqual(len(polls),1,name)
            if name in RESULT_FIELDS:
                self.assertEqual(signal,[('aq-result-engine',RESULT_FIELDS.index(name))])
            self.assertTrue(signal[0][1] < b[signal[0][0]]['numoutlets'])

    def test_all_late_fields_are_read_before_final_validation_and_clone(self):
        e,_,_,_=complete()
        row=e.run(np.zeros(1),np.zeros(1),permit=0)[0]
        g=ClarityGraph().initialized()
        for name in OUTPUTS:g.state['root/aq-'+name]['signal_sample']=row[column(name)]
        g.send('root/asrc-popup/export',(1,))
        frozen=g.state['root/aq-export-dict']['data']
        self.assertEqual(frozen['clarity_completed_result_export_valid'],(1,))
        self.assertEqual(frozen['clarity_completed_result_background_request'],(1,))
        self.assertEqual(frozen['clarity_completed_result_muted_windows'],(10,))
        self.assertEqual(frozen['clarity_completed_result_audible_windows'],(20,))
        self.assertGreater(frozen['clarity_completed_result_audible_mean_high'][0],0)
        self.assertEqual(frozen['clarity_completed_result_audible_above_windows_high'],(20,))
        self.assertEqual(frozen['clarity_test_phase_state'],(7,))
        self.assertFalse(g.calls)

    def test_available_flag_with_missing_stats_is_not_a_valid_export(self):
        g=ClarityGraph().initialized()
        for name in OUTPUTS:g.state['root/aq-'+name]['signal_sample']=0
        g.state['root/aq-completed_result_available']['signal_sample']=1
        g.state['root/aq-test_phase_state']['signal_sample']=7
        g.send('root/asrc-popup/export',(1,))
        self.assertEqual(g.state['root/aq-export-dict']['data']['clarity_completed_result_export_valid'],(0,))

    def test_export_validation_is_recomputed_after_prior_valid_or_invalid_exports(self):
        g=ClarityGraph().initialized()
        for name in OUTPUTS:g.state['root/aq-'+name]['signal_sample']=0
        checks={'available':1,'completed_phase_mask':3,'muted_windows':10,
                'audible_windows':20,'background_duration_ms':5000,
                'source_mode':1,'profile_valid':1}
        for suffix,bad in [('audible_windows',0),('background_duration_ms',0),('source_mode',0),('profile_valid',0),('completed_phase_mask',0)]:
            for name,v in checks.items():g.state['root/aq-completed_result_'+name]['signal_sample']=v
            g.send('root/asrc-popup/export',(1,))
            self.assertEqual(g.state['root/aq-export-dict']['data']['clarity_completed_result_export_valid'],(1,))
            g.state['root/aq-completed_result_'+suffix]['signal_sample']=bad
            g.send('root/asrc-popup/export',(1,))
            self.assertEqual(g.state['root/aq-export-dict']['data']['clarity_completed_result_export_valid'],(0,))


if __name__=='__main__':unittest.main()
