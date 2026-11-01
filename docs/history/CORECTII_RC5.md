> Historical development note. For current installation and validation, see ../../README.md and ../HOST_VALIDATION.json.

# RC5 — conexiune verificată pe executorul Stop și rezultat observabil

## Observații reale RC4

Au trecut testele locale în gazda utilizatorului pentru opt note → opt impulsuri
și abatere aproximativ +0,9 ms, cu compensare zero. Cu compensare -120 ms și
Auto Stop OFF: opt impulsuri, +120,9 ms, iar Live continuă. Aceste rezultate sunt
documentate prin capturi și sunt distincte de simulările automate.

Auto Stop ON a eșuat. Capturile noi arată comutatorul ON cu ceas sincronizat și
zero evenimente, înaintea clipului. Ulterior sunt șase impulsuri, -119,10 ms cu
compensare +120 ms, Live pe Play și comutatorul OFF. Abaterea provocată este peste
pragul de 100 ms și cu acest semn. Nu este o dovadă de operare greșită a utilizatorului.

Nu s-au înregistrat valorile fiecărei protecții native sau ID-ul efectiv al
executorului la cerere. Nu putem atribui sigur eșecul unei anumite condiții.

## Deficiență confirmată în codul RC4

Eticheta de conexiune pregătită era activată din ID-ul primit de la `live.path`.
Acest lucru dovedește rezolvarea căii, dar nu verifică prin răspuns propriu că
`live.object`, cel care execută Stop, este legat la ID-ul așteptat. Nu se citea
nici `is_playing` după cerere. Revenirea comutatorului OFF nu dovedește oprirea Live.

Aceste lipsuri de verificare sunt confirmate în surse. Nu afirmăm că unul dintre
ele este deja demonstrat drept cauza exactă a eșecului în gazdă.

## Schimbări RC5

- `live.path` → `route id` → ID numeric. Un `trigger` numeric fixează ordinea,
  iar `prepend id` reconstruiește explicit mesajul pentru intrarea dreaptă a
  executorului. Nu se mai trimite mesajul de legare prin `t l l`.
- Orice schimbare a ID-ului așteptat invalidează imediat conexiunea și dezarmează
  Auto Stop. După legare, se trimite `getid` prin `deferlow` către același executor.
- Conexiunea devine pregătită numai dacă ID-ul întors de executor este pozitiv
  și egal cu ID-ul așteptat. Răspunsurile zero sau nepotrivite rămân invalide.
- Păstrate verificările native pentru opt-in, analiză, API, preview, bypass,
  sincronizare și actualizări DSP. Nicio protecție nu este eliminată pentru a
  forța aparent reușita testului.
- La o cerere blocată se păstrează primul motiv relevant în cardul STARE.
  Dacă o protecție dezarmează comutatorul înainte de cererea detectorului,
  cauza este capturată înaintea dezarmării, numai dacă Auto Stop era armat.
- Un apel permis arată comanda trimisă. După un temporizator nominal de 150 ms
  se citește `get is_playing`, printr-un traseu permis numai cu conexiune validă.
  Răspunsul 0 arată oprire confirmată, iar 1 arată Live încă redă. Nu se retrimite Stop.
  Pierderea API anulează temporizatorul; nici revenirea API nu rearmează Auto Stop.
- Rezultatul cererii rămâne vizibil după trecerea pe OFF. O pierdere ulterioară
  a ceasului, când Auto Stop este deja OFF, nu suprascrie rezultatul ultimei cereri.

Citirea nu este un termen garantat de oprire: planificatorul Max/Live poate întârzia
temporizatorul și răspunsul API. Dacă utilizatorul repornește redarea înaintea citirii,
afișajul reflectă starea la citire. Dacă API nu răspunde, comanda trimisă nu este
prezentată drept confirmare. `is_playing` nu este folosit pentru timestamp sau detector.

## Motorul audio păstrat

Corpul GenExpr este identic cu RC4, exceptând primul comentariu de versiune.
Un test de amprentă verifică această proprietate. Filtrul, anvelopa, confirmarea,
faza, abaterile, numărătoarea și ieșirea mută nu sunt modificate.
Fereastra rămâne separată, iar Auto Stop este OFF la încărcare.

## Afișajul ultimei cereri

| Mesaj | Ce dovedește |
|---|---|
| Conexiune pregătită | Executorul a returnat ID-ul așteptat; nu dovedește o oprire. |
| Blocat — motiv | Protecția a refuzat cererea sau a dezarmat înaintea ei. |
| Comanda trimisă | Traseul a emis apelul API; nu dovedește că Live s-a oprit. |
| Oprire confirmată de Live | Proprietatea `is_playing` a răspuns 0 după cerere. |
| Live încă redă | Proprietatea a răspuns 1 după cerere; verificarea nu a trecut. |

Mesajele sunt informații despre ultimul eveniment, nu o listă de valori interne
care trebuie depanate de utilizator. Este suficientă o captură dacă testul eșuează.

## Verificare automată și limite

Testele noi folosesc răspunsuri API **simulate explicit**: lipsa unui răspuns,
ID nepotrivit, ID zero, confirmare Stop și comandă fără efect. Verifică motivul
refuzului, dezarmarea înainte de cerere, anularea citirii la pierderea API și
faptul că o comandă trimisă nu este confundată cu o confirmare.

Modelul nu execută API Live. Răspunsul simulat de oprire este o condiție de test,
nu o dovadă că apelul real a reușit. Testele vechi de algoritm, integrare simulată,
conexiuni și container continuă să ruleze; raportul exact este în TEST_RESULTS.
RC5 nu a fost executat în Max/Ableton în mediul de dezvoltare și nici validat încă
în gazda utilizatorului. Nu se declară repararea reală completă a Auto Stop.

## Testul scurt în gazdă

Înlocuiește instanța activă RC4 cu RC5, păstrând RC4 dezactivat ca rezervă.
Pe pista 6, cu aceleași rutări: grilă 1/4, prag 100 ms, detecție -32 dB,
compensare temporară +120 ms. RESET, Play cu două măsuri înaintea clipului,
apoi AUTO STOP ON după ce ceasul este sincronizat și înaintea primului impuls.

Rezultat așteptat: transport oprit, un impuls audio, Auto Stop OFF și oprire
confirmată de Live. Dacă redarea continuă, trimite o singură captură a monitorului;
nu modifica legăturile în Max. Readu compensarea la 0 după încheierea verificării.

## Documentație oficială

- [live.object](https://docs.cycling74.com/reference/live.object/): `id nn`,
  `getid`, `call` și `get`; operațiile API sunt amânate pe firul principal.
- [live.path](https://docs.cycling74.com/reference/live.path/): rezolvarea căii și ID-uri.
- [trigger](https://docs.cycling74.com/reference/trigger/): ordonarea și conversia tipurilor.
- [Song](https://docs.cycling74.com/apiref/lom/song/): `stop_playing` și `is_playing`.
