# Protocol de testare nativă 0.8 RC1.3 Studio

Protocol reproductibil; nu este o listă de teste pe care proprietarul trebuie să le repete. Acceptarea din 03.11.2026 și limitele ei sunt în [HOST_VALIDATION.json](HOST_VALIDATION.json); exemplele de valori și combinațiile de mai jos nu sunt toate rezultate native documentate. Testează într-o copie a proiectului, cu o singură instanță VTM activă pe pista de analiză. Păstrează RC3.3 și fișierul referit de proiectul original.

## 1. Încărcare și aspect

Încarcă noul AMXD și apasă „Deschide monitorul”. Confirmă versiunea 0.8 RC1.3, cele două unde, diacriticele și lipsa textelor tăiate. Comută ambele teme. În „Setări”, verifică pagina uzuală și „Avansat”: nu trebuie să existe controale suprapuse/lipsă. După mutarea ferestrei, extinderea/restrângerea trebuie să păstreze colțul stânga sus.

PNG-urile nu confirmă randarea nativă. Dacă apar obiecte lipsă, mesaje de eroare Max sau culori greșite, raportează observația înainte de înlocuirea versiunii funcționale.

## 2. Voce și instrumental

Introdu valorile preferate în noua instanță, alege sursa instrumentalului/Post Mixer și lasă oprirea automată OFF. Pornește redarea cu analiza activă. Verifică separat ambele unde și un pasaj scurt de vorbire normală urmat de liniște, cu instrumentalul pornit: contorul crește la atacuri și rămâne stabil în pauza testată.

Adaptează pragul la nivelul actual al microfonului, fără să forțezi vocea. Indicatorul brut și marcajul trebuie să răspundă la semnal/prag. Nivelul este vârful brut pe 600 ms, nu anvelopa filtrată internă; „peste prag” nu promite un atac la fiecare vârf. Schimbarea temei/paginii păstrează sursa, controalele și analiza. Nu provoca intenționat supraîncărcare.

## 3. Salvare și repornire completă

Alege tema luminoasă și valori recognoscibile: analiză OFF, grilă 1/8, toleranță 80 ms, măriri 2/3. Păstrează compensarea/detecția potrivite și sursa instrumentalului. Cu oprirea automată OFF, salvează Ctrl+S, închide complet Ableton și redeschide exact proiectul salvat.

Confirmă tema, cele nouă controale, sursa/Post Mixer și concordanța antetului „Analiză oprită” cu butonul. Oprirea automată rămâne OFF; pagina inițială este compactă. Repetă cu tema întunecată. O instanță nouă trebuie să aibă propriile valori, fără să schimbe instanța salvată.

## 4. Înregistrare și oprire automată

Revino la grila 1/4 și toleranța potrivită (de exemplu 100 ms la 100 BPM). După sincronizare, activează explicit oprirea automată. Tema/pagina nu trebuie să o dezarmeze sau să oprească transportul. Înregistrează o încercare normală pe pista separată. La un atac confirmat peste toleranță verifică oprirea transportului/înregistrării, păstrarea clipului, controlul revenit OFF și mesajul din Avansat „Ultimul Stop: oprire confirmata de Live”.

Separat, salvează cu oprirea automată explicit ON, închide complet și redeschide: trebuie să fie OFF, iar tema și celelalte valori păstrate. Salvarea făcută deja cu OFF nu verifică acest ultim caz.

## Acceptare

Proprietarul a acceptat fluxul testat în RC1.3, inclusiv restaurarea temei luminoase înainte de deschiderea monitorului, controalele salvate, înregistrarea/oprirea cu clip păstrat și redeschiderea OFF după salvare cu ON. Raportul de rezultate precizează ce a fost observat și ce rămâne în afara acestei verificări. Păstrează doar rezultatele funcționale și versiunea testată în raportul public; proiectele/audio/diagnosticele brute private nu se publică.

## Verificări noi RC1.2

În Avansat, verifică afișarea 1× / 2× și editarea unei valori 2.5×. Schimbă tema și revino: valoarea trebuie să rămână numerică și lizibilă. Include o valoare fracționară în testul de salvare/repornire. Verifică și textele mărite în toate cele trei vederi. Dacă textul rămâne pixelat, inspectează preferința High DPI Rendering conform TEXT_RENDERING.md înainte de a relua audio.

## Verificări noi RC1.3

În copia de test, înlocuiește RC1.2 cu RC1.3 și păstrează o singură instanță activă. O instanță nouă are valori inițiale; introdu din nou setările folosite. Lasă oprirea automată OFF. Cu panoul dispozitivului vizibil, comută tema luminoasă/întunecată în monitor: ambele suprafețe trebuie să corespundă, inclusiv textele și butonul de deschidere. Bara de titlu/cadrul exterior aparțin Live.

Salvează tema luminoasă, închide complet Ableton și redeschide proiectul. Înainte de deschiderea monitorului, panoul dispozitivului trebuie să fie deja luminos. Deschide monitorul și confirmă aceeași temă și valorile salvate. Repetă pentru întunecată dacă apare o diferență. Apoi continuă testele de înregistrare/oprire de mai sus. Rezultatele RC1.2 confirmate anterior sunt arhivate separat; nu se declară automat trecute pentru noul AMXD.
