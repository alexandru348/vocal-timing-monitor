# Vocal Timing Monitor 0.8 RC1.3 Studio — owner-tested release candidate

**Owner acceptance completed on 3 November 2026 in the tested Windows / Ableton Live 12 workflow.** Based on tested RC3.3 at `8cd555d6ac907816d375efe2f2410132c7dded70`; that earlier tag/release remains available. The RC1.3 AMXD is byte-identical to the owner-tested artifact (SHA-256 `9d26049639cfad68ee18c6c7800e99b57013b4b1fd567b383405d5106dbd9e00`). Publication changes documentation only after acceptance.

- Native floating UI redesigned at 640 × 370, expanding to 640 × 760 with basic/advanced pages.
- Light/dark theme, saved per instance as an additional Stored Only parameter.
- Clear Romanian names and result/direction labels; states distinguished by text/symbol and color.
- Raw microphone peak meter with gate marker/overload feedback; independent of the filtered detector.
- Compensation/calibration and visual zoom moved to advanced settings. Impossible-tolerance warning beside its control.
- Existing nine stored-control IDs, Gen source, audio graph, routing and automatic-stop lifecycle retained. Theme/page changes preserve audio controls and stop intent.

155 automated static/simulation tests passed. Eight approximate layout illustrations used synthetic waves; no estimated text overflow. The owner confirmed the light device/monitor palette, restoration before opening the monitor, controls/source after full restart, playback/recording waves, actual automatic stop with retained clip and Live confirmation, and saved-ON/reopened-OFF behavior. See docs/HOST_VALIDATION.json for evidence and limits. Earlier RC3.3 host validation is archived separately.

Test the new AMXD in a copied Live Set with RC3.3 deactivated; retain the old file. Enter preferences once for a fresh instance. Save with Ctrl+S. Auto Stop always loads OFF. See docs/TESTARE_0_8.md.

MIT licensed, including commercial reuse, with notices retained. No private Live Sets, extracted private diagnostics, recordings or owner screenshots are packaged.

## RC1.1 spacing correction

Owner screenshots of RC1 showed the compact time labels too close to the lower window border. Compact height is now 370 instead of 360 native units, giving 12 units below the label boxes instead of 2. Waveforms, label coordinates and expanded height remain unchanged. Initial size and both expand/collapse calculations use the same constants. The compact layout was subsequently accepted by the owner.

## RC1.2 text and units

Native LCD zoom fields display 1×, 2× and fractional multipliers while preserving Float parameter identities/ranges and the visual-only signal path. Displayed text now uses Segoe UI with enlarged small captions, integer point sizes and room for descenders. The compact lower padding is retained. The owner accepted the revised text and confirmed fractional unit display/editing and saved values after restart; objective sharpness measurements are not claimed; the global Max High DPI preference is neither inspected nor changed by the AMXD.

## RC1.3 embedded device body

Synchronize the embedded device body and floating monitor using the same instance-scoped stored theme. Root background uses a native solid-fill panel; title, notes and open-button normal/on/hover colors follow the palette. A dedicated second popup outlet carries theme values to root-local thispatcher messages only. Saved-theme replay applies before opening the monitor. No new parameters, audio routes, runtime dependencies or global settings. Live's own device header/frame is unchanged.

Three additional regression checks cover both toggle directions with armed stop intent preserved, full-restart/repeated-ready replay while the monitor is closed, local outlet/target isolation and independent instance models. All 155 tests pass. Native RC1.2 partial acceptance is recorded in history/RC1_2_HOST_OBSERVATIONS.json; current RC1.3 owner acceptance, actual recording/stop and saved-ON/reopened-OFF results are in docs/HOST_VALIDATION.json. Dark-body restart and native multi-instance isolation were not independently documented; both palette directions and instance isolation have automated model coverage.
