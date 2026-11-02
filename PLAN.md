# RC3.3 checkpoint — 2026-11-02

Completed: nine per-instance Live Set controls, exact source/channel label capture/restore, initial analysis-OFF display correction. 140 automated checks passed. No Gen DSP source changes from tested RC2.

Owner native tests passed: complete Ableton restarts retain controls including non-default OFF/1/8/80/zoom2-3 and routing; corrected OFF header; both waves and speech/silence behavior; separate track3 recording; actual Auto Stop with clip retained and host confirmation; saving Auto Stop ON then reopening OFF with other settings retained. Details and chronological failures/fixes in docs/HOST_VALIDATION.json. Native tests used same-patch compatibility filename RC3_2, canonical RC3_3 equivalence verified offline.

Final test settings: mic70%, speakers15%, detection-26 dB, offset92.2ms, grid1/4, threshold100ms, zoom1/1. These are setup-specific, not defaults.

Release: v0.7-rc3.3, MIT, canonical RC3_3 AMXD plus sources and optional in-place RC3_2 update. Preserve original v0.7-rc2 tag/commit/release. New instances have factory defaults; no automatic RC2 migration. Current owner project may retain compat filename safely; changing local filename is not required for GitHub release. Private .als/audio/screenshots are excluded.

Limits: speech timing is approximate; noise/speaker bleed can trigger. Other host/audio setups remain unverified. Saving controls requires saving Live Set; no periodic disk autosave. Future work should branch from the new checkpoint, with native validation for host-dependent changes.
