"""Declared quiet measurements describe a baseline; they cannot identify voice."""
import unittest
import numpy as np
from assistant_clarity import OUTPUTS, BACKGROUND_STATES
from clarity_harness import Clarity
from test_assistant_clarity import column, signals, ClarityGraph

BANDS = ('low', 'mid', 'high')
FIELDS = OUTPUTS[54:]


def data(sr=44100, seconds=6):
    ref, other = signals(sr, seconds)
    return .22 * other, ref


def stream(engine, mic, ref, **kw):
    """Bound harness memory while exercising DSP at the actual sample rate."""
    last = None
    for i in range(0, len(mic), 4096):
        last = engine.run(mic[i:i+4096], ref[i:i+4096], **kw)[-1].copy()
    return last


def capture(sr=44100):
    mic, ref = data(sr)
    e = Clarity(sr)
    e.run(mic[:1], ref[:1])  # Establish the context before the explicit request.
    e.set(backgroundrequest=1)
    row = stream(e, mic, ref)
    assert row[column('background_state')] == 2
    return e, row, mic, ref


class BackgroundCaptureTests(unittest.TestCase):
    def test_no_measurement_is_inferred_without_a_user_request(self):
        mic, ref = data()
        row = stream(Clarity(), mic, ref)
        self.assertFalse(row[54:].any())

    def test_five_seconds_of_complete_frames_are_required_at_each_rate(self):
        for sr in (22050, 44100, 48000, 96000):
            mic, ref = data(sr)
            e = Clarity(sr)
            e.run(mic[:1], ref[:1])
            e.set(backgroundrequest=1)
            before = stream(e, mic[:5*sr], ref[:5*sr])
            self.assertEqual(before[column('background_state')], 1)
            self.assertLess(before[column('background_duration_ms')], 5000)
            after = stream(e, mic[5*sr:], ref[5*sr:])
            self.assertEqual(after[column('background_state')], 2)
            self.assertGreaterEqual(after[column('background_duration_ms')], 5000)
            self.assertLess(after[column('background_duration_ms')], 5010.1)
            self.assertEqual(after[column('voice_confirmed')], 0)

    def test_capture_never_changes_the_existing_comparison_or_voice_output(self):
        mic, ref = data(seconds=6)
        a, b = Clarity(), Clarity()
        a.run(mic[:1], ref[:1]); b.run(mic[:1], ref[:1])
        b.set(backgroundrequest=1)
        for i in range(0, len(mic), 4096):
            x = a.run(mic[i:i+4096], ref[i:i+4096])
            y = b.run(mic[i:i+4096], ref[i:i+4096])
            np.testing.assert_array_equal(x[:, :54], y[:, :54])

    def test_reported_moments_match_independently_filtered_disjoint_frames(self):
        sr = 44100
        mic, ref = data(sr)
        e = Clarity(sr)
        e.run(mic[:1], ref[:1])
        e.set(backgroundrequest=1)
        row = stream(e, mic, ref)
        # Independent scalar filtering of the exact continuous input sequence.
        coeff = np.exp(-2*np.pi*np.array([20., 400., 1800.])/sr)
        # Context initialization resets the first sample's filter and sums.
        bands = np.empty((len(mic), 3))
        dc = low = upper = 0.
        for i, x in enumerate(mic):
            dc = x + coeff[0]*(dc-x)
            hp = x-dc
            low = hp + coeff[1]*(low-hp)
            upper = hp + coeff[2]*(upper-hp)
            bands[i] = abs(low), abs(upper-low), abs(hp-upper)
        # One leading frame plus 500 ms of settling, then 500 complete frames.
        frames = bands[:551*441].reshape(551,441,3).mean(axis=1)[51:]
        self.assertEqual(row[column('background_frames')], 500)
        for i, band in enumerate(BANDS):
            for stat, expected in [('mean', frames[:,i].mean()),
                                   ('variance', frames[:,i].var())]:
                self.assertAlmostEqual(row[column('background_'+stat+'_'+band)], expected, places=11)

    def test_completed_baseline_is_frozen_and_later_levels_remain_separate(self):
        e, before, mic, ref = capture()
        row = stream(e, 3*mic, ref)
        for band in BANDS:
            for stat in ('mean', 'variance'):
                key = column('background_'+stat+'_'+band)
                self.assertEqual(row[key], before[key])
            ratio = row[column('band_input_level_'+band)]/before[column('background_mean_'+band)]
            self.assertGreater(ratio, 2)
        self.assertEqual(row[column('voice_confirmed')], 0)

    def test_zero_background_stays_zero_without_fabricated_relative_evidence(self):
        mic, ref = data()
        e = Clarity()
        e.run(mic[:1]*0, ref[:1])
        e.set(backgroundrequest=1)
        row = stream(e, mic*0, ref)
        self.assertEqual(row[column('background_state')], 2)
        self.assertEqual(row[column('background_frames')], 500)
        self.assertFalse(row[column('background_mean_low'):64].any())
        row = stream(e, mic, ref)
        self.assertFalse(row[column('background_mean_low'):64].any())
        self.assertGreater(row[column('band_input_level_low')], 0)

    def test_new_request_discards_old_measurement_and_partial_leading_frame(self):
        e, before, mic, ref = capture()
        e.set(backgroundrequest=2)
        row = e.run(mic[:1]*2, ref[:1])[0]
        self.assertEqual(row[column('background_state')], 1)
        self.assertEqual(row[column('background_request')], 2)
        self.assertFalse(row[column('background_frames'):86].any())
        row = stream(e, mic*2, ref)
        self.assertEqual(row[column('background_state')], 2)
        self.assertGreater(row[column('background_mean_low')], before[column('background_mean_low')]*1.9)

    def test_context_changes_abort_active_and_completed_captures_without_restart(self):
        for complete in (False, True):
            for change in ('epoch', 'offset', 'permit', 'profile', 'mode', 'clip'):
                e = Clarity()
                mic, ref = data()
                e.run(mic[:1], ref[:1]); e.set(backgroundrequest=1)
                stream(e, mic if complete else mic[:44100], ref if complete else ref[:44100])
                kw = {}
                if change == 'profile': e.set(profilevalid=0)
                elif change == 'mode': e.set(sourcemode=2)
                elif change == 'epoch': kw['epoch'] = 2
                elif change == 'offset': kw['offset'] = 83
                elif change == 'permit': kw['permit'] = 0
                row = e.run(np.array([1. if change == 'clip' else 0.]), ref[:1], **kw)[0]
                self.assertEqual(row[column('background_state')], 3, (complete, change))
                self.assertFalse(row[column('background_frames'):86].any())
                e.set(profilevalid=1, sourcemode=1)
                row = stream(e, mic, ref)
                self.assertEqual(row[column('background_state')], 3)
                self.assertEqual(row[column('background_frames')], 0)

    def test_capture_request_while_unready_is_rejected_until_a_new_request(self):
        mic, ref = data()
        e = Clarity(backgroundrequest=1, profilevalid=0)
        row = stream(e, mic, ref)
        self.assertEqual(row[column('background_state')], 3)
        e.set(profilevalid=1)
        row = stream(e, mic, ref)
        self.assertEqual(row[column('background_state')], 3)
        self.assertEqual(row[column('background_frames')], 0)
        e.set(backgroundrequest=2)
        row = stream(e, mic, ref)
        self.assertEqual(row[column('background_state')], 2)


