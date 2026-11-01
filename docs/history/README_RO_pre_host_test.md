> Historical pre-host-test snapshot; see ../../README.md for current status.

# Vocal Timing Monitor 0.7 RC2 Compact

Interfață compactă pentru lucrul alături de clipurile din Ableton Live 12.
Motorul Gen, rutarea celor două semnale și executorul Auto Stop sunt păstrate
identic din 0.7 RC1. Nu trebuie editat cod sau realizate conexiuni în Max.

## Ce s-a schimbat

- Fereastră principală de 600 × 340 px, față de 900 × 720 px în RC1: aproximativ
  69% mai puțină suprafață, înaintea ramei sistemului și a scalării Windows/Max.
- Voce sus, instrumental jos, reperele grilei între ele; istoric comun de 6 secunde.
- Indicator mare de timing și abatere numerică în milisecunde.
- Comenzi principale: Analiză, Auto Stop, Reset și Setări.
- Setări extinse la 600 × 620 px: sursa instrumentalului, grila, pragul temporal,
  compensarea, sensibilitatea, mărirea vizuală separată, calibrarea și diagnosticul.
- ASCUNDE restrânge setările, păstrând poziția ferestrei și toate valorile.
  Deschiderea setărilor nu activează/dezactivează Auto Stop și nu schimbă rutarea.

## Instalare în proiectul actual — înainte de microfon

1. Oprește Live și salvează proiectul. Dezactivează 0.7 RC1, păstrându-l ca rezervă.
2. Încarcă `Vocal_Timing_Monitor_v0_7_RC2_Compact.amxd` pe aceeași pistă 6 și
   deschide OPEN MONITOR. Păstrează intrarea pistei pe Puls_calibrare, Monitor In,
   Sends Only și trimiterile A/B la minimum.
3. În SETARI verifică sursa instrumentalului: pista `4-primul_beat_v1_24bit`,
   Post Mixer. Compensare 0 ms, grilă 1/4, prag 100 ms, Auto Stop OFF.
   Apasă ASCUNDE și mută fereastra unde îți lasă clipurile vizibile.
4. Redă zona în care sunt ambele clipuri: impulsurile sus, instrumentalul jos,
   abatere în jur de +0,9 ms pentru traseul deja verificat. Numărul de atacuri crește.
   Deschide/ascunde setările și verifică să continue afișarea fără schimbarea sursei.

Schimbarea dispozitivului nu înlocuiește automat toate valorile personale:
această ediție inițializează controalele. Verifică selecția beat-ului după încărcare.
Nu modifica încă intrarea pe microfon; întâi se confirmă fereastra compactă.

## Citirea timing-ului și Auto Stop

Rezultatul descrie ultimul atac audio detectat față de cel mai apropiat reper al
GRILEI LIVE; nu reprezintă o comparație cu fiecare sunet al instrumentalului și
nu evaluează muzical flow-ul. Minus = devreme, plus = târziu.

Clasificarea EXISTENTĂ a fost păstrată, cu etichete mai scurte:

- Verde / ON BEAT: abatere absolută sub `min(45 ms, prag / 2)`.
- Galben / USOR DECALAT: de la acel nivel până sub pragul ales.
- Roșu / OFF BEAT: abatere absolută mai mare sau egală cu pragul ales.

La pragul implicit de 100 ms: verde sub 45 ms, galben de la 45 până sub 100 ms,
roșu de la 100 ms. Aceste praguri nu s-au schimbat față de motorul verificat.

Auto Stop este OFF la încărcare. După ce ceasul este sincronizat, activează-l
explicit când dorești oprire automată. Prima abatere roșie confirmată trimite
`stop_playing` către Live și revine OFF; oprește astfel transportul și înregistrarea
în curs. Nu șterge automat înregistrarea și nu oprește doar pista vocală.
Diagnosticul ultimei opriri rămâne disponibil în SETARI.

RESET, schimbarea grilei/pragului/compensării și pierderea sincronizării sau a
procesării pot dezarma Auto Stop, conform logicii existente. Butonul TEST IMPULS
verifică mesajele; nu produce audio și nu poate solicita Auto Stop.

Pentru un test separat al opririi: impulsuri de calibrare, grilă 1/4, prag 100 ms,
compensare temporară +120 ms, RESET, Play înainte de clip, Auto Stop ON după
sincronizare și înaintea primului impuls. Așteptat: contor 1, Live oprit, Auto Stop
OFF, confirmare în SETARI. Revino la compensare 0 după test.

## Semnale, calibrare și limite

Undele afișează semnalele reale de pe două intrări separate. Mărirea x1–x8 este
numai vizuală; nu modifică volumul, sensibilitatea detectorului sau Auto Stop.
Compensarea se aplică rezultatului numeric; nu deplasează desenul undei.
RESET șterge contoarele analizei; istoricul undelor se înlocuiește în șase secunde.

CALIBREAZA copiază ultima abatere audio BRUTĂ în compensare numai pe 1/4 după un
atac audio. Se folosește cu un impuls cunoscut și aliniat, nu cu o silabă întârziată
intenționat. Calibrarea microfonului și a traseului fizic rămâne o etapă separată.

La 100 BPM, distanța maximă față de reperul cel mai apropiat este ±300 ms pe 1/4,
±150 ms pe 1/8, ±75 ms pe 1/16. Un prag de 100 ms nu poate fi atins pe 1/16 la
acest tempo. Limita numerică rămâne vizibilă în SETARI.

Detectorul urmărește atacuri de amplitudine, nu identifică semantic silabele.
Vocea reală și beat-ul captat acustic prin difuzoare nu au fost încă validate;
dispozitivul nu separă automat aceste două sunete din semnalul microfonului.
Pe pista de analiză rămân Sends Only și trimiterile la minimum; ieșirea dispozitivului
activ este mută. Pista destinată înregistrării poate rămâne separată, Monitor Off.

## Ce a fost verificat

- RC6: oprire reală confirmată anterior în Ableton, la primul impuls cu abatere mare.
- RC1: istoricul conversației furnizat confirmă cele două unde și selectarea separată
  a instrumentalului real; testul No Input a lăsat unda de jos plată și pe cea de sus activă.
- RC2 Compact: verificări statice și simulate, inclusiv integrarea PCM → motor →
  afișaj → o singură cerere Stop; parentul audio/API este identic structural cu RC1.
  Sunt verificate și expandarea/restrângerea după mutarea ferestrei și izolarea setărilor.
- Așezarea a fost inspectată într-o reconstrucție de layout din coordonatele patch-ului,
  cu semnale ilustrative. Aceasta nu este o captură sau o randare nativă Max.

**RC2 Compact nu a fost executat în Max/Ableton în mediul de dezvoltare.**
Încărcarea, fereastra nativă, scalarea sistemului și regresia reală Auto Stop trebuie
confirmate în proiectul utilizatorului. Containerul `.amxd` este generat programatic,
nu prin Save/Freeze din Max. Toate componentele de execuție sunt incluse în dispozitiv.

## Reconstruire și verificare locală

`python3 build.py`

`python3 -m unittest discover -s tests -v`

Harness-ul aritmetic necesită Python, NumPy și un compilator C++17. Nu înlocuiește
compilatorul Gen sau programarea în timp real din Max. Rezultatele și limitele sunt
consemnate în `docs/TEST_RESULTS.json` și `docs/COMPACT_0_7_RC2.md`.
