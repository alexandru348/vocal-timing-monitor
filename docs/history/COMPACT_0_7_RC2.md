> Historical development note. For current installation and validation, see ../../README.md and ../HOST_VALIDATION.json.

# 0.7 RC2 Compact — modificare de prezentare

Cerere: fereastră mai mică, intuitivă, alături de clipurile Ableton, cu ambele unde,
indicator on/off beat și oprire automată păstrată.

Implementare: compact_popup() rearanjează obiectele native existente fără a schimba
numărul de eșantioane, intervalul afișajelor, semnalele sau protocolul de analiză.
Panoul de setări se află sub viewport; butonul modifică numai dimensiunea ferestrei.
`thispatcher` răspunde la `window getsize`; coordonatele originii sunt păstrate și
se calculează noua limită dreapta/jos. Mesajul `window size ... , window exec` aplică
noua dimensiune. Fereastra rămâne flotantă și deplasabilă prin bara de titlu.

Suprafață principală: 600 × 340 = 204000 px², față de 648000 px² în RC1 (-68,52%).
Dimensiunile sunt coordonate Max înainte de scalarea sistemului și de rama nativă.
Setări extinse: 600 × 620. Nu se adaugă scripturi, fonturi sau biblioteci externe.

Etichetele au fost schimbate: starea 4 ON BEAT, 5 USOR DECALAT, 6 OFF BEAT,
9 OPRIRE...; clasificarea, pragurile și calculul numeric rămân cele originale.
Auto Stop ON are evidențiere chihlimbar; rămâne OFF implicit.

Verificare: hash fix al parentului RC1, excluzând doar metadatele de versiune și
conținutul subpatch-ului UI; motorul Gen este identic. Testele verifică controalele
fără suprapuneri, încadrarea în cele două dimensiuni, păstrarea originii după mutare,
izolarea butonului Setări și păstrarea intenției Auto Stop inclusiv după restrângere.

Reconstrucția vizuală locală folosește coordonatele patch-ului și fonturi locale;
nu emulează desenarea live.scope~ și nu demonstrează randarea nativă Max.
Verificările de runtime rămase: încărcare RC2, dimensiune/scalare, expandare,
restrângere, afișaje și oprire în Ableton. Vocea și calibrarea fizică rămân nevalidate.

Sursă oficială pentru protocolul ferestrei, consultată la 1 noiembrie 2026:
https://docs.cycling74.com/reference/thispatcher/
