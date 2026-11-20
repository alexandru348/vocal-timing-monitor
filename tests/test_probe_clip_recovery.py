"""Exercise guarded clipping recovery through preflight, analysis and export."""
import unittest

import numpy as np

from assistant_clarity import OUTPUTS, make_clarity_patch
from assistant_preflight import OUTPUTS as PREFLIGHT_OUTPUTS
from clarity_harness import Clarity
from preflight_harness import ready
from test_assistant_clarity import ClarityGraph, column
from test_background_comparison import tone
from test_static import edges


PAUSE = PREFLIGHT_OUTPUTS.index('probe_clip_pause')
LAST_CLIP = PREFLIGHT_OUTPUTS.index('last_clip_input_mask')


class ProbeClipTests(unittest.TestCase):
    def setUp(self):
        self.preflight = ready()
        self.clarity = Clarity(self.preflight.sr)
        self.advance(.2)

    def feed(self, mic, ref):
        pre = self.preflight.run(mic, ref)
        row = self.clarity.run(mic, ref, permit=pre[:, 1], epoch=pre[:, 9],
                               offset=pre[:, 11], clip_pause=pre[:, PAUSE])[-1].copy()
        return pre, row

    def advance(self, seconds, overload=None):
        sr = self.preflight.sr
        for i in range(0, round(seconds*sr), 4096):
            count = min(4096, round(seconds*sr)-i)
            mic = tone(sr, count, self.preflight.time)
            ref = .25 * mic
            if overload == 'reference':
                ref[:] = 1.0
            _, result = self.feed(mic, ref)
        return result

    def spike(self, mic, ref):
        pre, result = self.feed(np.array([mic]), np.array([ref]))
        self.assertEqual(pre[-1, PAUSE], 1)
        self.assertEqual(pre[-1, 1], 0)
        self.assertEqual(pre[-1, 2], 0)
        self.assertEqual(result[column('state')], 11)
        self.assertEqual(result[column('joint_band_codes')], 0)
        return pre[-1], result

    def prepare_speech(self):
        self.clarity.set(backgroundrequest=1)
        row = self.advance(16)
        self.assertEqual(row[column('test_phase_state')], 2)
        self.clarity.set(speakersrequest=1)
        row = self.advance(7.2)
        self.assertEqual(row[column('guided_cue')], 2)
        return row

    def test_spikes_in_capture_muted_and_speech_keep_clean_completed_result(self):
        self.clarity.set(backgroundrequest=1)
        initial = self.advance(2)
        _, paused = self.spike(1.0, .01)
        self.assertEqual(paused[column('background_frames')], initial[column('background_frames')])
        self.advance(6)
        _, paused = self.spike(.01, 1.0)
        self.assertEqual(paused[column('test_phase_state')], 1)
        self.advance(11)
        self.clarity.set(speakersrequest=1)
        before = self.advance(7.2)
        self.assertEqual(before[column('guided_cue')], 2)
        clip, paused = self.spike(1.0, 1.0)
        self.assertEqual(clip[LAST_CLIP], 3)
        self.assertEqual(paused[column('guided_cue')], 2)
        self.assertEqual(paused[column('test_audible_windows')], before[column('test_audible_windows')])
        self.assertEqual(paused[column('background_limit_high')], before[column('background_limit_high')])
        completed = self.advance(16)
        self.assertEqual(completed[column('completed_guided_available')], 1)
        self.assertEqual(completed[column('completed_result_background_frames')], 500)
        self.assertEqual(completed[column('completed_result_audible_windows')], 20)
        self.assertEqual(completed[column('completed_result_background_limit_high')], before[column('background_limit_high')])
        self.assertEqual(completed[column('completed_joint_audible_above_unusable_high')], 0)
        self.assertEqual(completed[column('voice_confirmed')], 0)
        self.preflight.set(playing=0)
        self.preflight.play = False
        stopped = self.advance(.08)
        self.assertEqual(stopped[column('test_phase_state')], 7)
        graph = ClarityGraph().initialized()
        for index, name in enumerate(OUTPUTS):
            graph.state['root/aq-'+name]['signal_sample'] = stopped[index]
        graph.send('root/asrc-popup/export', (1,))
        exported = graph.state['root/aq-export-dict']['data']
        self.assertEqual(exported['clarity_completed_guided_export_valid'], (1,))
        self.assertFalse(graph.calls)

    def test_sustained_overload_finishes_with_clear_status_and_no_result(self):
        self.prepare_speech()
        row = self.advance(6.1, overload='reference')
        self.assertEqual(row[column('test_phase_state')], 8)
        self.assertEqual(row[column('guided_cue')], 5)
        self.assertEqual(row[column('completed_guided_available')], 0)
        pre, row = self.feed(np.zeros(1), np.ones(1))
        self.assertEqual(pre[-1, LAST_CLIP], 2)
        self.assertEqual(row[column('test_phase_state')], 8)
        self.advance(.5)
        self.clarity.set(backgroundrequest=2)
        row = self.advance(6)
        self.assertEqual(row[column('background_state')], 2)
        self.assertEqual(row[column('test_phase_state')], 1)

    def test_transport_stop_during_clip_still_invalidates(self):
        self.prepare_speech()
        self.spike(1.0, 0.0)
        self.preflight.set(playing=0)
        self.preflight.play = False
        pre, row = self.feed(np.ones(1), np.zeros(1))
        self.assertEqual(pre[-1, PAUSE], 0)
        self.assertEqual(pre[-1, LAST_CLIP], 1)
        self.assertEqual(row[column('test_phase_state')], 6)
        self.assertEqual(row[column('completed_guided_available')], 0)

    def test_deployed_wire_carries_only_preflight_clip_pause(self):
        patch = make_clarity_patch()['patcher']
        self.assertIn((('apf-engine', PAUSE), ('aq-engine', 7)), edges(patch))
