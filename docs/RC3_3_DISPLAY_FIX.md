# RC3.3 — initial analysis-OFF status

Actual owner screenshot before save displayed ANALIZA OPRITA with analysis OFF, grid 1/8 and threshold 80. After full restart all values were retained, but header showed ASTEPT CEAS AUDIO. Offline reproduction using the generated message graph and compiled arithmetic harness confirmed engine enabled=0, state=0, count=0: the raw `change` object suppressed its first zero while state-pak was initialized to 1.

Fix: state-change becomes `change -1`, allowing the first zero through. No Gen source, audio edges, Live API paths, control persistence or routing behavior changes. The historical parent graph digest test normalizes only the documented display initializer, registry and UI metadata; audio/API graph remains pinned.

140 checks pass. The owner subsequently confirmed the RC3.3 initial OFF header, preserved settings, playback/detection, separate recording and actual Auto Stop, plus saved-ON/reopened-OFF. See HOST_VALIDATION.json for distinct historical and current observations.

The compatibility AMXD contains exactly the same Max patch as the canonical RC3.3 artifact, but its internal entry/outer filename uses the existing RC3_2 name referenced by the owner .als. Close Ableton before replacing that file. Reopen the saved existing instance; do not recreate it. All parameter keys remain stable. The canonical public artifact uses RC3_3. No user project is rewritten.
