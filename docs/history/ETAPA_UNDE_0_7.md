> Historical development note. For current installation and validation, see ../../README.md and ../HOST_VALIDATION.json.

> Document istoric al etapei anterioare. Pentru starea curentă și limitele RC2 Compact, consultați README_RO.md, COMPACT_0_7_RC2.md și TEST_RESULTS.json.

# 0.7 RC1 — implementare și limite de verificare

Motorul `src/vtm_engine.genexpr` este identic cu cel din RC6. Cele șase condiții ale
executorului Stop, confirmarea ID-ului, deferlow, dezarmarea înaintea comenzii și
citirea is_playing nu au fost schimbate. Auto Stop a fost confirmat real în RC6,
nu încă în 0.7. Vezi HOST_VALIDATION.json pentru dovezi și limite.

## Trasee

`plugin~ 1 2` alimentează detectorul vocal original și separat afișajul de sus.
`plugin~ 3 4` alimentează numai afișajul și indicatorul de nivel al beat-ului.
Un singur `live.routing @port audio_inputs @index 1` alege al doilea bus stereo.
Niciun semnal nou nu intră în detector. `sig~ 0` rămâne singura sursă plugout~.

live.routing este configurat și la inițializarea live.thisdevice. Cele cinci ieșiri
sunt declarate conform exemplului de Max al Cycling ’74: selectat tip/canal la 0/1,
liste disponibile la 2/3, ieșirea 4 nefolosită. Meniurile sunt reconstruite cu
clear, iter, append; setsymbol actualizează selecția fără a o retrimite.
Comenzile beat_type, beat_channel, beat_refresh sunt extrase înainte de protocolul
motorului. Restul mesajelor parcurg traseul RC6.

Pentru fiecare bus se selectează eșantionul semnat cu valoare absolută mai mare,
folosind abs~, >=~, +~ și selector~. Sunt păstrate semnalele mono/right-only și
cele cu polarități opuse, fără anularea lor prin însumare. Este o reprezentare
mono a activității stereo, nu o conversie audio trimisă la ieșire.

## Afișare

Trei live.scope~ în modul History au aceeași durată de 6 s, lățime și interval40 ms.
Rata este preluată din ieșirea a doua dspstate~, conectat la semnal; se cere și
la inițializare/periodic. change evită realocarea când rata nu se schimbă.
Ieșirea on/off a dspstate~ nu este conectată. Detectarea activității DSP și starea
analizei folosesc în continuare contorul și validarea fazei din RC6.

Două scope-uri arată audio real, al treilea arată impulsurile grilei derivate din
plugphasor~: scalare grid/4, modulo1, comparație <0.025, mască de sync valid.
Așadar grila este o bandă comună, nu linii verticale statice prezentate ca timing.
Mărirea x1–x8 este după despărțirea traseului de analiză și numai înaintea scope-ului.
Compensarea numerică nu mută unda. Niciun API JavaScript, fișier audio extern sau
alt dispozitiv Sender/Receiver nu este necesar la rulare.

## Verificări

Testele moștenite procesează aritmetica Gen prin harness C++17 și folosesc stub-uri
Live API explicite. Testele noi evaluează operațiile DSP native citind graful generat,
protocolul meniurilor și rutarea comenzilor. Nu interpretează codul intern C74,
nu desenează live.scope~ și nu execută DeviceIO în Live.

Verificarea de așezare a interfeței este o randare aproximativă din JSON, cu fonturi
Linux; nu este screenshot Max. Nu este prezentată ca validare a obiectelor native.

Nu au fost executate: încărcarea 0.7 în Max, livrarea audio pe bus3/4, desenul/consumul
real al history-urilor mari, reîmprospătarea exactă între scope-uri, close/reopen,
regresia Auto Stop0.7 și microfonul. Aceste limite impun eticheta RC1.

Fișierul AMXD este produs de builderul determinist compatibil cu structura versiunilor
anterioare încărcate de utilizator. Nu este rezultatul comenzii Max Save/Freeze.
Testele verifică structura, chunk-urile, sursa înglobată și lipsa dependențelor externe.
