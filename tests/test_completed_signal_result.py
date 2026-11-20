"""Completed DSP results survive Stop as history, never as live evidence."""
import math
import unittest
import numpy as np
from assistant_clarity import OUTPUTS, RESULT_FIELDS
from clarity_harness import Clarity
from test_assistant_clarity import column, ClarityGraph
from test_background_comparison import tone, measured
from test_signal_test_phases import run, first_phase

FIRST=column('completed_result_available')


def complete(sr=44100):
    e,baseline,quiet,start=first_phase(sr)
    e.set(speakersrequest=1)
    row,start=run(e,start,22,gain=3)
    assert row[column('completed_result_available')]==1
    return e,baseline,row,start


def before_last_sample():
    e,baseline,quiet,start=first_phase()
    sr=e.sr
    e.set(speakersrequest=1)
    row=e.run(tone(sr,1,start,3),.1*tone(sr,1,start))[0];start+=1
    gate=row[column('test_audible_gate_sampleclock')]
    width=round(quiet[column('background_comparison_duration_ms')]*sr/1000)
    anchor=quiet[column('test_muted_end_sampleclock')]+1
    first=anchor+math.ceil(max(0,gate-anchor)/width)*width
    last=first+20*width-1
    n=round(last-row[column('sampleclock')])-1
    row,start=run(e,start,n/sr,gain=3)
    assert row[column('test_audible_windows')]==19
    assert row[column('completed_result_available')]==0
    return e,baseline,row,start


