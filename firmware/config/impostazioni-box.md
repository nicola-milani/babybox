# Configurazione del firmware

Verificato sul fork di **ESPuino 3.1** (commit `b157ba4`) il 17 ottobre 2026.
Parecchie cose sono cambiate rispetto a quello che davamo per scontato: qui
sotto c'è lo stato reale.

## I tre file della nostra configurazione

Stanno **qui**, non dentro il fork, e ci arrivano con `./firmware/applica-config.sh`:

| File | Dove finisce | Come |
| --- | --- | --- |
| `platformio-override.ini` | `ESPuino/platformio-override.ini` | symlink — in ESPuino è in `.gitignore`, è il punto di personalizzazione previsto |
| `settings-override.h` | `ESPuino/src/settings-override.h` | symlink — idem |
| `settings-custom.h` | `ESPuino/src/settings-custom.h` | copia — questo file è tracciato dal fork, la modifica si vede come differenza del submodule (voluto) |

Così il fork resta pulito: l'unica differenza rispetto al master di ESPuino è
il file dei pin, più il ramo `italiano` con la traduzione. Comodo per gli
allineamenti mensili (task 5).

> `settings-override.h`, quando esiste, **sostituisce del tutto** `settings.h`:
> è una copia di quello di ESPuino 3.1 con le nostre righe marcate `[BOX]`.
> Al prossimo allineamento va rigenerato dal `settings.h` nuovo e vanno
> riapplicate quelle righe. Sono 32.

## Quello che pensavamo di dover compilare, e invece no

ESPuino 3.1 ha spostato nella web UI (preferenze in NVS) quasi tutte le
opzioni della nostra lista:

| Opzione di partenza | Com'è adesso |
| --- | --- |
| `RFID_READER_TYPE_PN5180` | Non esiste più: c'è `RFID_READER_TYPE_RUNTIME` (0 = auto, 1 = MFRC522 SPI, 2 = MFRC522 I2C, 3 = PN5180). L'abbiamo messa a **3**, ma si cambia anche dalla web UI |
| `PN5180_ENABLE_LPCD` | Preferenza a runtime (`pn5180Lpcd`): si accende dalla web UI, niente ricompilazione |
| `PAUSE_WHEN_RFID_REMOVED` | Impostazione della web UI |
| `SAVE_PLAYPOS_BEFORE_SHUTDOWN` | Impostazione della web UI |
| `SAVE_PLAYPOS_WHEN_RFID_CHANGE` | Impostazione della web UI |
| `MEASURE_BATTERY_VOLTAGE` | Ancora una `#define`: attiva da noi, accende da sola `BATTERY_MEASURE_ENABLE` |
| `SD_MMC_1BIT_MODE` | Ancora una `#define`: già attiva di default |

**Conseguenza pratica:** il task 1 è più corto di quanto sembrasse. Quasi
tutto si configura dal telefono al primo avvio, e va scritto nella guida
invece che nel firmware.

## Quello che abbiamo spento (in `settings-override.h`)

- `NEOPIXEL_ENABLE` — il box non ha indicatori luminosi: lo stato si legge dalla web UI e la batteria scarica si annuncia a voce.
- `USEROTARY_ENABLE` — al posto dell'encoder c'è il cursore a slitta.
- `BLUETOOTH_ENABLE` — mangia flash e RAM, non ci serve.
- `MQTT_ENABLE`, `FTP_ENABLE`, `HEADPHONE_ADJUST_ENABLE` — non servono; l'FTP
  per di più si attiva con una combinazione di tasti, che il progetto vieta.
- **Tutte le azioni lunghe e tutte le combinazioni** dei tasti: ogni
  `BUTTON_n_LONG` e ogni `BUTTON_MULTI_nn` è `CMD_NOTHING`. È la regola "niente
  pressione lunga per il bambino", applicata dove conta davvero.

Lingua: per ora `LANGUAGE EN`. Diventa `IT` quando il task 3 aggiunge
`LogMessages_IT.cpp`; prima di allora non compilerebbe.

## Stato della compilazione (17 ottobre, verificato)

Il firmware compila per la nostra scheda: **RAM 14,8 %**, **flash 45,5 %**
della partizione app da 6,25 MB con OTA. Resta molto spazio per i moduli dei
task 2, 6 e 7.

Ci sono volute sette build. Le quattro trappole, tutte di ESPuino o della
piattaforma, nessuna del nostro box:

1. **PlatformIO 6.2.0 non va**: tira dentro tool-scons 4.11 e rompe il link.
   Serve la 6.1.19 su Python 3.12 — vedi `../README.md`.
2. **`platform = espressif32` nell'ambiente S3 di ESPuino** scavalca la
   piattaforma pinnata e fa sparire `managed_components/`: la build muore su
   `https_server.crt not found`. Il nostro ambiente eredita `[env]` e basta.
3. **L'ESP32-S3 non ha il Bluetooth Classic**: la libreria ESP32-A2DP si
   rifiuta di compilare, va esclusa con `lib_ignore` (il Bluetooth lo
   avevamo già spento, ma la libreria sta in `lib_deps`).
4. **PSRAM octal**: `custom_sdkconfig` di pioarduino viene ignorato quando il
   framework è `arduino, espidf`. Serve `sdkconfig.defaults.esp32s3`.

Le ultime tre valgono per chiunque compili ESPuino su un S3, perché la loro
CI prova solo schede ESP32. Restano nel nostro fork: su questo progetto non
si aprono pull request verso progetti altrui.

## Punti aperti, da chiudere alla prima accensione

1. ~~**Pin della microSD.**~~ **Risolto il 18 ottobre.** Si era detto che
   ESPuino usasse i default del core: non è così. Sull'ESP32-S3 i pin di
   SD_MMC passano dalla matrice GPIO e per la variante `esp32s3` il core
   **non ne assegna nessuno**, quindi senza `setPins()` la scheda non si
   monta e basta — non c'era nessun default da adottare. Risolto con tre
   righe in `src/SdCard.cpp` (marcate `[BOX]`) che leggono
   `BOX_SD_CLK/CMD/D0` da `settings-custom.h`: 38/39/40 sono definitivi.
2. **GPIO48 / LED RGB.** Su molte DevKitC-1 è il LED RGB: se c'è, RST del
   PN5180 si sposta.
3. ~~**Risveglio con la statuina (LPCD).**~~ **Chiuso il 18 ottobre, ed era
   meno grave di come l'avevamo scritto.** Nell'header dell'IDF, fuori
   dall'ESP32, `ESP_EXT1_WAKEUP_ALL_LOW` è un alias deprecato di
   `ANY_LOW` con lo stesso valore: il risveglio avrebbe funzionato lo stesso,
   l'avviso era solo rumore. Sostituito comunque con una costante scelta in
   base al chip, così la compilazione resta pulita e si legge cosa succede.
   **Resta da provare sul banco** che l'LPCD svegli davvero il box: quello
   dipende dal PN5180 e dai suoi ponticelli, non da questa riga.
4. **Log sulla USB nativa.** `ARDUINO_USB_CDC_ON_BOOT=1` è già
   nell'ambiente: da verificare che i log escano davvero, visto che UART0
   (43/44) la usa il DS3231.

## Valori da tarare col box in mano

- Volume massimo: partire basso e salire a orecchio con l'altoparlante scelto.
- Sleep per inattività: 10 minuti (da confermare).
- Nome host: `babybox-cucina`.
- Offset del partitore batteria: dalla web UI, col multimetro (task 1).
