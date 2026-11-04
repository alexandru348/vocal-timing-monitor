# Synthetic acoustic timing reference — 100 BPM

Generate with `python3 make_reference_audio.py` (development numpy dependency). The WAV is mono, 44.1 kHz / 16-bit, 28.8 seconds, peak -12 dBFS, with 48 identical short broadband pulses. It contains no owner recording. Generated-file SHA-256: `a9b9e4bd35434234bc56df0dad7f8691e9a91eccec8ca48861e1709d2c6bb97e`.

Place the whole clip at Arrangement 1.1.1 with Warp OFF, tempo 100 BPM and no clip/track delay. Use the same speaker/microphone path as the prior calibration, preserve that compensation, select the reference/Post Mixer, and silence other playback. Keep the analyzer monitoring the microphone on its separate silent-output track. Grid 1/4, tolerance 100 ms, Auto Stop OFF for timing-only checks. Do not recalibrate on this periodic pulse train; it is a timing test, not a calibration signal.

| Section | Beat index (zero-based) | Placement relative to quarter grid | Suggested captured time |
| --- | --- | --- | --- |
| First four bars | 0–15 | 0 ms | 5–8 s |
| Middle four bars | 16–31 | +150 ms | 13–16 s |
| Final four bars | 32–47 | -150 ms | 23–26 s |

Quarter note spacing is exactly 26460 samples (600 ms); the signed shift is 6615 samples (150 ms). Section boundaries are 9.6 and 19.2 seconds, but the shifted first pulses occur at 9.75 and 19.05 seconds. Skip boundary/startup events when interpreting a section. Captures show the last detected onset, which may also be triggered by keyboard or ambient sound; they do not record an event distribution. Do not infer the cause of a discrepant value from a screenshot alone.

Owner-observed samples at compensation 92.885786 ms: -0.20, +149.8, -150.10 ms. An earlier +231.9 ms sample in the middle section remains unexplained. The file schedule was byte-checked, and a separate arithmetic harness with a known inserted delay recovered the three placements; neither substitutes for native acoustic measurements.

For the Arrangement Auto Stop check, use a separate empty recording track (microphone input, Monitor Off, armed), Auto Stop ON, tolerance 100 ms and start at 1.1.1. On the tested setup F9 alone started Arrangement recording; do not press Space after recording has started. Stay quiet until Stop. The first intentionally late source pulse is 9.75 s; host reaction includes the acoustic path and scheduling delay. The observed stop was 5.1.2 with +149.9 ms; the clip remained and Live confirmed Stop. This test does not certify recorded-clip placement or every host transition.
