# 0.9 RC1.6 — reference-based acoustic calibration

This is an owner-tested RC with limited native scope. Current observations are recorded in HOST_VALIDATION.json and the publication section below. Keep the owner-tested 0.8 RC1.3 available; earlier-version reports remain historical evidence.

## User workflow

The monitor layout, themes, ten saved controls, waveform zoom fields, detection threshold, grid and timing tolerance are preserved. The existing **Preia întârzierea** button now measures a reference delay instead of copying the last microphone attack's raw deviation. It is available without a previously counted vocal event and works independently of the chosen rhythmic subdivision.

1. Select the same instrumental source that is actually heard through the speakers. Both microphone and instrumental waves must be present.
2. Leave Arrangement Record, Session Record and Auto Stop OFF. Start playback in a varied instrumental passage lasting at least twenty seconds. Do not sing, speak or operate the keyboard during the measurement.
3. In Advanced, click **Preia întârzierea** once. Keep quiet until the final result, allowing twenty seconds while the music plays. The existing help text reports acquisition, analysis, acceptance, rejection or cancellation.
4. On success the existing compensation field receives the measured estimate. Ctrl+S saves this value with the Set. Enable Auto Stop explicitly only when starting the intended attempt.
5. On rejection/cancellation the previous compensation remains. A sparse/repeated passage, missing reference, an inaudible acoustic return or dominant unrelated sound can prevent calibration. Inspect the diagnostic explanation before repeating; do not force a number from a vocal error. Each button press starts a fresh capture without a reset; reset during measurement cancels it.

The microphone must capture an acoustic copy of the selected instrumental. A silent/different output path cannot be measured this way. No microphone audio is sent to the device output, and no calibration sound is generated. Waveform visual zoom has no effect on the estimate.

This is automatic measurement initiated by the existing button, not continuous learning from singing. Repeat it after a change to the relevant audio path, buffer, effects latency or physical setup. A saved number cannot certify a later audio configuration.

## What it estimates

The estimator compares the selected digital reference bus with the corresponding sound received by the analysis microphone. It estimates their effective relative delay, including acoustic travel and applicable processing along their different paths. It does not read or claim the total interface round-trip latency, identify every delay component, move a recorded clip, or inspect the recorded clip's timing. It assumes the selected reference bus is the appropriate host-synchronized timing reference for the sound the performer hears. Different routing, additional signals and monitoring/compensation arrangements can violate that assumption; native verification is required.

From a microphone onset alone, technical delay and a genuinely late performance are not independently observable. The calibration therefore never estimates compensation from the microphone's grid deviation, the player's average timing, the timing tolerance or a preference for an on-grid result. After applying a measured compensation, the existing onset engine still reports actual early/late input relative to the selected Live grid. It does not judge syllables, swing or musical intention.

## Algorithm and acceptance

`src/vtm_latency.genexpr` is embedded in a separate native gen~ module. Four matched feature paths compare microphone L/R with instrumental L/R: the previous 65 Hz high-pass path, plus 250–700, 700–2000 and 2000–6000 Hz overlapping bands. Each band uses two cascaded first-order high-pass and two first-order low-pass stages on each input, then the same 4 ms magnitude envelope. Stereo maximum magnitudes avoid cancellation on antiphase channels. A rational accumulator averages the envelopes at 1 kHz without assuming that the host sample rate is divisible by 1000. The bands are overlapping comparisons, not statistically independent confidence trials.

The module captures 3584 ms in instance-local Data arrays and examines lags from -400 to +400 ms. Mean-removed, normalized envelope correlations are calculated over two non-overlapping 1024 ms windows independently for every feature path. Each path is conclusive only when:

- the lower correlation across the two windows is at least 0.85;
- the best delay is at least 0.12 above a competing peak outside a ±20 ms neighborhood;
- independently optimal window delays agree within 3 ms;
- the result is clear of the search boundary and both paths have sufficient varying energy.

When at least two paths are conclusive, ALL conclusive estimates must fall within a 3 ms range. The highest-correlation conclusive estimate is selected only after that check. Conflicting conclusive paths are rejected; the implementation does not cherry-pick a cluster.