class CompletedSignalResultTests(unittest.TestCase):
    def test_no_result_is_created_by_initialization_or_baseline_alone(self):
        e,_,start=measured()
        row,start=run(e,start,3)
        self.assertFalse(row[FIRST:FIRST+len(RESULT_FIELDS)].any())

    def test_completed_copy_contains_the_full_original_baseline_and_both_phases(self):
        e,baseline,row,_=complete()
        self.assertEqual(row[column('completed_result_completed_phase_mask')],3)
        self.assertEqual(row[column('completed_result_background_frames')],500)
        self.assertEqual(row[column('completed_result_source_mode')],1)
        self.assertEqual(row[column('completed_result_profile_valid')],1)
        self.assertEqual(row[column('completed_result_background_request')],1)
        self.assertEqual(row[column('completed_result_epoch')],row[column('epoch')])
        self.assertEqual(row[column('completed_result_samplerate')],44100)
        for name in RESULT_FIELDS:
            suffix=name.removeprefix('completed_result_')
            if suffix.startswith(('muted_','audible_')):
                self.assertEqual(row[column(name)],row[column('test_'+suffix)],name)
            elif suffix.startswith('background_') and suffix not in ('background_request',):
                expected=column(suffix)
                self.assertEqual(row[column(name)],row[expected],name)
        self.assertEqual(row[column('completed_result_sampleclock')],row[column('test_audible_end_sampleclock')])

    def test_immediate_stop_after_last_sample_keeps_result_without_a_ui_poll(self):
        e,_,before,start=before_last_sample()
        done=e.run(tone(44100,1,start,3),.1*tone(44100,1,start))[0]
        self.assertEqual(done[column('test_phase_state')],5)
        self.assertEqual(done[FIRST],1)
        stopped=e.run(np.zeros(1),np.zeros(1),permit=0)[0]
        np.testing.assert_array_equal(done[FIRST:FIRST+len(RESULT_FIELDS)],stopped[FIRST:FIRST+len(RESULT_FIELDS)])
        self.assertEqual(stopped[column('test_phase_state')],7)
        self.assertEqual(stopped[column('background_state')],3)
        self.assertEqual(stopped[column('test_completed_phase_mask')],0)
        self.assertEqual(stopped[column('voice_confirmed')],0)
        self.assertEqual(stopped[column('state')],0)

    def test_guard_revocation_on_final_sample_cannot_create_a_complete_result(self):
        e,_,before,start=before_last_sample()
        row=e.run(np.zeros(1),np.zeros(1),permit=0)[0]
        self.assertEqual(row[column('test_phase_state')],6)
        self.assertFalse(row[FIRST:FIRST+len(RESULT_FIELDS)].any())

    def test_partial_audible_phase_is_never_saved_as_a_complete_result(self):
        e,_,_,start=first_phase()
        e.set(speakersrequest=1)
        row,start=run(e,start,12,gain=3)
        self.assertLess(row[column('test_audible_windows')],20)
        row=e.run(np.zeros(1),np.zeros(1),permit=0)[0]
        self.assertFalse(row[FIRST:FIRST+len(RESULT_FIELDS)].any())
        self.assertEqual(row[column('test_phase_state')],6)

    def test_stop_restart_and_later_audio_do_not_modify_or_reuse_the_result(self):
        e,_,before,start=complete()
        z=np.zeros(44100)
        from test_background_capture import stream
        row=stream(e,z,z,permit=0)
        np.testing.assert_array_equal(before[FIRST:FIRST+len(RESULT_FIELDS)],row[FIRST:FIRST+len(RESULT_FIELDS)])
        row,start=run(e,start,3,gain=4)
        np.testing.assert_array_equal(before[FIRST:FIRST+len(RESULT_FIELDS)],row[FIRST:FIRST+len(RESULT_FIELDS)])
        self.assertEqual(row[column('background_state')],3)
        self.assertEqual(row[column('test_completed_phase_mask')],0)
        self.assertEqual(row[column('test_phase_state')],7)
        self.assertEqual(row[column('voice_confirmed')],0)

    def test_provenance_is_retained_across_later_context_and_compensation_changes(self):
        e,_,before,_=complete()
        for kw,params,mic in [({'epoch':2},{},0),({'offset':83},{},0),({'permit':0},{},0),({}, {'profilevalid':0},0),({}, {'sourcemode':2},0),({}, {},1)]:
            e.set(profilevalid=1,sourcemode=1)
            e.set(**params)
            row=e.run(np.array([mic]),np.zeros(1),**kw)[0]
            np.testing.assert_array_equal(before[FIRST:FIRST+len(RESULT_FIELDS)],row[FIRST:FIRST+len(RESULT_FIELDS)])
            self.assertEqual(row[column('test_completed_phase_mask')],0)
            self.assertEqual(row[column('voice_confirmed')],0)
        self.assertEqual(row[column('completed_result_epoch')],1)
        self.assertEqual(row[column('completed_result_offset_ms')],0)

    def test_new_measurement_discards_old_result_even_if_request_is_unready(self):
        for permit in (0,1):
            e,_,_,_=complete()
            e.set(backgroundrequest=2)
            row=e.run(np.zeros(1),np.zeros(1),permit=permit)[0]
            self.assertFalse(row[FIRST:FIRST+len(RESULT_FIELDS)].any())

    def test_a_new_completed_probe_replaces_result_with_its_own_statistics(self):
        e,_,before,start=complete()
        e.set(backgroundrequest=2)
        row,start=run(e,start,16,gain=.7)
        self.assertEqual(row[column('test_phase_state')],2)
        self.assertFalse(row[FIRST:FIRST+len(RESULT_FIELDS)].any())
        e.set(speakersrequest=2)
        row,start=run(e,start,22,gain=4)
        self.assertEqual(row[FIRST],1)
        self.assertEqual(row[column('completed_result_background_request')],2)
        self.assertGreater(row[column('completed_result_sampleclock')],before[column('completed_result_sampleclock')])
        self.assertLess(row[column('completed_result_background_mean_low')],before[column('completed_result_background_mean_low')]*.8)
        self.assertGreater(row[column('completed_result_audible_mean_high')],before[column('completed_result_audible_mean_high')]*1.3)

    def test_result_is_instance_scoped_and_not_loaded_as_a_valid_measurement(self):
        _,_,before,_=complete()
        self.assertEqual(before[FIRST],1)
        fresh=Clarity()
        row=fresh.run(np.zeros(1),np.zeros(1))[0]
        self.assertFalse(row[FIRST:FIRST+len(RESULT_FIELDS)].any())

    def test_result_survives_stop_at_each_tested_rate(self):
        for sr in (22050,48000,96000):
            e,_,before,_=complete(sr)
            after=e.run(np.zeros(1),np.zeros(1),permit=0)[0]
            np.testing.assert_array_equal(before[FIRST:FIRST+len(RESULT_FIELDS)],after[FIRST:FIRST+len(RESULT_FIELDS)])
            self.assertEqual(after[column('completed_result_samplerate')],sr)
            self.assertEqual(after[column('completed_result_muted_windows')],10)
            self.assertEqual(after[column('completed_result_audible_windows')],20)


class CompletedSignalResultGraphTests(unittest.TestCase):
    def test_delayed_first_ui_poll_and_export_after_stop_keep_all_result_fields(self):
        e,_,_,_=complete()
        row=e.run(np.zeros(1),np.zeros(1),permit=0)[0]
        g=ClarityGraph().initialized()
        # No phase-completion UI event is delivered before Stop. The DSP copy
        # supplies the first result read by export, while live values are zero.
        for name in OUTPUTS:g.state['root/aq-'+name]['signal_sample']=row[column(name)]
        g.send('root/asrc-popup/export',(1,))
        frozen=dict(g.state['root/aq-export-dict']['data'])
        for name in RESULT_FIELDS:self.assertEqual(frozen['clarity_'+name],(row[column(name)],))
        self.assertEqual(frozen['clarity_test_phase_state'],(7,))
        self.assertEqual(frozen['clarity_voice_confirmed'],(0,))
        for name in RESULT_FIELDS:g.emit('root/aq-'+name,(0,))
        self.assertEqual(g.state['root/aq-export-dict']['data'],frozen)
        self.assertNotIn('quality',g.preflight_params)
        self.assertFalse(g.calls)
        self.assertFalse(any('completed_result' in n for n in g.saved_parameters()))


if __name__=='__main__':unittest.main()
