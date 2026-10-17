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

## Ambiente di compilazione (verificato il 17 ottobre 2026)

Due versioni non sono negoziabili, ed entrambe ci hanno fatto perdere tempo:

```bash
python3.12 -m venv .venv-pio                      # NON 3.13 o 3.14
.venv-pio/bin/pip install "platformio==6.1.19"    # NON 6.2.0
.venv-pio/bin/pio run -e boxstorie -d firmware/ESPuino
```

- **PlatformIO 6.1.19.** La 6.2.0 tira dentro tool-scons 4.11, che rompe il
  link di pioarduino. Lo dice la CI di ESPuino stessa, nel commento di
  `.github/workflows/firmware-builds.yml`.
- **Mai scrivere `platform = espressif32`** nel nostro ambiente, e mai fare
  `extends = env:esp32-s3-devkitc-1`. Quella riga c'è nell'ambiente S3 di
  ESPuino e scavalca la piattaforma pinnata in `[env]` (pioarduino
  55.03.311): si finisce sulla piattaforma ufficiale, il cui framework
  Arduino non ha `idf_component.yml`, quindi non nasce `managed_components/`
  e la build muore su `https_server.crt not found`. La CI di ESPuino non se
  ne accorge perché compila solo schede ESP32: l'ambiente S3 non lo prova
  nessuno. **Candidato per una pull request a monte**, insieme alla
  traduzione del task 3.

## Dove vanno le nostre modifiche

- **Configurazione:** solo nei file di impostazioni di ESPuino (impostazioni generali + file della scheda personalizzata; verificare nel sorgente quale profilo "custom" usa ESPuino). Una copia commentata delle nostre scelte sta in `config/`.
- **Moduli nuovi** (display e-paper, controllo genitori, export/import): in file nuovi dentro il fork, con commit separati.
- **Core:** solo se indispensabile, commit piccolo e motivato.

## Cartelle

- `config/` — le nostre impostazioni (pin + opzioni) come riferimento da riportare nel fork.
- `ESPuino/` — submodule (dopo il setup).
