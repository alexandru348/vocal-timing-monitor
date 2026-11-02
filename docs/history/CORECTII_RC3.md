> Historical development note. For current installation and validation, see ../../README.md and ../HOST_VALIDATION.json.

# RC3 — activitatea DSP și nivelul de intrare

## Dovezi reale disponibile

Capturile RC2 trimise de utilizator arată fereastra deschisă și consola fără
erorile de compilare RC1. În timpul redării la 100 BPM, ceasul este sincronizat,
dar starea este AUDIO ENGINE OFF, Intrare este -100 dB, iar numărătoarea rămâne zero.
Ultima captură arată pista 6 activă, Monitor In, intrare Reference Pulse / Post Mixer
și nivel înaintea dispozitivului. Activarea pistei nu a rezolvat simptomul.

Capturile nu arată valorile interne ale tuturor parametrilor sau anvelopa dintre
două actualizări. Nu permit atribuirea sigură a numărătorii zero unei singure cauze.

## Probleme confirmate în codul RC2

1. După publicarea stării Gen, același ciclu de polling interoghează `dspstate~`
   fără intrare de semnal. Orice zero primit suprascrie starea cu AUDIO ENGINE OFF
   și dezarmează Auto Stop. Nu există `change` pe această dezarmare. O valoare
   repetată poate astfel anula manual activarea Auto Stop la fiecare ciclu.
   Documentația spune că, fără semnal conectat, `dspstate~` raportează starea globală;
   aceasta nu este o verificare directă a execuției motorului Gen local.
2. Intrare provine dintr-un `snapshot~` al anvelopei, o dată la 20 ms. Este un singur
   eșantion al ultimului vector, nu maximul intervalului. Valoarea -100 dB dintr-o
   captură nu demonstrează absența tuturor impulsurilor precedente.

Prima problemă afectează afișajul și dezarmarea; nu este o condiție directă de
oprire a detectorului. A doua afectează măsurarea afișată. **Aceste constatări nu
demonstrează încă de ce contorul audio RC2 a rămas zero.**

## Corecția implementată

- Eliminată ramura globală `dspstate~` care suprascria starea.
- Adăugat un contor de eșantioane la ieșirea 11 a motorului Gen. Avansează cu DSP-ul,
  inclusiv cu intrare tăcută sau transport oprit. Cele zece ieșiri și algoritmul de
  detecție originale sunt păstrate.
- Contorul este citit la 20 ms. Dacă nu se schimbă timp de 250 ms, interfața arată
  FARA PROCESARE AUDIO, invalidează ceasul afișat și dezarmează Auto Stop.
  Eticheta descrie lipsa actualizărilor locale, nu starea driverului global.
- Activitatea restabilită redă starea motorului și sincronizarea, chiar dacă
  valorile lor nu s-au schimbat între timp. Nu reactivează Auto Stop automat.
- Auto Stop verifică și activitatea locală actuală după `deferlow`, pentru a bloca
  o cerere rămasă în coadă după suspendarea procesării. Dezarmarea la pierderea
  activității se produce la tranziție, nu la fiecare polling.
- Intrare folosește `abs~` pe ambele canale, `maximum~`, apoi `peakamp~ 600`:
  vârful brut pe ultimele 600 ms, independent de Gen, filtrare și prag. Nu există
  însumare stereo care ar anula canalele în antifază.
- `change 0.` este explicit pentru valorile zecimale ale abaterii brute și limitei.
  Nu au fost adăugate fișiere externe sau modificări ale rutării audio de ieșire.

Actualizarea stării depinde și de programarea mesajelor Max. Un blocaj al firului
de mesaje poate întârzia atât citirea, cât și expirarea temporizatorului; monitorul
nu pretinde o detecție independentă de planificator. Noul traseu nu a fost încă
executat în Max/Ableton.

## Verificare și limite

Testele noi execută contorul în harness-ul aritmetic și simulează: lipsa procesării,
reluarea, sincronizarea afișată, dezarmarea o singură dată, anularea cererilor
amânate și traseul nivelului brut către interfață. Acestea se adaugă testelor
detectorului și verificărilor containerului, protocolului și conexiunilor.

Modelul mesajelor și compilatorul C++ nu sunt runtime Max sau compilator Gen.
Numărul exact și rezultatele testelor sunt în TEST_RESULTS.txt/json.
Nu s-a validat încărcarea noului RC3, intrarea reală, numărarea sau stopul în gazdă.

## Următorul test în Ableton

Oprește redarea, dezactivează RC2 și încarcă RC3 pe aceeași pistă 6. Lasă Auto Stop
OFF și rutarea neschimbată. Redă porțiunea cu impulsuri. Observă Intrare, starea,
ceasul și numărătoarea; dacă simptomul continuă, o singură captură în timpul
impulsurilor este suficientă. Nu sunt necesare legături sau editări în Max.

Pentru un semnal controlat există WAV-ul de acceptanță și pașii din README_RO.md.
Semnalul are opt impulsuri, ultimul la +120 ms. Rezultatele sunt așteptări calculate,
nu măsurători deja obținute în Ableton.

## Contracte oficiale reverificate

- [dspstate~](https://docs.cycling74.com/reference/dspstate~/): stare globală fără
  intrare de semnal; nu este contorul motorului nostru.
- [snapshot~](https://docs.cycling74.com/reference/snapshot~/): un eșantion din
  ultimul vector, inclusiv la bang; nu reține automat vârful dintre citiri.
- [peakamp~](https://docs.cycling74.com/reference/peakamp~/): maximul absolut de la
  ultima raportare; argumentul nenul stabilește raportarea periodică.
- [maximum~](https://docs.cycling74.com/reference/maximum~/): maxim între semnale.
- [delay](https://docs.cycling74.com/reference/delay/): bang amânat, anulabil cu stop.
- [change](https://docs.cycling74.com/reference/change/): filtrarea repetițiilor,
  argument inițial numeric și mesaje întregi/zecimale.
