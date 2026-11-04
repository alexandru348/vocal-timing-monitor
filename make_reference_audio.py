"""Generate the exact synthetic acoustic timing reference used in the owner test.
Development-only; numpy is already a development dependency. No owner media.
"""
from pathlib import Path
import wave
import numpy as np

def main():
    sr=44100
    audio=np.zeros(1270080,dtype=np.float64) # 28.8 seconds, 12 bars at 100 BPM
    rng=np.random.default_rng(20261104)
    pulse=rng.uniform(-1,1,round(.018*sr))
    pulse[:round(.006*sr)]=np.sign(pulse[:round(.006*sr)])
    pulse*=np.exp(-np.arange(len(pulse))/sr/.009)
    pulse*=10**(-12/20)/np.max(np.abs(pulse))
    for section,shift in enumerate((0,6615,-6615)):
        for beat in range(16):
            at=(section*16+beat)*26460+shift
            audio[at:at+len(pulse)]+=pulse
    pcm=np.round(audio*32767).astype('<i2')
    target=Path(__file__).resolve().parent/'test_audio/VTM_REPER_100BPM_0_PLUS150_MINUS150.wav'
    target.parent.mkdir(parents=True,exist_ok=True)
    with wave.open(str(target),'wb') as f:
        f.setnchannels(1);f.setsampwidth(2);f.setframerate(sr);f.writeframes(pcm.tobytes())
    print(target)

if __name__=='__main__':
    main()
