# Assegnazione dei pin — ESP32-S3 DevKitC-1 N16R8

Provvisoria, da confermare sulla breadboard. Evitare GPIO 35–37 (PSRAM), 0, 3, 45, 46 (strapping) e 19–20 (USB nativa).

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
| E-paper | SCK | 12 | Secondo bus SPI, separato dal PN5180 |
| E-paper | MOSI | 13 | |
| E-paper | CS | 14 | |
| E-paper | DC | 15 | |
| E-paper | RST | 16 | |
| E-paper | BUSY | 17 | |
| microSD | CLK | 39 | SD_MMC 1 bit |
| microSD | CMD | 38 | |
| microSD | D0 | 40 | |
| DS3231 | SDA | 43 | Pin UART0: i log passano dalla USB nativa |
| DS3231 | SCL | 44 | |
| Cursore volume | Wiper | 2 | ADC1 |
| Cursore volume | Alimentazione | 42 | Alto solo da sveglio |
| Tasto avanti | — | 21 | Pin RTC, risveglio; pull-up interno |
| Tasto indietro | — | 47 | Pull-up interno |
| Tasto genitori | — | 0 | In parallelo al tasto BOOT |
| Batteria | ADC | 7 | Partitore 100 kΩ / 100 kΩ + 100 nF |
| Libero | — | 1 | Riserva, ADC e RTC |

## Verifiche sulla breadboard (spuntare quando confermato)

- [ ] GPIO48 libero (nessun LED RGB collegato) oppure spostare RST del PN5180
- [ ] SD_MMC su 38/39/40 funziona con la PSRAM octal
- [ ] Log su USB nativa con UART0 occupata dal DS3231
- [ ] Partitore batteria: lettura tarata con multimetro
