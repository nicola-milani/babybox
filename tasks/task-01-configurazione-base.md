# Task 1 · Configurazione di base (M1 e M2)

Portare ESPuino sull'ESP32-S3 N16R8 con i pin di `hardware/pinout.md` e le opzioni di `firmware/config/impostazioni-box.md`.

## Gesti del bambino (solo pressione breve)
- Cursore = volume, da sinistra (piano) a destra (forte).
- Tasto avanti / indietro = traccia successiva / precedente.
- Togliere la statuina = pausa.
- Nessuna pressione lunga o combinazione di tasti.

## Lettura del cursore
- Potenziometro su ADC (GPIO2), alimentato da GPIO42 solo quando il box è sveglio.
- Lettura ogni 50 ms con media e isteresi, niente tremolio.
- Corsa intera = 0 → massimo impostato. Il volume della web UI diventa un **limite**, non un valore assoluto.

## Gesti del genitore
- Tasto incassato sul fondo = attiva/disattiva modalità setup. Tutto il resto dalla web UI.

## Accettazione
- [ ] La statuina avvia la storia in meno di 1 s
- [ ] Togliendola va in pausa; rimettendola riparte dal punto salvato
- [ ] Appoggiandola a box addormentato il box si sveglia
- [ ] Un bambino di 2 anni usa cursore e tasti senza aiuto
- [ ] La percentuale di batteria non oscilla più di 3 punti
- [ ] Deep sleep sotto 1 mA (misurato col multimetro)
