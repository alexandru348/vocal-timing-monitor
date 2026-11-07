# Vocal Timing Monitor — 0.9 RC1.7.1 Studio

Session Auto Stop retains the visible ON choice across repeated takes. Optional first-use calibration defaults ON and runs only when compensation is absent, a selected digital reference is audible, playback is permitted, REC and Auto Stop are OFF. Reuse successful saved values (including conclusive zero); manual recalibration remains available. No continuous vocal-error learning or recorded-clip movement.

[Download RC1.7.1 AMXD](dist/Vocal_Timing_Monitor_v0_9_RC1_7_1_Studio.amxd?raw=true) · [Published RC1.6 recovery version](https://github.com/alexandru348/vocal-timing-monitor/releases/tag/v0.9-rc1.6) · [Romanian instructions](README_RO.md)

Use a copied Set and one active analyzer. The device outputs silence; record separately. A new instance uses its own defaults. Select the instrumental actually heard by the microphone, play varied audio without speaking and allow approximately 20 seconds for acquisition/confirmation. Save with Ctrl+S. Relevant audio-path changes require manual recalibration. Auto Stop starts OFF on reload; the automatic-calibration preference and validity marker are stored (12 saved values total).

Owner-tested prerelease on Windows / Ableton Live 12 Suite at 44.1 kHz. The owner observed automatic first-use calibration (83.290486 ms), a second F9 take with Auto Stop still ON, manual OFF behavior, saved-OFF automatic-calibration preference and saved compensation after full application restart, and reuse of that value after turning automatic mode ON. See [native scope and observations](docs/HOST_VALIDATION.json). These checks do not certify every audio configuration or general vocal accuracy. Both GenExpr estimators are unchanged from RC1.6. Offline evidence is separate: the inherited 250-test RC1.7 run plus 30 targeted RC1.7.1 help/version correction checks; neither executes Max/Live.

Build with `python build.py`; run `python -m unittest discover -s tests -v` after installing requirements-dev.txt. Python/C++ are development-only. Native components are embedded. Generated previews are approximate Pillow layout checks, not native screenshots. See RELEASE_NOTES.md and docs/TESTARE_0_9.md for scope and validation steps.

The earlier RC1.6 +231.9 ms sample and an early RC1.7.1 Stop at -264.2 ms both have **cause unconfirmed**. Amplitude detection may count keyboard/room sounds and speaker bleed, and does not evaluate musical intent. No private audio, Sets or screenshots included. MIT license; see LICENSE.
