# Lista d'ordine — **un box solo**, niente scorte

Aggiornata al 18 ottobre 2026, sera. Prezzi indicativi, IVA inclusa.

Si costruisce **un pezzo**. Le quantità qui sotto sono quelle che servono a
quel pezzo e basta: dove c'è scritto «conf. da N» è perché quel componente
non si compra sfuso, non perché ne servano N.

**La regola che decide dove si compra:** se un pezzo muore durante il
montaggio, Amazon lo rimanda in 48 ore, la Cina in dieci giorni. Alla
consegna mancano 33 giorni. Quindi **tutto quello che serve al primo
montaggio sta nella parte A**, anche la minuteria che su AliExpress
costerebbe la metà: la differenza è una ventina di euro, e un pezzo che
manca in settimana 2 ne costa molti di più.

La lista **non dipende dalla scelta fra cubo e console**: stessa elettronica,
stesso pinout, stesso firmware. Gli unici due pezzi della sola console sono
la ferrite (A13) e il TPU (C2), venti euro in tutto — si comprano comunque,
per non chiudere la porta prima di aver provato.

## A · Amazon, subito: tutto quello che serve a montarlo

| # | Cosa cercare | Q.tà | € | Note di scelta |
| --- | --- | --- | --- | --- |
| A1 | `ESP32-S3-DevKitC-1 N16R8` (16 MB flash, 8 MB PSRAM **octal**) | 1 | 12–20 | Verificare la sigla **N16R8**: N8R2 e N8R8 hanno meno flash, e la PSRAM octal serve a ESPuino. Prendere il modello coi pin già saldati |
| A2 | `PN5180 NFC modulo ISO15693 SPI` con antenna sul PCB | 1 | 9–14 | È l'unico lettore che fa il risveglio all'appoggio (LPCD). Deve avere i sei segnali SCK/MOSI/MISO/NSS/BUSY/RST. Il case è disegnato su un modulo da **58 × 47 × 8** |
| A3 | `Carte NFC NTAG213 PVC CR80` (85,6 × 54) | 10 | 8–14 | Sono le carte delle storie: tag già dentro, niente da incollare. Cinque servono alla 1.0, le altre sono per crescere |
| A3b | `NTAG213 adesivi 25 mm` | conf. da 20–50 | 8–12 | Solo per i dischi della musica, che stampiamo noi. NTAG213 (ISO 14443A): **non** NTAG215/216 «amiibo», non Mifare Classic |
| A4 | `MAX98357A modulo I2S amplificatore` | 1 | 6–10 | Spesso venduto in coppia. Breakout con morsettiera o pad per l'altoparlante |
| A5 | `Altoparlante 4 Ω 3 W Ø40 mm` (h ≤ 6 mm) | 1 | 6–10 | Quasi sempre in coppia. **Misurare diametro e altezza appena arriva**: il case è disegnato su Ø40 × 6 |
| A7 | `18650 Samsung 35E / LG MJ1 protetta` 3000–3500 mAh | 1 | 8–14 | Venditore serio, non celle «9900 mAh» |
| A8 | `TP4056 USB-C con protezione DW01` (6 pin) | conf. da 5 | 6–9 | La versione a 6 pin ha la protezione scarica/cortocircuito. **USB-C**, non micro-USB |
| A9 | `Potenziometro a slitta B10K corsa 60 mm` | 1 | 6–10 | Lineare (B), non logaritmico. **Misurare corpo e levetta appena arriva** |
| A10 | `Pulsanti arcade 30 mm` a bassa forza | 2 | 6–10 | Due colori diversi: sono «indietro» e «avanti». Verificare il foro di montaggio (28 o 30 mm) |
| A11 | `MicroSD 32 GB classe 10` | 1 | 6–9 | Da formattare FAT32 |
| A12 | `Modulo microSD per Arduino` (SPI/SD_MMC) | conf. da 5 | 3–5 | Serve solo il lettore meccanico; i pin si cablano in modalità SD_MMC 1 bit |
| A13 | `Foglio ferrite NFC schermante adesivo` 60 × 60, sp. 0,3–0,5 mm | 1 | 5–9 | **Solo console v2**: va dietro l'antenna, altrimenti il lettore vede le carte nel vano sul retro e fa partire storie da solo. Cercare «ferrite sheet NFC anti-metal»; il foglio va 5–10 mm più grande della spira per lato |
| A14 | `ME6211C33` o `AP2112K-3.3` modulo LDO (500–600 mA) | conf. da 5 | 5–8 | Evitare AMS1117 (caduta 1,1 V) e HT7333 (solo 250 mA) |
| A15 | `Portabatteria 18650` contatti a molla | conf. da 2–5 | 5–7 | **Misurare**: le culle sono disegnate su 24 × 78 × 20 |
| A16 | `Interruttore a slitta da pannello SS12D00` | conf. da 5–10 | 5–7 | Incassato sul retro (console) o nel fondo (cubo) |
| A17 | `WS2812B` singolo su breakout, o striscia corta da tagliare | 1 | 6–8 | Il LED di stato. Alimentato da un GPIO, non da 3V3 fisso: spento assorbe comunque ~1 mA |
| A18 | `Micropulsante 6 × 6 mm` | conf. da 20 | 5–7 | È il tasto genitori |
| A19 | `Kit resistenze 1%` + `kit condensatori` (100 nF, 10 µF, 220 µF) | kit | 8–10 | Partitore della batteria (100 k), pull-up SD (10 k), serbatoi |
| A20 | `Basetta millefori 70 × 90 mm` doppia faccia | conf. da 5 | 6–8 | Da 70 × 90 si ricava sia la basetta del cubo sia quella della console (36 × 80) |
| A21 | `Inserti a caldo M2,5` + `viti M2,5` assortite | kit | 10–12 | Servono dal primo montaggio: senza, il case non si chiude |
| A22 | `Cavetti siliconici 26 AWG` + `connettori JST-XH 2/3 vie` | kit | 8–10 | |
| A23 | `Rete anti-polvere` + `biadesivo 3M VHB` | 1 | 5–7 | La rete va dietro la griglia dell'altoparlante |