When exactly one path is conclusive, its estimate stays provisional and a second complete capture starts automatically. The SAME feature path must pass the same two-window tests again. Every conclusive path in the second capture, together with the first estimate, must fit within a 3 ms range. Only then is the average of the first estimate and the matching second-path estimate applied; its quality is the lower of those two qualities. This supplies four non-overlapping 1024 ms verification windows across separate captures without relaxing .85 correlation, .12 margin, window agreement or boundary checks. Missing/weak confirmation, a changed delay or a lost guard retains the existing compensation. This is temporal repeatability evidence, not independent information about every frequency component or a calibrated probability.

The peak is interpolated locally; fractional displayed values are estimates, not a claim of sub-millisecond acoustic accuracy. Correlation is a similarity score, not a calibrated probability. Filtering, room response, noise and limited reference bandwidth affect real accuracy. Rhythmic ambiguity, silence or unrelated dominant sound is rejected rather than mapped to the nearest attractive beat. A structurally similar unrelated signal can still be ambiguous; quiet acquisition and native checks remain necessary.

Work is bounded to 64 accumulation iterations per DSP sample while analyzing, with the four paths processed sequentially. Capture lasts 3.584 seconds; correlation work takes about 2.33 seconds at 44.1 kHz, so completion is about six seconds of uninterrupted DSP processing. With one conclusive path, the fresh capture plus the same analysis adds about six seconds, for roughly twelve seconds total at 44.1 kHz. Allow twenty seconds of quiet playback for the native trial. Status 7 reports fresh reconfirmation and is not terminal or an applied compensation. Data memory is about 240 KiB with 64-bit elements (two 14336-element histories, one 801-element score array and one 40-element evidence array). While idle, only input filtering and small lifecycle checks run. It needs no JS, external, runtime Python, bundled image or external buffer. Actual CPU cost and Gen compilation remain native-host checks.

## Transaction and lifecycle

Calibration requires analysis, host/audio activity, valid API binding and explicit zero recording-state reports from native observers (`record_mode`, `session_record`, `session_record_status`), plus Auto Stop OFF. Unknown reports block acceptance. The module receives the existing host audio phase; clock loss, lifecycle loss, relevant control/source changes and observed DSP configuration changes cancel acquisition or an outstanding result.

Each request has a generation token. Polling samples result/quality/token before state. Application is deferred, rechecks current guards and token, and consumes the result once. An estimate cannot overwrite a newer manual value or a newer calibration request. The UI announces an applied calibration only after the guarded parameter write. The existing compensation parameter remains the sole stored result; calibration state/confidence is transient. Calibration does not arm/disarm Auto Stop, start/stop transport, record audio, change audio devices, change routing, or set global latency compensation. The ordinary compensation write retains the old timing-reset behavior.

These are implementation/model-tested safeguards, not an atomic guarantee about every Live transition. Active Arrangement REC and Auto Stop ON request refusal were observed natively; Session transitions and exhaustive scheduling/configuration races remain unverified.

## Evidence and limits

229 automated checks passed. Exact GenExpr arithmetic was compiled into a C++ harness with explicit Data/History semantics; this is not the Cycling '74 compiler. Synthetic delayed reference cases recovered 0, 23.6, 92.2, 173 and -74 ms within 0.6 ms at 44.1/48/96 kHz. Additional tests cover stereo polarity, noise/mild echo, silence, absent reference, unrelated/dominant sound, periodic ambiguity, changing delay, search boundaries and cancellation. Integrated arithmetic tests preserve genuine ±140 ms errors after measured compensation and preserve the existing automatic-stop decision.

Generated native message-graph tests cover unknown/active recording, armed Auto Stop, stale generation, queued acceptance cancellation, manual/source/buffer changes, one-shot application and existing saved parameter identity. All 70 presented monitor objects and six device objects retain their classes, geometry, fonts and parameter metadata relative to RC1.3. The onset engine bytes and historical audio/API protocol remain pinned after explicitly excluding only the new calibration taps and existing UI normalization.

