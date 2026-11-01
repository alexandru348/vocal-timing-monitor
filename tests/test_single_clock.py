"""Integrated arithmetic + message simulation, NOT a run inside Max/Ableton.

The generated Gen arithmetic processes PCM at sample rate. Its outputs feed
the generated native message graph at simulated 20 ms polling boundaries.
Cycling74's compiler, scheduler, host phase source and audio routing are absent.
"""
from pathlib import Path
import re
import unittest
import wave
import numpy as np
from gen_harness import Engine, pulse_train
from max_event_model import Graph
from test_static import PATCH, boxmap

ROOT = Path(__file__).resolve().parents[1]


class Pipeline:
    def __init__(self):
        self.g = Graph(); self.g.initialize()
        self.e = Engine(); self.previous = {}

    def run(self, audio, arm_at=None, flag_at=None):
        frames = []
        for start in range(0, len(audio), 882):
            if arm_at is not None and start >= arm_at * self.e.sr:
                self.g.click('autostop'); arm_at = None
            if flag_at is not None and start >= flag_at[0] * self.e.sr:
                _, value, outlet = flag_at
                self.g.emit('root/thisdevice', (value,), outlet); flag_at = None
            updates = {k:v for k,v in self.g.params.items() if self.previous.get(k) != v}
            self.e.set(**updates); self.previous = dict(self.g.params)
            block = self.e.run(left=audio[start:start+882]); frame = block[-1]
            frames.append(frame)
            for i in range(10):
                self.g.state['root/snapshot-'+str(i)]['signal_sample'] = float(frame[i])
            self.g.state['root/heartbeat-snapshot']['signal_sample'] = float(frame[10])
            self.g.advance(len(block) * 1000 / self.e.sr)
            self.g.emit('root/qmetro'); self.g.drain()
            if self.g.calls:
                break
        return np.asarray(frames)

    def label(self, name):
        key = 'root/popup/'+name
        # A comment keeps its serialized text until a setter changes it.
        if 'label' not in self.g.state[key]:
            return self.g.boxes[key]['text']
        return ' '.join(map(str, self.g.state[key]['label']))


