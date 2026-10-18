# Specifiche di progetto

Copia di lavoro del documento *Box racconta storie open source — Progetto*. Pin in `../hardware/pinout.md`, componenti in `../hardware/bom.csv`, task firmware in `../tasks/`.

## Panoramica

Box audio per bambini, open source e a batteria: si appoggia sul coperchio una **carta della storia** (PVC, formato carta di credito, con il tag NFC già dentro) oppure un **disco della musica** stampato in 3D, e il box riproduce dalla microSD. Togliendo la carta la riproduzione va in pausa; rimettendola riparte da dove era rimasta.

Ai due lati si agganciano due raccoglitori stampati, uno da sei carte e uno da sei dischi: la collezione resta in vista e il bambino sceglie guardando.

Principi:
- **Componenti comuni ed economici** (Amazon, AliExpress, negozi di elettronica), sotto 60 € per box.
- **Batteria 18650 sostituibile con ricarica USB-C**, livello di carica visibile, almeno 10 ore di ascolto.
- **Gestione via WiFi** da browser: caricamento audio e associazione tag, senza app.
- **Case, dischi e raccoglitori stampati in 3D**, adatti dai 2 anni: nessuna parte piccola staccabile, comandi grandi, volume massimo limitato da firmware.
- **Carte delle storie comprate già fatte** (18 ottobre): una carta stampata costava due ore di stampa e una pausa a metà per infilare il tag; una carta CR80 con NTAG213 dentro costa 0,40 € e si disegna con un adesivo.
- **Firmware** basato su un fork di ESPuino (PlatformIO): aggiungiamo solo controllo genitori, italiano e una pagina semplice per i genitori.
- **Storie e musica:** storie registrate in casa, canzoncine caricate dai genitori. Le carte avviano le storie, i dischi stampati le canzoni: la forma dice il tipo, e un bambino di due anni lo impara subito.
- **Controllo genitori via WiFi:** fasce orarie e modalità nanna dal telefono.

## Architettura hardware

L'ESP32-S3 è il centro: ogni periferica ha un bus dedicato (I2S audio, SPI per PN5180, SD_MMC 1 bit, I2C per DS3231). L'interruttore stacca tutto, compreso l'amplificatore, alimentato direttamente dalla batteria.

Autonomia stimata: 150–250 mA in riproduzione a volume medio → 12–15 ore con 3000 mAh; deep sleep sotto 1 mA.

## Funzioni: cosa c'è già in ESPuino e cosa facciamo noi

| Funzione | Già in ESPuino | Nostro lavoro |
| --- | --- | --- |
| Lettura carte e dischi | Sì: RC522 e PN5180 | Configurare PN5180 e risveglio all'appoggio (LPCD) |
| Pausa togliendo la carta | Sì, opzione | Abilitarla |
| Riproduzione MP3 da SD | Sì, audiolibro con salvataggio posizione | Configurare, volume massimo |
| Musica | Sì: singolo, ripetizione, casuale | Tipo di tag "musica" e caricamento in un passo (task 8) |
| Associazione tag | Sì, web UI con backup | Nessuno |
| Cursore volume e tasti | Tasti sì; cursore no (encoder) | Lettura cursore (task 1) |
| Batteria e deep sleep | Sì | Tarare il partitore |
| Web UI e caricamento file | Sì, DE/EN | Traduzione italiana (task 3) |
| Come si sa cosa fa | Anello LED | **Niente schermo** (18 ottobre): lo stato si legge dalla web UI, al bambino lo dice la carta che ha in mano, e la batteria scarica il box la annuncia a voce. In più **un LED RGB** dietro una finestrella sul fronte, che ESPuino sa già pilotare: livello di batteria al risveglio, WiFi, modalità configurazione, conferma del tag |
| Suoni di sistema | Sì | Registrarli in italiano (task 4) |
| Controllo genitori | In parte: sleep timer, blocco comandi | Fasce orarie, nanna, messaggio vocale (task 6) |

Il risveglio appoggiando la carta (LPCD) funziona solo con tag ISO 14443: gli NTAG213 vanno bene.

## Web UI

Web UI di ESPuino tradotta in italiano, su `nomebox.local`.
- **Già disponibile:** esplora file SD, associazione carta → cartella con modalità, volume/sleep/WiFi, backup associazioni.
- **Da configurare:** password al primo avvio, nome del box (es. `babybox-cucina`), volume massimo, WiFi sempre attivo in risparmio energetico mentre il box è acceso.
- **Caricamenti grandi:** oltre 50 MB meglio copiare la microSD dal PC: la microSD è dentro il case, si svita il fondo. Fuori resta solo la USB-C, protetta da una porticina scorrevole.
- **Pagina "Controllo genitori"** (task 6), **pagina "Backup"** (task 7), **associazione con tipo** storia/musica e flusso "Nuovo disco" (task 8).
- **Accettazione:** associare una nuova carta da telefono richiede meno di 30 s.

## Stampa 3D

Vedi `../modelli-3d/README.md` per le misure di case, dischi e raccoglitori.

## Decisioni prese

- **Firmware:** fork di ESPuino; aggiungiamo controllo genitori e italiano.
- **Niente display** (18 ottobre): la web UI dice tutto ai genitori, la carta dice tutto al bambino. Risparmiati 12–18 € e una settimana di lavoro.
- **Batteria:** 18650 sostituibile, ricarica USB-C.
- **Contenuti:** storie registrate da noi (task 4), canzoni caricate dai genitori (task 8).
- **Quantità:** un box su millefori, schema in KiCad. Kit per altre famiglie solo dopo (M6). Vendere box finiti richiede marcatura CE (sicurezza giocattoli): da verificare prima.
- **Età:** dai 2 anni.
- **Più box in casa:** uno per casa, nessuna sincronizzazione; export/import (task 7).
- **Licenza:** GPL come ESPuino; modelli 3D CC BY-SA 4.0.
- **Ricarica notturna:** sì, WiFi sempre attivo non è un problema.
- **Messaggio nanna:** registrato dai genitori, caricato da web UI.
- **Musica nelle fasce di riposo:** una canzone conta come una storia.
