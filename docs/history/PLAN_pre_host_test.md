# Vocal Timing Monitor — punct de reluare, 1 noiembrie 2026

Etapa curentă: interfață compactă înainte de conectarea microfonului.

Confirmat în istoricul furnizat:
- RC6 a oprit efectiv Live la primul impuls cu abatere mare, contor 1, Auto Stop OFF.
- RC1 afișează două unde: Puls_calibrare sus și primul_beat jos.
- Testul No Input confirmă separarea intrărilor.

Implementat în RC2 Compact:
- Fereastră 600 × 340, cu cele două unde, grilă, stare/abatere, Auto Stop și Reset.
- Setări extensibile la 600 × 620; poziția și valorile sunt păstrate la restrângere.
- Motorul și graful audio/API/Auto Stop din RC1 rămân identice.

Urmează: verificarea noii ferestre în Ableton, păstrând impulsurile și beat-ul.
Apoi conectarea microfonului, calibrarea traseului fizic și verificarea cu voce reală.
Auto Stop actual oprește transportul și înregistrarea în curs; nu doar pista vocală.

Nu se declară funcționarea nativă RC2 înainte de testul pe calculatorul utilizatorului.
