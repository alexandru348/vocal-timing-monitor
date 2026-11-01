> Historical development note. For current installation and validation, see ../../README.md and ../HOST_VALIDATION.json.

# RC4 — o singură sursă de timp pentru analiză

## Ce s-a observat în Ableton

RC3 se încarcă, deschide fereastra și afișează intrarea reală la -9 dB. Clicurile
TEST ajung la motor (Teste: 8), dar contorul audio rămâne zero, fără abatere.
Captura finală arată TEST OK / FARA MASURARE cu Ceas audio: sincronizat; captura
anterioară arată PLAY OPRIT în timpul redării. Acesta este un eșec funcțional.

Nu s-au capturat valorile interne ale fiecărui flag în momentul clicului. Un test
făcut înaintea stabilizării ceasului are prioritate în afișaj timp de 0,8 secunde
și poate rămâne ultima stare până la un nou eveniment, chiar dacă sincronizarea
apare ulterior. Prin urmare, cele două etichete dintr-o
singură captură nu demonstrează o anumită valoare falsă de Play, preview sau bypass.
Nu declarăm o cauză istorică exactă pe care nu am putut-o măsura sau reproduce.

## Problema de arhitectură eliminată

În RC3, validarea ceasului depinde de Play raportat separat prin `plugsync~`.
Permisiunea de analiză mai depinde de `deviceon` și `preview` din `live.thisdevice`.
Astfel, un flux audio cu fază utilizabilă poate fi exclus de o stare secundară.
Aceste condiții pot fi reproduse în simulare, dar asta nu dovedește că exact una
dintre ele a produs simptomul din captura utilizatorului.

Contractul oficial `plugphasor~` oferă o fază sincronizată cu audio-ul Live și
semnal zero când transportul este oprit sau sincronizarea nu este disponibilă.
RC4 folosește progresul valid al acestei faze atât pentru sincronizare, cât și
pentru măsurare. Nu combină un timestamp audio cu o stare Play citită separat.

## Schimbări concrete

1. Eliminat `plugsync~` din patch; eliminate Param `hostplay`, `deviceon` și
   `preview` din Gen, împreună cu istoricul `prevdevice`.
2. Faza trebuie să aibă increment corespunzător intervalului 20–400 BPM timp de
   10 ms. Numai această validare și comutatorul ANALIZA permit detectorului să ruleze.
   Filtrul, anvelopa, confirmarea de 2 ms și calculul abaterii nu au fost schimbate.
3. Preview și bypass rămân în verificarea nativă înainte de `stop_playing` și
   dezarmează Auto Stop. Eliminarea lor din analiza de citire nu elimină siguranța.
   În bypass real procesarea poate fi suspendată; contorul DSP local invalidează
   afișajul când nu mai există actualizări.
4. Cererea Stop verifică după `deferlow`: Auto Stop, ANALIZA, ID API, lipsa preview,
   dispozitiv activ, ceas sincronizat și actualizări DSP recente. Este consumată
   și dezarmată inclusiv dacă este respinsă; nu se execută după o recuperare ulterioară.
5. Pierderea ID-ului API dezarmează explicit comutatorul. Recuperarea conexiunii
   nu rearmează Auto Stop.
6. ASTEPT CEAS AUDIO descrie lipsa fazei utilizabile. Nu este o declarație că
   butonul Play al Live este oprit. STABILIZEZ CEASUL descrie primele 10 ms valide.
   Un TEST fără ceas în momentul clicului afișează TEST: FARA SYNC LA CLICK.
7. Listele numerice `unpack` folosesc valori inițiale numerice explicite `0`.
   Nu atribuim acestui detaliu cauza eșecului RC3.
8. Păstrate: fereastra separată, ieșirea audio mută, contorul activității DSP,
   vârful intrării pe 600 ms, grilele, compensarea și Auto Stop OFF la încărcare.
   Nu sunt necesare scripturi sau conexiuni manuale.

## Verificare locală efectuată

În plus față de testele detectorului și verificările statice, noul modul
`test_single_clock.py` conectează ieșirile harness-ului aritmetic Gen la modelul
mesajelor Max, folosind polling simulat de 20 ms și conexiunile din patch-ul generat.
Verifică WAV-ul inclus: opt evenimente, +120 ms la ultimul, zero opriri cu Auto Stop
OFF și un singur apel simulat Stop la prima abatere mare cu Auto Stop ON.

Mai verifică: stări de ceas coerente, TEST după stabilizarea fazei, input pe canalul
drept, fază cuantizată pe 32 de biți, redeschiderea interfeței fără resetarea
numărătorii, pierderea API și cereri respinse care nu se execută ulterior.
Rezultatele exacte sunt în TEST_RESULTS.txt/json.

**Harness-ul C++ nu este compilatorul Gen al Cycling '74. Modelul mesajelor nu este
runtime Max, scheduler MSP sau API Live real.** Nu au fost executate pentru RC4:
încărcarea în Max, compilarea reală Gen, ferestrele Windows, intrarea microfonului,
transportul sau închiderea efectivă a popup-ului în Ableton.

Nu există Max/Ableton în mediul de dezvoltare. Nu este onest să garantăm că RC4 va
funcționa perfect din prima pe baza acestor teste. Livrarea rămâne candidat pentru
verificarea reală; nu se declară că problema din captura RC3 este rezolvată în gazdă.

## Test real scurt

Oprește redarea, dezactivează RC3 și încarcă RC4 pe aceeași pistă 6. Păstrează
rutarea și Auto Stop OFF. Redă porțiunea cu impulsuri. Criteriul de reușită:
ceas sincronizat, creșterea contorului audio și abatere numerică. Închiderea și
redeschiderea ferestrei nu trebuie să reseteze numărătoarea.

Pentru testul complet controlat, README_RO.md descrie WAV-ul inclus, pe o pistă
temporară: opt impulsuri, ultimul întârziat cu 120 ms; apoi verificarea Auto Stop.
Aceste rezultate sunt așteptate, nu deja măsurate în Ableton.

Funcția cu vocea și instrumentalul ca două unde audio reale rămâne în PLAN.md,
pentru etapa de după validarea de bază. Nu este pretinsă ca implementată în RC4.

## Surse oficiale

- [plugphasor~](https://docs.cycling74.com/reference/plugphasor~/)
- [live.thisdevice](https://docs.cycling74.com/reference/live.thisdevice/)
- [GenExpr](https://docs.cycling74.com/userguide/gen/gen_genexpr/)
- [Gen out](https://docs.cycling74.com/reference/gen_common_out/)
- [snapshot~](https://docs.cycling74.com/reference/snapshot~/)
- [unpack](https://docs.cycling74.com/reference/unpack/)
- [pak](https://docs.cycling74.com/reference/pak/)
