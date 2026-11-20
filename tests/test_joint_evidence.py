"""Same-frame background/reference observations; never speech identification."""
import json
import math
from pathlib import Path
import unittest
import numpy as np
from assistant_clarity import OUTPUTS, JOINT_LIVE_FIELDS, JOINT_RESULT_FIELDS, JOINT_CATEGORIES
from clarity_harness import Clarity, compile_clarity, load_library, BUILD
from test_assistant_clarity import column, signals, ClarityGraph
from test_background_capture import stream
from test_background_comparison import measured, follow, tone
from test_completed_signal_result import complete

BANDS=('low','mid','high')
HIST=[column(n) for n in JOINT_RESULT_FIELDS]


def codes(row):
    value=int(row[column('joint_band_codes')])
    return [(value//8**i)%8 for i in range(3)]


def counts(row):
    value=int(row[column('joint_above_counts')])
    return [(value//64**i)%64 for i in range(3)]


class JointEvidenceTests(unittest.TestCase):
    def test_no_baseline_means_no_joint_observation(self):
        ref,mic=signals(seconds=2)
        row=stream(Clarity(),mic,ref)
        self.assertFalse(row[[column(n) for n in JOINT_LIVE_FIELDS]].any())
        self.assertFalse(row[HIST].any())

    def test_unchanged_background_is_within_even_when_reference_is_unusable(self):
        e,_,start=measured();row=follow(e,start,2)
        self.assertEqual(codes(row),[1,1,1])
        self.assertEqual(counts(row),[0,0,0])
        self.assertEqual(row[column('voice_confirmed')],0)

    def test_echo_above_background_has_reference_supported_categories(self):
        e,_,_=measured();ref,_=signals(seconds=2)
        row=stream(e,.6*ref,ref)
        self.assertEqual(codes(row),[3,3,3])
        self.assertTrue(all(n>=36 for n in counts(row)))
        self.assertEqual(row[column('voice_confirmed')],0)

    def test_low_match_above_background_remains_unconfirmed(self):
        e,_,_=measured();ref,other=signals(seconds=2)
        row=stream(e,.6*other,ref)
        self.assertEqual(codes(row),[4,4,4])
        self.assertEqual(row[column('voice_confirmed')],0)

    def test_steady_level_increase_with_unusable_reference_is_explicitly_uncertain(self):
        e,_,start=measured();row=follow(e,start,2,gain=3)
        self.assertEqual(codes(row),[5,5,5])
        self.assertEqual(counts(row),[60,60,60])

    def test_occupancy_counts_match_an_independent_filter_and_exact_reported_span(self):
        from scipy.signal import lfilter
        sr=44100;n=7*sr
        gain=np.ones(n);gain[round(6.5*sr):round(6.65*sr)]=3
        mic=tone(sr,n)*gain
        e=Clarity();e.run(np.zeros(1),np.zeros(1));e.set(backgroundrequest=1)
        row=stream(e,mic,.1*tone(sr,n))
        def lowpass(x,hz):
            c=math.exp(-6.28318530718*hz/sr)
            return lfilter([1-c],[1,-c],x)
        hp=mic-lowpass(mic,20)
        lo=lowpass(hp,400);hi=lowpass(hp,1800)
        end=int(row[column('joint_window_end_sampleclock')]);start=end-60*441+1
        expected=[]
        for b,x in zip(BANDS,(lo,hi-lo,hp-hi)):
            frames=np.abs(x[start-1:end]).reshape(60,441).mean(axis=1)
            expected.append(int((frames>row[column('background_limit_'+b)]).sum()))
        self.assertEqual(counts(row),expected)
        self.assertEqual(codes(row),[2,2,2])
        self.assertTrue(all(6<x<36 for x in expected))

    def test_permission_profile_offset_epoch_mode_and_clip_revoke_joint_live_fields(self):
        for cause in ('permit','profile','offset','epoch','mode','clip','request'):
            e,_,start=measured();self.assertGreater(follow(e,start,2)[column('joint_band_codes')],0)
            kw={}
            if cause=='permit':kw['permit']=0
            if cause=='offset':kw['offset']=83
            if cause=='epoch':kw['epoch']=2
            if cause=='profile':e.set(profilevalid=0)
            if cause=='mode':e.set(sourcemode=2)
            if cause=='request':e.set(backgroundrequest=2)
            row=e.run(np.array([1. if cause=='clip' else 0.]),np.zeros(1),**kw)[0]
            self.assertFalse(row[[column(n) for n in JOINT_LIVE_FIELDS]].any(),cause)

    def test_categories_exhaust_each_band_and_summaries_use_only_the_declared_phase(self):
        _,_,row,_=complete()
        self.assertEqual(row[column('completed_joint_available')],1)
        for phase,n in [('muted',10),('audible',20)]:
            p='completed_joint_'+phase+'_'
            self.assertEqual(row[column(p+'observations')],n)
            self.assertEqual(row[column(p+'skipped')],0)
            for b in BANDS:
                self.assertEqual(sum(row[column(p+c+'_'+b)] for c in JOINT_CATEGORIES),n)
            self.assertGreaterEqual(row[column(p+'first_window_start_sampleclock')],row[column('completed_result_'+phase+'_start_sampleclock')])
            self.assertLessEqual(row[column(p+'last_window_end_sampleclock')],row[column('completed_result_'+phase+'_end_sampleclock')])
        for b in BANDS:
            self.assertEqual(row[column('completed_joint_muted_within_'+b)],10)
            self.assertEqual(row[column('completed_joint_audible_above_unusable_'+b)],20)

    def test_joint_summary_survives_stop_and_later_audio_but_new_request_discards_it(self):
        e,_,before,start=complete()
        row=e.run(np.zeros(1),np.zeros(1),permit=0)[0]
        np.testing.assert_array_equal(before[HIST],row[HIST])
        row=follow(e,start,2,gain=4)
        np.testing.assert_array_equal(before[HIST],row[HIST])
        self.assertFalse(row[[column(n) for n in JOINT_LIVE_FIELDS]].any())
        e.set(backgroundrequest=2)
        row=e.run(np.zeros(1),np.zeros(1))[0]
        self.assertFalse(row[HIST].any())

    def test_partial_probe_does_not_become_a_completed_joint_result(self):
        e,_,start=measured();follow(e,start,3)
        row=e.run(np.zeros(1),np.zeros(1),permit=0)[0]
        self.assertFalse(row[HIST].any())

    def test_signed_offsets_and_sample_rates_exclude_spans_before_phase_start(self):
        for sr,offset in [(22050,-500),(44100,-93),(48000,93),(96000,500)]:
            e=Clarity(sr);e.run(np.zeros(1),np.zeros(1),offset=offset);e.set(backgroundrequest=1)
            frame=int(sr*.01)
            n=(1+math.ceil(sr*.5/frame)+math.ceil(sr*5/frame))*frame
            start=0
            row=stream(e,tone(sr,n),.1*tone(sr,n),offset=offset);start+=n
            n=round(sr*11)
            row=stream(e,tone(sr,n,start),.1*tone(sr,n,start),offset=offset);start+=n
            self.assertEqual(row[column('test_phase_state')],2)
            e.set(speakersrequest=1);n=round(sr*22)
            row=stream(e,tone(sr,n,start,3),.1*tone(sr,n,start),offset=offset)
            self.assertEqual(row[column('completed_joint_available')],1,(sr,offset))
            for phase,nwindows in [('muted',10),('audible',20)]:
                p='completed_joint_'+phase+'_'
                obs=row[column(p+'observations')];skipped=row[column(p+'skipped')]
                self.assertEqual(obs+skipped,nwindows)
                self.assertGreater(obs,0)
                self.assertGreaterEqual(row[column(p+'first_window_start_sampleclock')],row[column('completed_result_'+phase+'_start_sampleclock')])
                self.assertLessEqual(row[column(p+'last_window_end_sampleclock')],row[column('completed_result_'+phase+'_end_sampleclock')])

    def test_all_174_original_outputs_match_the_frozen_0214_graph_exactly(self):
        old = Path(__file__).with_name('fixtures') / 'assistant_0214_analysis.json'
        compile_clarity(patch=json.loads(old.read_text(encoding='utf-8')),
                        stem='clarity_0214', report_outputs=OUTPUTS[:174])
        olde=Clarity(library=load_library(BUILD/'clarity_0214.so'),width=174)
        newe=Clarity()
        for e in (olde,newe):e.run(np.zeros(1),np.zeros(1));e.set(backgroundrequest=1)
        # Full quiet capture, muted phase, declaration, audible phase and Stop.
        start=0
        for seconds,gain,declare in [(17,1,False),(22,3,True)]:
            if declare:
                for e in (olde,newe):e.set(speakersrequest=1)
            n=round(44100*seconds)
            for i in range(0,n,4096):
                count=min(4096,n-i);a=tone(44100,count,start+i,gain);b=.1*tone(44100,count,start+i)
                np.testing.assert_array_equal(newe.run(a,b)[:,:174],olde.run(a,b))
            start+=n
        np.testing.assert_array_equal(newe.run(np.zeros(1),np.zeros(1),permit=0)[:,:174],olde.run(np.zeros(1),np.zeros(1),permit=0))


class JointEvidenceGraphTests(unittest.TestCase):
    def test_all_joint_fields_are_frozen_after_stop_including_the_last_port(self):
        e,_,_,_=complete();row=e.run(np.zeros(1),np.zeros(1),permit=0)[0]
        g=ClarityGraph().initialized()
        for n in OUTPUTS:g.state['root/aq-'+n]['signal_sample']=row[column(n)]
        g.send('root/asrc-popup/export',(1,))
        frozen=dict(g.state['root/aq-export-dict']['data'])
        for n in JOINT_RESULT_FIELDS:self.assertEqual(frozen['clarity_'+n],(row[column(n)],))
        for n in JOINT_RESULT_FIELDS:g.emit('root/aq-'+n,(0,))
        self.assertEqual(g.state['root/aq-export-dict']['data'],frozen)
        self.assertEqual(frozen['clarity_completed_result_export_valid'],(1,))
        self.assertEqual(frozen['clarity_completed_joint_audible_above_unusable_high'],(20,))
        self.assertFalse(g.calls)
        self.assertNotIn('quality',g.preflight_params)

    def test_joint_fields_are_not_saved_as_live_parameters(self):
        g=ClarityGraph().initialized()
        self.assertFalse(any('joint' in n for n in g.saved_parameters()))


if __name__=='__main__':unittest.main()
