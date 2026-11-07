# Vocal Timing Monitor — 0.9 RC1.7.1 Studio

Două îmbunătățiri cerute: Oprire auto rămâne ON între take-uri, iar calibrarea poate porni automat când lipsește compensarea. Versiune prerelease verificată de proprietar în Ableton Live 12 Suite, Windows, la 44,1 kHz, în limitele descrise în raportul de testare. [English](README.md).

[Plugin RC1.7.1](dist/Vocal_Timing_Monitor_v0_9_RC1_7_1_Studio.amxd?raw=true) · [RC1.6 publicată, pentru revenire](https://github.com/alexandru348/vocal-timing-monitor/releases/tag/v0.9-rc1.6)

## Prima folosire

Folosește o copie a proiectului și o singură instanță VTM activă pe pista de analiză. Înlocuirea cu o instanță nouă nu transferă automat setările instanței vechi. Necesită Ableton cu Max for Live; componentele sunt incluse, fără Python la utilizare. Ieșirea pistei de analiză este mută; înregistrează pe o pistă separată.

1. Selectează instrumentalul real în Setări, cu punctul de preluare potrivit (de exemplu Post Mixer). Microfonul trebuie să capteze același sunet redat prin difuzoare.
2. În Setări → Avansat, Calibrare auto este ON implicit. Lasă Oprire auto OFF pentru calibrare și pornește un pasaj variat fără REC, fără să vorbești.
3. Când nu există compensare, măsurarea pornește singură după stabilizarea condițiilor. Lasă aproximativ 20 de secunde pentru rezultatul final. Dacă reperul este neconcludent, valoarea veche se păstrează; poți relua redarea sau folosi Preia întârzierea.
4. După un rezultat aplicat, salvează cu Ctrl+S. Compensarea este reutilizată la următoarele take-uri și redeschideri. O valoare zero măsurată concludent este diferită de lipsa calibrării.
5. Activează Oprire auto o singură dată. La o abatere peste toleranță, take-ul se oprește, dar comutatorul rămâne ON. Poți porni următorul take cu F9 pe configurația testată, fără să reactivezi comutatorul.

Calibrare auto OFF dezactivează pornirea automată și păstrează butonul manual. Preferința se salvează în proiect. Oprire auto revine OFF doar la inițializarea/redeschiderea dispozitivului/proiectului sau când o oprești tu. O cerere internă consumată nu înseamnă că butonul vizibil trece pe OFF.

## Limite

Calibrarea automată nu rulează în timpul REC sau cu Oprire auto ON. Nu recalibrează la fiecare take și nu detectează singură schimbările traseului audio: după schimbări relevante folosește butonul manual. Valori manuale/salvate nenule sunt reutilizate. Un rezultat neconcludent nu este acceptat automat.

Detectorul compară atacuri sonore cu grila, nu recunoaște silabe sau intenția flow-ului. Tastele, camera și instrumentalul pot produce atacuri. Compensarea corectează măsurarea, fără să mute clipurile. Reluarea unui take fără reactivarea comutatorului a fost observată în Ableton; toate combinațiile de tranziții nu sunt certificate.

[Protocol scurt](docs/TESTARE_0_9.md) · [Rezultate automate](docs/TEST_RESULTS.json) · [Stare nativă](docs/HOST_VALIDATION.json) · [Detalii](RELEASE_NOTES.md)

Observația anterioară +231,9 ms și oprirea timpurie la −264,2 ms au **cauză neconfirmată**. RC1.6 rămâne disponibilă pentru revenire; previzualizările RC1.7.1 sunt ilustrații aproximative cu semnale sintetice. Nu sunt incluse fișiere personale. [Licență MIT](LICENSE).

## Testele proprietarului din 7 noiembrie 2026

Calibrarea fără buton a aplicat 83,290486 ms. Oprire auto a rămas ON după oprire; următorul take a pornit cu F9 și s-a oprit ulterior la +159,5 ms. Cu Oprire auto OFF înregistrarea a continuat. După închiderea și redeschiderea Ableton, Oprire auto a revenit OFF, iar Calibrare auto OFF și compensarea s-au păstrat. După activarea Calibrare auto ON și redarea întregului reper, compensarea a rămas identică. Sunt verificări punctuale pe configurația testată, nu o garanție generală de precizie.

Cele 250 de verificări automate provin din RC1.7; corecția RC1.7.1 a textului a primit separat 30 de verificări țintite. Nu sunt 280 de teste distincte.