Historical RC1.2 native screenshots confirmed diagnostics render and reject weak reference correlation; no successful calibration had been observed at that stage. Native RC1.3 reached a strong single-path candidate in both passages but kept compensation unchanged (N=1). One native RC1.4 calibration was accepted and written to the compensation field. Later repeated trials cancelled, including a synchronized playing screenshot. Repeatability and physical accuracy remain unvalidated; Native RC1.5 subsequently reported C300 with active synchronized playback; the owner supplied a repeat screenshot during playback. The later RC1.6 owner session observed successful repeated calibration and sampled known-reference timing; see the current native report. Historical pending statements below describe those earlier development stages. Synthetic accuracy and message stubs do not establish acoustic accuracy, false-positive rates, CPU performance, native Gen compilation or every Live/OS configuration. Private recordings, Live Sets, diagnostic dumps and owner screenshots are excluded.

Primary references:

- https://docs.cycling74.com/userguide/gen/gen_genexpr/
- https://docs.cycling74.com/reference/gen_dsp_peek/
- https://docs.cycling74.com/reference/gen_dsp_poke/
- https://docs.cycling74.com/reference/plugphasor~/
- https://docs.cycling74.com/reference/live.observer
- https://docs.cycling74.com/apiref/lom/song/
- https://docs.cycling74.com/reference/dspstate~/
- https://www.mathworks.com/help/signal/ref/finddelay.html
- https://help.ableton.com/hc/en-us/articles/360010545559-How-Latency-Works

## RC1.1 startup correction

Native RC1 was reported blocked even with active playback, synchronized clock and both waves. No successful calibration was observed. RC1.1 changes recording observers from an undocumented @property constructor to documented positional property arguments, explicitly selects each property after confirmed binding, and preserves unknown-state refusal. A subsequent native RC1.1 report reached terminal rejection with full help text in both intro and full-beat passages. This confirms progress beyond blocked startup, not calibration accuracy.

Calibration now reports the current failed guard in the existing help field. Literal punctuation is escaped in Max message text so commas and semicolons cannot split the explanation or act as remote-message separators. All status packets are generation-checked; repeated refusal updates the current reason and old terminal packets cannot consume a newer request.

The message test model now follows documented observer property selection and escaped-message punctuation. Seven new regression checks were added; all 184 checks passed at that checkpoint. Both Gen sources and UI control geometry/parameter identities were unchanged from RC1. This is a new native-test candidate, not a confirmed fix on every host.

## RC1.2 rejection diagnostics

The owner reported unchanged compensation (0 ms) and the generic inconclusive-reference message on both intro and full-beat passages. The physical cause cannot be inferred from screenshots. RC1.2 adds read-only diagnostic outputs and renders them only on a current-token terminal rejection, within the existing help field. No new presented object or stored control is added. Acceptance criteria remain .85 minimum correlation, .12 peak separation, <=3 ms window agreement and interior search peak.

The first failed check is reported: insufficient digital-reference variation, insufficient microphone variation, insufficient correlation, competing delay peaks, disagreement between windows, or search boundary. C is the minimum two-window correlation at the common candidate (clamped to 0..1); A/B are the independently best window correlations; M is common-peak minus competing-peak correlation outside 20 ms; D is the absolute difference between the two independently best window lags. Candidate is an integer search lag, not an accepted compensation. Low variation takes priority; otherwise reasons follow the original acceptance checks. Reasons describe failed algorithm checks, not proven hardware faults.

DSP exports 11 signals: existing state/result/quality/busy/token, then reason, candidate lag, best correlation A, best correlation B, peak margin and window-lag disagreement. Existing first five outlets remain stable. Poll samples all diagnostic values before reason and state. Rejection text is rendered only after current-token validation. All 193 automated checks passed; nine new checks cover diagnostic branches/values, native-message rendering, coherent poll order, stale-token suppression, repeated rejection, unchanged manual compensation and presentation/parameter invariants. Subsequent native RC1.2 screenshots confirmed diagnostic rendering and reported insufficient correlation in both passages, with unchanged compensation. Successful real acoustic calibration remains pending.

