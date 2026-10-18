# Box racconta storie open source

Box audio per bambini dai 2 anni, open source e a batteria. Si appoggia sul coperchio una **carta della storia** (PVC, formato carta di credito, con il tag NFC dentro) o un **disco della musica** stampato in 3D, e il box riproduce dalla microSD. Togliendo la carta va in pausa; rimettendola riparte da dove era rimasta. Ai lati si agganciano due raccoglitori: sei carte e sei dischi, in vista.

- **Firmware:** fork di [ESPuino](https://github.com/biologist79/ESPuino) (PlatformIO) su ESP32-S3 N16R8, con controllo genitori e italiano.
- **Hardware:** PN5180, MAX98357A, DS3231, cella 18650 sostituibile con ricarica USB-C. Nessuno schermo: lo stato si legge dalla web UI. Costo 35–50 € per box.
- **Gestione:** web UI da browser su `nomebox.local`, nessuna app.
- **Case, dischi e raccoglitori:** stampati in 3D, sorgenti parametrici nel repository. Le carte delle storie si comprano già fatte.

**Obiettivo:** versione 1.0 funzionante entro **venerdì 20 novembre 2026** → vedi [PIANO_DI_LAVORO.md](PIANO_DI_LAVORO.md).

**Per partire:** cosa comprare → [`hardware/ordine.md`](hardware/ordine.md) · come collegare →
[`hardware/cablaggio.md`](hardware/cablaggio.md) · cosa stampare →
[`modelli-3d/stampa.md`](modelli-3d/stampa.md).

## Struttura

| Cartella | Contenuto |
| --- | --- |
| `docs/` | Specifiche complete, roadmap, decisioni prese; varianti esplorate in `docs/varianti/` (v3: console da viaggio) |
| `tasks/` | Un file per task firmware (1–8), con criteri di accettazione: si passano a Claude Code uno alla volta |
| `firmware/` | Istruzioni per il fork di ESPuino e le nostre configurazioni/moduli |
| `hardware/` | Lista d'ordine (`ordine.md`), componenti (`bom.csv`), pinout, schema di cablaggio |
| `modelli-3d/` | Case, dischi, raccoglitori: sorgenti OpenSCAD parametrici + STL, istruzioni di stampa |
| `audio/` | Regole di registrazione, suoni di sistema, storie (gli MP3 non vanno su git) |
| `test/` | Checklist di verifica per milestone e test d'uso |

## Documento di progetto

La versione "viva" delle specifiche è il documento *Box racconta storie open source — Progetto*. I file in `docs/` ne sono una copia per lavorare offline e con Claude Code: se cambi qualcosa di sostanziale, aggiorna entrambi.

## Licenze

- **Firmware, script e documentazione:** GPL-3.0 (`LICENSE`), come ESPuino da cui deriva il firmware.
- **Modelli 3D:** CC BY-SA 4.0 (`modelli-3d/LICENSE`).
- **Registrazioni audio:** non stanno qui, sono di chi le ha fatte.

Dettagli e motivazioni in [LICENSE-note.md](LICENSE-note.md).
