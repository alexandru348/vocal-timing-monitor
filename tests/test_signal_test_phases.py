"""Explicitly declared test phases; no inference about actual speaker mute."""
import math
import unittest
import numpy as np
from assistant_clarity import OUTPUTS, TEST_PHASE_STATES
from clarity_harness import Clarity
from test_assistant_clarity import column, ClarityGraph
from test_background_capture import stream
from test_background_comparison import measured, tone

START=column('test_phase_state')
BANDS=('low','mid','high')


def run(e,start,seconds,gain=1):
    n=round(e.sr*seconds)
    x=tone(e.sr,n,start,gain)
    return stream(e,x,.1*tone(e.sr,n,start)),start+n


def first_phase(sr=44100):
    e,baseline,start=measured(sr)
    frame=int(sr*.010)
    duration=math.ceil(sr/frame)*frame*10/sr+.05
    row,start=run(e,start,duration)
    assert row[column('test_phase_state')]==2
    return e,baseline,row,start


class SignalTestPhaseTests(unittest.TestCase):
    def test_no_phases_are_started_without_an_explicit_background_capture(self):
        e=Clarity()
        e.set(speakersrequest=1)
        row,_=run(e,0,2)
        self.assertEqual(row[START],0)
        self.assertEqual(row[column('test_completed_phase_mask')],0)
        self.assertFalse(row[column('test_muted_windows'):].any())

    def test_muted_phase_starts_only_after_capture_and_requires_ten_windows(self):
        e,_,start=measured()
        row,start=run(e,start,9.99)
        self.assertEqual(row[START],1)
        self.assertEqual(row[column('test_muted_windows')],9)
        row,start=run(e,start,.01)
        self.assertEqual(row[START],2)
        self.assertEqual(row[column('test_muted_windows')],10)
        self.assertEqual(row[column('test_completed_phase_mask')],1)
        self.assertAlmostEqual(row[column('test_muted_duration_ms')],10000)

    def test_waiting_for_user_neither_guesses_unmute_nor_contaminates_muted_summary(self):
        e,_,before,start=first_phase()
        after,start=run(e,start,6,gain=4)
        self.assertEqual(after[START],2)
        np.testing.assert_array_equal(before[START:174],after[START:174])
        self.assertEqual(after[column('test_audible_windows')],0)
        self.assertGreater(after[column('background_comparison_windows')],before[column('background_comparison_windows')])

    def test_early_declaration_is_consumed_without_later_starting_automatically(self):
        e,_,start=measured()
        e.set(speakersrequest=1)
        row,start=run(e,start,11)
        self.assertEqual(row[START],2)
        self.assertEqual(row[column('test_audible_windows')],0)
        e.set(speakersrequest=2)
        row,start=run(e,start,.01)
        self.assertEqual(row[START],3)

    def test_transition_waits_half_second_and_excludes_a_straddling_window(self):
        e,_,quiet,start=first_phase()
        e.set(speakersrequest=1)
        row,start=run(e,start,.49,gain=4)
        self.assertEqual(row[START],3)
        self.assertEqual(row[column('test_audible_windows')],0)
        gate=row[column('test_audible_gate_sampleclock')]
        row,start=run(e,start,.51,gain=4)
        self.assertEqual(row[START],4)
        self.assertEqual(row[column('test_audible_windows')],0)
        row,start=run(e,start,1,gain=2)
        self.assertEqual(row[column('test_audible_windows')],1)
        self.assertGreaterEqual(row[column('test_audible_start_sampleclock')],gate)

    def test_two_phases_have_separate_statistics_and_freeze_after_completion(self):
        e,baseline,quiet,start=first_phase()
        self.assertEqual(quiet[column('test_muted_within_windows')],10)
        e.set(speakersrequest=1)
        row,start=run(e,start,22,gain=3)
        self.assertEqual(row[START],5)
        self.assertEqual(row[column('test_completed_phase_mask')],3)
        self.assertEqual(row[column('test_audible_windows')],20)
        self.assertEqual(row[column('test_audible_above_windows')],20)
        self.assertAlmostEqual(row[column('test_audible_duration_ms')],20000)
        for b in BANDS:
            self.assertAlmostEqual(row[column('test_muted_mean_'+b)]/baseline[column('background_mean_'+b)],1,places=3)
            self.assertAlmostEqual(row[column('test_audible_mean_'+b)]/baseline[column('background_mean_'+b)],3,delta=.01)
            self.assertEqual(row[column('test_muted_above_windows_'+b)],0)
            self.assertEqual(row[column('test_audible_above_windows_'+b)],20)
            self.assertGreater(row[column('test_audible_above_fraction_'+b)],.99)
        self.assertLess(row[column('test_muted_end_sampleclock')],row[column('test_audible_start_sampleclock')])
        for pref in ('muted','audible'):
            span=row[column('test_'+pref+'_end_sampleclock')]-row[column('test_'+pref+'_start_sampleclock')]+1
            self.assertAlmostEqual(span/e.sr*1000,row[column('test_'+pref+'_duration_ms')])
            total=sum(row[column('test_'+pref+'_'+k+'_windows')] for k in ('within','above','uncertain'))
            self.assertEqual(total,row[column('test_'+pref+'_windows')])
        after,start=run(e,start,3,gain=.2)
        np.testing.assert_array_equal(row[START:174],after[START:174])
        self.assertEqual(after[column('voice_confirmed')],0)

    def test_repeated_declarations_do_not_restart_or_extend_a_phase(self):
        e,_,_,start=first_phase()
        e.set(speakersrequest=1)
        row,start=run(e,start,3,gain=2)
        before=row[column('test_audible_windows')]
        gate=row[column('test_audible_gate_sampleclock')]
        e.set(speakersrequest=2)
        row,start=run(e,start,2,gain=2)
        self.assertEqual(row[column('test_audible_gate_sampleclock')],gate)
        self.assertEqual(row[column('test_audible_windows')],before+2)

    def test_new_background_request_discards_both_phases(self):
        e,_,_,start=first_phase()
        e.set(backgroundrequest=2)
        row,start=run(e,start,.01)
        self.assertEqual(row[START],0)
        self.assertFalse(row[column('test_completed_phase_mask'):].any())
        row,start=run(e,start,6)
        self.assertEqual(row[START],1)
        self.assertEqual(row[column('test_audible_windows')],0)

    def test_context_loss_invalidates_live_summaries_and_prevents_automatic_reuse(self):
        e,_,_,start=first_phase()
        e.set(speakersrequest=1)
        row,start=run(e,start,22,gain=3)
        for change in ('epoch','offset','permit','profile','mode','clip'):
            with self.subTest(change=change):
                # A separate ready instance, with one partial muted window.
                x,_,t=measured()
                run(x,t,1)
                kw={}
                if change=='epoch':kw['epoch']=2
                elif change=='offset':kw['offset']=83
                elif change=='permit':kw['permit']=0
                elif change=='profile':x.set(profilevalid=0)
                elif change=='mode':x.set(sourcemode=2)
                row=x.run(np.array([1. if change=='clip' else 0.]),np.zeros(1),**kw)[0]
                self.assertEqual(row[START],6)
                self.assertFalse(row[column('test_completed_phase_mask'):].any())
        # Live summaries are revoked; the separately marked historic result remains.
        row=e.run(np.zeros(1),np.zeros(1),epoch=2)[0]
        self.assertEqual(row[START],7)
        self.assertFalse(row[column('test_completed_phase_mask'):122].any())
        self.assertEqual(row[column('completed_result_available')],1)

    def test_rounded_frame_rates_still_produce_ten_and_twenty_complete_seconds(self):
        for sr in (22050,48000,96000):
            with self.subTest(sr=sr):
                e,_,row,start=first_phase(sr)
                e.set(speakersrequest=1)
                row,start=run(e,start,22,gain=3)
                self.assertEqual(row[START],5)
                self.assertEqual(row[column('test_muted_windows')],10)
                self.assertEqual(row[column('test_audible_windows')],20)
                self.assertGreaterEqual(row[column('test_muted_duration_ms')],10000-1e-7)
                self.assertLess(row[column('test_muted_duration_ms')],10100)
                self.assertGreaterEqual(row[column('test_audible_duration_ms')],20000-1e-7)
                self.assertLess(row[column('test_audible_duration_ms')],20200)

    def test_declaration_cannot_change_any_prior_audio_diagnostic_output(self):
        a,_,_,start=first_phase()
        b,_,_,_=first_phase()
        a.set(speakersrequest=1)
        n=4*44100;mic=tone(44100,n,start,3);ref=.1*tone(44100,n,start)
        for i in range(0,n,4096):
            x=a.run(mic[i:i+4096],ref[i:i+4096]);y=b.run(mic[i:i+4096],ref[i:i+4096])
            np.testing.assert_array_equal(x[:,:86],y[:,:86])


