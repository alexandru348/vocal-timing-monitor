# Vocal Timing Monitor — 0.7 RC2 Compact

Max for Live audio device for visual timing feedback and optional automatic transport stop in Ableton Live. [Documentație în română](README_RO.md).

**Early release candidate validated in one Windows/Ableton setup.** Measures audio attacks against the nearest Ableton grid point. It does not judge musical flow or match syllables to individual drum hits.

## Download and requirements

Download `Vocal_Timing_Monitor_v0_7_RC2_Compact.amxd` from [Releases](https://github.com/alexandru348/vocal-timing-monitor/releases) after publication. Until then, the same file is in [dist](dist/).

- Ableton Live with Max for Live available; validated in Live 12 Suite.
- Tested on Windows 11, 44.1 kHz, at 100 BPM. Other configurations are unverified.
- This is an AMXD device, not a VST/AU or standalone application.
- Runtime components are embedded. Python, NumPy and C++ are only needed for development.
- Current UI labels use Romanian.

## Features

- Compact floating monitor (600 × 340 logical pixels) with expandable settings.
- Separate voice/input and instrumental waveforms, six seconds of history and grid markers.
- Signed deviation in milliseconds, color feedback and attack counter.
- Quarter, eighth and sixteenth note grids; adjustable threshold, compensation and detection.
- Independent visual magnification for each waveform.
- Optional Auto Stop with host confirmation; recorded clips are retained.

## Setup

1. Drag the AMXD onto a dedicated audio analysis track and click OPEN MONITOR.
2. Route the microphone to that track: Ext. In, the appropriate input and Monitor In.
3. Set the analysis track output to Sends Only and turn its sends fully down. The active device outputs silence. Use a separate track for recording.
4. Under SETARI → SURSA INSTRUMENTALULUI, select the instrumental track and Post Mixer. It feeds a separate additional input bus.
5. On the separate recording track choose the microphone input and arm it when recording. The validated speaker setup uses Monitor Off on this recording track.
6. Start playback with ANALIZA ON and AUTO STOP OFF. Check the two waveforms and synchronized clock, then explicitly enable Auto Stop for the attempt.

Track names and input numbers depend on your project. Adjust detection and compensation for your signal path. Defaults are not a universal calibration. MĂRIRE affects only the drawing.

## Timing and Auto Stop

Minus means early; plus means late, after compensation. At a 100 ms threshold: green below 45 ms absolute deviation, amber from 45 to below 100 ms, red at or above 100 ms. The general green boundary is `min(45 ms, threshold / 2)`.

After synchronization, turn AUTO STOP ON. The first confirmed red event requests a stop of **the entire Live transport, including recording**. It does not delete the clip. Auto Stop disarms after the request; enable it again for each new attempt. Reset, parameter changes or sync loss can also disarm it. Diagnostics are in SETARI.

At 100 BPM, the nearest-grid range is ±300 ms on 1/4, ±150 ms on 1/8 and ±75 ms on 1/16. A 100 ms threshold cannot be reached on 1/16 at that tempo.

## Known limitations and calibration

- **Controls reset on load.** Note their values separately and reapply after reopening. Persistence is planned, not implemented here.
- The amplitude attack detector can respond to keyboard clicks, room noise and speaker bleed. It does not isolate speech or cancel acoustic echo.
- Compensation corrects the numeric result, not the recording or waveform position.
- CALIBREAZA copies the last raw audio deviation into compensation on the 1/4 grid. Use an aligned reference impulse; a later noise event can overwrite that reading.
- TEST IMPULS tests display messages: no audio is produced and Auto Stop cannot be requested by it.
- Impulse calibration does not establish precise vocal timing accuracy.
- Closing the monitor hides the UI; the device remains on its track.

## Validation

On 1 November 2026 the owner confirmed in Ableton Live 12 Suite: compact/expanded UI, both waveforms, microphone attack detection, separate vocal recording and actual Auto Stop during recording with the clip retained. The final stop test showed two attacks, −240.20 ms and `Ultimul Stop: oprire confirmata de Live`.

A speaker/microphone reference test gave +92.2 ms across eight impulses. After compensation the owner reported 0.00 ms across the eight impulses. The reference used detection −26 dB, then normal speech used −14 dB; vocal compensation remains approximate. These observations describe one setup, not broad compatibility tests.

108 automated checks cover static structure and simulated arithmetic/messages. They do not execute Max or replace native host testing. See [host validation](docs/HOST_VALIDATION.json) and [test results](docs/TEST_RESULTS.json).

## Build and development

Requires Python 3, NumPy and a C++17 compiler (`g++` for the harness).

```sh
python3 -m pip install -r requirements-dev.txt
python3 build.py
python3 -m unittest discover -s tests -v
```

`build.py` generates the Max patch and AMXD in `dist/`, embedding `src/vtm_engine.genexpr`. The AMXD container is generated programmatically, not via native Save/Freeze. The distributed AMXD is unchanged from the owner-tested device. `SHA256SUMS` lists package hashes.

Preserve tag `v0.7-rc2` as the tested checkpoint when publishing. Develop persistence on a separate branch and validate it in Ableton before merging. Earlier engineering notes in [docs/history](docs/history/) describe historical stages.

The owner has not selected a project license yet.
