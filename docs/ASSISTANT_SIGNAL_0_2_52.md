# Asistentul de ritm vocal 0.2.52

Prerelease Max for Live pentru exerciții vocale la **100 BPM**. **Probă ritm** afișează patru repere și estimează cât de devreme sau de târziu începe fiecare silabă confirmată. În **Probă frază**, dispozitivul urmărește începuturile de sunet timp de 12 secunde și le include în raport.

[Descarcă dispozitivul `.amxd`](https://github.com/alexandru348/vocal-timing-monitor/releases/download/assistant-v0.2.52/Vocal_Timing_Monitor_Asistent_Ritm_Vocal_Semnal_v0_2_52.amxd) · [Monitorul RC1.7.1 pentru revenire](https://github.com/alexandru348/vocal-timing-monitor/releases/tag/v0.9-rc1.7.1)

## Prima folosire

1. Deschide o copie a proiectului în Ableton Live cu Max for Live și încarcă dispozitivul pe pista de analiză. Urmează [instrucțiunile monitorului](../README_RO.md) pentru alegerea reperului instrumental și calibrare.
2. Deschide **Surse și claritatea semnalului**, alege **Intrare live** și verifică sursa microfonului și reperul instrumental.
3. Pornește redarea la **100 BPM**, apasă **Probă ritm**, rămâi în liniște în timpul pregătirii și spune „ta” o dată la fiecare semnal **TA**. Apasă **Salvează raportul** pentru a păstra rezultatul local.
4. Pentru **Oprire auto**, pornește **REC** în Arrangement înainte de **Probă ritm**. Când opțiunea este ON, prima abatere vocală confirmată dincolo de toleranța de 100 ms și de marja de incertitudine de 35 ms poate opri înregistrarea. Cu OFF, poți urmări măsurătorile până la finalul probei. La redeschiderea proiectului, opțiunea pornește pe OFF.

Oprirea automată din acest pachet se aplică în **Probă ritm**. **Probă frază** raportează observații despre momentul atacurilor și posibile sunete vocale. Rezultatele depind de semnalul captat. Un semnal saturat poate amâna sau bloca oprirea. Dispozitivul salvează date de diagnostic în JSON și lasă materialul înregistrat în Live.

## Verificări

- În Ableton Live 12 Suite pe Windows, la 44,1 kHz, versiunea preconfigurată 0.2.51 a trimis o singură comandă la al doilea reper din proba ON. Abaterea măsurată a fost −137,6 ms, iar Live a confirmat oprirea. Proba OFF a ajuns la final cu zero comenzi. În acel raport OFF, atacurile confirmate au căzut în afara reperelor.
- Pachetul distribuit folosește aceeași analiză și aceeași comandă de oprire. Setează sursele din proiectul tău. Cele patru semnale apar la intervalele normale ale probei.
- Reproduce pachetul cu `python assistant_clarity.py --guided-stop`. Din surse, rulează `python -m unittest discover -s tests` după instalarea dependențelor din `requirements-dev.txt`.
