# Configurazione di riferimento

I tre file che personalizzano ESPuino stanno qui e si applicano al fork con
`./firmware/applica-config.sh`:

- `platformio-override.ini` — ambiente `boxstorie` per l'ESP32-S3 N16R8
  (16 MB di flash, PSRAM octal, HAL 99, log sulla USB nativa).
- `settings-override.h` — impostazioni generali; sostituisce `settings.h`
  di ESPuino, le nostre righe sono marcate `[BOX]`.
- `settings-custom.h` — i pin, da `hardware/pinout.md`.

Com'è messo il firmware davvero, con i punti ancora aperti:
[`impostazioni-box.md`](impostazioni-box.md).
