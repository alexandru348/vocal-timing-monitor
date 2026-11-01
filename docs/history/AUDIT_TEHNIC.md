> Historical development note. For current installation and validation, see ../../README.md and ../HOST_VALIDATION.json.

> Document istoric al etapei anterioare. Pentru starea curentă și limitele RC2 Compact, consultați README_RO.md, COMPACT_0_7_RC2.md și TEST_RESULTS.json.

# Actualizare 0.7 RC1

RC6 a trecut testul real Auto Stop descris în HOST_VALIDATION.json. 0.7 păstrează
motorul și adaugă afișarea a două busuri stereo separate. Documentația curentă:
ETAPA_UNDE_0_7.md, README_RO.md, TEST_RESULTS.json și PLAN.md.

Textul de mai jos păstrează auditul istoric al versiunilor anterioare. Declarațiile
„încă netestat” despre RC6 sunt starea de atunci, nu contrazic rezultatul nou.

---

# Revizuire tehnică — 1 noiembrie 2026

## Actualizare RC6 după diagnosticul real RC5

Captura `image(20261101-121109).png` raportează explicit blocarea ultimei cereri
prin condiția preview Max. Captura anterioară confirmă Auto Stop ON și ceas
sincronizat înaintea evenimentelor. Avem astfel o cauză concretă a refuzului curent,
nu doar ipoteze despre un ID sau un ceas lipsă.

Documentația oficială Preview Mode spune că sunt transportate inclusiv comenzi
Live API. Un veto necondiționat pe flagul preview nu era necesar pentru cererea
Stop autorizată explicit. RC6 îl elimină și păstrează celelalte șase condiții.
Motorul audio și confirmarea prin `is_playing` rămân neschimbate. Descrierea curentă
este în `CORECTII_RC6.md`; secțiunile RC1–RC5 de mai jos sunt istoricul dezvoltării.

RC6 nu a fost încă rulat în Max/Ableton. Testele locale nu confirmă efectul real
al comenzii Stop; este pregătită o singură reluare a testului controlat în gazdă.

## Actualizare RC5 după verificările reale RC4

RC4 are acum dovezi reale pentru numărătoare și măsurare: opt note → opt impulsuri,
+0,9 ms cu compensare zero; cu compensare -120 ms și Auto Stop OFF: opt impulsuri,
+120,9 ms și Live continuă. Auto Stop ON a eșuat chiar activat după sincronizare:
Live continuă, comutatorul revine OFF, iar contorul trece de primul eveniment.

RC5 păstrează corpul motorului Gen identic și schimbă exclusiv traseele native API,
verificarea legării și afișarea rezultatului Stop. `CORECTII_RC5.md` este descrierea
curentă a acestui traseu; explicațiile RC1–RC4 de mai jos sunt istoricul arhitecturii.
`HOST_VALIDATION.json` consemnează separat observațiile reale. Nu este demonstrat
încă exact ce condiție sau ce etapă a produs eșecul Stop în RC4.

Noul RC5 nu a fost încă executat în Max/Ableton. Răspunsurile API din teste sunt
simulate explicit și nu dovedesc efectul comenzii în gazda utilizatorului.

## Actualizare RC4 după testul real RC3

RC3 a deschis fereastra și a primit semnal real, afișat la -9 dB. Testul a ajuns
la motor (contor Teste: 8), dar au rămas zero impulsuri audio și fără abatere.
S-a observat TEST OK / FARA MASURARE împreună cu ceas sincronizat, iar anterior
PLAY OPRIT în timpul redării. Aceste capturi confirmă eșecul funcțional RC3.
Nu identifică singure valorile tuturor condițiilor interne la momentul clicului.

RC4 elimină dependența analizei de `plugsync~` și de flagurile native de lifecycle.
Detecția și sincronizarea folosesc aceeași fază audio validată. Preview/bypass
rămân protecții ale cererii Stop, în partea nativă. `CORECTII_RC4.md` prezintă
justificarea, schimbările și limitele. `test_single_clock.py` verifică în simulare
întregul traseu PCM → Gen → mesaje → interfață → cerere Stop.

Noul RC4 nu a fost încă executat în Max/Ableton. Corecția arhitecturală nu este
prezentată drept reproducere certă a unui anumit flag incorect din gazda reală.

## Actualizare RC3 după testele reale RC1 și RC2

RC2 a deschis fereastra separată, fără erori noi în consolă conform capturilor
utilizatorului. În timpul redării afișa însă simultan ceas sincronizat, AUDIO ENGINE
OFF, Intrare -100 dB și zero impulsuri. Ultima captură confirmă pista 6 activă și
semnal înaintea dispozitivului; simpla activare a pistei nu a rezolvat problema.

