# Assegnazione dei pin — ESP32-S3 DevKitC-1 N16R8

Da confermare sulla breadboard.

**Pin da evitare su questa scheda:** 33–37 (con la PSRAM **octal** della N16R8
il chip li usa tutti e cinque, non solo 35–37 come si legge in giro), 3, 45, 46
(strapping), 19–20 (USB nativa). GPIO0 è strapping ma è il tasto BOOT, e lo
usiamo apposta come tasto genitori.

**Margine:** togliendo il display erano tornati liberi sei GPIO (12–17). Due
sono già andati al LED di stato; restano 14, 15, 16 e 17 per un sensore, un
terzo tasto o il DS3231 se un domani gli servisse un pin di sveglia.

| Periferica | Segnale | GPIO | Note |
| --- | --- | --- | --- |
| MAX98357A | BCLK | 4 | |
| MAX98357A | LRC | 5 | |
| MAX98357A | DIN | 6 | |
| MAX98357A | SD (shutdown) | 18 | Basso = amplificatore spento |
| PN5180 | SCK | 8 | Bus SPI dedicato al lettore |
| PN5180 | MOSI | 9 | |
| PN5180 | MISO | 10 | |
| PN5180 | NSS | 11 | |
| PN5180 | BUSY | 41 | |
| PN5180 | RST | 48 | Su alcune DevKitC-1 è il LED RGB: verificare |
| PN5180 | IRQ | 1 | **Serve all'LPCD**: è il pin che sveglia il box quando appoggi la statuina. Deve essere un GPIO RTC (0–21) |
| LED di stato | Dati (WS2812) | 12 | Dietro la finestrella sul fronte |
| LED di stato | Alimentazione | 13 | Alto solo da svegli: un WS2812 assorbe ~1 mA anche spento |
| Liberi | — | 14, 15, 16, 17 | Erano del display e-paper, tolto il 18 ottobre |
| microSD | CLK | 39 | SD_MMC 1 bit, impostati con `setPins()` (vedi nota) |
| microSD | CMD | 38 | |
| microSD | D0 | 40 | |
| DS3231 | SDA | 43 | Pin UART0: i log passano dalla USB nativa |
| DS3231 | SCL | 44 | |
| Cursore volume | Wiper | 2 | ADC1 |
| Cursore volume | Alimentazione | 42 | Alto solo da sveglio |
| Tasto avanti | — | 21 | Pin RTC, risveglio; pull-up interno |
| Tasto indietro | — | 47 | Pull-up interno; non è un pin RTC, non sveglia (va bene) |
| Tasto genitori | — | 0 | In parallelo al tasto BOOT |
| Batteria | ADC | 7 | Partitore 100 kΩ / 100 kΩ + 100 nF |


## I pin della microSD: risolto il 18 ottobre

Non erano provvisori per scelta, ma per un problema vero: ESPuino chiama
`SD_MMC.begin()` senza `setPins()`, e sull'ESP32-S3 i pin di SD_MMC passano
dalla matrice GPIO — il core Arduino, per la variante `esp32s3`, **non ne
assegna nessuno**. Non c'erano default da adottare: senza `setPins()` la
scheda non si monta, qualunque GPIO si scelga.

Risolto con tre righe nel fork (`SdCard.cpp`, marcate `[BOX]`) che leggono
`BOX_SD_CLK/CMD/D0` dal file dei pin. 38/39/40 sono quindi definitivi, e si
cambiano da `firmware/config/settings-custom.h` come tutti gli altri.

## Verifiche sulla breadboard (spuntare quando confermato)

- [ ] GPIO48 libero (nessun LED RGB collegato) oppure spostare RST del PN5180
- [ ] SD_MMC su 38/39/40 funziona con la PSRAM octal (i pin ora sono dichiarati nel firmware)
- [ ] Log su USB nativa con UART0 occupata dal DS3231
- [ ] Partitore batteria: lettura tarata con multimetro
- [ ] Modulo microSD a 3,3 V nativo (quelli con AMS1117 + 74LVC125 non vanno)
- [ ] Regolatore 3,3 V da almeno 500 mA e bassa caduta (ME6211 / AP2112K)

Collegamento per collegamento e insidie note: [`cablaggio.md`](cablaggio.md).
