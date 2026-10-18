# Modelli 3D

Tutto è parametrico in **OpenSCAD**: le misure stanno in un unico file,
`sorgenti/parametri.scad`, e gli STL si rigenerano con un comando.

```bash
brew install --cask openscad@snapshot   # una volta sola
./modelli-3d/genera-stl.sh              # rigenera tutti gli STL
```

Licenza proposta: CC BY-SA 4.0.

## Cosa stampare, in che ordine

| # | Pezzo | File | Quando |
| --- | --- | --- | --- |
| 1 | **Provino NFC** | `provini/stl/provino-nfc.stl` | **Subito**, prima di tutto: dice se il lettore arriva al tag attraverso la plastica |
| 2 | Calibro parti piccole | `provini/stl/calibro-parti-piccole.stl` | Subito: serve a verificare le statuine (EN 71-1) |
| 3 | Base statuina + orso | `statuine/stl/` | Settimana 1, per provare tag e lettura |
| 4 | Vinile | `vinili/stl/vinile.stl` | Settimana 1 |
| 5 | Scocca + fondo + pezzi interni | `case/stl/` | Quando i componenti sono arrivati e misurati |

> Prima di stampare il case: ricontrollare col calibro le misure marcate
> `[VERIFICARE]` in `sorgenti/parametri.scad` (potenziometro, tasti,
> altoparlante, PN5180, portabatteria) e rigenerare gli STL. Sono 10 minuti che
> evitano una stampa da 10 ore buttata.

## Il case

Scatola **130 × 130 × 100 mm**, angoli verticali raggio 8 mm, bordo superiore
raccordato: nessuno spigolo vivo.

Due pezzi grandi soltanto:

- **`scocca`** — pareti *e* coperchio in un pezzo unico. Si stampa **capovolta**
  (coperchio sul piano): il coperchio viene liscio come il primo strato, non
  servono supporti e soprattutto **non c'è nessun coperchio che un bambino
  possa aprire**.
- **`fondo`** — l'unica parte smontabile, con 4 viti a testa speciale.

Pezzi piccoli: `piatto-nfc` (il fondo dello scasso dove si appoggia la
statuina, incollato dall'interno), `pomello-cursore`, `culla-cursore`,
`camera-altoparlante`, `sportellino-batteria`.

Il **display e-paper è stato tolto** il 18 ottobre: il fronte è chiuso, con la
sola griglia dell'altoparlante. Per rimetterlo basta `CON_DISPLAY = true` in
`sorgenti/parametri.scad` e rigenerare la scocca.

### Cosa c'è su ogni faccia

| Faccia | Contenuto |
| --- | --- |
| Coperchio | Scasso Ø62 per statuine e vinili (con due tacche per sollevare il disco), fessura del cursore con icone del volume, due tasti arcade Ø30 con frecce incise |
| Fronte | Solo la griglia dell'altoparlante (fori Ø1,8), centrata. Nessuna finestra: il display è stato tolto il 18 ottobre |
| Retro | USB-C di ricarica, fessura microSD, sfiati |
| Fondo | Interruttore generale e tasto genitori **incassati**, sportellino batteria |

### Come stanno dentro i pezzi

```
      ^ retro (y +)
  +-------------------------------+   z=95  soffitto: PN5180 sotto lo scasso NFC
  |  [PN5180 58x47]               |
  |                               |
  |   culla cursore --- fessura   |   z=88
  |                               |
  |  ####### millefori 90x70 #### |   z=28   (ESP32-S3, MAX98357A, DS3231...)
  |  #  TP4056 (retro sx)       # |
  |  camera   [18650 a destra]    |   z=3..23
  |  altopar.                     |
  +-------------------------------+   z=0   fondo avvitato
      v fronte (y -)   griglia dell'altoparlante
```

La batteria sta a destra con l'asse lungo in profondità; la basetta millefori
le passa sopra a 28 mm dal fondo, appoggiata su 4 colonnine stampate col fondo.
L'altoparlante ha la sua camera chiusa: tiene il magnete lontano dall'antenna
NFC e fa da cassa acustica.

## Statuine

Base Ø40 × 8 mm, sede del tag Ø26,4 a **1 mm dal fondo**: fra tag e antenna
restano 1 mm di base + 2 mm di piatto NFC.

Il tag si mette **durante la stampa**: pausa (M600 / *change filament*) a
Z = 2,0 mm, si appoggia l'adesivo nella sede, si riprende. In alternativa si
stampa con `TAPPO = true` e si incolla il dischetto.

`statuina-orso.scad` è il modello da copiare per gli altri personaggi: forme
piene ottenute con `hull()` di sfere, niente colli sottili, baricentro basso,
nessuna parte che possa staccarsi. Altezza totale 61,5 mm.

**Verifica obbligatoria:** nessun pezzo deve entrare tutto nel calibro Ø31,7.

## Vinili

Disco Ø60 × 5,2 mm (4 mm di corpo più solchi ed etichetta in rilievo), bordi
raccordati, nessun foro centrale, stessa sede del tag delle statuine.
Con un cambio colore alla quota dell'etichetta viene bicolore.

## Scostamenti dalle specifiche iniziali

Tre, tutti motivati:

1. **Dimensioni 130 × 130 × 100 invece di 110 × 110 × 90.** Sullo stesso
   coperchio devono convivere lo scasso Ø62, il cursore da 60 mm di corsa e
   due tasti da 30 mm distanti fra loro: a 110 mm non ci stanno senza
   stringere i comandi, che è esattamente ciò che non si deve fare a 2 anni.
   Per riferimento la Toniebox è 120 × 120 × 120.
2. **Icone incise invece che in rilievo.** La faccia superiore è il primo
   strato di stampa: un rilievo lì non è stampabile senza dividere il
   coperchio dalla scocca. Incise restano tattili e si possono evidenziare
   con un pennarello.
3. **Fessura del cursore 3,2 mm invece di 2 mm.** Il pomello non infila la
   levetta del potenziometro nella fessura: ci passa una lama stampata che
   la afferra sotto. Così la fessura resta stretta e il cappello largo la
   copre comunque; un collare interno impedisce alle briciole di arrivare
   all'elettronica.
