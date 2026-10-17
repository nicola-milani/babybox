# Modelli 3D

Progettazione parametrica (FreeCAD, Fusion o OpenSCAD). Nel repository vanno **sorgenti + STL**. Licenza proposta CC BY-SA 4.0.

## Case (`case/`)
- Circa 110 × 110 × 90 mm, angoli arrotondati (raggio ≥ 5 mm), nessuno spigolo vivo.
- **Coperchio:** scasso circolare Ø 62 mm, profondo 3 mm, sopra l'antenna del PN5180; fondo dello scasso spesso max 2 mm. Due tacche laterali per sollevare il vinile.
- **Comandi sul coperchio:** cursore volume, corsa 60 mm, pomello largo, icone in rilievo (altoparlante piccolo a sinistra, grande a destra); fessura max 2 mm con bandella interna anti-briciole. Due tasti arcade 30 mm con frecce in rilievo, distanti ≥ 30 mm.
- **Frontale:** finestra e-paper con vetrino o parete sottile; griglia altoparlante con fori ≤ 2 mm.
- **Retro:** USB-C di ricarica e fessura microSD. **Fondo:** interruttore e tasto genitori incassati.
- **Interno:** inserti a caldo M2,5; vano batteria ventilato con sportellino avvitato; camera chiusa dietro l'altoparlante.
- **Chiusura:** fondo con viti a testa speciale, non apribile a mano da un bambino.
- **Materiale:** PETG (PLA per prototipi), riempimento 20–30%, 3 perimetri.

## Statuine (`statuine/`)
- Base: cilindro Ø 40 × 8 mm, incavo per tag 25 mm a 1 mm dal fondo (pausa M600 o tappo incollato).
- Personaggio 50–80 mm, forme compatte, baricentro basso.
- **Obbligatorio:** nessun pezzo che passi dal cilindro per parti piccole (Ø 31,7 mm).
- Finitura multicolore o vernici atossiche EN 71-3. PLA/PETG, riempimento ≥ 40%.

## Vinili (`vinili/`)
- Disco Ø 60 × 4 mm, solchi concentrici in rilievo, etichetta centrale colorata con icona.
- Incavo tag 25 mm al centro a 1 mm dal fondo (M600). Bordi arrotondati, niente foro centrale.

## Primo stampato da fare (settimana 1)
**Provino NFC:** piastrina 2 mm + base statuina, per misurare la distanza di lettura prima di stampare il case intero.

## Verifiche sul primo prototipo
Vedi `../test/checklist-prototipo.md`.
