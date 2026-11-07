"""New session workflow: generated message graph plus exact onset arithmetic.

No native Max compiler, scheduler, serialization or Live recording is executed.
"""
import unittest
import numpy as np
from gen_harness import Engine, pulse_train
from max_event_model import Graph
from test_latency import result


def intent(g):
    return g.state['root/popup/autostop']['value']


def host_play(g, playing):
    g.playing=bool(playing)
    g.emit('root/as-play-observer',(int(playing),))
    g.emit('root/lat-observe-3',(int(playing),))


def wait_audio(g, milliseconds):
    """Keep the independent DSP heartbeat live while advancing model timers."""
    for _ in range(int(milliseconds/20)):
        g.emit('root/heartbeat-snapshot',(g.now*44.1+8820.,))
        g.advance(20);g.drain()


class SessionIntentTests(unittest.TestCase):
    def ready(self):
        g=Graph();g.initialize({'VTM Compensation ms':92.885786})
        g.toggle_stop_at_idle_poll();return g

    def test_five_take_retries_keep_on_without_button_reactivation(self):
        g=self.ready()
        for n in range(5):
            if n:
                host_play(g,1);g.emit('root/snapshot-7',(1,))
                g.emit('root/snapshot-2',(0,))
            g.emit('root/snapshot-2',(1,));g.drain()
            self.assertEqual(len(g.calls),n+1)
            self.assertEqual(intent(g),1)
            self.assertEqual(g.params['autostop'],0)  # spent, not user OFF
            host_play(g,0);g.emit('root/snapshot-7',(0,))
            g.emit('root/snapshot-2',(0,))
        self.assertEqual(intent(g),1)

    def test_deferred_old_request_cannot_stop_next_take(self):
        g=self.ready();g.emit('root/snapshot-2',(1,))
        host_play(g,0);host_play(g,1)
        g.emit('root/snapshot-2',(0,));g.drain()
        self.assertFalse(g.calls);self.assertEqual(intent(g),1)
        g.emit('root/snapshot-2',(1,));g.drain()
        self.assertEqual(len(g.calls),1)

    def test_explicit_off_on_cannot_revive_queued_request(self):
        g=self.ready();g.emit('root/snapshot-2',(1,))
        g.click('autostop');g.click('autostop')
        g.emit('root/snapshot-2',(0,));g.drain()
        self.assertFalse(g.calls);self.assertEqual(intent(g),1)
        g.emit('root/snapshot-2',(1,));g.drain()
        self.assertEqual(len(g.calls),1)

    def test_start_requires_fresh_dsp_low_not_previous_red(self):
        g=self.ready();g.emit('root/snapshot-2',(1,));g.drain()
        host_play(g,0);host_play(g,1)
        g.emit('root/snapshot-7',(1,));g.emit('root/snapshot-2',(1,));g.drain()
        self.assertEqual(len(g.calls),1)
        self.assertEqual(g.params['autostop'],0)
        g.emit('root/snapshot-2',(0,))
        self.assertEqual(g.params['autostop'],1)
        g.emit('root/snapshot-2',(1,));g.drain()
        self.assertEqual(len(g.calls),2)

    def test_unconfirmed_stop_never_retries_during_same_transport_run(self):
        g=self.ready();g.simulate_stop_effect=False
        g.emit('root/snapshot-2',(1,));g.drain();g.advance(151);g.drain()
        for _ in range(4):
            g.emit('root/snapshot-2',(0,));g.emit('root/snapshot-2',(1,));g.drain()
        self.assertEqual(len(g.calls),1);self.assertEqual(intent(g),1)
        self.assertIn('Live inca reda',' '.join(g.state['root/popup/api-text']['label']))

    def test_clock_flicker_does_not_replenish_spent_attempt(self):
        g=self.ready();g.simulate_stop_effect=False
        g.emit('root/snapshot-2',(1,));g.drain()
        g.emit('root/snapshot-7',(0,));g.emit('root/snapshot-2',(0,))
        g.emit('root/snapshot-7',(1,));g.emit('root/snapshot-2',(1,));g.drain()
        self.assertEqual(len(g.calls),1);self.assertEqual(intent(g),1)

    def test_loss_recovery_before_defer_never_revives_old_request(self):
        for lose,recover in [
            (('root/snapshot-7',(0,),0),('root/snapshot-7',(1,),0)),
            (('root/thisdevice',(0,),1),('root/thisdevice',(1,),1)),
            (('root/audio-off',(0,),0),('root/audio-on',(1,),0)),
        ]:
            g=self.ready();g.emit('root/snapshot-2',(1,))
            for source,msg,outlet in (lose,recover):g.emit(source,msg,outlet)
            g.emit('root/snapshot-2',(0,));g.drain()
            self.assertFalse(g.calls);self.assertEqual(intent(g),1)

    def test_reset_and_timing_edits_keep_intent_but_cancel_pending_request(self):
        for control,value in [('grid-ui',1),('redms',80),('offsetms',93.),('gatedb',-25),('reset',1)]:
            g=self.ready();g.emit('root/snapshot-2',(1,))
            g.send('root/popup/'+control,(value,));g.drain()
            self.assertFalse(g.calls);self.assertEqual(intent(g),1)

    def test_popup_close_open_and_save_do_not_clear_on_but_new_instance_does(self):
        g=self.ready();g.send('root/open',(1,));g.click('settings')
        saved=g.saved_parameters();self.assertEqual(intent(g),1)
        g.send('root/open',(1,));self.assertEqual(intent(g),1)
        fresh=Graph();fresh.initialize(saved)
        self.assertEqual(intent(fresh),0);self.assertEqual(fresh.params['offsetms'],92.885786)
        self.assertFalse(fresh.calls)


