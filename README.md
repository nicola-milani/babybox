# Box racconta storie open source

Box audio per bambini dai 2 anni, open source e a batteria. Si appoggia una statuina (o un piccolo vinile stampato in 3D) con un tag NFC sul coperchio e il box riproduce la storia o la canzone dalla microSD. Togliendo la statuina va in pausa; rimettendola riparte da dove era rimasta.

- **Firmware:** fork di [ESPuino](https://github.com/biologist79/ESPuino) (PlatformIO) su ESP32-S3 N16R8, con display e-paper, controllo genitori e italiano.
- **Hardware:** PN5180, MAX98357A, e-paper 2,13", DS3231, cella 18650 sostituibile con ricarica USB-C. Costo 45–60 € per box.
- **Gestione:** web UI da browser su `nomebox.local`, nessuna app.
- **Case e statuine:** stampati in 3D, sorgenti parametrici nel repository.

**Obiettivo:** versione 1.0 funzionante entro **venerdì 20 novembre 2026** → vedi [PIANO_DI_LAVORO.md](PIANO_DI_LAVORO.md).

**Per partire:** cosa comprare → [`hardware/ordine.md`](hardware/ordine.md) · come collegare →
[`hardware/cablaggio.md`](hardware/cablaggio.md) · cosa stampare →
[`modelli-3d/stampa.md`](modelli-3d/stampa.md).

## Struttura

| Cartella | Contenuto |
| --- | --- |
| `docs/` | Specifiche complete, roadmap, decisioni prese |
| `tasks/` | Un file per task firmware (1–8), con criteri di accettazione: si passano a Claude Code uno alla volta |
| `firmware/` | Istruzioni per il fork di ESPuino e le nostre configurazioni/moduli |
| `hardware/` | Lista d'ordine (`ordine.md`), componenti (`bom.csv`), pinout, schema di cablaggio |
| `modelli-3d/` | Case, statuine e vinili: sorgenti OpenSCAD parametrici + STL, istruzioni di stampa |
| `audio/` | Regole di registrazione, suoni di sistema, storie (gli MP3 non vanno su git) |
| `test/` | Checklist di verifica per milestone e test d'uso |

## Documento di progetto

La versione "viva" delle specifiche è il documento *Box racconta storie open source — Progetto*. I file in `docs/` ne sono una copia per lavorare offline e con Claude Code: se cambi qualcosa di sostanziale, aggiorna entrambi.

## Licenza

Firmware GPL come ESPuino (verificare la versione esatta nel file LICENSE di ESPuino). Modelli 3D: proposta CC BY-SA 4.0.
