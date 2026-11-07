# 0.9 RC1.7.1 Studio — owner-tested prerelease

## Changes

- Auto Stop's visible ON choice survives an automatic Stop, manual Stop/Start, repeated recording attempts, settings edits and temporary guard loss. The current take still stops on its first confirmed over-tolerance attack. Reload starts OFF.
- Internal per-attempt permission is separate: require known playing state, original safety guards and a fresh low detector latch; consume each request once. Stop/Start, explicit OFF/ON and guard/configuration transitions invalidate queued old requests. An unconfirmed host Stop is reported without command retries in the same transport run.
- Settings → Advanced adds **Calibrare auto: ON/OFF**, default ON and saved. With missing compensation, an audible selected digital reference and continuously permitted conditions for one second launch the existing estimator. Keep quiet, with REC and Auto Stop OFF. A successful value is saved/reused; a conclusive zero is also marked valid. Nonzero manual/legacy values are reused. Manual recalibration remains available.
- Automatic scheduling tries once per playback, preserves values on failure and does not continuously learn from voice/grid error. Turning it OFF cancels only an automatically launched request. Its preference and a compensation-valid marker are the only extra stored values (12 total).

Both GenExpr files are byte-identical to RC1.6. The interface adds one button in unused Advanced space, with the same compact window, themes, native controls, silent output and separate recording track.

## Validation and limits

Offline validation is documented in docs/TEST_RESULTS.json: the inherited 250-test RC1.7 run passed; 15 static/container and 15 UI graph checks separately passed for the RC1.7.1 help/version correction. These are overlapping suites, not 280 distinct tests, and do not execute the native compiler or Live scheduler. Separate owner-observed RC1.7.1 checks on 2026-11-07 covered:

- Native loading and the corrected calibration-help text.
- Automatic first-use calibration without the manual button, applying 83.290486 ms.
- Auto Stop retaining ON and compensation after Stop; a second F9 take without touching the toggle/reset progressed and later stopped at 5.1.2 with +159.5 ms and a retained recording.
- Manual OFF allowing recording to continue through the over-tolerance section.
- Full application close/reopen: saved Auto Stop ON reopened OFF, while automatic-calibration OFF and compensation 83.290486 ms were retained.
- Automatic mode re-enabled and the whole reference played: compensation stayed 83.290486 ms.

See docs/HOST_VALIDATION.json for exact scope. A final retained reference display was -140.50 ms in the nominal -150 ms section (49 counted attacks); this is one sample, not a general accuracy bound. Historical RC1.6 observations remain separately archived.

Calibration still measures effective relative digital-reference/acoustic-return delay, not recorded-clip placement. It requires an appropriate instrumental reference, no voice during acquisition and unchanged audio path afterward. Relevant path changes require manual revalidation/recalibration; they are not automatically inferred. No continuous recalibration during takes. Automatic first-use is deferred while Auto Stop or recording is active.

An earlier +231.9 ms sample in RC1.6 and an early RC1.7.1 Stop at -264.2 ms (two attacks, before the deliberate +150 ms section) both have **cause unconfirmed**; neither is claimed fixed. Other hardware, native CPU peaks and exhaustive host-transition races remain unverified.

Owner-tested AMXD SHA-256: 893eb2d8f00e39485a52badf2331b138dd21a0d0008756ae8e18b6db18fcda57
Published recovery version: https://github.com/alexandru348/vocal-timing-monitor/releases/tag/v0.9-rc1.6
MIT licensed. No private Set, owner recording or screenshots included.

RC1.7.1 is a copy-only correction after owner-observed clipping in RC1.7: shortened startup calibration help. Structural patch comparison confirms only help/version strings changed. Fifteen static/container and fifteen UI graph checks passed for the correction; the 250-test RC1.7 result remains inherited. The later owner observations above apply to RC1.7.1. Conclusive zero validity, missing/ambiguous-reference rejection, native CPU peaks and exhaustive Session/configuration transitions have not all been tested natively.

## Two calibration controls retained

Calibrare auto ON/OFF controls automatic first-use acquisition only when no valid compensation exists. Preia întârzierea explicitly requests a fresh measurement even when compensation already exists, for example after relevant audio-path changes. Both use the same estimator but serve different workflows. The user explicitly chose to keep both. Manual recalibration still requires playback with REC and Auto Stop OFF.
