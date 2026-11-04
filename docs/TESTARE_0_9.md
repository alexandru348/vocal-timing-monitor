# Verificare nativă 0.9 RC1.6 — protocol și rezultate

Rezultatele sesiunii din 2026-11-04 sunt consemnate în [HOST_VALIDATION.json](HOST_VALIDATION.json). Calibrarea repetată, reperele cunoscute, oprirea automată în Arrangement, repornirea și cele două refuzuri de calibrare au fost observate. Alte configurații, toate tranzițiile Session/DSP și profilarea CPU rămân în afara validării native. Pașii de mai jos sunt protocolul reutilizabil, nu o listă integrală de teste executate.

Păstrează versiunea 0.8 RC1.3. Încarcă 0.9 RC1.6 într-o copie a proiectului cu o singură instanță VTM activă pe pista de analiză. Instanța nouă are valorile inițiale: reintrodu setările dorite și sursa instrumentalului/Post Mixer; nu presupune că sunt copiate automat.

## Primul pas

Deschide monitorul, Setări, Avansat. Confirmă că aspectul și setările sunt cele cunoscute. Lasă REC și Oprire auto OFF. Alege un pasaj de instrumental variat care durează cel puțin douăzeci de secunde, redat prin difuzoarele captate de microfon. Pornește redarea și așteaptă sincronizarea.

Apasă o singură dată **Preia întârzierea**, apoi nu vorbi și nu apăsa taste douăzeci de secunde. Notează mesajul final și valoarea compensării. Trimite o captură numai după ce măsurarea s-a încheiat. Dacă apare un mesaj de compilare Max sau un salt mare de CPU, raportează-l înainte de înregistrare.

Pentru această etapă, la refuz trimite explicația completă cu C, candidat, A/B, M, D, N și S. Nu repeta alte pasaje până nu interpretăm valorile. Candidatul nu este compensarea aplicată. Reperul trebuie să fie același sunet atât pe intrarea digitală selectată, cât și în microfon.

## După primul rezultat

Repetă măsurarea în alt pasaj și verifică stabilitatea valorii. O valoare nouă nu se validează doar pentru că vocea pare mai aproape de grilă: verifică și un reper de timp cunoscut, păstrând neschimbată configurația audio. Diferența dintre intrări este o estimare efectivă a traseului, nu neapărat valoarea Overall Latency din Ableton.

Cu REC sau Oprire auto ON, o cerere de calibrare nu trebuie să modifice compensarea sau să opereze transportul. Verifică anularea la oprirea redării / schimbarea sursei și păstrarea unei valori introduse manual în locul rezultatului vechi. După calibrare reușită, verifică vorbirea obișnuită și o încercare de înregistrare/Auto Stop; o abatere reală trebuie să rămână detectată.

Testele Session Record, restaurarea după repornire, DSP restart/configurație și încărcarea CPU în analiză sunt de asemenea verificări native; testele automate nu le înlocuiesc. Păstrează doar concluzii funcționale publice, fără fișierele/înregistrările private.

Nu este nevoie de Reset între încercări: butonul începe o captură nouă. Reset în timpul calibrării o anulează. În RC1.3, N reprezintă numărul de benzi concludente și S diferența dintre întârzierile lor; două benzi pot confirma direct, iar o singură bandă necesită automat o a doua captură concludentă a aceleiași benzi, cu acord temporal în limita a 3 ms. Nu apăsa butonul din nou când apare Reconfirm: a doua captură pornește automat. Aceste cifre nu înlocuiesc verificarea ulterioară cu un reper de timp cunoscut.

În RC1.5, o anulare afișează explicația și un cod [C...]. Trimite acel mesaj complet dacă apare; nu repeta alte pasaje înainte să interpretăm cauza. Noua versiune nu presupune că redarea este oprită doar pentru că cererea a fost anulată.
