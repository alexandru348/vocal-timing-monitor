"""Band evidence stays descriptive and never authorizes voice or rhythm."""
import unittest
import numpy as np
from assistant_clarity import OUTPUTS
from clarity_harness import Clarity
from preflight_harness import ready
from test_assistant_clarity import column, signals, ClarityGraph

BANDS = ('low','mid','high')
NEW_FIELDS = OUTPUTS[33:54]


def partial_signals(sr=44100, seconds=3):
    t = np.arange(round(sr*seconds))/sr
    high = (.10+.07*np.sin(2*np.pi*6.7*t))*np.sin(2*np.pi*3300*t)
    ref = (.15+.10*np.sin(2*np.pi*2.3*t))*np.sin(2*np.pi*130*t)+high
    mic = (.18+.14*np.sin(2*np.pi*4.1*t))*np.sin(2*np.pi*140*t)+.4*high
    return mic,ref


class BandDiagnosticsTests(unittest.TestCase):
    def test_partial_high_band_match_is_explained_without_discarding_low_band(self):
        for sr in (44100,48000,96000):
            mic,ref=partial_signals(sr)
            out=Clarity(sr).run(mic,ref)
            row=out[-1]
            self.assertEqual(row[0],10)
            self.assertLess(row[1],.35)
            self.assertGreater(row[column('band_match_high')],.9)
            self.assertEqual(row[column('reference_supported_band_mask')],4)
            self.assertGreater(row[column('band_weight_low')],.85)
            self.assertGreater(row[column('partial_reference_windows')],0)
            self.assertGreater(row[column('band_reference_windows_high')],0)
            self.assertFalse(out[:,column('voice_confirmed')].any())

    def test_reported_band_weights_reconstruct_existing_score_and_levels(self):
        ref,mic=signals(seconds=3)
        for input in (mic,ref*.2):
            out=Clarity().run(input,ref)
            weights=out[:,[column('band_weight_'+b) for b in BANDS]]
            scores=out[:,[column('band_match_'+b) for b in BANDS]]
            valid=out[:,column('usable_bands')]>0
            np.testing.assert_allclose(weights[valid].sum(axis=1),1,atol=1e-12)
            np.testing.assert_allclose((weights*scores).sum(axis=1),out[:,1],atol=1e-12)
            for group,total in (('band_input_level',3),('band_reference_level',4)):
                levels=out[:,[column(group+'_'+b) for b in BANDS]]
                np.testing.assert_allclose(levels.sum(axis=1),out[:,total],atol=1e-12)
            for group in ('band_input_variation','band_reference_variation'):
                self.assertTrue(np.all(out[:,[column(group+'_'+b) for b in BANDS]]>=0))

    def test_silent_bands_do_not_look_like_usable_or_supported_evidence(self):
        zero=np.zeros(44100)
        out=Clarity().run(zero,zero)
        self.assertFalse(out[:,column('usable_band_mask')].any())
        self.assertFalse(out[:,column('reference_supported_band_mask')].any())
        self.assertFalse(out[:,[column('band_weight_'+b) for b in BANDS]].any())
        self.assertFalse(out[:,column('partial_reference_windows')].any())

    def test_partial_status_requires_three_consecutive_supported_windows(self):
        mic,ref=partial_signals()
        out=Clarity().run(mic,ref)
        windows=out[np.flatnonzero(np.diff(out[:,column('lifetime_windows')],prepend=0)>0)]
        partial=np.flatnonzero(windows[:,0]==10)
        self.assertGreater(len(partial),0)
        for index in partial:
            self.assertGreaterEqual(index,2)
            previous=windows[index-2:index+1]
            self.assertTrue(np.all(previous[:,column('reference_supported_band_mask')]>0))
            self.assertTrue(np.all(previous[:,1]<.72))
        self.assertEqual(out[-1,column('partial_reference_windows')],len(partial))

    def test_context_reset_clears_all_new_evidence_and_preserves_lifetime_count(self):
        mic,ref=partial_signals()
        engine=Clarity()
        before=engine.run(mic,ref)
        self.assertGreater(before[-1,column('band_reference_windows_high')],0)
        after=engine.run(mic[:1],ref[:1],epoch=2)
        self.assertFalse(after[:,33:].any())
        self.assertEqual(after[0,column('lifetime_windows')],before[-1,column('lifetime_windows')])
        after=engine.run(mic[:22050],ref[:22050],epoch=2)
        self.assertFalse(after[:,33:].any())
        self.assertTrue(np.all(after[:,0]==1))

    def test_profile_mode_permission_and_clipping_revoke_band_evidence_immediately(self):
        mic,ref=partial_signals()
        for params,kwargs,state in (({'profilevalid':0},{},8),
                                    ({'sourcemode':2},{},9),({}, {'permit':0},0),
                                    ({},{'clipped':True},2)):
            engine=Clarity(); engine.run(mic,ref)
            engine.set(**params)
            input=mic[:1].copy()
            if kwargs.pop('clipped',False):input[0]=1
            after=engine.run(input,ref[:1],**kwargs)
            self.assertEqual(after[0,0],state)
            self.assertFalse(after[:,33:].any())
            self.assertEqual(after[0,column('voice_confirmed')],0)

    def test_partial_evidence_never_opens_real_preflight_evaluation(self):
        mic,ref=partial_signals()
        p=ready(quality=0,offsetms=0)
        pre=p.run(mic,ref)
        out=Clarity().run(mic,ref,permit=pre[:,1],epoch=pre[:,9],offset=pre[:,11])
        self.assertTrue(np.any(out[:,0]==10))
        self.assertFalse(pre[:,2].any())
        self.assertFalse(out[:,column('voice_confirmed')].any())

    def test_all_new_fields_are_export_only_and_frozen_before_file_dialog(self):
        g=ClarityGraph().initialized()
        for i,name in enumerate(NEW_FIELDS):g.state['root/aq-'+name]['signal_sample']=i+.25
        g.send('root/aq-poll')
        for name in NEW_FIELDS:self.assertNotIn('clarity_'+name,g.state['root/asrc-report']['data'])
        g.send('root/asrc-popup/export',(1,))
        frozen=dict(g.state['root/aq-export-dict']['data'])
        for i,name in enumerate(NEW_FIELDS):
            self.assertEqual(frozen['clarity_'+name],(i+.25,))
            g.emit('root/aq-'+name,(0,))
        self.assertEqual(g.state['root/aq-export-dict']['data'],frozen)
        self.assertFalse(g.calls)


if __name__=='__main__':unittest.main()
