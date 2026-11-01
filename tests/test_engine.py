import unittest
import numpy as np
from pathlib import Path
import wave
from gen_harness import Engine, pulse_train, events


class DSPTests(unittest.TestCase):
    def test_delivered_pcm_acceptance_file(self):
        path = Path(__file__).resolve().parents[1]/'test_audio/VTM_TEST_100BPM.wav'
        with wave.open(str(path),'rb') as w:
            self.assertEqual(w.getnchannels(),1)
            self.assertEqual(w.getsampwidth(),2)
            sr=w.getframerate()
            audio=np.frombuffer(w.readframes(w.getnframes()),dtype='<i2').astype(float)/32768
        for autostop in [0,1]:
            e=Engine(sr,autostop=autostop,apiready=1)
            out=e.run(left=audio); ix,ev=events(out)
            self.assertEqual(len(ev),8)
            self.assertLess(np.max(np.abs(ev[:7,0])),1)
            self.assertAlmostEqual(ev[-1,0],120,delta=1)
            self.assertFalse(out[:ix[-1],2].any())
            self.assertEqual(out[ix[-1],2],autostop)

    def test_eight_quarter_pulses_and_sample_rates(self):
        for sr in [44100, 48000, 96000]:
            with self.subTest(sr=sr):
                e = Engine(sr)
                a = pulse_train(sr, 5.5, [.6*i for i in range(1, 9)])
                out = e.run(left=a)
                ix, ev = events(out)
                self.assertEqual(len(ix), 8)
                self.assertLess(np.max(np.abs(ev[:, 0])), 1)
                self.assertTrue(np.all(ev[:, 3] == 4))
                self.assertTrue(np.all(out[:, 2] == 0))

    def test_signed_offsets(self):
        for offset in [-.120, -.050, 0, .050, .120, .290]:
            with self.subTest(offset=offset):
                e = Engine(); a = pulse_train(e.sr, 1.4, [.6+offset])
                _, ev = events(e.run(left=a))
                self.assertEqual(len(ev), 1)
                self.assertAlmostEqual(ev[0, 0], offset * 1000, delta=1)

    def test_confirmation_keeps_original_timestamp(self):
        e = Engine(); a = pulse_train(e.sr, 1., [.600])
        ix, ev = events(e.run(left=a))
        self.assertGreater(ix[0] / e.sr, .601)
        self.assertLess(abs(ev[0, 0]), 1.)

    def test_stereo_antiphase_and_right_only(self):
        for right_only in [False, True]:
            e = Engine(); a = pulse_train(e.sr, 1.4, [.6, 1.2])
            _, ev = events(e.run(left=np.zeros_like(a) if right_only else a, right=-a))
            self.assertEqual(len(ev), 2)

    def test_grid_eighth_and_sixteenth(self):
        for grid, step in [(8, .3), (16, .15)]:
            e = Engine(grid=grid)
            a = pulse_train(e.sr, 2., [.6+i*step for i in range(8)])
            expected = sum(.6+i*step < 2. for i in range(8))
            _, ev = events(e.run(left=a))
            self.assertEqual(len(ev), expected)
            self.assertLess(abs(ev[:, 0]).max(), 1.)

    def test_nearest_grid_wrap_and_unreachable_threshold(self):
        e = Engine(grid=16, autostop=1, apiready=1)
        a = pulse_train(e.sr, 1.4, [.7, 1.3])
        out = e.run(left=a); _, ev = events(out)
        self.assertAlmostEqual(ev[0, 0], -50., delta=1.)
        self.assertAlmostEqual(out[-1, 8], 75., places=5)
        self.assertFalse(out[:, 2].any())

    def test_latency_compensation_and_sign(self):
        for offset in [35, 120, -80]:
            e = Engine(offsetms=offset)
            a = pulse_train(e.sr, 1.4, [.6+offset/1000])
            _, ev = events(e.run(left=a))
            self.assertLess(abs(ev[0, 0]), 1.)
            self.assertAlmostEqual(ev[0, 6], offset, delta=1.)

    def test_autostop_first_large_event(self):
        e = Engine(autostop=1, apiready=1)
        a = pulse_train(e.sr, 1.6, [.6, 1.32])
        out = e.run(left=a); ix, ev = events(out)
        self.assertFalse(out[:ix[1], 2].any())
        self.assertEqual(out[ix[1], 2], 1)
        self.assertEqual(out[ix[1], 3], 9)
        # One latched request; no per-frame stop spam.
        self.assertEqual(np.count_nonzero(np.diff(out[:, 2]) > 0), 1)

    def test_autostop_off_and_api_unavailable(self):
        for params in [dict(), dict(autostop=1, apiready=0)]:
            e = Engine(**params); a = pulse_train(e.sr, 1., [.72])
            out = e.run(left=a)
            self.assertEqual(out[-1, 1], 1)
            self.assertFalse(out[:, 2].any())

    def test_disarm_and_cancel_pending_request(self):
        for param in ['autostop', 'enabled', 'apiready']:
            e = Engine(autostop=1, apiready=1)
            a = pulse_train(e.sr, 1., [.72]); self.assertEqual(e.run(left=a)[-1, 2], 1)
            e.set(**{param: 0})
            self.assertFalse(e.run(seconds=.04)[:, 2].any())
        e = Engine(autostop=1, apiready=1)
        e.run(left=pulse_train(e.sr, 1., [.72])); e.play=0
        self.assertFalse(e.run(seconds=.04)[:, 2].any())

    def test_test_button_without_sync_and_without_play(self):
        for play in [0, 1]:
            e = Engine(autostop=1, apiready=1)
            e.play=play; e.set(testseq=1)
            out = e.run(seconds=.2, phase=np.zeros(8820))
            self.assertEqual(out[-1, 5], 1)
            self.assertEqual(out[-1, 1], 0)
            self.assertEqual(out[-1, 3], 8)
            self.assertEqual(out[-1, 9], 0)
            self.assertFalse(out[:, 2].any())

    def test_test_button_synced_never_autostops(self):
        e = Engine(autostop=1, apiready=1)
        e.run(seconds=.72); e.set(testseq=1)
        out = e.run(seconds=.1)
        self.assertEqual(out[-1, 5], 1)
        self.assertEqual(out[-1, 1], 0)
        self.assertEqual(out[-1, 9], 1)
        self.assertGreater(abs(out[-1, 0]), 100)
        self.assertFalse(out[:, 2].any())

    def test_test_without_sync_is_not_retroactively_upgraded(self):
        e = Engine(); e.set(testseq=1)
        out = e.run(seconds=.2)
        self.assertEqual(out[-1, 7], 1)  # clock has recovered
        self.assertEqual(out[-1, 3], 8)  # test was unmeasured
        self.assertEqual(out[-1, 9], 0)

    def test_random_offsets_stay_inside_nearest_grid(self):
        rng = np.random.default_rng(31)
        for k in range(60):
            e = Engine(grid=int(rng.choice([4, 8, 16])), offsetms=float(rng.uniform(-500, 500)))
            e.bpm = float(rng.uniform(20, 400))
            e.run(seconds=.1)
            e.set(testseq=1)
            out = e.run(seconds=.001)
            self.assertEqual(out[-1, 9], 1)
            self.assertLessEqual(abs(out[-1, 0]), out[-1, 8] + .0001)

    def test_analysis_switch_disables_detection(self):
        for params in [dict(enabled=0)]:
            e = Engine(**params)
            out = e.run(left=pulse_train(e.sr, 1.4, [.6, 1.2]))
            self.assertFalse(out[:, 1].any())
            self.assertFalse(out[:, 2].any())

    def test_silence_noise_and_sustained_sound(self):
        e = Engine()
        rng = np.random.default_rng(4)
        a = rng.normal(0, .001, 88200)
        out = e.run(left=a)
        self.assertFalse(out[:, 1].any())
        e = Engine(); t = np.arange(88200)/44100
        a = .3*np.cos(2*np.pi*1800*t)*(t >= .6)
        out = e.run(left=a)
        self.assertEqual(out[-1, 1], 1)

    def test_phase_clock_stall_and_recovery(self):
        e = Engine(); e.run(seconds=.4)
        out = e.run(left=pulse_train(e.sr, 1., [.2, .8]), phase=np.zeros(44100))
        self.assertFalse(out[:, 1].any())
        self.assertEqual(out[-1, 7], 0)
        self.assertEqual(out[-1, 3], 1)
        out = e.run(left=pulse_train(e.sr, 1., [.4]))
        self.assertEqual(out[-1, 1], 1)
        self.assertEqual(out[-1, 7], 1)

    def test_reset_clears_counters_and_measurement(self):
        e = Engine(); e.run(left=pulse_train(e.sr, 1., [.6]))
        e.set(resetseq=1)
        out = e.run(seconds=.1)
        self.assertFalse(out[:, 1].any())
        self.assertEqual(out[-1, 9], 0)
        self.assertEqual(out[-1, 3], 3)

    def test_tempo_range_and_change(self):
        for bpm in [20, 60, 100, 153, 250, 400]:
            e = Engine(); e.bpm = bpm
            out = e.run(seconds=.1)
            self.assertEqual(out[-1, 7], 1)
            self.assertAlmostEqual(out[-1, 8], 30000 / bpm, places=5)
        e = Engine(); e.run(seconds=.6); e.bpm = 153
        out = e.run(seconds=.1)
        self.assertEqual(out[-1, 7], 1)
        self.assertAlmostEqual(out[-1, 8], 30000/153, places=5)

    def test_loop_and_seek_discontinuity(self):
        e = Engine(); e.run(seconds=.8)
        n = 44100; phase = (np.arange(n)*100/(60*44100)) % 1
        out = e.run(seconds=1., phase=phase)
        self.assertEqual(out[0, 7], 0)
        self.assertEqual(out[-1, 7], 1)
        self.assertFalse(out[:, 2].any())


if __name__ == '__main__':
    unittest.main()
