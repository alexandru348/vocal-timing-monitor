> Historical development note. For current installation and validation, see ../../README.md and ../HOST_VALIDATION.json.

# RC6 — eliminarea veto-ului pentru Preview Mode

## Cauză demonstrată în gazdă

Captura RC5 `image(20261101-121109).png` indică explicit:
`Ultimul Stop: blocat - preview Max`. Live continuă, există trei evenimente audio,
iar abaterea este -119,10 ms cu compensare +120 ms și prag 100 ms. Captura
anterioară arată Auto Stop ON, ceas sincronizat și zero evenimente înaintea clipului.
Testul a fost executat în ordinea cerută.

Este identificată o condiție concretă care a refuzat cererea: veto-ul preview din
dispozitiv. Nu este doar o presupunere despre rutare sau ID. Nu afirmăm că toate
eșecurile istorice RC1–RC4 au avut exclusiv aceeași cauză.

## Contractul oficial reverificat

[Cycling ’74: Preview Mode](https://docs.cycling74.com/userguide/m4l/live_preview/)
explică faptul că editarea produce o copie în Max și una în Live. Preview permite
transmiterea audio, MIDI, timing și a comenzilor Live API între ele. Este activat
implicit când începe editarea. Flagul preview activ nu justifică singur refuzarea
unei comenzi Stop autorizate explicit de utilizator.

Un asemenea veto era o decizie a implementării noastre, nu o cerință Cycling ’74.
RC6 îl elimină. Schimbarea nu activează singură Auto Stop.

## Modificări limitate la traseul nativ Stop

- Eliminată dependența de ieșirea preview a `live.thisdevice`, atât pentru refuzul
  cererii, cât și pentru dezarmarea bazată doar pe acel flag.
- Rămân șase condiții actuale după `deferlow`: Auto Stop ON, ANALIZA ON, ID al
  executorului pozitiv și confirmat prin `getid`, dispozitiv activ, ceas sincronizat
  și actualizări DSP recente.
- Auto Stop rămâne OFF la încărcare; OFF apăsat înaintea executării anulează cererea.
  După o cerere este dezarmat. Pierderea ceasului, procesării, API sau activării
  dispozitivului continuă să dezarmeze și să blocheze cererile.
- Păstrat răspunsul după `get is_playing`: comanda trimisă nu este confundată cu
  oprirea confirmată. Nu se execută repetări automate ale comenzii Stop.
- Corpul GenExpr este identic cu RC4/RC5, în afara comentariului de versiune.
  Detectorul care numără corect semnalul de calibrare nu este modificat.
- Fereastra separată, ieșirea mută și autonomia `.amxd` sunt păstrate.

Documentația de timing menționează posibile discontinuități la trecerea în/din
preview. Validarea fazei și a activității DSP rămâne activă pentru aceste cazuri;
nu presupunem că orice Preview activ invalidează Live API.

## Verificare

Testele locale verifică Preview=1 cu opt-in și fără opt-in, eveniment audio mare
în Preview care ajunge la o singură cerere Stop în simulare, celelalte protecții,
confirmare API și răspuns în care Live continuă. Testul de amprentă păstrează corpul
motorului audio. Raportul exact este în TEST_RESULTS.txt/json.

Acestea sunt teste statice și simulate. Răspunsurile API și efectul Stop sunt
stub-uri explicite în model; nu reprezintă rulare Max/Ableton. RC6 nu a fost încă
executat în gazda reală și nu este declarat stabil înaintea acelei confirmări.

## Verificarea reală rămasă

Dezactivează RC5 și încarcă RC6 pe aceeași pistă 6, cu rutarea neschimbată.
Grilă 1/4, prag 100 ms, compensare temporară +120 ms, RESET. Pornește cu două măsuri
înaintea clipului și activează Auto Stop după sincronizare, înaintea primului impuls.

Rezultat așteptat: Live se oprește la primul impuls, contorul este 1, Auto Stop
revine OFF și linia ultimei cereri confirmă oprirea de către Live. Dacă nu apare,
o singură captură a monitorului este suficientă. Readu compensarea la 0 după test.
Nu este necesar să modifici cod sau legături în Max.
