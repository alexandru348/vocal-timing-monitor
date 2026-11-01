#!/usr/bin/env python3
"""Known acceptance signal: 7 on-grid attacks then one +120 ms at 100 BPM."""
from pathlib import Path
import json
import math
import struct
import wave

ROOT = Path(__file__).resolve().parent
RATE = 44100
TIMES = [1.2 + i*.6 for i in range(7)] + [5.52]


def make():
    samples = [0.] * round(6.2*RATE)
    for when in TIMES:
        start=round(when*RATE)
        for i in range(round(.012*RATE)):
            t=i/RATE
            samples[start+i] += .3*math.cos(2*math.pi*1800*t)*math.exp(-t/.004)
    out=ROOT/'test_audio'; out.mkdir(exist_ok=True)
    f=out/'VTM_TEST_100BPM.wav'
    with wave.open(str(f),'wb') as w:
        w.setnchannels(1); w.setsampwidth(2); w.setframerate(RATE)
        w.writeframes(b''.join(struct.pack('<h', round(x*32767)) for x in samples))
    (out/'expected.json').write_text(json.dumps(dict(bpm=100, placement='1.1.1', warp=False,
        grid='1/4', threshold_ms=100, compensation_ms=0, duration_seconds=6.2,
        onset_times_seconds=TIMES, expected_deviations_ms=[0]*7+[120],
        expected_audio_count=8, stop_expected_at_seconds=5.52,
        note='Expected values before Live routing/latency offsets. NOT measured in Ableton.'),indent=2))
    return f


if __name__=='__main__': print(make())
