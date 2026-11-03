# Vocal Timing Monitor — 0.8 RC1.3 Studio

Max for Live device with separate microphone/instrumental waveforms, grid timing feedback and optional automatic transport stop. [Documentație în română](README_RO.md).

**0.8 RC1.3 Studio — owner-tested release candidate, 3 November 2026.** The owner accepted the tested Windows / Ableton Live 12 workflow, including matching light themes, saved controls after full restart, actual recording/automatic stop with the clip retained, and saved-ON/reopened-OFF behavior. [Host results and limits](docs/HOST_VALIDATION.json). The earlier [0.7 RC3.3 release](https://github.com/alexandru348/vocal-timing-monitor/releases/tag/v0.7-rc3.3) remains available as a rollback point.

[Download the AMXD](https://github.com/alexandru348/vocal-timing-monitor/raw/refs/heads/main/dist/Vocal_Timing_Monitor_v0_8_RC1_3_Studio.amxd). No plugin rebuild or code change was made after owner acceptance; publication updates documentation only.

## Installation

Use `dist/Vocal_Timing_Monitor_v0_8_RC1_3_Studio.amxd`. Requires Ableton Live 12 with Max for Live and Max 8.6 or later. This is an AMXD, not VST/AU. Runtime components are embedded; Python and the build dependencies are development-only. UI text is Romanian.

1. Make a separate copy of your Live Set. Retain the working RC3.3 device and its referenced file as a rollback point.
2. In the copy, deactivate RC3.3 and load the new AMXD on the dedicated analysis track. Click **Deschide monitorul**. Keep one VTM analyzer active on that track.
3. Analysis track: microphone input, Monitor In, Sends Only, all sends fully down. The active device outputs silence. Record on a separate track, retaining the routing/monitoring appropriate to your setup.
4. Under **Setări → Instrumental**, select the instrumental track and **Post Mixer**. Enter preferred controls once for this fresh instance; a new instance does not copy another instance's values.
5. Start playback with **Analiză activă** and **Oprire auto: OFF**. Check both waves and ordinary speech/silence detection before enabling automatic stop.
6. **Ctrl+S saves controls and theme with the Live Set.** This does not periodically save the project to disk.

## New interface

- Compact 640 × 370 floating monitor, expanding to 640 × 760. Basic/advanced pages share the same space.
- Always-visible light/dark theme button; theme stored per instance in the Set.
- Prominent timing result with early/late explanation, readable state text and an additional symbol.
- Basic settings: grid, timing tolerance, microphone detection and instrumental source.
- Raw microphone peak meter and selected-threshold marker, including overload feedback. **A visual aid, not the detector's internal envelope.** Filtering, noise estimation and rearming also affect whether an attack is counted.
- Advanced: compensation/calibration, waveform zoom and temporary diagnostics.
- Existing Gen source, audio graph, routing and automatic-stop protocol retained. Theme/navigation send no audio-control or transport commands.

Images in `previews/` are approximate layout illustrations from generated geometry with synthetic waves and a substitute font. They are **not Max screenshots**. The owner accepted the tested native Windows layout; these illustrations themselves do not establish native rendering quality on other systems.

## Controls and interpretation

Speak normally, keep the raw microphone input below overload and adjust **Prag de detecție (dB)** until speech counts while a short silence test stays stable. More negative values increase sensitivity. Microphone percentages depend on the setup. Waveform **Mărire vizuală** changes drawing only. Windows levels and Live tempo are outside the device's stored controls.

Signed deviation is measured against the nearest selected Live grid point, after compensation. Negative means early; positive means late. It does not identify syllables, separate speech or judge musical flow. Compensation changes the reported number, not recorded audio or waveform placement.

At 100 ms tolerance: green below 45 ms absolute deviation, amber from 45 to below 100 ms, red at or above 100 ms. The general green boundary is `min(45 ms, tolerance / 2)`. At 100 BPM, nearest-grid range is ±300 ms on 1/4, ±150 ms on 1/8 and ±75 ms on 1/16. The UI warns when tolerance exceeds the possible deviation.

After synchronization, explicitly enable **Oprire auto: ON** for each attempt. A confirmed red event requests a stop of the **entire Live transport, including recording**, retaining the clip. It disarms after the request; reset, relevant parameter changes or synchronization loss may also disarm it. It always loads **OFF**, even if saved ON. Theme/page changes preserve current stop intent.

**Preia întârzierea** copies the last raw deviation on the 1/4 grid; use a known aligned reference impulse. **Test afișare** tests display messages without audio or an automatic-stop request.

Ten settings are stored: analysis, grid, tolerance, detection, compensation, two zooms, instrumental source/channel and theme. Exact confirmed routing labels are used; missing/renamed/renumbered labels require reselection. Counters, waves, diagnostics, action buttons and page selection are transient. [Persistence design](docs/PERSISTENCE.md).

## Validation

**155 automated checks passed**: static/container checks, C++ arithmetic harness and generated-message/host stubs. They do not execute native Max. Approximate device/compact/basic/advanced illustrations in both themes showed no estimated text overflow; they are not native layout proof.

New checks cover saved-theme replay, status repaint, raw-level/threshold feedback, contrast, layout bounds, view toggles without parameter/routing/stop side effects and impossible-tolerance warnings. DSP source is byte-identical to RC3.3. Parent audio/API graph retains its historical digest after explicitly normalizing the parameter registry, root UI copy, dedicated device-theme module and existing display initializer.

[Automated results](docs/TEST_RESULTS.json) and [current host status](docs/HOST_VALIDATION.json) are separate. The archived [RC3.3 host report](docs/history/RC3_3_HOST_VALIDATION.json) applies to RC3.3 only.

Other systems remain unverified. Room/keyboard noise and speaker bleed may trigger this amplitude detector. Vocal compensation remains approximate. Closing the monitor hides the UI; the device stays active. No private Live Sets, extracted diagnostic dumps, recordings or owner screenshots are included.

## Development

```sh
python3 -m pip install -r requirements-dev.txt
python3 build.py
python3 -m unittest discover -s tests -v
python3 tools/render_studio_preview.py
```

`build.py` and `studio_ui.py` generate native Max objects and the AMXD, embedding `src/vtm_engine.genexpr`. The container is generated programmatically, not through native Save/Freeze. The optional Pillow renderer uses a DejaVu Sans substitute font on Linux; preview images, Python and fonts are not runtime dependencies. Tests create temporary files under `tests/_generated/`.

`SHA256SUMS` verifies package files; standalone downloads have separate `SHA256SUMS-ASSETS`. Notes in `docs/history/` describe earlier versions and are not current instructions.

## License

Source and AMXD are under the [MIT License](LICENSE), Copyright (c) 2026 alexandru348. Commercial use, modification and redistribution are allowed with notices retained; provided without warranty. Third-party software retains its own license.

## RC1.2 text and zoom fields

The two waveform zoom controls use native live.numbox LCD fields with custom `%g×` units: 1×, 2×, 2.5×, up to 8×. The same Stored Only Float parameter names/IDs/ranges are retained. Their left outlets still send numeric multipliers only to waveform drawing, never to the detector or transport. The owner confirmed fractional editing and save/full application restart in RC1.2; RC1.3 subsequently confirmed the synchronized light device body, including restoration before the monitor opens.

All displayed text uses the Windows Segoe UI system font with integer point sizes; small captions are enlarged and comment boxes have more vertical room. Other operating systems may substitute a font. No font is bundled. The preview uses DejaVu Sans as an approximation. This improves readability but cannot establish native text sharpness from an offline renderer. Max's global High DPI Rendering preference and Windows/application scaling can affect the result; see docs/TEXT_RENDERING.md. The device does not modify those preferences.

## RC1.3 synchronized device theme

The embedded device body now follows the monitor theme: background, title, descriptive text and open button, including its selected/hover text colors. A second local popup outlet carries only the existing theme value to native root-patcher palette messages. Startup replays that value even when the floating monitor has not been opened. There is no additional stored parameter, global send/receive or Live theme change. The title bar and outer frame remain owned by Ableton.

RC1.2 monitor/layout and short untouched-silence observations remain archived with their original scope. In RC1.3, the owner accepted the corrected light device body and monitor, restored light body before opening the monitor, retained controls/source after full application restart, both waves during playback/recording, and actual automatic stop with the clip retained and confirmation from Live. The final restart test explicitly saved Auto Stop ON and reopened OFF while the other settings remained saved. See the current host report for limits; native dark-body restart, exhaustive combinations and sample-accurate stop timing are not claimed.
