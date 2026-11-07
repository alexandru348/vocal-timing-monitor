# Verificarea RC1.7.1 în Ableton — protocol și observații

Păstrează RC1.6 și folosește o copie a proiectului, cu o singură instanță VTM activă. Nu modifica preferințele audio pentru acest test. O instanță nouă începe cu valorile sale inițiale.

## 1. Calibrare fără buton

Selectează instrumentalul real, Post Mixer, și redă un pasaj variat prin difuzoare. Nu folosi clipul periodic de impulsuri pentru măsurarea întârzierii: poate fi ambiguu. REC global OFF, Oprire auto OFF, analiză activă. În Avansat, Calibrare auto ON și compensare inițială 0. Nu apăsa Preia întârzierea. Nu vorbi. Lasă aproximativ 20 de secunde; urmărește mesajul de măsurare/aplicare și compensarea. Dacă nu e concludent, valoarea se păstrează; oprește și reia pentru alt pasaj.

După aplicare, Ctrl+S. O nouă redare trebuie să reutilizeze valoarea. Cu Calibrare auto OFF nu trebuie să pornească o măsurare nouă. Butonul manual rămâne pentru recalibrare cu REC și Oprire auto OFF.

## 2. Mai multe take-uri

După calibrare selectează reperul cunoscut, oprește pista beat-ului original și păstrează traseul de analiză. Grilă 1/4, toleranță 100 ms, aceeași compensare. Pista de înregistrare separată pregătită; nu activa monitorizarea în difuzoare. Activează Oprire auto o singură dată. Revino la 1.1.1 și pornește cu F9 (pe configurația proprietarului F9 singur pornește REC). La prima secțiune +150 ms trebuie să oprească transportul, să păstreze clipul și să rămână ON.

Repetă încă un take fără a atinge comutatorul. Verifică că pornește normal și nu se oprește pe vechea abatere, apoi se oprește la următoarea abatere reală. Folosește o zonă/copie potrivită pentru a nu suprascrie take-uri de păstrat. Manual OFF trebuie să împiedice Auto Stop.

## 3. Redeschidere

Salvează cu Oprire auto ON și o compensare aplicată, apoi închide/redeschide proiectul. Oprire auto trebuie să fie OFF; compensarea, preferința Calibrare auto, tema și celelalte setări trebuie păstrate. Modul automat nu trebuie să măsoare din nou dacă există compensare validă. Nu este necesară trimiterea vocii; sunt suficiente observațiile și capturile interfeței.

Protocolul de mai sus este reutilizabil. Pe 7 noiembrie 2026, proprietarul a observat calibrarea fără buton, un nou take cu ON păstrat, dezactivarea manuală, salvarea/redeschiderea și reutilizarea compensării. Vezi HOST_VALIDATION.json pentru rezultate și limite. Oprirea inițială foarte timpurie la −264,2 ms are cauza neconfirmată; al doilea take a avansat și s-a oprit la +159,5 ms. Nu toate variantele protocolului au fost executate exhaustiv.
