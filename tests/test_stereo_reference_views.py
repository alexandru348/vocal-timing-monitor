"""Fixed reference-view tests; no real voice or room accuracy claims."""
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch
import json
import numpy as np
from scipy.signal import butter, sosfilt
import assistant_clarity
from assistant_clarity import make_clarity_patch, write_diagnostic, STATES
from assistant_test_setup import load_test_setup
from clarity_harness import Clarity
from test_assistant_clarity import signals, column, ClarityGraph
from test_static import boxmap
from latency_harness import shifted


def stereo(sr=44100, seconds=3):
    t = np.arange(round(sr*seconds))/sr
    left = sum((.12+.08*np.sin(2*np.pi*r*t))*np.sin(2*np.pi*f*t)
               for f,r in ((140,2.3),(750,4.1),(3100,6.7)))
    right = sum((.12+.08*np.sin(2*np.pi*r*t+1))*np.sin(2*np.pi*f*t+.3)
                for f,r in ((180,3.1),(1100,7.1),(4000,5.9)))
    return left, right


class StereoReferenceTests(unittest.TestCase):
    def test_phase_cancellation_reference_is_not_treated_as_distinct_sound(self):
        for sr in (44100, 48000, 96000):
            left, other = signals(sr, seconds=3)
            right = -left+.7*other
            mic = .4*shifted((left+right)*.5, sr, 92)
            out = Clarity(sr).run(mic, left, right_ref=right, offset=92)
            tail = out[sr:]
            self.assertTrue(np.any(tail[:,0] == 5))
            self.assertFalse(np.any(tail[:,0] == 6))
            self.assertEqual(out[-1,column('reference_model')], 1)
            self.assertGreater(out[-1,1], .90)
            self.assertGreater(out[-1,1]-out[-1,column('peak_reference_match')], .3)
            self.assertFalse(out[:,column('voice_confirmed')].any())

    def test_left_right_and_equal_mix_views_match_stereo_playback(self):
        for weight, model in ((0,2),(.5,1),(1,3)):
            left, right = stereo()
            mic = .2*shifted((1-weight)*left+weight*right, 44100, 92)
            out = Clarity().run(mic, left, right_ref=right, offset=92)
            self.assertEqual(out[-1,0], 5)
            self.assertEqual(out[-1,column('reference_model')], model)
            self.assertGreater(out[-1,1], .85)
            self.assertTrue(np.all(out[:,1] >= out[:,column('peak_reference_match')]))

    def test_colored_reverberant_mix_can_remain_uncertain_without_confirming_voice(self):
        left, right = stereo(seconds=4)
        room = sosfilt(butter(2,1000,fs=44100,output='sos'), .65*left+.35*right)
        mic = .30*shifted(room,44100,92)+.15*shifted(room,44100,130)+.12*shifted(room,44100,175)
        out = Clarity().run(mic,left,right_ref=right,offset=92)
        self.assertGreater(out[-1,1]-out[-1,column('peak_reference_match')], .1)
        self.assertFalse(out[:,column('voice_confirmed')].any())
        self.assertIn(out[-1,0], (5,7,10))

    def test_signed_offsets_keep_diagnostics_bounded_and_do_not_change_compensation(self):
        left,right=stereo()
        for offset in (-92,0,92,500):
            out=Clarity().run(.2*shifted((left+right)*.5,44100,offset),left,
                              right_ref=right,offset=offset)
            self.assertEqual(out[-1,0],5)
            self.assertTrue(np.all(np.abs(out[:,column('comparison_lag_ms')]) <= 20))
            bands=out[:,[column('band_match_low'),column('band_match_mid'),column('band_match_high')]]
            self.assertTrue(np.all((bands>=0) & (bands<=1)))
            self.assertTrue(np.all((out[:,column('usable_bands')]>=0) & (out[:,column('usable_bands')]<=3)))

    def test_new_views_reset_immediately_and_never_read_stale_ring_data(self):
        left,right=stereo(seconds=2)
        engine=Clarity()
        engine.run(.2*(left+right)*.5,left,right_ref=right)
        changed=engine.run(left[:1]*0,left[:1],right_ref=right[:1],epoch=2)
        self.assertTrue(np.all(changed[:,25:]==0))
        # Less than the full window remains at 'listening', after reset.
        out=engine.run(left[:22050]*0,left[:22050],right_ref=right[:22050],epoch=2)
        self.assertTrue(np.all(out[:,0]==1))
        self.assertFalse(out[:,25:].any())

    def test_stereo_chunk_boundaries_do_not_change_results(self):
        left,right=stereo(seconds=2)
        mic=.2*shifted((left+right)*.5,44100,92)
        expected=Clarity().run(mic,left,right_ref=right,offset=92)
        engine=Clarity()
        actual=np.concatenate([engine.run(mic[i:i+997],left[i:i+997],right_ref=right[i:i+997],offset=92)
                               for i in range(0,len(mic),997)])
        np.testing.assert_array_equal(actual,expected)

    def test_no_voice_claim_from_modulated_noise_or_mixture(self):
        left,right=stereo()
        t=np.arange(len(left))/44100
        noise=np.random.default_rng(42).normal(0,.02,len(left))*(1+.8*np.sin(2*np.pi*3.7*t))
        for mic in (noise,.2*(left+right)*.5+noise):
            out=Clarity().run(mic,left,right_ref=right)
            self.assertFalse(out[:,column('voice_confirmed')].any())
        self.assertNotIn('distinct',STATES[6].lower())

    def test_new_telemetry_is_frozen_in_export_with_previous_fields(self):
        g=ClarityGraph().initialized()
        values=dict(reference_model=1,comparison_lag_ms=-10,band_match_low=.8,
                    band_match_mid=.7,band_match_high=.6,usable_bands=3,
                    input_variation=.2,peak_reference_match=.3)
        for name,value in values.items():g.state['root/aq-'+name]['signal_sample']=value
        g.send('root/aq-poll')
        for name in values:self.assertNotIn('clarity_'+name,g.state['root/asrc-report']['data'])
        g.send('root/asrc-popup/export',(1,))
        frozen=dict(g.state['root/aq-export-dict']['data'])
        for name,value in values.items():self.assertEqual(frozen['clarity_'+name],(value,))
        g.emit('root/aq-reference_model',(3,))
        self.assertEqual(g.state['root/aq-export-dict']['data'],frozen)
        self.assertFalse(g.calls)


