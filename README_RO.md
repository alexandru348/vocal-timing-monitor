# Vocal Timing Monitor — 0.7 RC2 Compact

Dispozitiv audio Max for Live pentru afișarea abaterilor atacurilor față de grila Ableton și oprirea opțională a transportului. [English documentation](README.md).

## Utilizare

Necesită Ableton cu Max for Live disponibil; testat în Live 12 Suite, Windows 11, 44,1 kHz, 100 BPM. Fișierul pentru utilizare este `dist/Vocal_Timing_Monitor_v0_7_RC2_Compact.amxd`. Nu este VST/AU. Componentele de execuție sunt incluse.

1. Încarcă AMXD pe o pistă dedicată analizei și apasă OPEN MONITOR.
2. Pentru microfon: Audio From Ext. In, intrarea corespunzătoare, Monitor In. Pe pista de analiză: Audio To Sends Only, trimiterile la minimum. Ieșirea dispozitivului activ este mută.
3. În SETARI → SURSA INSTRUMENTALULUI alege pista cu beat-ul și Post Mixer.
4. Înregistrează pe o pistă separată cu intrarea microfonului. Configurația verificată cu difuzoare folosește Monitor Off pe pista de înregistrare.
5. Pornește cu ANALIZA ON și AUTO STOP OFF. După sincronizare și verificarea undelor, activează Auto Stop dacă dorești oprire automată.

Unda albastră este intrarea/vocea, cea verde instrumentalul; istoric comun de șase secunde. Mărirea este doar vizuală. Numele pistelor și intrările depind de proiect.

## Interpretare și limite

Rezultatul descrie ultimul atac detectat față de cel mai apropiat reper al grilei Live, nu față de fiecare sunet al beat-ului. Nu identifică silabe și nu evaluează muzical flow-ul. Minus = devreme; plus = târziu, după compensare.

La prag 100 ms: verde sub 45 ms, galben de la 45 până sub 100 ms, roșu de la 100 ms, în valoare absolută. Limita verde generală: min(45 ms, prag/2).

Auto Stop oprește întregul transport Live, inclusiv înregistrarea, la prima abatere roșie confirmată. Clipul rămâne. Revine OFF și trebuie reactivat explicit pentru fiecare încercare. Resetarea, schimbarea parametrilor sau pierderea sincronizării îl pot dezarma. Diagnosticul este în SETARI.

La 100 BPM limitele față de reperul apropiat sunt ±300 ms pe 1/4, ±150 ms pe 1/8 și ±75 ms pe 1/16. Pragul 100 ms nu poate fi atins pe 1/16.

- Controalele se reinițializează la încărcare. Notează și reaplică valorile; persistența rămâne pentru o versiune viitoare.
- Detectorul poate reacționa la taste, zgomot și beat captat de microfon. Nu separă automat vocea de acestea.
- Compensarea corectează valoarea numerică, nu înregistrarea sau desenul undei.
- CALIBREAZA copiază ultima abatere audio brută pe 1/4. Folosește un impuls aliniat; un zgomot ulterior poate înlocui valoarea.
- TEST IMPULS nu produce sunet și nu poate solicita Auto Stop.
- Calibrarea pe impulsuri nu garantează precizie identică pentru voce.

## Configurația verificată — 01.11.2026

Aceste valori sunt specifice unui laptop, nu o calibrare universală.

| Parametru | Valoare |
| --- | --- |
| Tempo / grilă | 100 BPM / 1/4 |
| Prag | ±100 ms |
| Compensare | +92.2 ms |
| Detecție pentru voce | −14 dB |
| Volum Windows | 15 |
| Mărire voce / beat | 1x / 1x |
| Instrumental | Pista 4, Post Mixer |
| Înregistrare | Pista 3: Ext. In, mono 1, Monitor Off, Main |
| Analiză | Pista 6: Ext. In, 1/2, Monitor In, Sends Only |

Autorul a confirmat interfața compactă/extinsă, ambele unde, detecția microfonului, înregistrarea și oprirea automată cu păstrarea clipului. Ultimul test: două atacuri, −240.20 ms, „Ultimul Stop: oprire confirmata de Live”.

Opt impulsuri de referință au dat +92.2 ms constant înainte de compensare și, conform raportării autorului, 0.00 ms după compensare. Referința a folosit detecție −26 dB; ulterior s-a revenit la −14 dB pentru voce. Compensarea vocală rămâne aproximativă.

108 teste statice/simulate au trecut; ele nu execută Max. Vezi [validarea în Ableton](docs/HOST_VALIDATION.json) și [testele locale](docs/TEST_RESULTS.json). Notele din docs/history descriu etape anterioare, nu starea curentă.

## Dezvoltare

Python 3, NumPy, g++ C++17: `python3 -m pip install -r requirements-dev.txt`, apoi `python3 build.py` și `python3 -m unittest discover -s tests -v`.

Motor: src/vtm_engine.genexpr; construcție: build.py; rezultate: dist/. AMXD este generat programatic, nu prin Save/Freeze. Fișierul distribuit este identic cu RC2 testat; s-a actualizat documentația.

## Licență

Codul proiectului și dispozitivul Vocal Timing Monitor AMXD distribuit sunt oferite sub [licența MIT](LICENSE). Copyright (c) 2026 alexandru348.

Sunt permise utilizarea, modificarea și redistribuirea, inclusiv comercială, cu păstrarea mențiunilor de copyright și a licenței. Software-ul este oferit fără garanție. Ableton Live, Max și alte programe terțe furnizate separat își păstrează propriile licențe.

Tagul original v0.7-rc2 rămâne punctul testat. Release-ul include separat LICENSE și o arhivă de surse cu licența inclusă; fișierele de execuție sunt neschimbate.
