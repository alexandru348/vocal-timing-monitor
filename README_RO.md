# Vocal Timing Monitor — 0.9 RC1.6 Studio

Versiune RC cu măsurarea automată a întârzierii prin reper audio, verificată de proprietar în Ableton pe 4 noiembrie 2026. Au fost verificate calibrarea repetată, repere cu abateri cunoscute, înregistrarea cu oprire automată, păstrarea compensării după repornire și refuzul calibrării cu Oprire auto sau REC active. Rezultatele se referă la configurația testată; nu certifică toate configurațiile audio. [English](README.md).

**[Descarcă pluginul 0.9 RC1.6 testat](dist/Vocal_Timing_Monitor_v0_9_RC1_6_Studio.amxd?raw=true)** · [Versiunea anterioară 0.8 RC1.3](https://github.com/alexandru348/vocal-timing-monitor/tree/checkpoint/v0.8-rc1.3).

Folosește `dist/Vocal_Timing_Monitor_v0_9_RC1_6_Studio.amxd` într-o copie a proiectului, cu o singură instanță VTM activă pe pista de analiză. Necesită Live 12 cu Max for Live și Max 8.6 sau mai nou. Componentele sunt incluse; utilizarea nu necesită Python. Pista de analiză are ieșire mută; pista de înregistrare își păstrează rutarea existentă.

## Ce se schimbă

Butonul existent **Preia întârzierea**, din Avansat, măsoară diferența dintre instrumentalul primit direct și același sunet captat de microfon. Nu mai copiază ultima abatere vocală.

1. Selectează instrumentalul pe care îl auzi efectiv prin difuzoare și pornește un pasaj variat, cu REC și Oprire auto OFF.
2. Apasă **Preia întârzierea** și păstrează liniștea până la mesajul final (lasă douăzeci de secunde).
3. Dacă măsurarea este concludentă, câmpul existent de compensare primește valoarea estimată. Salvează cu Ctrl+S.
4. Dacă reperul lipsește sau este ambiguu, valoarea existentă este păstrată și apare o explicație în aceeași zonă.

Măsurarea automată este pornită prin buton. Microfonul trebuie să capteze instrumentalul difuzoarelor; nu se poate măsura din voce singură. Repetă după schimbări relevante de configurație audio sau rutare. Nu există învățare continuă din felul în care cânți. Compensarea manuală rămâne disponibilă.

Interfața, pozițiile controalelor, temele, cele două unde, cele zece setări salvate, grila, toleranța, măririle și funcționarea obișnuită a opririi automate sunt păstrate. Oprirea automată pornește OFF la încărcare. Calibrarea nu pornește/oprește redarea și nu schimbă dispozitivele audio.

## Ce este verificat

229 de verificări automate au trecut: întârziere cunoscută în semnale sintetice, refuzul reperelor ambigue/absente, anularea rezultatelor vechi și păstrarea abaterilor vocale reale după compensare. Motorul de detecție este identic cu cel anterior. Verificările automate nu rulează Max; rezultatele native sunt consemnate separat, iar încărcarea CPU nu a fost măsurată sistematic.

Calibrarea a aplicat 93,056351 ms și, la repetare în aceeași versiune, 92,885786 ms. Cu a doua valoare, reperele 0 / +150 / −150 ms au produs în capturile analizate −0,20 / +149,8 / −150,10 ms. Înregistrarea s-a oprit la prima secțiune întârziată intenționat, iar clipul s-a păstrat. Compensarea și tema luminoasă au rămas după repornire; Oprire auto salvată ON a revenit OFF. Cererile de calibrare cu Oprire auto ON sau REC activ au fost refuzate fără modificarea compensării.

Sunt observații punctuale, nu o garanție generală de precizie sub o milisecundă. O valoare anterioară de +231,9 ms, în secțiunea +150 ms, rămâne cu cauza neconfirmată; o captură ulterioară a arătat +149,8 ms. Detectorul poate număra zgomote, însă acest lucru nu dovedește cauza acelei valori. Tranzițiile Session Record, toate schimbările de configurație, vârfurile CPU și alte dispozitive nu au fost verificate exhaustiv în Ableton. [Protocolul reperului](docs/REFERENCE_TEST.md).

[Pașii scurți pentru Ableton](docs/TESTARE_0_9.md). [Algoritm, protecții și limite](docs/AUTO_CALIBRATION.md). [Rezultate automate](docs/TEST_RESULTS.json). [Starea testelor native](docs/HOST_VALIDATION.json).

Zgomotul, tastele și instrumentalul captat în microfon pot produce atacuri: detectorul nu recunoaște vorbirea. Compensarea corectează măsurarea față de grila Live, fără să mute clipul și fără să evalueze intenția muzicală. Măririle modifică doar desenul undelor. Rezultatul pozitiv înseamnă mai târziu, cel negativ mai devreme. Setările se salvează cu Ctrl+S; o instanță nouă are valorile sale inițiale. Dacă sursa/canalul salvat își schimbă numele sau lipsește, reselectează și salvează.

Previzualizările sunt ilustrații aproximative, cu semnale sintetice și font substituit, nu capturi din Max. Nu sunt incluse proiecte Live private, înregistrări sau capturi ale proprietarului. Codul și AMXD sunt sub [licența MIT](LICENSE), inclusiv pentru reutilizare comercială cu mențiunile păstrate; fără garanție.
