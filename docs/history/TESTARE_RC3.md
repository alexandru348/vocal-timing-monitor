# Testare nativă RC3.3 — protocol și rezultat

Testele descrise mai jos au fost efectuate de autor în Ableton Live 12 Suite / Windows 11, 44,1 kHz, 100 BPM, la 02.11.2026. Rezultatele detaliate și numele capturilor sunt în HOST_VALIDATION.json. Cele 140 de verificări automate sunt separate și nu execută Max.

1. Într-o copie a proiectului, selectează manual sursa instrumentalului și Post Mixer. Configurează compensarea, detecția și măriri vizuale neimplicite. Salvează cu Ctrl+S în Ableton, închide complet aplicația și redeschide aceeași instanță. Rezultat: sursă/canal, compensare92.2, detecție−14 și măriri2/3 păstrate.
2. Schimbă ANALIZA OFF, grila1/8 și prag80, salvează și repornește complet. Rezultat: valorile păstrate; defectul inițial de mesaj din RC3.2 a fost corectat în RC3.3, apoi confirmat „ANALIZA OPRITA”.
3. Revino ON, grila1/4, prag100, măriri1/1. Pornește instrumentalul și vorbește normal. Ajustează nivelul microfonului pentru a evita supraîncărcarea, apoi DETECTIE pentru nivelul nou. Rezultat: la microfon70%, difuzoare15%, detecție−26 dB, atacuri detectate când autorul vorbește și contor stabil în liniște pe pasajul testat; ambele unde și ceas sincronizat.
4. Înregistrează pe pista3 separată, Monitor Off. După sincronizare activează explicit Auto Stop. Rezultat: Live a oprit redarea și înregistrarea, clipul a rămas și apare „Ultimul Stop: oprire confirmata de Live”. Auto Stop a revenit OFF.
5. Cu transportul oprit, activează Auto Stop ON. Salvează proiectul cu Ctrl+S fără a-l trece OFF, închide complet Ableton și redeschide proiectul. Rezultat: Auto Stop OFF, celelalte valori păstrate. Capturile ON înainte/după Ctrl+S și OFF după redeschidere, plus clarificarea autorului, confirmă tranziția.

Niciun pas nu necesită țipete sau forțarea vocii. Nu confunda nivelul difuzoarelor cu nivelul microfonului. Valorile enumerate sunt ale laptopului testat, nu valori universale.

Testele native au folosit patch-ul RC3.3 în fișierul compatibil RC3_2 referit de proiect. Varianta canonică RC3_3 are același JSON al patch-ului și diferă prin numele containerului; aceasta a fost verificată offline. Nu sunt incluse proiectele .als sau înregistrările private. Instanțe multiple și liste de rutare reordonate sunt acoperite de modelul automat, fără validare nativă generală.
