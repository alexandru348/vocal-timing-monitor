# 0.9 RC1.6 — owner-tested release candidate

Implemented and frozen: reference-based delay calibration, strict signal qualification and temporal reconfirmation, guarded one-shot compensation writes, detailed cancellation reasons, bounded calibration clock liveness and independent read-only playback state. The tested AMXD, onset engine, presentation and stored parameter identities are unchanged for publication.

Completed native session: repeated acoustic calibration; known 0/+150/-150 ms sampled references; Arrangement recording and automatic Stop with retained clip/host confirmation; saved compensation/light themes after full restart and saved-ON/reopened-OFF Auto Stop; refusal of calibration with Auto Stop ON and active Arrangement REC. See docs/HOST_VALIDATION.json.

229 automated checks pass separately from native observations. Release status is RC with limited native scope, not universal certification. An isolated earlier +231.9 ms display remains unexplained. Future investigation may collect controlled event distributions and native transport/configuration traces without publishing private media. CPU profiling, other hardware/rates/OS, Session transitions and configuration races remain extensions of validation, not claimed passes.

Publish current sources, documentation and the byte-identical tested AMXD while preserving the 0.8 RC1.3 checkpoint. Never include owner audio, Sets, screenshots or raw routing/input diagnostics.
