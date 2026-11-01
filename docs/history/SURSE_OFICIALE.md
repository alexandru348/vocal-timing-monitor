> Historical development note. For current installation and validation, see ../../README.md and ../HOST_VALIDATION.json.

# Documentație oficială consultată la 1 noiembrie 2026

Nu au fost folosite forumuri sau exemple terțe ca autoritate pentru contractele obiectelor.
Concluziile despre cauzele din versiunile vechi provin din sursele recuperate;
documentația de mai jos stabilește comportamentul așteptat al obiectelor.

| Sursă | Relevanță pentru implementare |
|---|---|
| [Cycling '74: plugsync~](https://docs.cycling74.com/reference/plugsync~/) | Ordinea ieșirilor din versiunile vechi; eliminat din analiza RC4. |
| [Cycling '74: plugphasor~](https://docs.cycling74.com/reference/plugphasor~/) | Rampă la nivel audio sincronizată cu bătaia Live; zero la oprire/fără suport. Unicul ceas al analizei RC4. |
| [Cycling '74: timing în Max for Live](https://docs.cycling74.com/userguide/m4l/live_timing/) | Transportul fără nume urmărește Live; preview poate întrerupe continuitatea. |
| [Cycling '74: transport](https://docs.cycling74.com/reference/transport/) | Alternativă validă pentru transport, dar nu dovadă a cauzei blocajului din v0.5. |
| [Cycling '74: gen~](https://docs.cycling74.com/reference/gen~/) | Patcher Gen inclus, parametri, reset și compilare. |
| [Cycling '74: Gen Overview](https://docs.cycling74.com/userguide/gen/_gen_overview/) | Procesare per eșantion, samplerate și History. |
| [Cycling '74: GenExpr](https://docs.cycling74.com/userguide/gen/gen_genexpr/) | Declarații Param, ramificare, operatori și cod inclus. |
| [Cycling '74: History](https://docs.cycling74.com/reference/gen_dsp_history/) | Stocare cu întârziere de un eșantion. |
| [Cycling '74: snapshot~](https://docs.cycling74.com/reference/snapshot~/) | Conversie a semnalelor în mesaje; folosit pentru afișare, nu timestamp. |
| [Cycling '74: dspstate~](https://docs.cycling74.com/reference/dspstate~/) | Global fără semnal conectat; eliminat din RC3 în favoarea activității locale. |
| [Cycling '74: peakamp~](https://docs.cycling74.com/reference/peakamp~/) | Vârf absolut de la ultima raportare, cu interval de raportare. |
| [Cycling '74: maximum~](https://docs.cycling74.com/reference/maximum~/) | Maxim între cele două semnale stereo rectificate. |
| [Cycling '74: delay](https://docs.cycling74.com/reference/delay/) | Temporizare anulabilă cu stop pentru lipsa actualizărilor. |
| [Cycling '74: change](https://docs.cycling74.com/reference/change/) | Filtrează repetiții și permite valoare inițială întreagă/zecimală. |
| [Cycling '74: live.thisdevice](https://docs.cycling74.com/reference/live.thisdevice/) | Inițializare completă, bypass și preview. |
| [Cycling '74: Live API overview](https://docs.cycling74.com/userguide/m4l/live_api_overview/) | Inițializare prin live.thisdevice, ID 0 invalid și conexiuni native. |
| [Cycling '74: live.path](https://docs.cycling74.com/reference/live.path/) | ID-uri și urmărirea schimbării obiectului prin ieșirea din mijloc. |
| [Cycling '74: live.object](https://docs.cycling74.com/reference/live.object/) | Operații Live native, automat amânate pe firul principal. |
| [Cycling '74: live.observer](https://docs.cycling74.com/reference/live.observer/) | Notificările nu permit modificarea imediată a Set-ului. Obiectul nu este necesar în versiunea livrată. |
| [Cycling '74: pcontrol](https://docs.cycling74.com/reference/pcontrol/) | Deschidere/închidere a ferestrei separat de enable/mute. |
| [Cycling '74: thispatcher](https://docs.cycling74.com/reference/thispatcher/) | Comenzi pentru fereastra flotantă și coordonate. |
| [Cycling '74: textbutton](https://docs.cycling74.com/reference/textbutton/) | Toggle, set fără output și comportamentul clicurilor. |
| [Cycling '74: counter](https://docs.cycling74.com/reference/counter/) | Intervalul numărătoarelor pentru comenzile de test/reset. |
| [Cycling '74: expr](https://docs.cycling74.com/reference/expr/) | Inlet-uri și expresii pentru controale native. |
| [Cycling '74: limitări Max for Live](https://docs.cycling74.com/userguide/m4l/live_limitations/) | Dispozitivele cu Gen pot fi încărcate/rulate cu Max for Live; editarea lor are condiții de licență separate. |
| [Cycling '74: freezing](https://docs.cycling74.com/legacy/max8/vignettes/live_freezing) | Save/Freeze este fluxul oficial de distribuție; aici nu a putut fi executat. |
| [Ableton: How Latency Works](https://help.ableton.com/hc/en-us/articles/360010545559-How-Latency-Works) | Buffer, driver, rutare, monitorizare, compensare și latența editorului Max. |
| [Ableton: monitoring latency](https://help.ableton.com/hc/en-us/articles/360011924559-How-to-reduce-latency-while-monitoring) | Opțiunile de monitorizare schimbă traseul și latența. |
| [Ableton: device latency](https://help.ableton.com/hc/en-us/articles/360001820360-Viewing-the-latency-of-a-plugin-or-Live-device) | Dezactivarea unui dispozitiv nu elimină neapărat latența declarată. |

Formatul binar AMXD nu este prezentat aici ca specificație oficială publică:
împachetarea a fost derivată din fișierul existent, nu din aceste pagini.

Contracte reverificate pentru RC4: `plugphasor~` și `live.thisdevice` de mai sus,
[Gen out](https://docs.cycling74.com/reference/gen_common_out/),
[Gen codebox](https://docs.cycling74.com/reference/gen_common_codebox/),
[unpack](https://docs.cycling74.com/reference/unpack/),
[pak](https://docs.cycling74.com/reference/pak/). Listele numerice folosesc
argumente numerice explicite în `unpack` (`0`); acestea nu sunt confundate cu
specificatorii de tip ai altor obiecte. Nu se atribuie acestui detaliu cauza
numărătorii zero din RC3.

Reverificate pentru RC5: [live.object](https://docs.cycling74.com/reference/live.object/)
(legarea prin `id nn`, citirea propriei legări cu `getid`, `get` și `call`),
[live.path](https://docs.cycling74.com/reference/live.path/),
[trigger](https://docs.cycling74.com/reference/trigger/),
[Song](https://docs.cycling74.com/apiref/lom/song/) (`is_playing`, `stop_playing`).
Contractele justifică verificarea executorului. Nu demonstrează că legarea era
cauza exactă a eșecului real RC4; aceasta nu a fost măsurată direct.

## Contractul decisiv pentru RC6

[Cycling ’74: Preview Mode](https://docs.cycling74.com/userguide/m4l/live_preview/)
explică cele două copii ale unui dispozitiv în timpul editării și transportul de
audio, timing și comenzi Live API între Max și Live. Preview activ nu este echivalent
cu lipsa accesului API. RC6 păstrează cererea explicită a utilizatorului și verifică
executorul/ceasul, fără veto bazat doar pe Preview. Documentația menționează și o
latență suplimentară posibilă în preview; calibrarea trebuie făcută pe traseul utilizat.
[Timpul în Max for Live](https://docs.cycling74.com/userguide/m4l/live_timing/)
menționează posibile discontinuități la schimbarea modului; validarea fazei rămâne activă.


## 0.7 — două semnale reale și istoric

- https://docs.cycling74.com/reference/plugin~/ — lista canalelor logice de intrare.
- https://docs.cycling74.com/reference/live.routing — port, index, type și channel;
  este folosit un singur obiect pentru busul suplimentar.
- https://docs.cycling74.com/apiref/lom/maxdevice/ — audio_inputs este lista DeviceIO.
- https://docs.cycling74.com/apiref/lom/deviceio/ — tipuri/canale disponibile și selecții.
- https://cycling74.com/articles/audio-routes-using-audio-routes-tooling-for-your-mfl-devices
  — rutare în perechi stereo; 1/2 și 3/4 sunt busuri separate.
- https://cycling74.com/articles/what%27s-new-in-live-11-part-1 — obiectul live.scope~;
  exemplul de live.routing publicat de Mattijs Kneppers în discuția articolului a
  fost inspectat pentru contractul celor cinci ieșiri și protocolul meniurilor.
  Referință patch: 308feac1675742d2999eb327fbc29ed2. Implementarea nu cere fișierul lui.
- https://docs.cycling74.com/reference/live.scope~/ — History, samples, interval,
  range, active și intrarea de semnal. 6 s = rată *6, refresh cerut40 ms.
- https://docs.cycling74.com/reference/dspstate~/ — rata semnalului pe ieșirea a doua.
- https://docs.cycling74.com/reference/selector~/ — selecție prin semnal; ramptime0.
- https://docs.cycling74.com/reference/modulo~/ — `%~` păstrează restul real.
- https://docs.cycling74.com/reference/inlet/ — inlete de subpatch inclusiv de semnal.
- https://www.ableton.com/en/manual/max-for-live-devices/ — rutare sidechain în
  dispozitivele Max for Live; sursa și punctul de preluare sunt alegeri distincte.

Consultate la 1 noiembrie2026. Nicio sursă documentară nu înlocuiește testul efectiv
al acestui fișier în Ableton. Documentele CORECTII_RC2–RC6 păstrează istoricul;
README_RO.md și ETAPA_UNDE_0_7.md descriu ediția curentă.
