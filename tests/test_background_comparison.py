"""Matched-duration background diagnostics; these tests never identify speech."""
import math
import unittest
import numpy as np
from assistant_clarity import OUTPUTS, BACKGROUND_COMPARISON_STATES
from clarity_harness import Clarity
from test_assistant_clarity import column, ClarityGraph
from test_background_capture import stream

START = column('background_comparison_state')
BANDS = ('low', 'mid', 'high')


def tone(sr, count, start=0, gain=1):
    t = (np.arange(count)+start)/sr
    return gain*(.020*np.sin(2*np.pi*100*t)+.008*np.sin(2*np.pi*900*t)+.006*np.sin(2*np.pi*3200*t))


def measured(sr=44100, silent=False):
    frame = int(sr*.010)
    count = (1+math.ceil(sr*.5/frame)+math.ceil(sr*5/frame))*frame
    e = Clarity(sr)
    e.run(np.zeros(1), np.zeros(1))
    e.set(backgroundrequest=1)
    mic = tone(sr, count)*(not silent)
    row = stream(e, mic, .1*tone(sr, count))
    assert row[column('background_state')] == 2
    assert row[column('background_comparison_frames')] == 0
    return e, row, count


def follow(e, start, seconds=1, gain=1):
    n = round(e.sr*seconds)
    x = tone(e.sr, n, start, gain)
    return stream(e, x, .1*tone(e.sr, n, start))


class BackgroundComparisonTests(unittest.TestCase):
    def test_no_comparison_or_limits_before_a_declared_measurement(self):
        e = Clarity()
        row = follow(e, 0, 2)
        self.assertFalse(row[START:86].any())

    def test_a_full_second_after_acquisition_is_required_at_all_supported_rates(self):
        for sr in (22050, 44100, 48000, 96000):
            with self.subTest(sr=sr):
                e, before, start = measured(sr)
                n = math.ceil(sr/int(sr*.010))*int(sr*.010)
                x = tone(sr, n, start)
                row = stream(e, x[:-1], .1*x[:-1])
                self.assertEqual(row[START], 1)
                self.assertEqual(row[column('background_comparison_frames')], 0)
                row = e.run(x[-1:], .1*x[-1:])[-1]
                self.assertEqual(row[column('background_comparison_windows')], 1)
                duration = row[column('background_comparison_duration_ms')]
                self.assertGreaterEqual(duration, 1000)
                self.assertLess(duration, 1010)
                self.assertEqual(row[column('background_comparison_frames')], math.ceil(sr/int(sr*.010)))

    def test_unchanged_background_has_no_persistent_band_exceedance(self):
        e, _, start = measured()
        row = follow(e, start)
        self.assertEqual(row[START], 2)
        self.assertEqual(row[column('background_above_band_mask')], 0)
        self.assertEqual(row[column('background_within_windows')], 1)
        for b in BANDS:
            self.assertAlmostEqual(row[column('background_mean_ratio_'+b)], 1, places=3)

    def test_sustained_level_increase_is_descriptive_and_band_specific(self):
        e, baseline, start = measured()
        row = follow(e, start, gain=3)
        self.assertEqual(row[START], 3)
        self.assertEqual(row[column('background_above_band_mask')], 7)
        self.assertEqual(row[column('background_above_windows')], 1)
        for b in BANDS:
            self.assertGreater(row[column('background_above_fraction_'+b)], .95)
            self.assertAlmostEqual(row[column('background_mean_ratio_'+b)], 3, delta=.01)
            self.assertEqual(row[column('background_mean_'+b)], baseline[column('background_mean_'+b)])
        self.assertEqual(row[column('voice_confirmed')], 0)

    def test_one_brief_burst_is_intermittent_rather_than_persistent(self):
        e, _, start = measured()
        gain = np.ones(44100); gain[15000:23820] = 3
        row = follow(e, start, gain=gain)
        self.assertEqual(row[START], 4)
        self.assertEqual(row[column('background_above_band_mask')], 0)
        self.assertEqual(row[column('background_uncertain_windows')], 1)
        self.assertEqual(row[column('voice_confirmed')], 0)

    def test_below_background_is_not_mistaken_for_excess(self):
        e, _, start = measured()
        row = follow(e, start, gain=.3)
        self.assertEqual(row[START], 2)
        self.assertEqual(row[column('background_above_band_mask')], 0)

    def test_zero_background_has_finite_limits_but_no_fabricated_ratios(self):
        e, _, start = measured(silent=True)
        row = follow(e, start)
        self.assertEqual(row[START], 3)
        self.assertEqual(row[column('background_ratio_valid_band_mask')], 0)
        for b in BANDS:
            self.assertEqual(row[column('background_mean_ratio_'+b)], 0)
            self.assertEqual(row[column('background_limit_'+b)], .00001)
        self.assertEqual(row[column('voice_confirmed')], 0)

    def test_limits_use_acquired_population_variance_with_absolute_and_relative_floors(self):
        e, _, start = measured()
        row = follow(e, start)
        for b in BANDS:
            mean = row[column('background_mean_'+b)]
            sd = math.sqrt(row[column('background_variance_'+b)])
            self.assertAlmostEqual(row[column('background_limit_'+b)], mean+max(.00001, mean*.1, 3*sd), places=14)

    def test_completed_window_is_frozen_while_next_window_is_partial(self):
        e, _, start = measured()
        before = follow(e, start, gain=3)
        after = follow(e, start+44100, seconds=.5, gain=.3)
        np.testing.assert_array_equal(before[START:86], after[START:86])
        after = follow(e, start+66150, seconds=.5, gain=.3)
        self.assertEqual(after[column('background_comparison_windows')], 2)
        self.assertGreater(after[column('background_comparison_end_sampleclock')], before[column('background_comparison_end_sampleclock')])
        self.assertEqual(after[START], 2)

    def test_every_context_revocation_clears_completed_and_pending_comparison(self):
        for change in ('epoch','offset','permit','profile','mode','clip'):
            with self.subTest(change=change):
                e, _, start = measured()
                follow(e, start, gain=3)
                kw = {}
                if change == 'profile': e.set(profilevalid=0)
                elif change == 'mode': e.set(sourcemode=2)
                elif change == 'epoch': kw['epoch'] = 2
                elif change == 'offset': kw['offset'] = 83
                elif change == 'permit': kw['permit'] = 0
                row = e.run(np.array([1. if change == 'clip' else 0.]), np.zeros(1), **kw)[0]
                self.assertFalse(row[START:86].any())
                self.assertEqual(row[column('voice_confirmed')], 0)

    def test_new_acquisition_clears_previous_comparison_without_reusing_a_partial_frame(self):
        e, _, start = measured()
        follow(e, start, gain=3)
        e.set(backgroundrequest=2)
        row = e.run(np.zeros(1), np.zeros(1))[0]
        self.assertFalse(row[START:86].any())
        self.assertEqual(row[column('background_state')], 1)

    def test_single_band_excess_does_not_force_a_low_band_excess(self):
        e, _, start = measured()
        t=(np.arange(44100)+start)/44100
        mic=tone(44100,44100,start)+.03*np.sin(2*np.pi*8000*t)
        row=stream(e,mic,.1*tone(44100,44100,start))
        mask=int(row[column('background_above_band_mask')])
        self.assertTrue(mask & 4)
        self.assertFalse(mask & 1)
        self.assertEqual(row[column('voice_confirmed')], 0)


