# 0.9 RC1.7.1 Studio — owner-tested prerelease

Implemented and owner-observed on the tested Windows / Live 12 / 44.1 kHz setup: session Auto Stop ON retention, second F9 recording attempt without reactivation, manual OFF, automatic first-use calibration, saved automatic-calibration OFF/compensation after restart, Auto Stop OFF on reload, saved-value reuse and shortened calibration-help text. Both calibration controls are retained by explicit user decision.

The owner-tested AMXD is frozen; publication changes documentation only. Offline evidence: inherited 250-test RC1.7 run and 30 targeted checks for the copy-only RC1.7.1 correction, not 280 distinct checks. Both DSP source files remain byte-identical to RC1.6.

Publish current sources, documentation and the exact AMXD as a prerelease. Preserve RC1.6 release/tag/checkpoint as a recovery version. +231.9 ms (historical) and the early -264.2 ms Stop have cause unconfirmed. No private media or Live Sets.

Further validation scope, not claimed passes: native conclusive-zero persistence, all missing/ambiguous-reference and Session/transport races, CPU peaks, other hardware/OS/rates and vocal timing error distributions. See docs/HOST_VALIDATION.json.
