import unittest
from max_event_model import Graph


class MessageTests(unittest.TestCase):
    def ready(self):
        g=Graph(); g.initialize(); return g

    def test_lifecycle_initializes_controls_and_engine(self):
        g=self.ready()
        for name,value in dict(enabled=1,autostop=0,grid=4,redms=100,offsetms=0,apiready=1).items():
            self.assertEqual(g.params[name],value)
        self.assertAlmostEqual(g.params['gateamp'],10**(-32/20))
        self.assertEqual(g.calls,[])

    def test_open_reopen_and_test_clicks(self):
        g=self.ready()
        for _ in range(2):
            g.send('root/open',(1,)); self.assertEqual(g.calls,[])
        self.assertEqual(g.openings,2)
        for expected in [1,2,3]:
            g.click('test'); self.assertEqual(g.params['testseq'],expected)
        self.assertFalse(g.calls)

    def test_native_stop_disarms_before_single_call(self):
        g=self.ready(); g.click('autostop')
        self.assertEqual(g.params['autostop'],1)
        g.emit('root/snapshot-2',(1,)); self.assertFalse(g.calls)
        g.drain()
        self.assertEqual(g.params['autostop'],0)
        self.assertEqual(g.calls,[('call','stop_playing')])
        g.emit('root/snapshot-2',(1,)); g.drain()
        self.assertEqual(len(g.calls),1)

    def test_off_after_queued_request_cancels_stop(self):
        g=self.ready(); g.click('autostop')
        g.emit('root/snapshot-2',(1,))
        g.click('autostop'); g.drain()
        self.assertFalse(g.calls)

    def test_clock_loss_after_queued_request_cancels_stop(self):
        g=self.ready(); g.click('autostop')
        g.emit('root/snapshot-2',(1,))
        g.emit('root/snapshot-7',(0,)); g.drain()
        self.assertFalse(g.calls)

    def test_queued_stop_is_cancelled_by_reset_and_disable(self):
        for action in ['reset','enabled']:
            g=self.ready(); g.click('autostop'); g.emit('root/snapshot-2',(1,))
            g.click(action); g.drain(); self.assertFalse(g.calls)

    def test_queued_stop_cancelled_by_transport_api_and_bypass(self):
        for id,msg,outlet in [('root/snapshot-7',(0,),0),
            ('root/thisdevice',(0,),1),('root/live-path',('id',0),1)]:
            g=self.ready(); g.click('autostop'); g.emit('root/snapshot-2',(1,))
            g.emit(id,msg,outlet); g.drain(); self.assertFalse(g.calls)

    def test_settings_changes_disarm(self):
        for control,value in [('grid-ui',1),('redms',80),('offsetms',23)]:
            g=self.ready(); g.click('autostop')
            g.send('root/popup/'+control,(value,))
            self.assertEqual(g.params['autostop'],0)

    def test_calibration_routes_raw_value_and_guards_grid(self):
        g=self.ready(); g.send('root/popup',('raw',35.4)); g.send('root/popup',('count',8))
        g.click('calibrate'); self.assertAlmostEqual(g.params['offsetms'],35.4)
        g.send('root/popup/grid-ui',(1,)); g.send('root/popup',('raw',120))
        g.click('calibrate'); self.assertAlmostEqual(g.params['offsetms'],35.4)

    def test_zero_deviation_is_visible_only_after_measurement(self):
        g=self.ready(); g.send('root/popup',('hasdelta',0)); g.send('root/popup',('delta',0.))
        self.assertEqual(g.state['root/popup/delta-text']['label'],('--',))
        g.send('root/popup',('hasdelta',1)); g.send('root/popup',('delta',0.))
        self.assertEqual(g.state['root/popup/delta-text']['label'],('+0.0 ms',))


if __name__=='__main__': unittest.main()
