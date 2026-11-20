"""Distinguish interruption causes in synthetic DSP and the Max graph model."""
import unittest
import numpy as np
from assistant_preflight import OUTPUTS, DIAGNOSTIC_OUTPUTS
from preflight_harness import ready
from test_assistant_clarity import ClarityGraph, signals, column
from clarity_harness import Clarity
from assistant_clarity import VERSION


def at(row, name):
    return row[OUTPUTS.index(name)]


class PreflightDiagnosticsTests(unittest.TestCase):
    def test_stable_quantized_clock_has_no_new_causes_or_false_startup_gap(self):
        for sr in (44100, 48000, 96000):
            p = ready(sr=sr, quality=0)
            before = p.signal()[-1]
            n = round(sr * 1.2)
            phase = (((np.arange(n) + p.time) * p.bpm / (60*sr)) % 1).astype(np.float32)
            after = p.run(np.full(n, .1), np.full(n, .15), phase=phase)[-1]
            for name in ('epoch', 'polltimeouts', 'synclosses', 'periodchanges',
                         'hostchanges', 'sourcechanges', 'timingchanges'):
                self.assertEqual(at(before, name), at(after, name))
            self.assertLessEqual(at(after, 'maxpollgapms'), 20.1)
            self.assertEqual(after[2], 0)  # diagnostics do not confirm quality

    def test_delayed_poll_is_distinct_from_clock_loss_and_retained_on_recovery(self):
        p = ready(quality=0)
        before = p.signal()[-1]
        lost = p.signal(seconds=.35, heartbeat=False)[-1]
        self.assertEqual(at(lost, 'polltimeouts'), at(before, 'polltimeouts') + 1)
        self.assertEqual(at(lost, 'synclosses'), at(before, 'synclosses'))
        self.assertEqual(int(at(lost, 'lastboundarymask')), 32)
        self.assertTrue(int(at(lost, 'lastpermitmask')) & 8)
        self.assertGreater(at(lost, 'hostagems'), 250)
        recovered = p.signal()[-1]
        self.assertEqual(recovered[1], 1)
        self.assertEqual(recovered[2], 0)
        for name in ('lastpermitmask', 'lastpermitlossms', 'lastpermitboundarymask', 'polltimeouts'):
            self.assertEqual(at(recovered, name), at(lost, name))
        self.assertGreaterEqual(at(recovered, 'maxpollgapms'), at(lost, 'hostagems'))
        self.assertLess(at(recovered, 'hostagems'), 21)

    def test_clock_loss_is_distinct_from_poll_timeout(self):
        p = ready()
        before = p.signal()[-1]
        p.play = False
        lost = p.signal(seconds=.1)[-1]
        self.assertEqual(at(lost, 'polltimeouts'), at(before, 'polltimeouts'))
        self.assertEqual(at(lost, 'synclosses'), at(before, 'synclosses') + 1)
        self.assertTrue(int(at(lost, 'lastboundarymask')) & 64)
        self.assertTrue(int(at(lost, 'lastpermitmask')) & 128)
        self.assertEqual(lost[1], 0)

    def test_control_host_source_timing_and_reset_edits_have_separate_causes(self):
        for edit, name, mask in ((dict(enabled=0), 'controlchanges', 1),
                                 (dict(recording=1), 'hostchanges', 2),
                                 (dict(voicebinding=2), 'sourcechanges', 4),
                                 (dict(offsetms=84), 'timingchanges', 8),
                                 (dict(resetseq=1), 'resetchanges', 16)):
            with self.subTest(edit=edit):
                p = ready()
                before = p.signal()[-1]
                p.set(**edit)
                changed = p.signal(seconds=1/p.sr)[0]
                self.assertEqual(int(at(changed, 'lastboundarymask')), mask)
                self.assertEqual(at(changed, name), at(before, name) + 1)
                self.assertEqual(changed[1], 0)
                self.assertEqual(at(changed, 'lastpermitboundarymask'), mask)
                self.assertAlmostEqual(at(changed, 'lastboundaryms'), 160)
                self.assertAlmostEqual(at(changed, 'lastpermitlossms'), 160)

    def test_simultaneous_changes_preserve_all_causes_in_one_boundary(self):
        p = ready()
        before = p.signal()[-1]
        p.set(recording=1, offsetms=84, resetseq=1)
        row = p.signal(seconds=1/p.sr)[0]
        self.assertEqual(at(row, 'lastboundarymask'), 2+8+16)
        self.assertEqual(row[9], before[9] + 1)

    def test_clipping_and_tempo_are_reported_without_claiming_poll_loss(self):
        for action, cause, bit, failure in ((lambda p: None, 'clipchanges', 128, 4096),
                                            (lambda p: setattr(p, 'bpm', 153), 'periodchanges', 256, 256)):
            p = ready()
            before = p.signal()[-1]
            action(p)
            out = p.signal(seconds=.04, mic=2 if cause == 'clipchanges' else .1)
            self.assertGreater(at(out[-1], cause), at(before, cause))
            masks = out[:, OUTPUTS.index('lastboundarymask')].astype(int)
            self.assertTrue(np.any(masks & bit))
            self.assertTrue(int(at(out[-1], 'lastpermitmask')) & failure)
            self.assertEqual(at(out[-1], 'polltimeouts'), at(before, 'polltimeouts'))
            self.assertEqual(out[-1, 1], 0)

    def test_diagnostic_counters_survive_reset_without_preserving_acoustic_evidence(self):
        p = ready(quality=0)
        ref, other = signals(seconds=2)
        pre = p.run(other, ref)
        c = Clarity()
        before = c.run(other, ref, permit=pre[:, 1], epoch=pre[:, 9], offset=pre[:, 11])
        self.assertGreater(before[-1, column('lifetime_windows')], 0)
        n = round(p.sr*.35)
        pre = p.run(other[:n], ref[:n], heartbeat=False)
        after = c.run(other[:n], ref[:n], permit=pre[:, 1], epoch=pre[:, 9], offset=pre[:, 11])
        self.assertGreater(at(pre[-1], 'polltimeouts'), 0)
        self.assertEqual(after[-1, column('window_ms')], 0)
        self.assertEqual(after[-1, column('distinct_windows')], 0)
        self.assertGreater(after[-1, column('lifetime_windows')], 0)

    def test_frozen_export_contains_each_diagnostic_and_preserves_loss_cause(self):
        g = ClarityGraph().initialized()
        for i, name in enumerate(DIAGNOSTIC_OUTPUTS):
            g.state['root/apf-'+name]['signal_sample'] = i+100
        g.send('root/asrc-popup/export', (1,))
        frozen = g.state['root/aq-export-dict']['data']
        self.assertEqual(frozen['format'], ('vtm-assistant-signal-'+VERSION,))
        for i, name in enumerate(DIAGNOSTIC_OUTPUTS):
            self.assertEqual(frozen['preflight_'+name], (i+100,))
            g.emit('root/apf-'+name, (0,))
            self.assertEqual(frozen['preflight_'+name], (i+100,))
        self.assertFalse(g.calls)

    def test_regular_ui_poll_does_not_sample_additional_diagnostics(self):
        g = ClarityGraph().initialized()
        for name in DIAGNOSTIC_OUTPUTS:
            g.state['root/apf-'+name]['signal_sample'] = 777
        g.emit('root/qmetro')
        live = g.state['root/asrc-report']['data']
        for name in DIAGNOSTIC_OUTPUTS:
            self.assertNotIn('preflight_'+name, live)
        g.send('root/asrc-popup/export', (1,))
        for name in DIAGNOSTIC_OUTPUTS:
            self.assertEqual(g.state['root/aq-export-dict']['data']['preflight_'+name], (777,))


if __name__ == '__main__':
    unittest.main()
