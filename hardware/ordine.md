# Lista d'ordine — **un box solo**, due carrelli

Aggiornata al 19 ottobre 2026. Prezzi indicativi, IVA inclusa.

Si costruisce **un pezzo**. Le quantità sono quelle che servono a quel pezzo:
dove c'è scritto «conf. da N» è perché quel componente sfuso non si compra,
non perché ne servano N.

## Il criterio: cosa non può né mancare né fallire

Su AliExpress gli stessi componenti costano circa la metà, ma arrivano fra
dieci e trenta giorni e, se uno è morto, non c'è un secondo giro: alla
consegna mancano 31 giorni dall'ordine. Quindi la lista è divisa per
**conseguenza del guasto**, non per prezzo.

- **Parte A, Amazon:** i pezzi che stanno sul percorso critico delle
  settimane 1 e 2, più i due dove il rischio non è il ritardo ma la
  sicurezza e i dati. Arrivano in 48 ore e si possono rimandare indietro.
- **Parte B, AliExpress:** tutto il resto. Serve dalla settimana 3, quando
  si monta davvero. **Filtrare i venditori con magazzino in Europa**: molti
  consegnano in 3–7 giorni allo stesso prezzo.

Con la sola parte A si fanno **tutte le prove delle settimane 1 e 2**:
risveglio LPCD, audio, microSD, deep sleep col LED alimentato, taratura
della batteria, test di autonomia. Se la parte B arriva il 10 novembre, il
piano non si muove.

La lista **non dipende dalla scelta fra cubo e console**: stessa elettronica,
stesso pinout, stesso firmware. Gli unici due pezzi della sola console sono
la ferrite (B8) e il TPU (C2), una ventina di euro in tutto.

## A · Amazon, martedì 20

| # | Cosa cercare | Q.tà | € | Perché qui |
| --- | --- | --- | --- | --- |
| A1 | `ESP32-S3-DevKitC-1 N16R8` (16 MB flash, 8 MB PSRAM **octal**) | 1 | 12–20 | È il cervello: se è morto o è la sigla sbagliata, non parte niente. Verificare **N16R8**, non N8R2/N8R8 |
| A2 | `PN5180 NFC modulo ISO15693 SPI` con antenna sul PCB | 1 | 9–14 | Il pezzo più incerto del progetto: va provato in settimana 1 perché il piano B (RC522) si decide in settimana 2. Il case è disegnato su **58 × 47 × 8** |
| A3 | `18650 Samsung 35E / LG MJ1 protetta` 3000–3500 mAh | 1 | 8–14 | **Non si compra in Cina**: le celle sfuse verso l'UE spesso non partono, e il mercato è pieno di celle riciclate rimarchiate. Sta dentro un oggetto che un bambino tiene in braccio |
| A4 | `MicroSD 32 GB classe 10` | 1 | 6–9 | Le contraffatte dichiarano 32 GB e ne hanno 8: te ne accorgi quando le storie si corrompono |
| A5 | `Altoparlante 4 Ω 3 W Ø40 mm` (h ≤ 6 mm) | 1 | 6–10 | Il case è disegnato su Ø40 × 6 e le misure dichiarate in Cina sono ballerine. Qui si può rimandare indietro. **Misurarlo appena arriva** |
| A6 | `MAX98357A modulo I2S amplificatore` | 1 | 6–10 | Senza, in settimana 1 non si sente niente e metà delle prove si ferma |
| A7 | `ME6211C33` o `AP2112K-3.3` modulo LDO (500–600 mA) | conf. da 5 | 5–8 | **Serve a M2**: il deep sleep sotto 1 mA non si misura sulla DevKit alimentata da USB, perché il convertitore seriale e il suo regolatore assorbono molto di più. Evitare AMS1117 (caduta 1,1 V) e HT7333 (250 mA) |
| A8 | `Portabatteria 18650` contatti a molla | conf. da 2–5 | 5–7 | Serve al **test di autonomia** della settimana 2, e alla cella non si salda mai direttamente. **Misurare**: le culle sono disegnate su 24 × 78 × 20 |
| A9 | `WS2812B` singolo su breakout, o striscia corta da tagliare | 1 | 6–8 | M2 chiede il deep sleep **col LED alimentato**: senza, la misura non vale |

**Totale A: circa 63–100 €.**

## B · AliExpress, stesso giorno — magazzino Europa dove possibile