RC3 elimină suprascrierea stării și dezarmarea repetată prin `dspstate~`, urmărește
execuția locală cu un contor DSP și măsoară separat vârful intrării brute pe 600 ms.
Starea de lipsă a actualizărilor se numește FARA PROCESARE AUDIO. Algoritmul de
atacuri nu a fost schimbat. Cauza numărătorii zero nu este încă demonstrată.
`CORECTII_RC3.md` separă dovezile de ipoteze, corecțiile și limitele verificării.

La livrarea RC3 nu exista încă rezultatul real; observația ulterioară este consemnată mai sus. Rezultatele automate sunt statice
și simulate. `PLAN.md` păstrează cerința celor două unde audio pentru etapa ulterioară.

## Istoric: testul real RC1

Captura `image(5).png` arată că RC1 a încărcat interfața compactă în Ableton, dar
Max a respins două expresii native și compilarea Gen, cu `variable enabled is
not defined`. RC1 nu a îndeplinit verificarea de încărcare funcțională. Explicația
inițială despre lipsa rulării se referă la mediul Work; utilizatorul a furnizat
între timp acest rezultat real în Ableton.

RC2 corectează sintaxa declarațiilor Gen și înlocuiește condiționalele din `expr`
cu aritmetică și `maximum`. Motorul audio, transportul și funcțiile au rămas în
aceeași arhitectură. `CORECTII_RC2.md` descrie corecțiile și limitele testelor.
La livrarea RC2 nu exista încă rezultatul real; acesta este consemnat în actualizarea de mai sus.

## Acces și limite

Au fost recuperate sursele și arhivele v0.1–v0.5, inclusiv v0.4 POPUP, variantele
JavaScript v0.4.1 și FIX_TEST și arhiva completă v0.5 POPUP 1 ABATERE. Au fost
decodate patch-urile JSON și containerul AMXD v0.5; s-au comparat conexiunile cu
documentația oficială. `input_manifest.json` inventariază fișierele și amprentele.

Capturile din 31 octombrie și 1 noiembrie, recuperate separat, au fost parcurse
în planșe de contact, iar captura finală 20261101-084048 a fost inspectată la
rezoluția originală. Aceasta arată Play activ, nivel audio pe pista 6 și ASTEPT SYNC
cu zero impulsuri în noul monitor. Nu dovedește valorile numerice ale ieșirilor plugsync~.

**Nu au fost accesibile transcrierile integrale ale celor trei conversații.**
Instrumentul de recuperare a istoricului a furnizat fragmente și rezumate, nu
mesajele integrale. Nu este disponibil Set-ul real `prima_piesa_calibrare_TEST.als`,
dispozitivul v0.4.1 modificat manual pe calculator, proiectul Max salvat local după
acele modificări sau un jurnal complet cu valorile plugsync~ la momentul blocajului.
Conținutul acestor materiale nu a fost presupus.

Nu există Ableton Live sau runtime Max în acest mediu Linux. Pentru RC6 nu s-au executat:
încărcarea AMXD în Max, compilarea cu compilatorul Gen al Cycling '74, deschiderea
reală a ferestrei în Windows, analiza microfonului, testarea CPU în Live, redeschiderea
unui Set salvat sau oprirea transportului prin Live API.

## Constatări confirmate în surse

1. **v0.4 / v0.4.1:** momentul atacului este evaluat după `peakamp~ 10`, `deferlow`,
   confirmare și interogări LiveAPI. Rezultatul include întârzieri variabile ale
   mesajelor și nu reține momentul trecerii inițiale peste prag. Polling-ul de 150 ms
   al stării nu este un ceas potrivit pentru măsurarea atacurilor.
2. În sursele inițiale, `song.id !== 0` este o verificare insuficientă a unui
   identificator absent sau de alt tip. FIX_TEST îmbunătățește validarea numerică,
   dar nu dovedește de ce obiectul concret al utilizatorului a rămas invalid.
   Erorile observate nu justifică declararea unei singure cauze istorice certe.
3. Însumarea `L+R` și împărțirea la doi înaintea detecției poate anula canalele
   în opoziție de fază. Este o vulnerabilitate reală, nu cauza demonstrată a testului.
4. **v0.5:** ieșirile plugsync~ sunt conectate corect conform documentației:
   0-based 0 = transport, 5 = samples-per-beat, 6 = poziție PPQ. **Nu există dovadă
   de inversare a acestor porturi.** Ieșirea 8, cu biții de validitate, nu este verificată.