## RC1.3 spectral comparisons

Screenshots establish failed correlation checks, not a proven hardware or operating-system cause. A synthetic independent-rhythm mix passed through a 600–3800 Hz colored path reproduces a broadband rejection (score about .75 at a known 92.2 ms delay). Matched sub-band comparisons exceed the unchanged correlation/ambiguity thresholds and agree to less than 0.5 ms in that fixture; the selected result is about 92.35 ms. This is synthetic evidence, not a measurement of the owner’s laptop.

Eight new automated tests cover that filtered-path recovery, 48/96 kHz colored paths, conflicting frequency-dependent delays, refusal of a lone strong path, repeat without reset, cancellation during later-band analysis, coherent native-message diagnostics and explicit strict acceptance conditions. Synthetic conflicting bands approximately 50 ms apart are rejected even when both individually pass. SciPy is used only to create independent test filter fixtures, not shipped in the AMXD or needed at runtime.

DSP now exports 13 signals. The first 11 keep their existing roles but diagnostics describe the selected feature path; outlet 12 is the number of individually conclusive paths N (0..4), outlet 13 is their estimated-delay range S in milliseconds. Rejection reasons 7/8 describe insufficient cross-band confirmation or conflicting conclusive bands. An output quality is not an acceptance by itself. No audio, timing detector, parameter identity, routing, recording or Auto Stop behavior was altered. Native compilation, CPU, acoustic repeatability and calibrated timing remain pending.

## RC1.4 fresh temporal confirmation

The RC1.3 owner reports showed strong, unambiguous two-window matches in a single feature path across both intro and full-beat attempts; the two-path requirement still refused application. RC1.4 retains all strict per-path tests and adds a genuinely new acquisition for exactly-one-path cases. The request token is unchanged within that transaction; a new button press resets the anchor and must establish its own evidence. The first Data buffers are fully overwritten by the second capture before analysis; old band evidence cannot qualify a new capture.

Eight added automated checks cover provisional-before-confirmed timing, changed second-capture delay, missing second reference, permit/reset cancellation, a new request discarding its old anchor, provisional native help/recording guards, terminal diagnostic rendering and actual early/late/Stop decisions after temporally confirmed compensation. Synthetic single-path coloration recovered a known 92.2 ms delay near 92.25 ms. This does not validate the owner’s candidate number or prove total recording latency. Known native timing-reference and repeatability checks are still required.

The existing 13 DSP outputs and ten stored controls are preserved. DSP/UI status 7 means Reconfirm through a new capture; diagnostic reasons 9 and 10 mean inconclusive reconfirmation or a changed delay. During reconfirmation the result is not published and its quality is zero. N/S diagnostic fields describe the second capture; N=1 is allowed only after this strict temporal path succeeds. No microphone monitoring, driver settings, recorded clips or audio routing are changed.

## RC1.5 cancellation echoes and provenance

The native cancellation trigger is not established by screenshots. Inspection identified a separate reproducible issue: repeated identical numeric control/source readbacks unconditionally incremented the cancellation token. Only the new calibration taps now suppress identical numeric values (`change`) and identical source/channel messages (`zl change`). Original timing/control/routing paths remain connected exactly as before. Explicit Reset, refresh and lifecycle events are not suppressed, and actual configuration changes continue to cancel. DSP configuration was already change-filtered.

Two transient Gen parameters, cancelreason and guardreason, describe events; they are not Live stored controls. A cancellation latches its reason into the existing diagnostic output 6. Later guard recovery does not erase that code. Status 5 displays a specific message with a short C-code in the existing help field. Explicit-source codes are 101..118 (threshold, analysis, Auto Stop, grid, tolerance, manual compensation, reset, source/channel commands, refresh, source/channel readback changes, lifecycle, generic permit loss, DSP activity/rate/vector/I/O vector). Guard codes 201..212 follow the priority used by startup permission. DSP clock discontinuity and sample-rate change use 300/301. Unknown causes retain an explicit generic explanation rather than inventing Stop.

