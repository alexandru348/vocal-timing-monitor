# Vocal Timing Monitor — 0.7 RC3.3 Persistent

Dispozitiv audio Max for Live pentru afișarea abaterilor atacurilor față de grila Ableton și oprirea opțională a redării/înregistrării. **Setările se păstrează în proiectul Live și revin la redeschidere.** [English documentation](README.md).

## Descărcare și instalare

Descarcă `Vocal_Timing_Monitor_v0_7_RC3_3_Persistent.amxd` din [release v0.7-rc3.3](https://github.com/alexandru348/vocal-timing-monitor/releases/tag/v0.7-rc3.3) sau din [dist](dist/). Necesită Ableton cu Max for Live disponibil. Nu este VST/AU și nu necesită Python pentru utilizare. Etichetele interfeței sunt în română.

1. Încarcă AMXD pe o pistă dedicată analizei și apasă OPEN MONITOR.
2. Selectează microfonul: Ext. In, intrarea potrivită, Monitor In. Ieșirea pistei: Sends Only, trimiterile la minimum. Dispozitivul activ are ieșire mută.
3. În SETARI → SURSA INSTRUMENTALULUI alege manual pista cu beat-ul și Post Mixer.
4. Înregistrează pe o pistă separată, cu intrarea microfonului și armare activă când înregistrezi. Configurația testată cu difuzoare folosește Monitor Off pe pista de înregistrare.
5. Pornește redarea cu ANALIZA ON și AUTO STOP OFF. Verifică undele, sincronizarea și contorul. Apoi activează explicit Auto Stop pentru încercarea dorită.
6. **Apasă Ctrl+S în Ableton pentru a salva proiectul.** Setările se refac la redeschiderea aceleiași instanțe. Dispozitivul nu salvează periodic proiectul pe disc; o instanță nouă pornește cu valorile implicite.

## Ce se păstrează

Analiză, grilă, prag, compensare, detecție, cele două măriri și sursa/canalul instrumentalului. Sursa și canalul sunt căutate după numele exact din lista curentă; dacă numele dispare sau se schimbă, reselectează și salvează.

**Auto Stop pornește întotdeauna OFF**, chiar dacă proiectul a fost salvat cu ON. Contorul, istoricul undelor, acțiunile și diagnosticul temporar nu se păstrează. Volumul microfonului/difuzoarelor din Windows și tempo-ul Live sunt setări externe.

Pentru actualizarea de la RC2, introdu o singură dată valorile în noua instanță: RC2 nu le salva. Păstrează o copie a proiectului înainte să înlocuiești dispozitivul.

Numai pentru proiectul de test care referă deja fișierul RC3_2, folderul [compat](compat/) conține patch-ul RC3.3 sub numele vechi. Astfel instanța și valorile ei rămân pe loc. Nu redenumi/șterge acel fișier din Explorer fără actualizarea referinței proiectului. Pentru instalări noi folosește RC3_3 din dist. Conținutul patch-ului este identic, dar numele intern al containerului și hash-ul diferă.

## Interpretare

Unda albastră este intrarea/vocea, iar cea verde instrumentalul; istoricul comun este de șase secunde. MARIRE schimbă numai desenul.

Minus = devreme; plus = târziu, după compensare. Se măsoară față de reperul cel mai apropiat al grilei Live. Detectorul nu identifică silabe și nu evaluează muzical flow-ul.

La prag 100 ms: verde sub 45 ms, galben de la 45 până sub 100 ms, roșu de la 100 ms în valoare absolută. Limita verde generală este min(45 ms, prag/2). La 100 BPM limita abaterii este ±300 ms pe 1/4, ±150 ms pe 1/8 și ±75 ms pe 1/16; pragul 100 ms nu poate fi atins pe 1/16.

Auto Stop solicită oprirea întregului transport Live, inclusiv înregistrarea, la primul eveniment roșu confirmat. Clipul rămâne. Revine OFF și trebuie reactivat pentru fiecare încercare. Resetarea, anumite modificări de parametri sau pierderea sincronizării îl pot dezarma. Diagnosticul este în SETARI.

## Testare — 02.11.2026

Autorul a verificat în Ableton Live 12 Suite, Windows 11, 44,1 kHz și 100 BPM: restaurarea controalelor după închiderea completă a Ableton, sursa/Post Mixer, valorile neimplicite OFF / 1/8 / 80 ms / măriri 2 și 3, mesajul inițial corect, ambele unde, detecția vocii și contor stabil în liniște pe pasajul testat, înregistrarea separată și Auto Stop cu păstrarea clipului. Salvarea cu Auto Stop ON a fost urmată de OFF la redeschidere.

Configurația finală de test, specifică laptopului:

| Parametru | Valoare |
| --- | --- |
| Microfon Windows / difuzoare | 70% / 15% |
| Detecție | −26 dB |
| Compensare | +92,2 ms |
| Tempo / grilă / prag | 100 BPM / 1/4 / ±100 ms |
| Măriri voce / beat | 1× / 1× |
| Instrumental | Pista 4 / Post Mixer |
| Analiză | Pista 6: Ext. In 1/2, Monitor In, Sends Only |
| Înregistrare | Pista 3: Ext. In mono 1, Monitor Off, Main |

Nivelul microfonului a fost redus pentru evitarea supraîncărcării; apoi sensibilitatea detecției a fost adaptată. Nu vorbi mai tare pentru a compensa un prag nepotrivit. Aceste valori nu sunt o calibrare universală.

Testele native au folosit fișierul compatibil cu numele RC3_2 și patch RC3.3 identic cu varianta canonică; containerul cu numele RC3_3 a fost verificat offline. Proiectele și înregistrările private nu sunt incluse.

140 de verificări statice/simulate au trecut; ele nu execută Max. Vezi [rezultatele automate](docs/TEST_RESULTS.json), [observațiile în Ableton](docs/HOST_VALIDATION.json) și [protocolul](docs/TESTARE_RC3.md). [Versiunea RC2](https://github.com/alexandru348/vocal-timing-monitor/releases/tag/v0.7-rc2) rămâne punctul de revenire original.

## Limite

- Tastele, zgomotul și instrumentalul captat de microfon pot declanșa detectorul. Nu există separare automată a vocii sau anulare de ecou.
- Compensarea vocală rămâne aproximativă și schimbă numai rezultatul numeric. Referința RC2 cu opt impulsuri nu demonstrează aceeași precizie pentru voce.
- CALIBREAZA copiază ultima abatere brută pe grila 1/4; folosește un impuls aliniat, fără zgomote ulterioare.
- TEST IMPULS testează afișarea, fără sunet sau cerere Auto Stop.
- Închiderea monitorului ascunde interfața, dar dispozitivul rămâne activ. Alte configurații decât cea raportată nu sunt validate.

## Dezvoltare și licență

Python 3, NumPy și compilator C++17 sunt necesare numai dezvoltării: `python3 -m pip install -r requirements-dev.txt`, `python3 build.py`, apoi `python3 -m unittest discover -s tests -v`.

Motorul DSP este identic cu RC2. RC3 adaugă stocarea/inițializarea controalelor, iar RC3.3 corectează mesajul inițial pentru analiza oprită. Hash-urile fișierelor sunt în SHA256SUMS; hash-urile descărcărilor release-ului sunt în SHA256SUMS-ASSETS.

Codul și dispozitivul AMXD sunt sub [licența MIT](LICENSE), Copyright (c) 2026 alexandru348. Sunt permise utilizarea, modificarea și redistribuirea, inclusiv comercială, cu păstrarea licenței și a copyright-ului. Fără garanție. Programele terțe își păstrează propriile licențe.
