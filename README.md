# Vocal Timing Monitor — 0.9 RC1.6 Studio

Owner-tested release candidate adding reference-based automatic delay calibration while preserving the existing UI and onset/Auto Stop workflow. Native checks on 2026-11-04 covered repeated calibration, known early/on-grid/late references, Arrangement recording with automatic stop, saved compensation after restart, and calibration refusal with Auto Stop or REC active. Validation is limited to the tested laptop setup; this is not a universal stability or precision certification. [Română](README_RO.md).

**[Download the tested 0.9 RC1.6 AMXD](dist/Vocal_Timing_Monitor_v0_9_RC1_6_Studio.amxd?raw=true)** · [Keep the 0.8 RC1.3 baseline](https://github.com/alexandru348/vocal-timing-monitor/tree/checkpoint/v0.8-rc1.3).

Use `dist/Vocal_Timing_Monitor_v0_9_RC1_6_Studio.amxd` in a copied Live Set, with one active analyzer. Requires Live 12 with Max for Live and Max 8.6 or later. Native components and both Gen modules are embedded; Python is development-only. The analysis device outputs silence. Record on a separate track using the existing routing.

The interface, light/dark themes, separate microphone/instrumental waveforms, ten stored controls, zoom fields, grid, tolerance and Auto Stop workflow remain. Closing the monitor hides the UI; the analyzer stays active. Ctrl+S saves controls with the Set; Auto Stop always initializes OFF.

## New calibration

**Preia întârzierea** now measures the delay between the selected instrumental bus and its acoustic return through the microphone. Start a varied passage with Record and Auto Stop OFF, press the existing button in Advanced, and keep quiet until the final message (allow twenty seconds). On a clear result the existing compensation field is filled automatically. Otherwise it keeps the previous value and reports why. It does not generate sound or analyze recorded clips.

This requires the selected instrumental to be audible in the microphone. It is an estimate of the effective relative path delay, not universal automatic separation of latency and performance from any voice. It does not learn from vocal timing errors or continuously adjust a performance to the grid. Repeat after relevant audio-path/configuration changes. Manual compensation remains available.

[Algorithm, safeguards and scope](docs/AUTO_CALIBRATION.md). [Native test steps](docs/TESTARE_0_9.md).

## Evidence

229 automated static, C++ arithmetic and generated-message host-stub checks passed. Synthetic delay tests, ambiguity rejection and genuine early/late input after compensation are covered. All presented control geometry/fonts/parameter identities match RC1.3; the onset engine is byte-identical. These automated tests do not execute native Max. Separate owner-observed native results are summarized below; CPU has not been benchmarked. [Results](docs/TEST_RESULTS.json), [current native status](docs/HOST_VALIDATION.json), [historical RC1.3 report](docs/history/RC1_3_HOST_VALIDATION.json).

Native calibration trials applied 93.056351 and 92.885786 ms (difference about 0.17 ms). With the latter compensation, sampled displays for a known 0 / +150 / -150 ms reference were -0.20 / +149.8 / -150.10 ms. Arrangement recording stopped at the first deliberately late section and retained the clip. Compensation and light themes survived full application restart; saved Auto Stop ON reopened OFF. Calibration refused both Auto Stop ON and active Arrangement REC without changing compensation or stopping recording.

These are individual observations, not a statistical accuracy bound. An earlier +231.9 ms display in the +150 ms section remains unexplained; a later sample showed +149.8 ms. Keyboard/room onsets may be counted, but the cause of that observation is unproven. Session recording transitions, pending-result configuration races, CPU peaks and other hardware remain outside the native validation scope. See the [native report](docs/HOST_VALIDATION.json) and [reference protocol](docs/REFERENCE_TEST.md).

Input onset detection remains amplitude-based: room/keyboard noise and speaker bleed may count. Timing is measured against the nearest selected Live grid point after compensation; negative means early, positive late. It does not identify syllables or judge musical flow. Waveform zoom affects drawing only. Compensation changes the measurement, not the recorded clip. Recording placement in Live is a separate matter.

The same named source/channel must be available after reopen; renamed/missing sources require reselection. Windows levels, audio-driver settings and Live tempo are not stored by this device. No private Set, input/routing payload, owner recording or screenshot is included. Preview images are approximate geometry illustrations with synthetic signals and substitute fonts, not native Max screenshots.

## Development

```sh
python3 -m pip install -r requirements-dev.txt
python3 build.py
python3 -m unittest discover -s tests -v
python3 tools/render_studio_preview.py
```

`build.py`, `studio_ui.py` and `latency_patch.py` generate the native device. The container is generated programmatically, not through native Save/Freeze. The optional preview renderer uses Pillow. `SHA256SUMS` verifies the packaged files. Source and AMXD are under the [MIT License](LICENSE), Copyright (c) 2026 alexandru348. Commercial reuse is allowed with notices retained; provided without warranty.