class BackgroundGraphTests(unittest.TestCase):
    def test_only_explicit_button_presses_send_distinct_requests_without_host_actions(self):
        g = ClarityGraph().initialized()
        self.assertNotIn('backgroundrequest', g.clarity_params)
        g.send('root/asrc-popup/aq-background', (1,))
        self.assertEqual(g.clarity_params['backgroundrequest'], 1)
        g.send('root/asrc-popup/aq-background', (1,))
        self.assertEqual(g.clarity_params['backgroundrequest'], 2)
        self.assertNotIn('quality', g.preflight_params)
        self.assertFalse(g.calls)

    def test_background_status_is_live_and_follows_theme(self):
        g = ClarityGraph().initialized()
        for code, label in BACKGROUND_STATES.items():
            g.state['root/aq-background_state']['signal_sample'] = code
            g.send('root/aq-poll')
            self.assertEqual(' '.join(map(str, g.state['root/asrc-popup/aq-background-status']['label'])), label)
        g.click('theme')
        commands = g.state['root/asrc-popup/window']['commands']
        self.assertTrue(any(cmd[:4] == ('script','send','asrc_ui_aq-background','bgcolor') for cmd in commands))

    def test_full_measurement_is_frozen_before_export_and_never_persisted_as_settings(self):
        g = ClarityGraph().initialized()
        for i, name in enumerate(FIELDS):
            g.state['root/aq-'+name]['signal_sample'] = i+.25
        g.send('root/asrc-popup/export', (1,))
        frozen = dict(g.state['root/aq-export-dict']['data'])
        for i, name in enumerate(FIELDS):
            self.assertEqual(frozen['clarity_'+name], (i+.25,))
            g.emit('root/aq-'+name, (0,))
        self.assertEqual(g.state['root/aq-export-dict']['data'], frozen)
        self.assertFalse(any('background' in name.lower() for name in g.saved_parameters()))
        self.assertFalse(g.calls)


if __name__ == '__main__': unittest.main()
