# RC1.7.1 persistence — limited owner native observations

Twelve stored-only values: the ten previous identities plus VTM Automatic calibration (default 1) and VTM Compensation valid (default 0). Auto Stop remains transient/default OFF on device initialization, but its visible session choice no longer clears on Stop, retries or temporary guard loss. Internal spent/low-seen/generation flags are NOT saved. Two additional controls use existing native parameter/pattr replay conventions. Stored OFF for automatic calibration is retained; successful zero compensation has validity 1. The owner saved Auto Stop ON / automatic calibration OFF / compensation 83.290486 ms and fully restarted Ableton: Auto Stop reopened OFF while the other two were retained. Re-enabling automatic calibration reused that value during full reference playback. Native conclusive-zero persistence remains untested. RC1.6 observations below are historical.

# Persistence in 0.9 RC1

The ten existing control identities and types are preserved. Only the established compensation value is updated by successful reference calibration and saved with Ctrl+S. The request token, correlation confidence, acquisition buffers and status are transient. Auto Stop still initializes OFF. See AUTO_CALIBRATION.md for guards and limits; current owner-observed restart retention of compensation/light themes and saved-ON/reopened-OFF Auto Stop is recorded in HOST_VALIDATION.json; exhaustive parameter/host combinations are not claimed.

The following RC1.3 design description is retained as historical context. Its manual last-attack calibration path was replaced in 0.9, and its native observations apply only to RC1.3.

# 0.8 RC1.3 persistence design

Release candidate based on RC3.3 commit `8cd555d6ac907816d375efe2f2410132c7dded70`. Nine existing parameter IDs/names/types/varnames are preserved. Earlier native results are archived in history/RC3_3_HOST_VALIDATION.json. RC1.3 owner-tested persistence and automatic-stop initialization results are recorded in history/RC1_3_HOST_VALIDATION.json, with scope limits.

Seven numeric UI controls use Stored Only Live parameters: analysis, grid, tolerance, detection, compensation and two zooms. Two Blob pattr parameters store exact source/channel labels. Theme adds a tenth Stored Only integer, `VTM Theme`, varname `vtm_theme`, default 0 (dark), range 0–1. There is no global settings file.

Startup after live.thisdevice queries restored values instead of writing defaults. Bound nonparameter pattrs replay analysis/theme without banging their textbuttons, which would toggle them. Theme replay applies per-object colors and repaints current status/raw-level diagnostics without audio-control or routing commands.

Routing capture uses confirmed selected-index feedback resolved to current labels. Deferred startup lookups resolve desired labels to current indices; startup feedback cannot overwrite desired labels, and repeated feedback is bounded. Manual selection cancels pending restore. Unknown labels send no command; missing/renamed/renumbered labels require reselection. This is label-based restoration, not persistent track identity.

Auto Stop is nonpersistent and explicitly initializes OFF. Actions, counters, waves, diagnostics, window position and basic/advanced page choice are transient. Initialization returns to compact/basic while retaining theme. Ordinary settings expansion/collapse preserves the current origin; opening/hiding the monitor does not initialize the engine.

Ctrl+S in Live is required to save to disk. A fresh instance has defaults and does not inherit another instance's values. Windows levels, transport state and tempo are external.

155 static/simulation checks passed, including stubbed theme/modified-value roundtrips. They do not prove native painting or Live serialization. Gen is unchanged; parent audio/API digest remains pinned after explicitly normalizing parameter/UI metadata, popup contents, dedicated device-theme module and the existing initial-state display filter. No signal/transport edges are normalized away.

Primary references:

- https://docs.cycling74.com/userguide/m4l/live_pattr/
- https://docs.cycling74.com/userguide/parameter_mode/
- https://docs.cycling74.com/reference/pattr/
- https://docs.cycling74.com/reference/live.thisdevice/
- https://docs.cycling74.com/reference/live.routing/
- https://docs.cycling74.com/reference/textbutton/
- https://docs.cycling74.com/reference/thispatcher/
- https://docs.cycling74.com/reference/multislider/

Fixtures and preview waves are synthetic. Private Live Sets, diagnostic dumps, routing/input payloads, recordings and owner screenshots are excluded.

RC1.2 replaces the two zoom flonums with native live.numbox LCD controls using the same Float parameter identities, initial values, ranges and replay connections. Added metadata is parameter_unitstyle 9 and parameter_units `%g×`. Format affects display only; left outlets remain numeric. The owner subsequently confirmed fractional editing and retained values after a full native application restart. The host-stub result remains a separate form of evidence.

RC1.3 reuses the single VTM Theme parameter. ui-theme-trigger emits its integer on the new right-hand local popup outlet, while the existing left control outlet stays separate. The parent connects the theme outlet only to ui-device-theme-select and local palette/thispatcher objects. Regular outlet order is fixed by left-to-right patching coordinates. The initial bound pattr replay runs without opening the monitor and also updates the parent. Device palette targets are nonparameter color attributes; no value/action messages are sent. A solid bgfillcolor panel covers the 360×169 device body behind its existing foreground controls.

RC1.2 owner observation: the light monitor theme, 2.5×/2× fields and compensation survived a full Ableton restart. Other controls were reported retained. See history/RC1_2_HOST_OBSERVATIONS.json. In RC1.3 the owner subsequently confirmed the restored light root palette before monitor opening and retained settings after full restart, plus saved-ON/reopened-OFF behavior. See history/RC1_3_HOST_VALIDATION.json; native dark-body restart and exhaustive combinations are not claimed.

Additional native references:
- https://docs.cycling74.com/reference/panel/
- https://docs.cycling74.com/reference/outlet/