class SingleClockTests(unittest.TestCase):
    def test_only_audio_phase_and_analysis_switch_gate_detection(self):
        src = (ROOT/'src/vtm_engine.genexpr').read_text()
        params = set(re.findall(r'Param (\w+)\(', src))
        self.assertFalse({'hostplay','deviceon','preview'} & params)
        self.assertNotIn('hostsync', boxmap(PATCH['patcher']))
        self.assertIn('operating = (enabled > 0) && synced;', src)

    def test_sync_and_play_stopped_are_not_both_emitted_by_engine(self):
        e = Engine()
        for play in [1,0,1,0,1]:
            e.play = play
            out = e.run(seconds=.3)
            self.assertFalse(np.any((out[:,7] > 0) & np.isin(out[:,3], [1,2])))

    def test_test_click_after_valid_audio_clock_has_measurement(self):
        p = Pipeline(); p.run(np.zeros(8820))
        p.g.click('test'); p.run(np.zeros(4410))
        self.assertEqual(p.label('state-text'), 'TEST OK')
        self.assertEqual(p.label('tests-text'), 'Teste: 1')
        self.assertEqual(p.label('count-text'), '0')
        self.assertNotEqual(p.label('delta-text'), '--')
        self.assertFalse(p.g.calls)

    def test_large_audio_event_in_preview_reaches_one_stop_with_optin(self):
        p=Pipeline();p.g.send('root/popup/offsetms',(120.,))
        p.run(pulse_train(44100,1.5,[.6,1.2]),arm_at=.1,flag_at=(.2,1,2))
        self.assertEqual(p.label('count-text'),'1')
        self.assertEqual(p.label('delta-text'),'-120.0 ms')
        self.assertEqual(p.g.calls,[('call','stop_playing')])
        self.assertEqual(p.g.params['autostop'],0)

    def test_acceptance_pcm_reaches_engine_ui_and_first_stop(self):
        with wave.open(str(ROOT/'test_audio/VTM_TEST_100BPM.wav')) as w:
            audio = np.frombuffer(w.readframes(w.getnframes()),dtype='<i2').astype(float)/32768
        for arm in [False,True]:
            with self.subTest(autostop=arm):
                p = Pipeline(); p.run(audio, arm_at=.5 if arm else None)
                self.assertEqual(p.label('count-text'), '8')
                self.assertEqual(p.label('delta-text'), '+120.0 ms')
                self.assertEqual(p.label('clock-text'), 'Ceas audio: sincronizat')
                self.assertEqual(len(p.g.calls), int(arm))
                self.assertEqual(p.g.params['autostop'],0)
                self.assertEqual(p.label('state-text'),'OPRIRE...' if arm else 'OFF BEAT')

    def test_lifecycle_flags_do_not_block_read_only_analysis(self):
        # In this model DSP is deliberately still running. Real bypass normally
        # suspends the device; activity expiry then invalidates the display.
        for value,outlet in [(1,2),(0,1)]:
            p = Pipeline()
            a = pulse_train(44100,1.5,[.6,1.2])
            p.run(a,arm_at=.1,flag_at=(.2,value,outlet))
            self.assertEqual(p.label('count-text'),'2')
            self.assertEqual(p.label('state-text'),'ON BEAT')
            self.assertEqual(p.g.params['autostop'],1 if outlet==2 else 0)
            self.assertFalse(p.g.calls)

    def test_api_loss_disarms_and_recovery_does_not_rearm(self):
        g = Graph(); g.initialize(); g.click('autostop')
        g.emit('root/live-path',('id',0),1)
        self.assertEqual(g.params['autostop'],0)
        g.emit('root/live-path',('id',99),1)
        g.emit('root/snapshot-2',(1,)); g.drain()
        self.assertFalse(g.calls)

    def test_rejected_stop_request_is_consumed_and_disarmed(self):
        g=Graph();g.initialize()
        g.emit('root/thisdevice',(0,),1)  # disabled device is unsafe for side effects
        g.click('autostop')
        g.emit('root/snapshot-2',(1,));g.drain()
        self.assertEqual(g.params['autostop'],0)
        self.assertFalse(g.calls)
        g.emit('root/thisdevice',(1,),1)
        g.emit('root/snapshot-2',(1,));g.drain()
        self.assertFalse(g.calls)

    def test_reopening_popup_does_not_reset_engine_or_audio_count(self):
        p = Pipeline(); a = pulse_train(44100,1.4,[.6,1.2])
        p.run(a[:35280])
        self.assertEqual(p.label('count-text'),'1')
        p.g.send('root/open',(1,)); p.g.send('root/open',(0,))
        p.run(a[35280:])
        self.assertEqual(p.label('count-text'),'2')
        self.assertEqual(p.g.openings,2)

    def test_stopped_phase_disarms_pending_stop_and_blocks_audio_events(self):
        p = Pipeline(); p.run(np.zeros(8820)); p.g.click('autostop')
        p.e.play=0
        p.run(pulse_train(44100,1.,[.2,.8]))
        self.assertEqual(p.label('count-text'),'0')
        self.assertEqual(p.label('state-text'),'ASTEPT CEAS AUDIO')
        self.assertIn('indisponibil',p.label('clock-text'))
        self.assertEqual(p.g.params['autostop'],0)
        self.assertFalse(p.g.calls)

    def test_quantized_phase_and_right_only_audio_still_reach_ui(self):
        e=Engine();e.bpm=100
        n=int(1.5*e.sr)
        ph=(((np.arange(n)*100)/(60*e.sr)) % 1).astype(np.float32).astype(float)
        a=pulse_train(e.sr,1.5,[.6,1.32])
        out=e.run(left=np.zeros(n),right=a,phase=ph)
        self.assertEqual(out[-1,1],2)
        self.assertEqual(out[-1,7],1)
        self.assertAlmostEqual(out[-1,0],120,delta=2)


if __name__=='__main__': unittest.main()