The final deferred write predicate also reports which check refused application: 401 host guards, 402 consumed request, 403 request generation, 404 quality, 405 range. Code 400 is an unclassified final refusal. Diagnostic provenance may identify a software condition without proving the physical cause. No cancellation guard was disabled; no retry or confidence threshold was relaxed. The acquisition, spectral correlations, acceptance, averaging, and actual onset detector are unchanged from RC1.4.

Eleven new checks cover identical numeric/source/DSP readbacks, genuine changed control/source/reset/refresh/vector cancellation, cause-before-sequence ordering, latched DSP/recording causes, final predicate explanations and stable terminal text after recovery. Native confirmation of the fix and successful repeat calibration remain pending. Reference: https://docs.cycling74.com/reference/zl.change/ .

## RC1.6 calibration clock guard

The owner reproduced C300 while playback remained active. RC1.5’s per-sample increment rule cancelled immediately on any invalid phase sample. A deterministic old-source C++ replay reproduced C300 exactly at the first isolated held phase sample, while microphone/reference samples were uninterrupted. This establishes a software failure mechanism, not the exact shape of the owner’s unseen native phase signal.

Calibration already timestamps both acoustic paths with DSP sample counts; phase is a liveness guard, not the measured-delay timebase. RC1.6 requires the same initial 10 ms continuous valid-rate lock, then holds that lock across less than 2 ms of consecutive invalid increments. A sustained invalid clock clears lock and cancels. A phase discontinuity larger than 2 ms of estimated beat advance cancels immediately; the estimate is a smoothed valid increment rate. Natural wraps and inclusive wrap endpoints are handled. Cancel reason 302 reports persistent invalid phase and 303 reports a large phase jump. Sample-rate change and all existing control/API/recording/lifecycle guards remain. This tolerance is a bounded clock-guard policy, not proof that every host glitch is harmless or that native timing is accurate.

The calibration permit now uses a fourth read-only native observer, live.observer is_playing, bound and explicitly re-queried through the same confirmed Song ID as the recording observers. Unknown playback reports block acceptance and reset on API loss. The original onset engine and its instantaneous sync/Stop safety paths are unchanged. Calibration no longer uses sync-render-change as its transport flag; a short sync-display dropout alone must not abort a continuously running, valid sample-clock acquisition. Host Stop/unknown playback still blocks a deferred write, and stopped phasor activity is detected independently in DSP.

Nine added checks cover isolated zero/negative phase corrections at 44.1/48/96 kHz, 1 ms phase holds, float32/inclusive natural wraps, a persistent flat clock cancelled within 2 ms, immediate forward/backward phase-jump rejection, initial lock refusal, independence from the onset sync display, deferred write blocking after Stop/unknown and observer binding/unknown reset. Capture arrays, spectral correlations, confidence thresholds, temporal confirmation and averaging are byte-identical to RC1.5; only the liveness guard and its transport binding change.

Primary references: https://docs.cycling74.com/reference/plugphasor~/ and https://docs.cycling74.com/apiref/lom/song/ (is_playing is observable). Native repeatability, CPU and physical-reference precision still require owner testing.

## RC1.6 publication observations — 2026-11-04

The owner applied 93.056351 ms and repeated at 92.885786 ms, then verified sampled 0 / +150 / -150 ms reference displays at -0.20 / +149.8 / -150.10 ms without recalibrating. The Arrangement recording test stopped at its first deliberately late section (5.1.2, +149.9 ms, count 17), retained the clip and reported Live-confirmed Stop. Full application restart retained compensation/light themes and forced saved Auto Stop ON to OFF. Calibration refused Auto Stop ON and Arrangement REC without changing compensation or interrupting recording. These observed checks supersede the earlier pending status only within this scope.

One earlier sampled +231.9 ms result in the +150 ms section remains unexplained; it must not be silently discarded. Sampled good values are not an error-rate distribution or a guarantee for every input. CPU benchmarking, other native hardware/rates/OS, Session recording transitions, missing/ambiguous-reference behavior in this exact RC and configuration/acceptance races were not exhaustively tested natively. Model coverage remains separately labeled. The shipped AMXD bytes are identical to the tested candidate.