class BackgroundComparisonGraphTests(unittest.TestCase):
    def test_status_updates_live_and_follows_both_themes(self):
        g=ClarityGraph().initialized()
        for code,label in BACKGROUND_COMPARISON_STATES.items():
            g.state['root/aq-background_comparison_state']['signal_sample']=code
            g.send('root/aq-poll')
            self.assertEqual(' '.join(map(str,g.state['root/asrc-popup/aq-background-comparison-status']['label'])),label)
        g.click('theme')
        commands=g.state['root/asrc-popup/window']['commands']
        self.assertTrue(any(c[:4]==('script','send','asrc_ui_aq-background-comparison-status','textcolor') for c in commands))
        self.assertFalse(g.calls)
        self.assertNotIn('quality',g.preflight_params)

    def test_all_current_comparison_fields_are_frozen_before_modal_export(self):
        g=ClarityGraph().initialized()
        for i,name in enumerate(OUTPUTS[START:]):
            g.state['root/aq-'+name]['signal_sample']=i+.5
        g.send('root/asrc-popup/export',(1,))
        frozen=dict(g.state['root/aq-export-dict']['data'])
        for i,name in enumerate(OUTPUTS[START:]):
            self.assertEqual(frozen['clarity_'+name],(i+.5,))
            g.emit('root/aq-'+name,(0,))
        self.assertEqual(g.state['root/aq-export-dict']['data'],frozen)
        self.assertFalse(g.calls)


if __name__ == '__main__': unittest.main()