**Totale A: circa 145–200 €.**

> Il display e-paper è stato tolto dal progetto il 18 ottobre: lo stato si
> legge dalla web UI, al bambino lo dice la carta che ha in mano, e la
> batteria scarica il box la annuncia a voce. Se un domani lo si rivuole, la
> voce era `Waveshare e-Paper 2.13" 250x122 SPI`.

## B · AliExpress: quello che può arrivare in settimana 3

Niente di qui blocca il montaggio. Se arriva tardi, il box funziona lo stesso.

| # | Cosa cercare | Q.tà | € |
| --- | --- | --- | --- |
| B1 | `DS3231 modulo RTC` (con pila CR2032) | 1 | 2 |
| B9 | `Viti di sicurezza` (testa Torx pin / triwing) M2,5 × 8 | conf. da 20 | 5 |

**Totale B: circa 7 €.** Il DS3231 è un di più: ESPuino usa l'RTC interno via
NTP e il controllo genitori funziona anche senza (con l'ora non attendibile
applica la regola più restrittiva). Le viti di sicurezza chiudono il case in
settimana 4; se non arrivano si usano le M2,5 normali del kit A21.

## C · Filamento e materiali di consumo

- **C1 — PETG bianco, 1 kg** (~25 €). Un corpo ne usa 150 g scarsi. Bianco
  perché è il colore del progetto: i comandi colorati sono pezzi comprati.
- **C2 — TPU 95A, 500 g** (~15 €). Solo per i quattro paracolpi della
  console: 20 g in tutto. Si stampa lento, 20 mm/s, retrazione a zero.
- **PLA** per provino NFC, calibro e dischi: se ce n'è già in casa basta quello.
- Stagno, flussante, termorestringente.

**Totale con filamento: circa 190–245 €.**

## Attrezzi che servono davvero

Saldatore a temperatura regolabile con punta fine (per gli inserti a caldo
serve una punta apposita, oppure la punta vecchia a 220 °C), multimetro con
misura di corrente in µA (per verificare il deep sleep < 1 mA), pinzette,
tronchesino.

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

- **Scorte di qualunque cosa.** Si fa un pezzo solo e Amazon rimanda in 48
  ore; le uniche quantità in più sono le confezioni multiple, che non si
  evitano.
- **PCB custom:** è la milestone M6, dopo il 20 novembre. Per la 1.0 si va di
  millefori.
- **RC522:** solo se il PN5180 non arriva o l'LPCD non funziona (piano B del
  piano di lavoro). Costa 3 € e si decide in settimana 2.
- **Una seconda 18650:** l'autonomia si misura prima di decidere se serve.
