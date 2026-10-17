# Come stampare i pezzi

Profilo di partenza: ugello 0,4 — altezza strato 0,2 mm — 3 perimetri.
Stampante: Anycubic Kobra S2 / S3 Max (ci stanno tutti i pezzi in un pezzo solo).

| Pezzo | Materiale | Orientamento | Riemp. | Supporti | Tempo ~ |
| --- | --- | --- | --- | --- | --- |
| `provino-nfc` | PLA o PETG | appoggiato | 20% | no | 30 min |
| `calibro-parti-piccole` | PLA | in piedi | 20% | no | 1 h |
| `base-statuina` | PLA/PETG | appoggiata | 40% | no | 25 min |
| `statuina-orso` | PLA/PETG | in piedi | 40% | no | 2 h |
| `vinile` | PLA/PETG | appoggiato | 30% | no | 35 min |
| `scocca` | **PETG** | **capovolta**, coperchio sul piano | 25% | no | 10–14 h |
| `fondo` | PETG | faccia esterna sul piano | 25% | no | 2 h |
| `piatto-nfc` | PETG (altro colore) | appoggiato | 30% | no | 10 min |
| `pomello-cursore` | PETG | **su un fianco** | 40% | no | 15 min |
| `culla-cursore` | PETG | lato aperto in alto | 30% | no | 25 min |
| `camera-altoparlante` | PETG | fondo chiuso sul piano | 30% | no | 35 min |
| `sportellino-batteria` | PETG | faccia esterna sul piano | 30% | no | 20 min |

Nessun pezzo ha bisogno di supporti: è un vincolo di progetto, non un caso.
Se lo slicer ne propone, c'è qualcosa fuori posto — meglio capire cosa prima
di stampare.

## PETG o PLA

- **Case:** PETG. Regge il calore di un'auto d'estate e si scheggia meno.
  Temperature tipiche: 240 °C ugello, 80 °C piano, ventola al 40–50 %.
- **Statuine e provini:** PLA, più facile e più preciso; tanto non scaldano.

## La pausa per infilare il tag NFC

Statuine e vinili hanno una sede chiusa per il tag: il tag va messo **durante**
la stampa.

1. Nello slicer, a **Z = 2,0 mm**, inserisci una pausa
   (*Add pause at height* / *Inserisci pausa*: genera il comando giusto per la
   stampante — `PAUSE` con Klipper, `M600` con Marlin).
2. Quando la stampa si ferma, appoggia il tag adesivo nella sede, lato adesivo
   in basso, premendo che resti in piano.
3. Riprendi. Lo strato successivo chiude la sede.

Se preferisci non fermare la stampa: in `base-statuina.scad` metti
`TAPPO = true`, stampa anche il tappo e incollalo dopo aver messo il tag.

**Prima di stampare 5 statuine, provane una** e verifica col box (o col
provino NFC) che il tag si legga.

## Dopo la stampa

- **Inserti a caldo M2,5:** 4 nei pilastrini della scocca (per il fondo) e 2
  nei pilastrini del cursore. Punta del saldatore a 220 °C, inserto in asse,
  pressione lenta: deve scendere a filo, non affondare.
- **Piatto NFC:** si incolla dall'interno (cianoacrilato o bistadesivo sul
  bordo). Si incastra dal basso e non può cadere dentro: sotto c'è comunque il
  PN5180 a fargli da battuta.
- **Griglia altoparlante:** un pezzetto di rete anti-polvere incollato
  all'interno tiene fuori briciole e polvere.
- **Spigoli:** passare un dito su tutto. Se qualcosa graffia, carta vetrata
  400. È un oggetto per un bambino di 2 anni.

## Verifiche obbligatorie sui pezzi stampati

- [ ] Nessun pezzo (statuina, pomello, piatto, orecchio rotto) entra tutto nel
      calibro Ø31,7 → vedi `provini/`
- [ ] Il fondo si avvita e resta a filo, senza bordi che tagliano
- [ ] La statuina sta in piedi da sola sullo scasso e non scivola
- [ ] Il vinile si solleva con un dito dalle due tacche
