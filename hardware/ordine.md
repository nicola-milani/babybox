# Lista d'ordine — un box completo + ricambi

Aggiornata al 18 ottobre 2026. I prezzi sono indicativi (IVA inclusa).
Regola del piano di lavoro: **i pezzi critici su Amazon oggi**, i ricambi e la
minuteria su AliExpress (10–20 giorni, arrivano per la settimana 3).

## A · Da ordinare subito su Amazon (bloccano la settimana 1)

| # | Cosa cercare | Q.tà | € | Note di scelta |
| --- | --- | --- | --- | --- |
| A1 | `ESP32-S3-DevKitC-1 N16R8` (16 MB flash, 8 MB PSRAM **octal**) | 2 | 12–20 | La PSRAM serve a ESPuino. Verificare la sigla **N16R8**: le versioni N8R2/N8R8 hanno meno flash. Prendere il modello con i pin già saldati |
| A2 | `PN5180 NFC modulo ISO15693 SPI` con antenna sul PCB | 2 | 9–14 | È l'unico lettore che fa il risveglio all'appoggio (LPCD). Deve avere i 6 segnali SCK/MOSI/MISO/NSS/BUSY/RST |
| A3 | `Carte NFC NTAG213 PVC CR80` (85,6 × 54) | 20 | 8–14 | Sono le **carte delle storie**: si comprano già con il tag dentro, niente da incollare. Cercare «carte NFC NTAG213 stampabili» se le vuoi stampare a getto d'inchiostro |
| A3b | `NTAG213 adesivi 25 mm` | rotolo da 50 | 8–12 | Solo per i **dischi della musica**, che stampiamo noi. NTAG213 (ISO 14443A): **non** NTAG215/216 «amiibo», non Mifare Classic |
| A4 | `MAX98357A modulo I2S amplificatore` | 2 | 6–10 | Breakout con morsettiera o pad per l'altoparlante |
| A5 | `Altoparlante 4 Ω 3 W Ø40 mm` (h ≤ 6 mm) | 2 | 6–10 | **Misurare diametro e altezza appena arriva**: il case è disegnato su Ø40 × 6 |
| A7 | `18650 Samsung 35E / LG MJ1 protetta` 3000–3500 mAh | 2 | 10–18 | Comprare da venditore serio, non celle "9900 mAh" |
| A8 | `TP4056 USB-C con protezione DW01` (6 pin) | 3 | 6–9 | La versione a 6 pin ha la protezione scarica/cortocircuito. **USB-C**, non micro-USB |
| A9 | `Potenziometro a slitta B10K corsa 60 mm` | 2 | 6–10 | Lineare (B), non logaritmico. **Misurare corpo e levetta appena arriva** |
| A10 | `Pulsanti arcade 30 mm` a bassa forza | 4 | 6–10 | Due colori diversi. Verificare il foro di montaggio (28 o 30 mm) |
| A11 | `MicroSD 32 GB classe 10` | 1 | 6–9 | Da formattare FAT32 |
| A12 | `Modulo microSD per Arduino` (SPI/SD_MMC) | 2 | 3–5 | Serve solo il lettore meccanico; si cablano i pin in modalità SD_MMC 1 bit |
| A13 | `Foglio ferrite NFC schermante adesivo` 60 × 60, spessore 0,3–0,5 mm | 2 | 5–9 | **Solo per la console v2**: va dietro l'antenna, altrimenti il lettore legge le carte riposte nel vano sul retro e fa partire storie da solo. Cercare «ferrite sheet NFC anti-metal»: il foglio deve essere *più grande* della spira dell'antenna di 5–10 mm per lato |

**Totale A: circa 83–126 €** (ci sono dentro i ricambi di quasi tutto).

> Il display e-paper è stato tolto dal progetto il 18 ottobre: lo stato si
> legge dalla web UI, al bambino lo dice la carta che ha in mano e la
> batteria scarica il box la annuncia a voce. Sono 12–18 € e una settimana di
> lavoro in meno. Se un domani lo si rivuole, la voce era
> `Waveshare e-Paper 2.13" 250x122 SPI`.

## B · Su AliExpress (ricambi e minuteria, arrivo settimana 3)

| # | Cosa cercare | Q.tà | € |
| --- | --- | --- | --- |
| B1 | `DS3231 modulo RTC` (con pila CR2032) | 2 | 4 |
| B2 | `HT7333 TO-92` o `ME6211 modulo 3.3V` | 5 | 3 |
| B3 | `Portabatteria 18650 contatti a molla` | 3 | 3 |
| B4 | `Interruttore a slitta da pannello SS12D00` | 5 | 3 |
| B4b | `WS2812B` singolo su breakout, o striscia da tagliare | 5 | 3 |
| B5 | `Micropulsante 6x6 mm` | 20 | 2 |
| B6 | `Resistenze 100 kΩ 1%` + `condensatori 100 nF` | kit | 4 |
| B7 | `Basetta millefori 90 × 70 mm` doppia faccia | 5 | 6 |
| B8 | `Inserti a caldo M2,5` + `viti M2,5` assortite | kit | 8 |
| B9 | `Viti di sicurezza` (testa Torx pin / triwing) M2,5 × 8 | 20 | 5 |
| B10 | `Cavetti siliconici 26 AWG` + `connettori JST-XH 2/3 vie` | kit | 8 |
| B11 | `Biadesivo 3M VHB` + `rete anti-polvere` per la griglia | 1 | 5 |

**Totale B: circa 50 €.**

## C · Già in casa o da stampare

- Filamento **PETG** per il case (~150 g) e **PLA** per provini e dischi.
- Filamento **TPU 95A** (~20 g) solo se si sceglie la console v2: sono i quattro
  paracolpi degli angoli. Si stampano lenti, 20 mm/s, retrazione a zero.
- Stagno, flussante, termorestringente.
- Vernici atossiche **EN 71-3** se si colorano i dischi.

## Attrezzi che servono davvero

Saldatore a temperatura regolabile con punta fine (per gli inserti a caldo
serve una punta apposita o la punta vecchia a 220 °C), multimetro con misura
di corrente in µA (per verificare il deep sleep < 1 mA), pinzette, tronchesino.

## Appena arrivano i pezzi: misurare questi cinque

Il case è parametrico ma va rigenerato se qualcosa non torna. Col calibro:

| Componente | Misura da prendere | Parametro in `modelli-3d/sorgenti/parametri.scad` |
| --- | --- | --- |
| Altoparlante | diametro e altezza totale | `ALT_D`, `ALT_ALT` |
| Potenziometro | lunghezza corpo, larghezza, altezza, levetta | `CURSORE_*` |
| Tasti arcade | diametro del **foro di montaggio** | `TASTO_FORO` |
| PN5180 | ingombro del modulo con l'antenna | `PN_X`, `PN_Y`, `PN_ALT` |
| Portabatteria | larghezza × lunghezza × altezza | `BATT_HOLDER_*` |

Poi `./modelli-3d/genera-stl.sh` e si stampa.

## Cosa NON ordinare adesso

- **PCB custom:** è la milestone M6, dopo il 20 novembre. Per la 1.0 si va di
  millefori.
- **RC522:** solo se il PN5180 non arriva o non funziona (piano B del piano di
  lavoro). Costa 3 € e si decide in settimana 2, non adesso.
- **Batterie extra oltre le due:** l'autonomia si misura prima.