class SignalTestPhaseGraphTests(unittest.TestCase):
    def test_speaker_button_sends_only_explicit_declaration_without_host_commands(self):
        g=ClarityGraph().initialized()
        self.assertNotIn('speakersrequest',g.clarity_params)
        g.send('root/asrc-popup/aq-speakers',(1,))
        self.assertEqual(g.clarity_params['speakersrequest'],1)
        g.send('root/asrc-popup/aq-speakers',(1,))
        self.assertEqual(g.clarity_params['speakersrequest'],2)
        self.assertNotIn('quality',g.preflight_params)
        self.assertFalse(g.calls)

    def test_phase_messages_and_controls_follow_theme(self):
        g=ClarityGraph().initialized()
        for code,label in TEST_PHASE_STATES.items():
            g.state['root/aq-test_phase_state']['signal_sample']=code
            g.send('root/aq-poll')
            self.assertEqual(' '.join(map(str,g.state['root/asrc-popup/aq-test-phase-status']['label'])),label)
        g.click('theme')
        commands=g.state['root/asrc-popup/window']['commands']
        self.assertTrue(any(c[:4]==('script','send','asrc_ui_aq-speakers','bgcolor') for c in commands))
        self.assertTrue(any(c[:4]==('script','send','asrc_ui_aq-test-phase-status','textcolor') for c in commands))

    def test_all_phase_summaries_are_frozen_before_export_and_never_persisted(self):
        g=ClarityGraph().initialized()
        for i,name in enumerate(OUTPUTS[START:174]):g.state['root/aq-'+name]['signal_sample']=i+.5
        g.send('root/asrc-popup/export',(1,))
        frozen=dict(g.state['root/aq-export-dict']['data'])
        for i,name in enumerate(OUTPUTS[START:174]):
            self.assertEqual(frozen['clarity_'+name],(i+.5,))
            g.emit('root/aq-'+name,(0,))
        self.assertEqual(g.state['root/aq-export-dict']['data'],frozen)
        self.assertFalse(any('test_' in n for n in g.saved_parameters()))
        self.assertFalse(g.calls)


if __name__=='__main__':unittest.main()