class AutomaticCalibrationTests(unittest.TestCase):
    def ready(self,saved=None):
        g=Graph();g.initialize(saved);g.emit('root/beat-peak',(.2,));return g

    def test_first_reference_playback_starts_without_button(self):
        g=self.ready();wait_audio(g,1020)
        self.assertEqual(g.state['root/lat-request-counter']['value'],1)
        self.assertEqual(g.state['root/ac-state']['values'][5],1)
        self.assertFalse(g.calls)

    def test_saved_or_legacy_nonzero_compensation_is_reused(self):
        for saved in [{'VTM Compensation ms':92.885786},
                      {'VTM Compensation ms':0.,'VTM Compensation valid':1}]:
            g=self.ready(saved);wait_audio(g,1600)
            self.assertNotIn('value',g.state['root/lat-request-counter'])
            self.assertEqual(g.params['offsetms'],saved['VTM Compensation ms'])

    def test_conclusive_zero_is_marked_valid_and_survives_reopen(self):
        g=self.ready();wait_audio(g,1020);result(g,0.)
        self.assertEqual(g.saved_parameters()['VTM Compensation valid'],1)
        fresh=self.ready(g.saved_parameters());wait_audio(fresh,1600)
        self.assertNotIn('value',fresh.state['root/lat-request-counter'])

    def test_auto_off_is_saved_and_blocks_scheduling(self):
        g=self.ready();g.click('auto-calibrate');wait_audio(g,1600)
        self.assertNotIn('value',g.state['root/lat-request-counter'])
        saved=g.saved_parameters();self.assertEqual(saved['VTM Automatic calibration'],0)
        fresh=self.ready(saved);wait_audio(fresh,1600)
        self.assertEqual(fresh.state['root/popup/auto-calibrate']['value'],0)
        self.assertNotIn('value',fresh.state['root/lat-request-counter'])

    def test_no_instrumental_never_starts(self):
        g=Graph();g.initialize();wait_audio(g,2000)
        self.assertNotIn('value',g.state['root/lat-request-counter'])

    def test_all_recording_modes_and_autostop_block_scheduling(self):
        for source,value in [('root/lat-observe-0',1),('root/lat-observe-1',1),
                             ('root/lat-observe-2',1),('root/lat-observe-0',-1),
                             ('root/lat-observe-3',-1)]:
            g=self.ready();g.emit(source,(value,));wait_audio(g,1600)
            self.assertNotIn('value',g.state['root/lat-request-counter'])
        g=self.ready();g.toggle_stop_at_idle_poll();wait_audio(g,1600)
        self.assertNotIn('value',g.state['root/lat-request-counter'])
        self.assertEqual(intent(g),1)

    def test_rec_before_timer_expires_cancels_pending_start(self):
        g=self.ready();wait_audio(g,500);g.emit('root/lat-observe-0',(1,))
        wait_audio(g,800);self.assertNotIn('value',g.state['root/lat-request-counter'])

    def test_rec_before_deferred_success_prevents_value_write(self):
        g=self.ready();wait_audio(g,1020);result(g,93.,drain=False)
        g.emit('root/lat-observe-0',(1,));g.drain()
        self.assertEqual(g.params['offsetms'],0)
        self.assertEqual(g.saved_parameters()['VTM Compensation valid'],0)

    def test_rejection_does_not_loop_or_mark_zero_valid(self):
        g=self.ready();wait_audio(g,1020);result(g,0.,status=4)
        wait_audio(g,3000)
        self.assertEqual(g.state['root/lat-request-counter']['value'],1)
        self.assertEqual(g.saved_parameters()['VTM Compensation valid'],0)
        host_play(g,0);host_play(g,1);wait_audio(g,1020)
        self.assertEqual(g.state['root/lat-request-counter']['value'],2)

    def test_off_during_auto_measurement_cancels_it(self):
        g=self.ready();wait_audio(g,1020);g.click('auto-calibrate')
        self.assertEqual(g.state['root/lat-accept-pak']['values'][1],0)
        result(g,93.);self.assertEqual(g.params['offsetms'],0)

    def test_off_does_not_cancel_manual_calibration(self):
        g=self.ready({'VTM Compensation ms':37.5});g.click('calibrate')
        g.click('auto-calibrate');result(g,93.)
        self.assertEqual(g.params['offsetms'],93.)


class RepeatedTakePcmTests(unittest.TestCase):
    def test_five_bad_takes_then_on_grid_with_one_user_activation(self):
        for sr in (44100,48000,96000):
            g=Graph();g.initialize({'VTM Compensation ms':92.885786})
            e=Engine(sr=sr);g.click('autostop')
            def run(audio,playing):
                initial_calls=len(g.calls)
                block_size=round(sr*.02)
                for start in range(0,len(audio),block_size):
                    e.set(**g.params);e.play=playing
                    frame=e.run(left=audio[start:start+block_size])[-1]
                    for i in range(10):g.state['root/snapshot-'+str(i)]['signal_sample']=float(frame[i])
                    g.state['root/heartbeat-snapshot']['signal_sample']=float(frame[10])
                    g.advance(20);g.emit('root/qmetro');g.drain()
                    if len(g.calls)>initial_calls:break
            for take in range(6):
                if take:
                    host_play(g,0);run(np.zeros(round(sr*.08)),False)
                    host_play(g,1)
                e.time=0
                times=[.6+.092885786,1.2+.092885786,1.8+.092885786+(0.15 if take<5 else 0)]
                run(pulse_train(sr,2.2,times),True)
                self.assertEqual(len(g.calls),min(take+1,5),(sr,take))
                self.assertEqual(intent(g),1)
                self.assertAlmostEqual(g.params['offsetms'],92.885786)
            self.assertEqual(len(g.calls),5)


if __name__=='__main__':unittest.main()