5. `onset()` revine înainte de `attacks++` dacă `beatValue` nu este finit sau durata
   bătăii nu este finită/în intervalul 150–3000 ms. Prin urmare, **0 impulsuri în UI
   nu dovedește 0 atacuri în detector**. ASTEPT SYNC demonstrează intrarea în acest
   blocaj de validare, nu care valoare concretă a lipsit. UI nu separă aceste cazuri.
6. `Date.now()` și un beat actualizat separat la 20 ms amestecă două momente.
   Chiar după rezolvarea sincronizării, rezultatul poate conține cuantizarea și
   întârzierea planificării mesajelor.
7. v0.5 folosește 160 ms pauză între atacuri; la 100 BPM o șaisprezecime are 150 ms.
   Detectorul poate astfel pierde atacuri legitime la fiecare șaisprezecime.
8. v0.5 POPUP inițial cere două abateri; varianta 1 ABATERE corectează această regulă.
   Toate aceste versiuni au nevoie de tratarea separată a testului și a cererii stop.
9. Pragul de 100 ms pe 1/16 la 100 BPM este geometric imposibil față de reperul
   cel mai apropiat. Un transport alternativ nu poate corecta această limită.

## De ce nu a fost adăugat un fallback `transport`

Documentația confirmă că un `transport` fără nume urmează Live. Asta îl face un
obiect valid, dar nu dovedește că este soluția blocajului existent. Combinarea unui
beat dintr-un ceas cu un tempo sau un timestamp din alt traseu ar adăuga noi stări
de tranziție. Noua versiune folosește un singur semnal audio de fază pentru poziție
și durata bătăii. Nu interoghează poziția melodiei prin LiveAPI.

## Arhitectura 0.6 RC4

| Componentă | Contract și responsabilitate |
|---|---|
| `plugin~` | Intrarea audio stereo; nu schimbă rutarea Live. |
| `plugphasor~` | Rampă 0–1 per bătaie, sincronizată la audio-ul gazdei. |
| Fază audio validată | Unica stare de redare folosită de analiză; `plugsync~` nu mai este în patch. |
| `gen~` inclus | Filtru/anvelopă/detecție/timestamp/grilă/stop latch la nivel de eșantion. |
| `snapshot~`, qmetro | Publică valori deja reținute; nu decide momentul atacului. |
| Contor DSP + timeout | Verifică actualizarea motorului local; la lipsă dezarmează și invalidează afișajul. |
| `abs~`, `maximum~`, `peakamp~ 600` | Vârf stereo brut înainte de detector, separat de Gen. |
| `p VTM_Monitor` | Controale și etichete native; poate fi închis fără a scoate motorul din graf. |
| `pcontrol`, `thispatcher` | Deschiderea și comportamentul ferestrei flotante. |
| `live.thisdevice`, `live.path`, `live.object` | Inițializare nativă și exclusiv cererea `stop_playing`. |
| `sig~ 0` → `plugout~` | Ieșire silențioasă cât timp dispozitivul este activ. |

Nu există JavaScript sau alte fișiere de runtime externe. Nu există nume globale
send/receive care ar amesteca instanțele. Variabilele de stare și controalele sunt
locale. Parametrii de lucru sunt reinițializați la încărcare, cu Auto Stop OFF;
această ediție nu implementează memorarea setărilor utilizatorului în Set.

### Ceasul

Diferența dintre două eșantioane de fază determină perioada locală a bătăii.
Înfășurarea 1→0 este tratată explicit. Creșterile trebuie să fie compatibile cu
20–400 BPM timp de 10 ms consecutive; oprirea/staționarea sau o săritură invalidă
invalidează imediat sincronizarea și candidatul. Nu se continuă cu timestamp-uri vechi.
Rezultatul poate reapărea după 10 ms de fază validă. Prima notă exact la pornire sau
după un salt poate fi omisă: detectorul trebuie să se rearmeze după liniște.

Aceasta se bazează pe contractul oficial al plugphasor~. Calitatea semnalului real
în configurația Windows/Live și la tranzițiile preview trebuie confirmată în gazdă.

### Atacul

Fiecare canal este filtrat separat în jur de 65 Hz. Se folosește maximul valorilor
absolute, nu suma stereo. Anvelopa are atac 0,2 ms și relaxare 8 ms. Pragul minim
reglabil este combinat cu un zgomot de fond lent, adaptat numai în liniște.

