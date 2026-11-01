> Historical development note. For current installation and validation, see ../../README.md and ../HOST_VALIDATION.json.

# Corecții RC2 după erorile reale din consola Max

Problemele sunt în codul generat și livrat, nu în instalarea făcută de utilizator.
RC1 a încărcat interfața, însă motorul nu a trecut compilarea.

## Cauze și corecții

1. În GenExpr, `Param(enabled, 1);` nu declară variabila `enabled`. Forma folosită
   acum este `Param enabled(1);`. Analog, `History(prevphase, 0);` devine
   `History prevphase(0);`. Au fost corectate toate cele 42 de declarații.
2. Operatorul `?:` utilizat în două obiecte Max `expr` a fost respins în testul
   utilizatorului. Selectarea grilei folosește acum exclusiv aritmetică și comparații:
   `4 * (1 + ($i1 == 1) + 3 * ($i1 == 2))`. Nivelul audio trece prin
   `maximum 0.00001`, apoi `expr 20. * log10($f1)`.
3. Mesajele Gen necunoscute apar după eșecul compilării. Parametrii nu sunt
   disponibili într-un motor care nu a compilat. Nu s-a schimbat protocolul pentru
   a masca aceste mesaje.

## De ce au trecut testele RC1

Modelul C++ extrăgea și elimina declarațiile greșite înaintea execuției. El valida
aritmetica, dar accepta o formă de declarație care nu era GenExpr validă. În plus,
modelul mesajelor înlocuia rezultatul celor două expresii cu formule Python scrise
manual. Astfel, nu verifica expresiile native efectiv livrate.

În RC2, extragerea declarațiilor acceptă numai forma declarativă documentată și
respinge explicit formele greșite din RC1. Modelul evaluează textul real al
expresiilor aritmetice din patch; nu mai substituie manual rezultatul. Cele șapte
teste suplimentare includ cazuri negative cu formele greșite din RC1, schimbarea
grilei prin conexiunile generate și tratarea nivelului audio zero.

Aceste verificări suplimentare nu sunt un compilator Gen și nici un runtime Max.
Ele previn recurența acestor greșeli cunoscute. Încărcarea și compilarea reală a
RC2 rămân de confirmat în Ableton. Raportul exact al testelor este inclus separat.

## Documentație oficială folosită

- [Gen Overview — exemplu de declarație Param](https://docs.cycling74.com/userguide/gen/_gen_overview/)
- [GenExpr — declarații, scop și cod](https://docs.cycling74.com/userguide/gen/gen_genexpr/)
- [Gen DSP operators — declarația History în exemplul dcblock](https://docs.cycling74.com/userguide/gen/gen~_operators/)
- [Max expr — sintaxă și funcții](https://docs.cycling74.com/reference/expr/)
- [Max maximum — limitarea inferioară a nivelului pentru logaritm](https://docs.cycling74.com/reference/maximum/)
