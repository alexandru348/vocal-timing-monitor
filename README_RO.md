# Vocal Timing Monitor — 0.8 RC1.3 Studio

Monitor ritmic Max for Live cu interfață în română. **0.8 RC1.3 Studio — candidat de lansare acceptat în configurația testată, 03.11.2026.** Proprietarul a confirmat funcționarea în Windows / Ableton Live 12: teme luminoase sincronizate, setări păstrate după repornire completă, înregistrare și oprire automată cu clip păstrat, apoi redeschidere cu oprirea OFF după salvare cu ON. [Rezultate și limite](docs/HOST_VALIDATION.json). [Versiunea 0.7 RC3.3](https://github.com/alexandru348/vocal-timing-monitor/releases/tag/v0.7-rc3.3) rămâne disponibilă pentru revenire. [English](README.md).

[Descarcă dispozitivul AMXD](https://github.com/alexandru348/vocal-timing-monitor/raw/refs/heads/main/dist/Vocal_Timing_Monitor_v0_8_RC1_3_Studio.amxd). Fișierul publicat este exact cel testat; după acceptare s-a actualizat doar documentația.

## Ce s-a schimbat

- Teme luminoasă/întunecată, selectabile permanent și salvate în proiect.
- Rezultat ritmic mai vizibil, explicația „mai devreme” / „mai târziu”, text și simbol alături de culoare.
- Cele două unde rămân simultan vizibile: microfon și instrumental.
- Setări uzuale: grilă, toleranță, detecție și sursa instrumentalului.
- Indicator de nivel brut, marcaj pentru prag și mesaj de supraîncărcare. Depășirea pragului vizual nu garantează un atac: detectorul folosește și filtrare, anvelopă, zgomot și rearmare.
- Compensarea, calibrarea, mărirea vizuală și diagnosticul sunt în „Avansat”.
- Fereastră compactă de 640 × 370; cu setări deschise, 640 × 760. Paginile de setări folosesc aceeași zonă.

Motorul DSP și protocolul de rutare/oprire automată sunt păstrate. „Resetează măsurătorile” șterge contorul/rezultatul și dezarmează oprirea automată; valorile controalelor rămân.

## Instalare și prima utilizare

Folosește `dist/Vocal_Timing_Monitor_v0_8_RC1_3_Studio.amxd`. Necesită Ableton Live 12 cu Max for Live și Max 8.6 sau mai nou. Nu este VST/AU; utilizarea nu necesită Python.

1. Fă o copie separată a proiectului. Păstrează fișierul și instanța RC3.3 funcționale.
2. În copie, dezactivează RC3.3 și adaugă noul AMXD pe pista de analiză. Apasă **Deschide monitorul**. Păstrează o singură instanță VTM activă pe acea pistă.
3. Pista de analiză: intrarea microfonului, Monitor In, Sends Only, trimiterile la minimum. Dispozitivul activ are ieșire mută. Pista separată de înregistrare își păstrează rutarea potrivită configurației existente.
4. În **Setări**, selectează pista instrumentalului și **Post Mixer**, apoi introdu valorile preferate în noua instanță. O instanță nouă nu preia automat valorile celei vechi.
5. Lasă **Oprire auto: OFF**, pornește redarea cu **Analiză activă** și verifică undele/contorul. Vorbește normal, apoi păstrează câteva secunde de liniște.
6. **Ctrl+S salvează setările și tema în proiect.** Nu există salvare periodică a proiectului pe disc.

[Protocolul 0.8](docs/TESTARE_0_8.md) descrie verificările reproductibile: teme/pagini, repornire completă, restaurarea valorilor, voce/instrumental și oprire reală în timpul înregistrării, cu păstrarea clipului.

Nu există un procent universal potrivit pentru microfon. Evită supraîncărcarea vorbind normal și adaptează pragul la nivelul ales. Un număr mai negativ în **Prag de detecție (dB)** crește sensibilitatea. Nu forța vocea pentru a trece un prag nepotrivit. Volumul Windows și tempo-ul Live sunt setări externe.

## Interpretare și salvare

Minus = mai devreme; plus = mai târziu, după compensare, față de cel mai apropiat reper al grilei Live. Nu se identifică silabe și nu se evaluează flow-ul muzical. Compensarea schimbă rezultatul numeric, fără să mute înregistrarea sau undele.

La toleranță 100 ms: verde sub 45 ms, galben de la 45 până sub 100 ms, roșu de la 100 ms în valoare absolută. Limita verde este min(45 ms, toleranță/2). La 100 BPM: ±300 ms pe 1/4, ±150 ms pe 1/8, ±75 ms pe 1/16. Interfața explică dacă toleranța depășește limita grilei.

**Oprire auto: ON** se activează explicit după sincronizare, pentru încercarea dorită. Primul eveniment roșu confirmat solicită oprirea întregului transport Live, inclusiv înregistrarea; clipul rămâne. Revine OFF după cerere și întotdeauna la încărcare, inclusiv după salvare cu ON. Resetarea, anumite modificări de parametri sau pierderea sincronizării îl pot dezarma. Tema și navigarea nu schimbă această intenție.

Se salvează zece controale: analiză, grilă, toleranță, detecție, compensare, două măriri, sursa/canalul instrumentalului și temă. Pentru sursă/canal se folosește numele exact confirmat; dacă dispare/se schimbă, reselectează și salvează. Contorul, istoricul, diagnosticul și pagina deschisă sunt temporare. [Detalii](docs/PERSISTENCE.md).

**Preia întârzierea** copiază ultima abatere brută pe grila 1/4; folosește un impuls cunoscut și aliniat. **Test afișare** verifică mesajele vizuale, fără sunet sau cerere de oprire.

## Ce este verificat

155 de verificări statice/simulate au trecut, inclusiv pentru motorul existent. Nu rulează Max/Ableton. [Rezultatele automate](docs/TEST_RESULTS.json) sunt separate de [testele native](docs/HOST_VALIDATION.json), care consemnează acceptarea RC1.3 în configurația testată și limitele observațiilor.

Previzualizările PNG sunt ilustrații aproximative din geometria generată, cu unde sintetice și font substituit; nu sunt capturi din Max. Nu au indicat depășiri estimate de text pe cele trei pagini, în ambele teme. Aspectul nativ Windows folosit în test a fost acceptat de proprietar; PNG-urile nu demonstrează randarea pe alte sisteme. Testele RC3.3 arhivate nu validează automat noua interfață.

Zgomotul, tastele și sunetul difuzoarelor captat de microfon pot produce atacuri. Compensarea vocală rămâne aproximativă. Închiderea ferestrei ascunde interfața; dispozitivul rămâne activ. Alte configurații nu sunt validate. Nu sunt distribuite proiecte Live private, diagnosticele lor, înregistrări sau capturi ale proprietarului.

## Dezvoltare și licență

Sursele includ `build.py`, `studio_ui.py`, motorul Gen, testele, semnalul sintetic și documentația. Comenzile sunt în [README.md](README.md). SHA256SUMS verifică fișierele pachetului; SHA256SUMS-ASSETS verifică descărcările separate.

Codul și AMXD sunt sub [licența MIT](LICENSE), Copyright (c) 2026 alexandru348: utilizare, modificare și redistribuire, inclusiv comercială, cu mențiunile păstrate; fără garanție. Programele terțe își păstrează licențele.

## RC1.2: text și mărire vizuală

Câmpurile măririi afișează direct 1×, 2×, 2.5× etc., până la 8×, păstrând valori numerice și identificatorii salvați. Se folosesc controale native live.numbox; editarea fracționară și restaurarea valorilor au fost confirmate de proprietar în Ableton. Fontul este Segoe UI, disponibil în Windows, cu texte mici mărite și spațiu vertical adaptat. Alte sisteme pot înlocui fontul; nu este inclus un fișier de font. Previzualizarea folosește DejaVu Sans. Claritatea efectivă depinde și de randarea High DPI din Max, nu doar de font: vezi docs/TEXT_RENDERING.md. Pluginul nu schimbă setările globale Max/Windows.

## RC1.3: aceeași temă în monitor și în dispozitiv

Fundalul panoului din Ableton, titlul, explicațiile și butonul de deschidere urmează tema aleasă în monitor. Alegerea salvată se aplică și înainte să deschizi fereastra separată. Nu există un al doilea comutator sau parametru de temă. Bara de titlu și cadrul exterior sunt desenate de Ableton și își păstrează tema aplicației.

Observațiile RC1.2 despre aspectul monitorului și pauza fără interacțiune sunt arhivate separat. În RC1.3, proprietarul a confirmat aceeași temă luminoasă în panou și monitor, panoul deja luminos înainte de deschiderea monitorului după repornire, valorile/sursa păstrate, cele două unde în redare/înregistrare și oprirea automată cu clip păstrat și confirmare Live. În ultimul test s-a salvat explicit cu oprirea ON; după închiderea completă și redeschidere aceasta a revenit OFF, iar celelalte setări s-au păstrat. Raportul delimitează observațiile; nu declară testate toate configurațiile, repornirea nativă cu panou întunecat sau latența exactă a opririi.
