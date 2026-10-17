# Impostazioni da riportare nel fork

## Opzioni (#define da abilitare)

- `RFID_READER_TYPE_PN5180`
- `PN5180_ENABLE_LPCD`
- `PAUSE_WHEN_RFID_REMOVED`
- `SAVE_PLAYPOS_BEFORE_SHUTDOWN`
- `SAVE_PLAYPOS_WHEN_RFID_CHANGE`
- `MEASURE_BATTERY_VOLTAGE`
- `SD_MMC_1BIT_MODE`

Disabilitare: encoder rotativo (sostituito dal cursore), anello LED (sostituito dall'e-paper), salvo diversa decisione.

## Pin

Vedi `../../hardware/pinout.md`.

## Valori

- Volume massimo di default: da tarare a orecchio con l'altoparlante scelto (partire basso).
- Sleep per inattività: 10 minuti (da confermare).
- Nome host di default: `faba-cucina`.
