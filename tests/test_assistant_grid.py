"""Known-position sound candidates and signed timing, with an observed test clock."""
import tempfile
import unittest
import wave
from pathlib import Path

import numpy as np

from gen_harness import PTR, ROOT, compile_harness, load_library
from genexpr_scope import validate_scope
from assistant_preflight import OUTPUTS
from make_reference_audio import main as make_reference_audio
from preflight_harness import ready
from test_assistant_features import FeatureEngine, detected, tone


SOURCE = ROOT / 'src/vtm_assistant_grid.genexpr'
validate_scope(SOURCE.read_text(), inputs=5, outputs=5)
GRID_PARAMS = compile_harness(SOURCE, 'assistant_grid_harness', inputs=5, outputs=5)
GRID_LIBRARY = load_library('assistant_grid_harness', inputs=5)


def project(phase, *, grid=4, period=600, offset=0, event=1, context=1):
    phase = np.atleast_1d(np.asarray(phase, dtype=np.float64))
    columns = [
        np.ascontiguousarray(np.broadcast_to(value, phase.shape), dtype=np.float64)
        for value in (event, phase, period, offset, context)
    ]
    result = np.empty((len(phase), 5), dtype=np.float64)
    engine = GRID_LIBRARY.make_engine(44100)
    try:
        GRID_LIBRARY.set_param(engine, [name for name, _ in GRID_PARAMS].index('grid'), grid)
        GRID_LIBRARY.run_engine(engine, len(phase), *(col.ctypes.data_as(PTR) for col in columns),
                                result.ctypes.data_as(PTR))
    finally:
        GRID_LIBRARY.free_engine(engine)
    return result


class AssistantGridTests(unittest.TestCase):
    def test_grid_distances_and_midpoint_toward_next_mark(self):
        for grid, step in ((4, 600), (8, 300), (16, 150)):
            elapsed = np.array([0., 30., step-30., step/2])
            projected = project(elapsed / 600, grid=grid)
            np.testing.assert_allclose(projected[:, 1], [0., 30., -30., -step/2], atol=1e-10)
            np.testing.assert_array_equal(projected[:, 2], step)

    def test_signed_delay_compensation_is_applied_once_across_the_wrap(self):
        targets = np.array([0., 150., -150., -15.])
        for offset in (-92, 0, 92):
            for period in (60000/70, 600., 60000/153):
                raw_phase = np.remainder((targets + offset) / period, 1)
                result = project(raw_phase, period=period, offset=offset)
                np.testing.assert_array_equal(result[:, 0], 1)
                np.testing.assert_allclose(result[:, 1], targets, atol=1e-10)

    def test_candidate_missing_or_context_invalid_produces_no_measurement(self):
        for phase, settings in (
            (.25, {'event': 0}), (.25, {'context': 0}), (.25, {'grid': 7}),
            (-.1, {}), (1.1, {}), (.25, {'period': 0}), (.25, {'offset': 501}),
        ):
            with self.subTest(phase=phase, settings=settings):
                self.assertFalse(project(phase, **settings).any())

    def test_last_measurement_survives_paused_or_ineligible_samples(self):
        rows = project([.25, .5, .75, .125], event=[1, 0, 1, 1], context=[1, 1, 0, 1])
        np.testing.assert_allclose(rows[:, 3:], [[1, 150], [1, 150], [1, 150], [2, 75]])

    def test_live_preflight_gates_timing_without_promoting_musical_quality(self):
        sr = 44100
        delay = 92
        n = sr
        audio = tone(sr, 1, start=.6+delay/1000, end=.8)
        reference = np.full(n, .05)
        phases = ((np.arange(n) / (sr * .6)) % 1).astype(np.float32).astype(float)
        timing_fields = ['timing_probe_permit', 'epoch', 'periodms', 'appliedoffsetms']
        for settings in ({}, {'calibrationvalid': 0}, {'countingin': 1}, {'playing': 0},
                         {'referencebinding': 0}):
            with self.subTest(settings=settings):
                host = ready(sr=sr, quality=0, offsetms=delay, **settings)
                # Heartbeat is refreshed at each host polling block.
                rows = [host.run(audio[i:i+4096], reference[i:i+4096], phase=phases[i:i+4096])
                        for i in range(0, n, 4096)]
                status = np.concatenate(rows)
                self.assertFalse(status[:, 2].any())
                detector = FeatureEngine(sr=sr, hostcontext=1)
                candidates = detected(detector.run(
                    left=audio, phase=status[:, OUTPUTS.index('rawphase')],
                    extra=tuple(status[:, OUTPUTS.index(name)] for name in timing_fields)))
                if settings:
                    self.assertEqual(len(candidates), 0)
                else:
                    self.assertEqual(len(candidates), 1)
                    measured = project(candidates[:, 11], period=candidates[:, 12],
                                       offset=candidates[:, 13])
                    self.assertLessEqual(abs(measured[0, 1]), 10.1)

    def test_epoch_change_discards_pending_attack(self):
        sr = 44100
        detector = FeatureEngine(sr=sr, hostcontext=1)
        audio = tone(sr, .25, end=.22)
        split = round(sr*.212)
        pending = detector.run(left=audio[:split], extra=(1, 1, 600, 0))
        self.assertEqual(pending[-1, 8], 1)
        # Even if audio continues, the earlier candidate cannot confirm in another epoch.
        changed = detector.run(left=audio[split:], extra=(1, 2, 600, 0))
        self.assertFalse(changed[:, 0].any())

    def test_full_reference_recording_with_and_without_simulated_delay(self):
        with tempfile.TemporaryDirectory() as folder:
            target = Path(folder)/'reference.wav'
            make_reference_audio(target)
            with wave.open(str(target), 'rb') as source:
                sr = source.getframerate()
                audio = np.frombuffer(source.readframes(source.getnframes()), '<i2') / 32768
        expected = np.repeat([0., 150., -150.], 16)
        # Pre-roll allows the host clock to lock before the first reference pulse.
        preroll = round(.6 * sr)
        for delay, amplitude in ((0., 1.), (92., .5)):
            delay_samples = round(sr * delay / 1000)
            delayed = np.pad(amplitude*audio, (preroll+delay_samples, 0))
            phases = np.remainder((np.arange(len(delayed)) / (sr*.6)), 1)
            detector = FeatureEngine(sr=sr, hostcontext=1)
            rows = []
            for start in range(0, len(delayed), 4096):
                end = start+4096
                rows.append(detected(detector.run(left=delayed[start:end], phase=phases[start:end],
                                                  extra=(1, 1, 600, delay))))
            onsets = np.concatenate(rows)
            self.assertEqual(len(onsets), len(expected), delay)
            onset_indices = np.rint(onsets[:, 2] * sr / 1000).astype(int)
            np.testing.assert_allclose(onsets[:, 11], phases[onset_indices], atol=1e-12)
            result = project(onsets[:, 11], period=onsets[:, 12], offset=onsets[:, 13])
            np.testing.assert_array_equal(result[:, 0], 1)
            np.testing.assert_allclose(result[:, 1], expected, atol=10.1)
