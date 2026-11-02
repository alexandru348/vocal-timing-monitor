# Vocal Timing Monitor 0.7 RC3.3 Persistent

## Download

Download **Vocal_Timing_Monitor_v0_7_RC3_3_Persistent.amxd** from Assets and load it on a dedicated audio analysis track in Ableton Live. **VTM_v0_7_RC3_3_Persistent_Sources.zip** includes source, tests, documentation, MIT license and runtime. SHA256SUMS-ASSETS verifies release downloads; SHA256SUMS verifies the source snapshot.

## Changes since RC2

- Restores nine settings with the saved Live Set: analysis, grid, threshold, compensation, detection, both waveform zooms and instrumental source/channel.
- Resolves confirmed routing indices to exact labels for storage, then labels to current indices after reopen. Missing or renamed sources require reselection.
- Keeps Auto Stop OFF at load, even when the Set was saved with ON. New instances use factory defaults.
- Fixes the initial analysis-OFF status header. DSP source is unchanged from RC2.

Save your Live Set with Ctrl+S; this feature does not periodically save the project to disk. From RC2, enter your preferred settings once in the new instance. Existing RC3.2 test projects can retain their current filename using the optional **VTM_RC3_3_Update_Existing_RC3_2.zip** asset; its patch is identical to RC3.3, but keeps the old container filename. New users should use the canonical RC3_3 AMXD.

## Validation

Owner-tested on 2 November 2026 in Ableton Live 12 Suite / Windows 11, 44.1 kHz, 100 BPM: full restart restored changed controls and instrumental routing; initial OFF status corrected; both waves and speech attacks worked; the count stayed stable during silence in the short test. Actual Auto Stop stopped recording with the clip retained and host confirmation. Saving Auto Stop ON then reopening yielded OFF with other settings retained.

Native tests used the compatibility RC3_2 filename containing the exact RC3.3 patch; canonical container payload equivalence and deterministic output were verified offline. 140 automated static/simulation checks passed; these do not execute Max. Final speech/recording test used microphone 70%, speakers 15%, detection −26 dB and compensation +92.2 ms, specific to one laptop.

## Requirements and limits

Requires Ableton with Max for Live available; AMXD, not VST/AU. Current interface labels are Romanian. Timing follows the nearest Live grid point; it does not evaluate musical flow or separate speech. Keyboard noise and speaker bleed may trigger attacks. Vocal compensation is approximate and other setups are unverified. Auto Stop stops the entire transport, including recording, and must be enabled explicitly for each attempt after synchronization.

Source and AMXD are licensed under **MIT**, including commercial reuse, with notices retained; provided without warranty. See LICENSE and README.md / README_RO.md. No private Live Sets or recordings are included. Original tag and release **v0.7-rc2** are preserved as the earlier checkpoint.