class PublicAndLocalBuildTests(unittest.TestCase):
    def test_default_export_is_generic_without_personal_values_or_setup_objects(self):
        with tempfile.TemporaryDirectory() as folder:
            with patch.object(assistant_clarity,'ROOT',Path(folder)):
                path=write_diagnostic()
            data=json.loads(path.with_suffix('.maxpat').read_text())
            self.assertEqual(data,make_clarity_patch())
            text=json.dumps(data)
            for value in ('Test Reference Beat','91.25','test-setup-'):
                self.assertNotIn(value,text)
            controls=boxmap(boxmap(data['patcher'])['popup']['patcher'])
            self.assertEqual(controls['offsetms']['saved_attribute_attributes']['valueof']['parameter_initial'],[0.])
            self.assertEqual(controls['persist-type']['restore'],['__vtm_unset__'])

    def test_personal_build_requires_an_explicit_location_outside_repository(self):
        profile=load_test_setup()
        for output in (None,assistant_clarity.ROOT/'dist',assistant_clarity.ROOT/'personal'):
            with self.assertRaises(ValueError):write_diagnostic(test_setup=profile,output=output)
        with tempfile.TemporaryDirectory() as folder:
            path=write_diagnostic(test_setup=profile,output=Path(folder))
            data=json.loads(path.with_suffix('.maxpat').read_text())
            self.assertEqual(data,make_clarity_patch(test_setup=profile))
            self.assertIn('Test Reference Beat',json.dumps(data))

    def test_existing_diagnostic_cannot_be_silently_overwritten(self):
        with tempfile.TemporaryDirectory() as folder:
            path=write_diagnostic(output=Path(folder))
            previous=path.read_bytes()
            with self.assertRaises(FileExistsError):
                write_diagnostic(test_setup=load_test_setup(),output=Path(folder))
            self.assertEqual(path.read_bytes(),previous)


if __name__=='__main__':unittest.main()