| # | Cosa cercare | Q.tà | € |
| --- | --- | --- | --- |
| B1 | `Carte NFC NTAG213 PVC CR80` (85,6 × 54) | 10 | 4–7 |
| B2 | `NTAG213 adesivi 25 mm` | conf. da 20–50 | 4–6 |
| B3 | `TP4056 USB-C con protezione DW01` (6 pin) | conf. da 5 | 2–4 |
| B4 | `Potenziometro a slitta B10K corsa 60 mm` | 1–2 | 2–4 |
| B5 | `Pulsanti arcade 30 mm` a bassa forza, due colori | 2 | 3–5 |
| B6 | `Modulo microSD per Arduino` (SPI/SD_MMC) | conf. da 5 | 2–3 |
| B7 | `Interruttore a slitta da pannello SS12D00` | conf. da 10 | 1–3 |
| B8 | `Foglio ferrite NFC schermante adesivo` 60 × 60, sp. 0,3–0,5 | 1 | 2–4 |
| B9 | `Micropulsante 6 × 6 mm` | conf. da 20 | 1–2 |
| B10 | `Kit resistenze 1%` + `condensatori` (100 nF, 10 µF, 220 µF) | kit | 3–5 |
| B11 | `Basetta millefori 70 × 90 mm` doppia faccia | conf. da 5 | 2–4 |
| B12 | `Inserti a caldo M2,5` + `viti M2,5` assortite | kit | 4–6 |
| B13 | `Cavetti siliconici 26 AWG` + `connettori JST-XH 2/3 vie` | kit | 3–5 |
| B14 | `Rete anti-polvere` + `biadesivo 3M VHB` | 1 | 2–3 |
| B15 | `Viti di sicurezza` (Torx pin / triwing) M2,5 × 8 | conf. da 20 | 3–5 |
| B16 | `DS3231 modulo RTC` (con pila CR2032) | 1 | 2 |

**Totale B: circa 40–68 €.**

Note di scelta:
- **B2:** NTAG213 (ISO 14443A). **Non** NTAG215/216 «amiibo», non Mifare Classic.
- **B3:** USB-C a 6 pin, non micro-USB: la versione a 6 pin ha la protezione.
- **B4:** lineare (B), non logaritmico. Misurare corpo e levetta appena arriva.
- **B6:** **non** i moduli con AMS1117 + 74LVC125, che sono per 5 V.
- **B8:** cercare «ferrite sheet NFC anti-metal»; va ritagliato 5–10 mm più
  grande della spira dell'antenna per lato.
- **B11:** da 70 × 90 si ricava sia la basetta del cubo sia quella della
  console (36 × 80).
- **B16:** opzionale. ESPuino usa l'RTC interno via NTP, e il controllo
  genitori senza ora attendibile applica la regola più restrittiva.

**Se la parte B tarda oltre il 10 novembre:** si monta lo stesso. I tasti si
simulano con un filo, il TP4056 si rimpiazza caricando la cella a parte, le
viti di sicurezza con le M2,5 del kit. L'unica cosa che non si rimpiazza
sono le carte (B1): se si vuole un paracadute, quelle si prendono su Amazon
per 8–14 € invece che per 4–7.

## C · Filamento e consumabili — negozio o Amazon

Il filamento dalla Cina non conviene: pesa, e il risparmio se lo mangia la
spedizione.

- **C1 — PETG bianco, 1 kg** (~25 €). Un corpo ne usa 150 g scarsi.
- **C2 — TPU 95A, 500 g** (~15 €). Solo per i paracolpi della console: 20 g
  in tutto. Si stampa lento, 20 mm/s, retrazione a zero.
- **PLA** per provino NFC, calibro e dischi: va bene qualsiasi avanzo.
- Stagno, flussante, termorestringente.

## Quanto viene

| | |
| --- | --- |
| A · Amazon | 63–100 € |
| B · AliExpress | 40–68 € |
| C · filamento | ~40 € |
| **Totale** | **143–208 €** |

Comprando tutto su Amazon erano 190–245 €: si risparmiano **45–55 €** senza
mettere la data in mano alla dogana.

## Attrezzi che servono davvero

Saldatore a temperatura regolabile con punta fine (per gli inserti a caldo
serve una punta apposita, o la punta vecchia a 220 °C), multimetro con
misura di corrente in µA (per il deep sleep < 1 mA), pinzette, tronchesino.

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

- **Scorte di qualunque cosa.** Si fa un pezzo solo; le uniche quantità in
  più sono le confezioni multiple, che non si evitano.
- **PCB custom:** è la milestone M6, dopo il 20 novembre. Per la 1.0 si va di
  millefori.
- **RC522:** solo se il PN5180 non arriva o l'LPCD non funziona. Costa 3 € e
  si decide in settimana 2 — **da Amazon**, perché a quel punto dalla Cina
  non si fa più in tempo.
- **Una seconda 18650:** l'autonomia si misura prima di decidere se serve.