Prima trecere peste prag este reținută. Candidatul este confirmat după aproximativ
2 ms de anvelopă continuă peste pragul de relaxare. Abaterea se calculează cu faza
și perioada de la trecerea inițială. Confirmarea nu adaugă 2 ms la valoarea măsurată.
Rearmarea cere 12 ms de anvelopă mică, plus o pauză dependentă de grilă, 20–80 ms.

Aceasta este detecție de tranzienți, nu segmentare lingvistică, eliminare de respirații
sau separare voce/instrumental. Un zgomot suficient de puternic poate trece confirmarea.
Atacurile legate fără relaxare pot fi numărate ca un singur eveniment.

### Abaterea și calibrarea

Pentru `k = numitor_grilă / 4`, `T = durata_bătăii_ms` și faza `p`:

```
u = (p * T - compensare_ms) / (T / k)
abatere_ms = (u - floor(u + 0.5)) * (T / k)
```

Intervalul este [-jumătate de pas, +jumătate de pas). La egalitate exactă între
două repere este ales următorul reper. Nu se modelează intenția interpretului.
Calibrarea simplă preia ultima abatere audio brută de la un impuls cunoscut,
numai pe 1/4. Nu este o estimare statistică automată a latenței.

### Auto Stop

Auto Stop începe OFF și nu este parametru automatizabil/persistent. Motorul reține
o singură cerere la prima abatere mare confirmată, numai cu opt-in și ID nativ valid.
Pe firul de mesaje: `snapshot` → `change` → `sel 1` → `deferlow` → verificarea
controalelor ACTUALE → dezarmare → `call stop_playing`. O cerere respinsă de
verificările native este și ea dezarmată, fără apel API sau declanșare la o
recuperare ulterioară a stării.

Starea este **CERERE STOP**, nu o confirmare falsă că redarea s-a oprit.
Dispozitivul observă oprirea progresului fazei; nu primește un răspuns de confirmare
al comenzii Stop. Oprirea reală se verifică pe transportul Live.
Oprirea este asincronă, nu are termen maxim de răspuns garantat. Nu există o
condiție ascunsă de Arrangement Record: funcția se aplică redării dacă este activată.

Dezarmarea, oprirea redării, dezactivarea analizei/dispozitivului, preview, pierderea
ID-ului, sincronizării sau activității audio locale, RESET și schimbarea setărilor de timing închid traseul. Cererile amânate
sunt verificate după `deferlow`; OFF apasat între timp anulează cererea.
TEST IMPULS are contor separat, nu este un eveniment audio și nu poate crea oprire.

## Verificări efectuate și ce nu demonstrează

- C++17 execută automat exact subsetul aritmetic al textului GenExpr, cu History
  citit din eșantionul anterior. Teste pe semnale sintetice la 44,1/48/96 kHz,
  tempo, offset-uri, grile, stereo în antifază, reset, preview, pierdere de sync și stop.
  **Acesta nu este compilatorul Gen**, nici implementarea plugphasor~ din Live.
- Modelul mesajelor interpretează traseele din JSON-ul generat pentru inițializare,
  clicuri, gate-uri, deferlow, dezarmare și calibrare. DSP-ul, GUI-ul, ceasurile și
  API-ul real sunt înlocuite cu simulări explicite. Nu este un emulator Max complet.
  Testele integrate RC4 livrează ieșirile harness-ului Gen către aceste trasee la
  limite de polling simulate de 20 ms; nu reproduc ordonarea exactă MSP/Windows.
- Verificări statice pentru toate ID-urile, porturile, traseele audio, protocoalele,
  ordinea fan-out, autonomia, dimensiunile prezentării și reproducibilitate.
- Containerul AMXD este recitit independent, cu lungimi, offset-uri, director,
  nume și JSON verificate. Formatul a fost reconstruit din AMXD-ul recuperat.
  **RC6 nu a trecut prin Save/Freeze al Max și nu a fost validat de loader-ul Max.**
  RC2 și RC3 au fost încărcate de utilizator, dar au eșuat la verificarea funcțională descrisă mai sus.
- S-a făcut o previzualizare geometrică aproximativă a interfeței cu alte fonturi.
  Nu este o captură reală și nu dovedește randarea Max pe Windows.
- Raportul exact de execuție este inclus în `TEST_RESULTS.txt` și `TEST_RESULTS.json`.

Prin urmare, livrarea este completă ca fișiere și implementare, dar validarea în
gazda reală rămâne deschisă. Nu se afirmă că erorile istorice au fost reproduse
în această gazdă sau că detecția a fost validată pe microfonul utilizatorului.
