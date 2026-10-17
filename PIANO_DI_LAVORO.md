# Piano di lavoro — consegna venerdì 20 novembre 2026

Partenza: sabato 17 ottobre 2026. Tempo disponibile: **5 settimane**.

## Cosa significa "pronto" il 20 novembre

Un box completo e funzionante (milestone M1–M5 in versione essenziale):

- case in PETG chiuso, elettronica su millefori, batteria 18650 con ricarica USB-C;
- almeno **5 statuine** con storie registrate e **3 vinili** con canzoni;
- firmware: statuine, pausa/ripresa, cursore volume, tasti, deep sleep, e-paper, web UI in italiano, controllo genitori;
- test d'uso con un bambino superato; repository pubblico con README e STL.

**Fuori dal 20 novembre** (dopo la 1.0): PCB custom, M6 kit per altre famiglie, PR della traduzione a ESPuino (si può aprire, non serve che venga accettata), esportazione "personaggio" in TAR se il tempo stringe.

## Il rischio principale: i tempi di spedizione

AliExpress impiega spesso 10–20 giorni: ordinando sabato 17 i pezzi arrivano tra fine ottobre e inizio novembre, troppo tardi per M1.
**Strategia:** ordinare **oggi su Amazon** i moduli critici (ESP32-S3 N16R8, PN5180, MAX98357A, e-paper 2,13", tag NTAG213, 18650 + portabatteria, TP4056 USB-C) e su AliExpress i ricambi (2–3 pezzi dei moduli delicati) e la minuteria. Vedi `hardware/bom.csv`, colonna `fornitore_consigliato`.

## Settimana per settimana

| Settimana | Firmware | Hardware / 3D | Contenuti | Uscita (gate) |
| --- | --- | --- | --- | --- |
| **0 · 17–18 ott** (weekend) | Fork ESPuino, submodule, prima compilazione per ESP32-S3 | **Ordini** Amazon + AliExpress; schema KiCad rivisto | Scrivere elenco storie e canzoni | Firmware compila; ordini fatti |
| **1 · 19–25 ott** | Task 1 (config, pin, opzioni); Task 3 (italiano, non serve hardware) | Breadboard appena arrivano i pezzi; CAD case v1 + provino NFC (piastrina 2 mm) | Registrare 2 storie; suoni di sistema | **M1:** statuina → storia in < 1 s |
| **2 · 26 ott–1 nov** | Task 1 completo: cursore, tasti, deep sleep, batteria; avvio Task 2 (e-paper) | Alimentazione su breadboard; stampa case v1 e prime 2 statuine | Registrare altre 2 storie | **M2:** sleep < 1 mA, batteria stabile ±3 punti; avviare test autonomia |
| **3 · 2–8 nov** | Task 2 (e-paper), Task 6 (controllo genitori), Task 8 (musica e vinili) | Correzioni → case v2; statuine e vinili con tag (pausa M600) | 5ª storia; 3 canzoni | Display corretto entro 2 s; blocco nanna funziona |
| **4 · 9–15 nov** | Task 7 (export/import JSON), Task 5 (primo allineamento ESPuino), OTA | Montaggio su millefori nel case v2; verifiche prototipo (NFC, stabilità, calore, caduta) | Normalizzazione −16 LUFS di tutto | **M3 + M4:** statuina associata da telefono in 30 s; verifiche superate |
| **5 · 16–20 nov** | Solo bug fix, freeze del firmware mercoledì 18 | Ritocchi estetici, verniciatura EN 71-3 | — | **M5:** test d'uso con bambino, README, release 1.0 venerdì 20 |

M3 (firmware) e M4 (case) vanno in parallelo dalla settimana 2: se siete in due, uno segue il firmware e l'altro la stampa 3D.

## Ordine dei task firmware

1. `tasks/task-01-configurazione-base.md` — sett. 1–2
2. `tasks/task-03-italiano-web-ui.md` — sett. 1 (in parallelo, senza hardware)
3. `tasks/task-02-display-epaper.md` — sett. 2–3
4. `tasks/task-06-controllo-genitori.md` — sett. 3
5. `tasks/task-08-musica-vinili.md` — sett. 3
6. `tasks/task-07-export-import.md` — sett. 4 (JSON obbligatorio, TAR se c'è tempo)
7. `tasks/task-05-allineamento-espuino.md` — sett. 4, poi mensile
8. `tasks/task-04-registrazioni.md` — continuo, non è firmware

## Checklist di oggi (sabato 17 ottobre)

- [ ] Ordinare i componenti (vedi `hardware/bom.csv`)
- [ ] Fare il fork di ESPuino su GitHub e aggiungerlo come submodule (`firmware/README.md`)
- [ ] `git init` di questo repository e primo commit
- [ ] Installare in VS Code l'estensione PlatformIO
- [ ] Confermare la lista delle 5 storie e 3 canzoni per la 1.0

## Margini e piano B

- Se il PN5180 non arriva in tempo o dà problemi con LPCD: RC522 (supportato da ESPuino) per il prototipo, senza risveglio all'appoggio.
- Se l'e-paper slitta: la 1.0 esce senza display (stato via suoni di sistema), il task 2 diventa 1.1.
- Se il test di autonomia (10 h) non è chiuso: va comunque avviato in sett. 2, perché richiede una giornata intera.
