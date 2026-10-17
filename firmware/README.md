# Firmware

Il firmware è un fork di [ESPuino](https://github.com/biologist79/ESPuino). Il codice di ESPuino NON si copia qui: si collega come submodule del nostro fork.

## Setup (una volta sola)

1. Su GitHub: fork di `biologist79/ESPuino` sul tuo account (es. `nicola/ESPuino`), branch di lavoro `main`.
2. Da questa cartella del repository:
   ```bash
   git submodule add https://github.com/<tuo-utente>/ESPuino.git firmware/ESPuino
   ```
3. In VS Code installa l'estensione **PlatformIO IDE** e apri `firmware/ESPuino` come progetto PlatformIO (o usa il workspace `boxaudiobimbo.code-workspace`).
4. Scegli/crea l'ambiente per ESP32-S3 N16R8 in `platformio.ini` (verificare gli ambienti già presenti in ESPuino per S3 con PSRAM octal).
5. Prima compilazione senza modifiche: deve passare prima di toccare qualsiasi cosa.

## Dove vanno le nostre modifiche

- **Configurazione:** solo nei file di impostazioni di ESPuino (impostazioni generali + file della scheda personalizzata; verificare nel sorgente quale profilo "custom" usa ESPuino). Una copia commentata delle nostre scelte sta in `config/`.
- **Moduli nuovi** (display e-paper, controllo genitori, export/import): in file nuovi dentro il fork, con commit separati.
- **Core:** solo se indispensabile, commit piccolo e motivato.

## Cartelle

- `config/` — le nostre impostazioni (pin + opzioni) come riferimento da riportare nel fork.
- `ESPuino/` — submodule (dopo il setup).
