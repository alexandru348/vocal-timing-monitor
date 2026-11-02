# Vocal Timing Monitor — 0.7 RC3.3 Persistent

Max for Live audio device for visual attack timing feedback and optional automatic transport stop in Ableton Live. **RC3.3 saves controls with your Live Set and restores them when it reopens.** [Documentație în română](README_RO.md).

## Download

Get `Vocal_Timing_Monitor_v0_7_RC3_3_Persistent.amxd` from [release v0.7-rc3.3](https://github.com/alexandru348/vocal-timing-monitor/releases/tag/v0.7-rc3.3), or from [dist](dist/). Requires Ableton Live with Max for Live available; this is an AMXD device, not a VST/AU. Runtime components are embedded. No Python or compiler is needed to use it. UI labels currently use Romanian.

The previous [v0.7-rc2 release](https://github.com/alexandru348/vocal-timing-monitor/releases/tag/v0.7-rc2) and its tag remain available as the original tested checkpoint.

## Features

- Compact floating monitor with expandable settings, separate input/voice and instrumental waveforms, six seconds of history and grid markers.
- Attack counter, signed deviation in milliseconds and color feedback against the selected Live grid (1/4, 1/8 or 1/16).
- Adjustable detection, timing threshold and compensation; independent visual zoom for the two waves.
- Optional Auto Stop stops the entire Live transport, including recording, while retaining the recorded clip.
- Nine per-instance settings restored with the saved Live Set: analysis, grid, threshold, compensation, detection, both waveform zooms, instrumental source and channel.

## Setup

1. Load the AMXD on a dedicated audio analysis track and click OPEN MONITOR.
2. On that track select the microphone under Ext. In, the appropriate input and Monitor In. Set its output to Sends Only and all sends fully down. The active device outputs silence.
3. In SETARI → SURSA INSTRUMENTALULUI, manually choose the instrumental track and Post Mixer. This feeds a separate input bus.
4. Record on a separate audio track using the microphone input; arm it when recording. The tested laptop speaker setup uses Monitor Off on the recording track.
5. Start playback with ANALIZA ON and AUTO STOP OFF. Check both waves, clock synchronization and speech detection. Then explicitly enable Auto Stop if wanted.
6. **Save the Live Set with Ctrl+S.** Reopen that saved instance to restore its settings. This does not periodically save the project to disk. New instances start with factory defaults.

Input numbers, detection sensitivity and compensation depend on your setup. Keep the microphone input below overload while speaking normally, then adjust DETECTIE to register speech without continuous unwanted triggers during silence. MARIRE only changes the drawing. Windows volume, microphone level and Live tempo are outside this device's saved controls.

## Timing and Auto Stop

Minus means early and plus means late, after compensation. Timing is measured against the nearest selected Live grid point. It does not identify syllables, match each sound to a drum hit or judge musical flow.

At a 100 ms threshold: green below 45 ms absolute deviation, amber from 45 to below 100 ms, red at or above 100 ms. The general green boundary is `min(45 ms, threshold / 2)`. At 100 BPM the nearest-grid range is ±300 ms on 1/4, ±150 ms on 1/8 and ±75 ms on 1/16, so a 100 ms threshold cannot be reached on 1/16.

After synchronization, explicitly set AUTO STOP ON for an attempt. The first confirmed red event requests a stop of the **entire transport and recording**. Auto Stop disarms after its request. Reset, relevant parameter changes or sync loss may also disarm it. Diagnostics appear in SETARI. **Auto Stop always loads OFF, including when the project was saved with it ON.**

## Persistence and updating

Source/channel selections are stored as exact labels and resolved against current routing lists; they are captured after a manual menu selection. If a source is missing, renamed or renumbered in its displayed label, reselect it and save. Counts, waveform history, action buttons, transport state and temporary diagnostics are not restored. See [persistence design](docs/PERSISTENCE.md).

From RC2, enter your preferred settings once in the new instance; RC2 did not save them. Keep a copy of your project before replacing a device.

For the existing RC3.2 test project only, [compat](compat/) contains the same RC3.3 patch under the RC3_2 filename already referenced by the saved project. This preserves the existing instance. Do not rename or remove that referenced file in Explorer without updating the project's reference. New installations should use the canonical RC3_3 file in dist. The patch JSON is identical; container filename bytes and SHA-256 differ.

## Validation and limitations

On 2 November 2026, the owner tested RC3.3 in Ableton Live 12 Suite / Windows 11, 44.1 kHz, 100 BPM:

- Full restart restored controls, including non-default analysis OFF, grid 1/8, threshold 80 ms, zoom 2/3 and instrumental source/Post Mixer. Initial OFF header was corrected.
- Both waves, synchronized clock and ordinary speech attacks worked; the count stayed stable during silence in the short tested passage.
- A separate vocal recording was retained after actual Auto Stop; Live reported `Ultimul Stop: oprire confirmata de Live`, then Auto Stop was OFF.
- Saving with Auto Stop ON and reopening resulted in OFF, with other settings retained.

Final speech/recording tests used microphone level 70%, Windows speaker volume 15%, detection −26 dB, compensation +92.2 ms, grid 1/4, threshold 100 ms, zoom 1/1. These are **one laptop's test settings**, not universal defaults. Native tests used the in-place compatibility filename with the exact RC3.3 patch; the canonical filename container was verified offline. No private recordings or Live Sets are distributed.

140 automated static/simulation checks passed. They exercise generated structure, a C++ arithmetic harness and message/host stubs; they do not execute Max. [Actual host evidence](docs/HOST_VALIDATION.json) is separate from [automated results](docs/TEST_RESULTS.json).

- Keyboard clicks, room noise and speaker bleed can trigger the amplitude detector. It does not isolate speech or cancel acoustic echo.
- Vocal timing compensation remains approximate. RC2 reference impulses measured +92.2 ms before compensation and owner-reported 0.00 ms after it; this does not establish precise speech timing.
- Compensation changes the reported number, not the audio recording or waveform position.
- CALIBREAZA copies the last raw deviation on the 1/4 grid. Use an aligned reference impulse; later noise can overwrite it.
- TEST IMPULS exercises display messages without producing audio or requesting Auto Stop.
- Other systems and audio configurations remain unverified. Closing the monitor hides its UI; the device remains active on its track.

## Development

Python 3, NumPy and a C++17 compiler are development-only dependencies:

```sh
python3 -m pip install -r requirements-dev.txt
python3 build.py
python3 -m unittest discover -s tests -v
```

`build.py` embeds `src/vtm_engine.genexpr` and generates the Max patch and AMXD in dist. The container is generated programmatically, not via native Save/Freeze. The DSP source is byte-identical to RC2. Persistence changes initialization and state storage; RC3.3 also forwards the initial state zero to the status display. Audio and Live API paths retain regression coverage. `SHA256SUMS` verifies repository/source-package files; release `SHA256SUMS-ASSETS` verifies the downloadable release files. Historical engineering notes in docs/history are not current setup instructions.

## License

Source code and the distributed AMXD are under the [MIT License](LICENSE). Copyright (c) 2026 alexandru348. Use, modification and redistribution, including commercial use, are permitted with the copyright/license notices retained. Provided without warranty. Separately supplied Ableton, Max and other third-party software retain their own licenses.
