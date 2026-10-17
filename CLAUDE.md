# Contesto per Claude Code

Progetto: box audio NFC per bambini dai 2 anni, firmware = fork di ESPuino (PlatformIO, ESP32-S3 DevKitC-1 N16R8).
Lingua del progetto: italiano (commenti, documentazione, messaggi della web UI).

## Dove trovare le cose
- Specifiche complete: `docs/specifiche.md`
- Pin: `hardware/pinout.md` (unica fonte di verità per i GPIO)
- Task firmware: `tasks/task-0N-*.md` — ognuno ha "Accettazione": **scrivi prima i test/verifiche di accettazione, poi il codice**.
- Piano e scadenze: `PIANO_DI_LAVORO.md`

## Regole del fork
- Il codice ESPuino vive in `firmware/ESPuino/` (submodule del nostro fork). Branch `main` allineato periodicamente al master di ESPuino.
- Personalizzazioni SOLO nei file di configurazione di ESPuino (impostazioni generali e file della scheda) e in moduli nuovi. Il core si tocca solo se indispensabile, e in quel caso con commit piccolo e separato, motivato nel messaggio.
- Commit piccoli e atomici, un argomento per commit.
- Opzioni da abilitare: `RFID_READER_TYPE_PN5180`, `PN5180_ENABLE_LPCD`, `PAUSE_WHEN_RFID_REMOVED`, `SAVE_PLAYPOS_BEFORE_SHUTDOWN`, `SAVE_PLAYPOS_WHEN_RFID_CHANGE`, `MEASURE_BATTERY_VOLTAGE`, `SD_MMC_1BIT_MODE`.

## Vincoli che non si negoziano
- Volume massimo limitato da firmware: il cursore tutto a destra vale il limite impostato dai genitori, mai di più.
- Nessuna funzione a pressione lunga o combinazione di tasti per il bambino.
- Il display non deve mai causare salti audio (task FreeRTOS a bassa priorità, bus SPI separato dal PN5180).
- Stato del controllo genitori in memoria non volatile; ora non affidabile → regola più restrittiva.
- Evitare GPIO 35–37 (PSRAM), 0/3/45/46 (strapping, salvo il tasto genitori su GPIO0 già previsto), 19–20 (USB).
