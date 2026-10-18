# Specifiche di progetto

Copia di lavoro del documento *Box racconta storie open source — Progetto*. Pin in `../hardware/pinout.md`, componenti in `../hardware/bom.csv`, task firmware in `../tasks/`.

## Panoramica

Box audio per bambini, open source e a batteria: si appoggia una statuina con un tag NFC nella base e il box riproduce la storia associata dalla microSD. Togliendo la statuina la riproduzione va in pausa; rimettendola riparte da dove era rimasta.

Principi:
- **Componenti comuni ed economici** (Amazon, AliExpress, negozi di elettronica), sotto 60 € per box.
- **Batteria 18650 sostituibile con ricarica USB-C**, livello di carica visibile, almeno 10 ore di ascolto.
- **Display e-paper** per titolo e batteria, consumo nullo a schermo fermo.
- **Gestione via WiFi** da browser: caricamento audio e associazione tag, senza app.
- **Case e statuine stampati in 3D**, adatti dai 2 anni: nessuna parte piccola staccabile, comandi grandi, volume massimo limitato da firmware.
- **Firmware** basato su un fork di ESPuino (PlatformIO): aggiungiamo solo display e-paper, controllo genitori e italiano.
- **Storie e musica:** storie registrate in casa, canzoncine caricate dai genitori. Le statuine avviano le storie, i vinili stampati le canzoni.
- **Controllo genitori via WiFi:** fasce orarie e modalità nanna dal telefono.

## Architettura hardware

L'ESP32-S3 è il centro: ogni periferica ha un bus dedicato (I2S audio, SPI per PN5180, secondo SPI per e-paper, SD_MMC 1 bit, I2C per DS3231). L'interruttore stacca tutto, compreso l'amplificatore, alimentato direttamente dalla batteria.

Autonomia stimata: 150–250 mA in riproduzione a volume medio → 12–15 ore con 3000 mAh; deep sleep sotto 1 mA.

## Funzioni: cosa c'è già in ESPuino e cosa facciamo noi

| Funzione | Già in ESPuino | Nostro lavoro |
| --- | --- | --- |
| Lettura statuine e vinili | Sì: RC522 e PN5180 | Configurare PN5180 e risveglio all'appoggio (LPCD) |
| Pausa togliendo la statuina | Sì, opzione | Abilitarla |
| Riproduzione MP3 da SD | Sì, audiolibro con salvataggio posizione | Configurare, volume massimo |
| Musica | Sì: singolo, ripetizione, casuale | Tipo di tag "musica" e caricamento in un passo (task 8) |
| Associazione tag | Sì, web UI con backup | Nessuno |
| Cursore volume e tasti | Tasti sì; cursore no (encoder) | Lettura cursore (task 1) |
| Batteria e deep sleep | Sì | Tarare il partitore |
| Web UI e caricamento file | Sì, DE/EN | Traduzione italiana (task 3) |
| Display e-paper | No (anello LED) | Nuovo modulo (task 2) |
| Suoni di sistema | Sì | Registrarli in italiano (task 4) |
| Controllo genitori | In parte: sleep timer, blocco comandi | Fasce orarie, nanna, messaggio vocale (task 6) |

Il risveglio con la statuina (LPCD) funziona solo con tag ISO 14443: gli NTAG213 vanno bene.

## Web UI

Web UI di ESPuino tradotta in italiano, su `nomebox.local`.
- **Già disponibile:** esplora file SD, associazione statuina → cartella con modalità, volume/sleep/WiFi, backup associazioni.
- **Da configurare:** password al primo avvio, nome del box (es. `babybox-cucina`), volume massimo, WiFi sempre attivo in risparmio energetico mentre il box è acceso.
- **Caricamenti grandi:** oltre 50 MB meglio copiare la microSD dal PC (fessura sul retro).
- **Pagina "Controllo genitori"** (task 6), **pagina "Backup"** (task 7), **associazione con tipo** storia/musica e flusso "Nuovo vinile" (task 8).
- **Accettazione:** associare una nuova statuina da telefono richiede meno di 30 s.

## Stampa 3D

Vedi `../modelli-3d/README.md` per le misure di case, statuine e vinili.

## Decisioni prese

- **Firmware:** fork di ESPuino; aggiungiamo display, controllo genitori e italiano.
- **Batteria:** 18650 sostituibile, ricarica USB-C.
- **Contenuti:** storie registrate da noi (task 4), canzoni caricate dai genitori (task 8).
- **Quantità:** un box su millefori, schema in KiCad. Kit per altre famiglie solo dopo (M6). Vendere box finiti richiede marcatura CE (sicurezza giocattoli): da verificare prima.
- **Età:** dai 2 anni.
- **Più box in casa:** uno per casa, nessuna sincronizzazione; export/import (task 7).
- **Licenza:** GPL come ESPuino; modelli 3D CC BY-SA 4.0.
- **Ricarica notturna:** sì, WiFi sempre attivo non è un problema.
- **Messaggio nanna:** registrato dai genitori, caricato da web UI.
- **Musica nelle fasce di riposo:** una canzone conta come una storia.
