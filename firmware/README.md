# Firmware

Il firmware è un fork di [ESPuino](https://github.com/biologist79/ESPuino). Il codice di ESPuino NON si copia qui: si collega come submodule del nostro fork.

## Setup (una volta sola)

1. Autenticati su GitHub e lancia lo script: fa il fork e aggiunge il submodule.
   ```bash
   gh auth login          # una volta sola
   ./firmware/setup-fork.sh
   ```
   Lo script crea il fork `<tuo-utente>/ESPuino`, lo aggancia come submodule in
   `firmware/ESPuino` e gli aggiunge il remote `upstream` verso il progetto
   originale, che serve agli allineamenti mensili (task 5).
2. In VS Code installa l'estensione **PlatformIO IDE** e apri `firmware/ESPuino` come progetto PlatformIO (o usa il workspace `boxaudiobimbo.code-workspace`).
3. Scegli/crea l'ambiente per ESP32-S3 N16R8 in `platformio.ini` (verificare gli ambienti già presenti in ESPuino per S3 con PSRAM octal).
4. Prima compilazione senza modifiche: deve passare prima di toccare qualsiasi cosa.

## Dove vanno le nostre modifiche

- **Configurazione:** solo nei file di impostazioni di ESPuino (impostazioni generali + file della scheda personalizzata; verificare nel sorgente quale profilo "custom" usa ESPuino). Una copia commentata delle nostre scelte sta in `config/`.
- **Moduli nuovi** (display e-paper, controllo genitori, export/import): in file nuovi dentro il fork, con commit separati.
- **Core:** solo se indispensabile, commit piccolo e motivato.

## Cartelle

- `config/` — le nostre impostazioni (pin + opzioni) come riferimento da riportare nel fork.
- `ESPuino/` — submodule (dopo il setup).
