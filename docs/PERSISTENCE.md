# RC3.3 persistence design

Validated in the owner setup on 2026-11-02; see HOST_VALIDATION.json. Built from MIT main b2dedcc6d9a9fd18ad9ca8d004d650c2703272d7.

Seven existing UI controls use Live parameters with stable varnames and Stored Only visibility: analysis, grid, threshold, compensation, detection and the two waveform gains. A float host parameter preserves the threshold's full 10–300 ms range while the UI remains an integer number box. There is no external settings file or shared global state.

Startup runs after live.thisdevice. Numeric controls reemit their restored values instead of receiving hardcoded defaults. The analysis textbutton is queried through a bound, nonparameter pattr; banging the textbutton itself would toggle it. Auto Stop remains nonpersistent and is explicitly set to 0. Action buttons and transient diagnostics are excluded.

Two unbound Blob pattr parameters store prefixed exact source/channel labels, based on confirmed live.routing output after a manual menu selection. Startup feedback cannot overwrite the desired saved labels. Current lists populate anonymous coll maps, and deferred lookups resolve labels to current indices. change suppression bounds feedback; initialization resets lookup caches, and applying a source resets the channel cache so a channel can be applied again. A manual choice cancels pending restoration and opens capture. Unknown labels emit no routing command; renamed/missing labels require manual reselection. Labels are not stable track identities when Live renumbers or renames tracks.

Saving the Live Set (Ctrl+S) is required. Reopening the saved instance should restore its controls; dragging a fresh AMXD creates a new instance with factory defaults. Old RC2 values need one manual entry because RC2 did not persist them. Neither the Live transport state nor Windows volume is controlled by this storage feature.

140 automated static/simulation checks pass; native full restart, routing, analysis OFF, non-default grid/threshold/zoom, speech/silence, recording, actual Auto Stop and saved-ON/reopened-OFF were confirmed separately by the owner. Automated stubs do not prove native serialization.

The DSP source is byte-identical to RC2. The parent audio/API graph digest remains pinned after excluding popup changes and normalizing parameter/UI metadata plus the documented initial-state display filter (`change -1`). The original RC2 tag is untouched.

Primary implementation references:

- https://docs.cycling74.com/userguide/m4l/live_pattr/
- https://docs.cycling74.com/userguide/parameter_mode/
- https://docs.cycling74.com/reference/pattr/
- https://docs.cycling74.com/reference/live.thisdevice/
- https://docs.cycling74.com/reference/live.routing/
- https://docs.cycling74.com/reference/textbutton/
- https://docs.cycling74.com/reference/coll/
- https://docs.cycling74.com/reference/counter/

Public package privacy: private Live Sets and extracted diagnostic reports are excluded. Tests use synthetic fixtures and generic track labels. HOST_VALIDATION.json contains functional outcomes only.
