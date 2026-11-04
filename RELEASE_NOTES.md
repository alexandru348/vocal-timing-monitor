# 0.9 RC1.6 Studio — reference calibration, owner-tested RC

The existing Advanced “Preia întârzierea” button now measures the effective delay between the selected digital instrumental reference and its acoustic return in the microphone. Clear multiband evidence or a fresh matching temporal confirmation is required before writing the existing saved compensation. Rejection/cancellation preserves the prior value. There is no continuous learning from vocal timing and no recorded-clip movement.

The 0.8 interface, ten stored controls, themes, waveform zoom and amplitude onset/Auto Stop workflow are retained. RC1.6 adds bounded calibration clock tolerance and a separate read-only playback observer. The original onset engine remains byte-identical. All earlier correction details and algorithm limits remain in docs/AUTO_CALIBRATION.md.

## Validation

- 229 automated checks passed: static contracts, exact GenExpr arithmetic translated to C++, and generated Max-message graph stubs. These do not replace the native runtime.
- Owner-observed native execution in Live 12 Suite on Windows at 44.1 kHz with laptop speakers/microphone. Repeated calibration applied 93.056351 then 92.885786 ms.
- With compensation 92.885786 ms, sampled known-reference results for 0 / +150 / -150 ms were -0.20 / +149.8 / -150.10 ms.
- Arrangement recording stopped at 5.1.2 / +149.9 ms, at the first deliberate +150 ms section, and retained its recorded clip; Live confirmed Stop.
- Full application restart retained compensation and the light device/monitor themes; saved Auto Stop ON reopened OFF.
- Calibration refused Auto Stop ON and active Arrangement REC, leaving compensation unchanged. The recording continued until the owner switched REC off.

## Scope and unresolved observation

An earlier +231.9 ms display in the +150 ms section was not reproduced in a later captured sample; its cause remains unconfirmed. Do not describe it as fixed or attribute it to hardware/user noise without evidence. Sampled matching displays are not a population error bound. Amplitude detection can count keyboard/room sounds and instrumental bleed and does not classify voice or musical intent.

This RC does not certify other audio configurations, native CPU peaks, every Session Record/host transition, or pending-result configuration races. Those safeguards have model coverage, not exhaustive native coverage. See docs/HOST_VALIDATION.json for exact scope. Recalibrate after relevant path/configuration changes. Compensation affects measurement only, not recording placement.

The tested AMXD is unchanged: SHA-256 c25358cb4f89a85e6bdcbc0e44a6323b463bf6c650427209cc12b8e51a6609e3. Publication updates documentation and includes reproducible synthetic reference instructions. The 0.8 RC1.3 checkpoint and prior distributable remain available. No private Set, owner recording, original/annotated screenshot or raw routing/input dump is included.
