# Lista operativa d'acquisto — martedì 20 ottobre

Questa è `ordine.md` con i link. I prezzi sono quelli visti il 19 ottobre
2026: cambiano, e una inserzione può sparire. Dove non ho trovato un
prodotto che valesse la pena indicare, c'è il link di **ricerca già
impostata**: quello non muore.

Regola: **parte A su Amazon** (arriva in 48 h, si rimanda indietro), **parte
B su AliExpress** filtrando i venditori con magazzino in Europa.

---

## ⚠ Prima di ordinare: l'altoparlante

Il case è disegnato su un altoparlante **Ø40 alto 6 mm**. Cercando su
Amazon.it, i «40 mm 4 Ω 3 W» che si trovano sono **alti 18–20 mm**: è il
tipo con magnete grosso, e nella console non ci sta. Il guscio anteriore è
profondo 26 mm e il tubo dell'altoparlante ne occupa 12.

Serve il tipo **ultrasottile** (quello dei tablet e dei giocattoli), che su
AliExpress si trova facilmente cercando `40mm ultra thin speaker 4ohm 3W` e
su Amazon quasi mai.

Cosa farei: prendere **quello sottile su AliExpress** e, visto che sta sul
percorso critico, **uno qualsiasi su Amazon come riserva** (6–10 €). Se
arriva solo quello alto 20 mm, il guscio si può rifare, ma nella console
mangia tutta la profondità e la camera chiusa sparisce — cioè peggiora il
suono. Meglio spendere 8 € di assicurazione.

Limite da rispettare nella scelta: **spessore totale ≤ 10 mm**, meglio 5–6.

---

## A · Amazon — ordina martedì 20

### A1 · ESP32-S3-DevKitC-1 N16R8 — 1 pezzo, 10–17 €

- [Ulegqin, singolo, ~10 €](https://www.amazon.it/Ulegqin-ESP32-S3-DevKitC-1-Bluetooth-connettore-compatibile/dp/B0G4W9KRB1)
- [iHaospace, 2 pezzi, ~17 €](https://www.amazon.it/iHaospace-ESP32-S3-DevKitC-1-N16R8-microcontroller-Bluetooth/dp/B0D1CBV999) — se vuoi la riserva sul pezzo più importante, la differenza è 7 €
- [ricerca](https://www.amazon.it/s?k=ESP32-S3-DevKitC-1+N16R8)

**Da verificare nell'inserzione:** la sigla deve essere **N16R8** (16 MB
flash, 8 MB PSRAM octal). N8R2 e N8R8 non vanno. Due prese USB-C, pin già
saldati.

### A2 · PN5180 NFC con antenna — 1 pezzo, 10–13 €

- [RAKSTORE, ~10 €](https://www.amazon.it/RAKSTORE-Modulo-Supporto-ISO15693-frequenza/dp/B0C1SXFG8Z)
- [Lonrtesw, ~12,78 €](https://www.amazon.it/Lonrtesw-Pn5180-Iso15693-Lettore-Frequenza/dp/B0DXDVTVKZ)
- [ricerca](https://www.amazon.it/s?k=PN5180+NFC+ISO15693+module)

**Da verificare:** deve arrivare con la **scheda antenna separata** (il
PCB quadrato con la spira), non solo il modulo. Pin SCK, MOSI, MISO, NSS,
BUSY, RST. Il case è disegnato su un modulo da 58 × 47 × 8 mm: misuralo
appena arriva.

### A3 · Batteria 18650 protetta — 1 pezzo, 8–14 €

- [ricerca: 18650 protetta 3500mAh](https://www.amazon.it/s?k=batteria+18650+protetta+3500mAh)
- [ricerca: Samsung 35E](https://www.amazon.it/s?k=Samsung+INR18650+35E+protetta)

Non ho messo un link diretto apposta: qui conta il venditore, non il
prezzo. **Cerca «protetta» o «protected» nel titolo** (circuito PCB sul
polo negativo, la cella è 2 mm più lunga), marca dichiarata Samsung / LG /
Sony, capacità **3000–3500 mAh**. Qualunque cosa dichiari 5000, 9900 o
12000 mAh in formato 18650 è falsa. Niente AliExpress per questa: le celle
sfuse verso l'UE spesso non partono, e il mercato è pieno di celle
riciclate rimarchiate.

### A4 · MicroSD 32 GB — 1 pezzo, 8–12 €

- [SanDisk Ultra microSDHC 32 GB](https://www.amazon.it/SanDisk-Ultra-microSDHC-100MB-SDSQUNR-032G-GN3MN/dp/B08HYDH7JF)
- [ricerca](https://www.amazon.it/s?k=SanDisk+Ultra+microSDHC+32GB)

**Venduta e spedita da Amazon**, non da terzi: è il modo più semplice di
evitare le contraffatte. Da formattare FAT32.

### A5 · Altoparlante Ø40 — 1 pezzo, 6–10 € (vedi l'avvertenza sopra)

- [ricerca Amazon: riserva](https://www.amazon.it/s?k=altoparlante+40mm+4+ohm+3W)
- [ricerca AliExpress: il sottile](https://it.aliexpress.com/w/wholesale-40mm-ultra-thin-speaker-4ohm-3w.html)

**Spessore totale ≤ 10 mm**, meglio 5–6. Misuralo col calibro appena
arriva: è uno dei cinque parametri che fanno rigenerare il case.

### A6 · MAX98357A amplificatore I2S — 1 pezzo, 7–11 €

- [AZDelivery, singolo, ~11 €](https://www.amazon.it/AZDelivery-MAX98357A-amplificatore-Breakout-applicazioni/dp/B09PL7DSK5)
- [3 pezzi, ~13 €](https://www.amazon.it/MAX98357A-Amplifier-Breakout-Decodificatore-applicazione/dp/B0F21T7Q3P)
- [ricerca](https://www.amazon.it/s?k=MAX98357A+I2S)

**Da verificare:** versione **già saldata** (alcune arrivano con i pin
sciolti). Si alimenta da VBAT, non da 3V3.

### A7 · Regolatore 3,3 V ME6211 o AP2112K — 5–8 €

- [ricerca ME6211](https://www.amazon.it/s?k=ME6211+3.3V+modulo)
- [ricerca AP2112K](https://www.amazon.it/s?k=AP2112K+3.3V+breakout)

**Evitare AMS1117** (caduta 1,1 V: con la batteria scarica il box si
spegne prima) **e HT7333** (solo 250 mA). Serve a misurare il deep sleep
sotto 1 mA, che sulla DevKit alimentata da USB non si misura.

### A8 · Portabatteria 18650 — 5–7 €

- [ricerca](https://www.amazon.it/s?k=portabatteria+18650+contatti+molla)

Tipo con contatti a molla e fili già saldati. **Misura 24 × 78 × 20**: è
quella su cui sono disegnate le culle.

### A9 · WS2812B singolo — 6–8 €

- [ricerca breakout singolo](https://www.amazon.it/s?k=WS2812B+modulo+singolo+breakout)
- [ricerca striscia da tagliare](https://www.amazon.it/s?k=WS2812B+striscia+144+LED+m)

Va bene anche un pezzo di striscia tagliato a un LED. Serve alla misura di
M2, che chiede il deep sleep **col LED alimentato**.

**Totale A: 65–95 €.**

---

## B · AliExpress — stesso giorno, filtro «magazzino Europa»

Su ogni ricerca, nei filtri scegli **Spedizione da: Spagna / Italia /
Repubblica Ceca / Polonia**: stesso prezzo, 3–7 giorni invece di 10–30.
Dove non c'è magazzino europeo, ordina lo stesso: serve dalla settimana 3.

| # | Cosa | Q.tà | € | Ricerca |
| --- | --- | --- | --- | --- |
| B1 | Carte PVC CR80 con NTAG213 | 10 | 4–7 | [cerca](https://it.aliexpress.com/w/wholesale-ntag213-card-cr80-pvc.html) |
| B2 | Adesivi NTAG213 25 mm | 20–50 | 4–6 | [cerca](https://it.aliexpress.com/w/wholesale-ntag213-sticker-25mm.html) |
| B3 | TP4056 USB-C 6 pin con DW01 | conf. 5 | 2–4 | [cerca](https://it.aliexpress.com/w/wholesale-tp4056-type-c-protection-dw01.html) |
| B4 | Potenziometro a slitta B10K corsa 60 mm | 1–2 | 2–4 | [cerca](https://it.aliexpress.com/w/wholesale-slide-potentiometer-b10k-60mm.html) |
| B5 | Pulsanti arcade 30 mm, due colori | 2 | 3–5 | [cerca](https://it.aliexpress.com/w/wholesale-arcade-button-30mm-low-force.html) |
| B6 | Modulo microSD 3,3 V | conf. 5 | 2–3 | [cerca](https://it.aliexpress.com/w/wholesale-micro-sd-card-module-3.3v.html) |
| B7 | Interruttore a slitta SS12D00 | conf. 10 | 1–3 | [cerca](https://it.aliexpress.com/w/wholesale-ss12d00-slide-switch-panel.html) |
| B8 | Foglio di ferrite NFC 60 × 60 | 1 | 2–4 | [cerca](https://it.aliexpress.com/w/wholesale-nfc-ferrite-sheet-anti-metal.html) |
| B9 | Micropulsanti 6 × 6 mm | conf. 20 | 1–2 | [cerca](https://it.aliexpress.com/w/wholesale-tactile-push-button-6x6mm.html) |
| B10 | Kit resistenze 1% + condensatori | kit | 3–5 | [cerca](https://it.aliexpress.com/w/wholesale-resistor-kit-1-percent-capacitor-kit.html) |
| B11 | Basetta millefori 70 × 90 doppia faccia | conf. 5 | 2–4 | [cerca](https://it.aliexpress.com/w/wholesale-prototype-pcb-70x90-double-side.html) |
| B12 | Inserti a caldo M2,5 + viti M2,5 | kit | 4–6 | [cerca](https://it.aliexpress.com/w/wholesale-m2.5-heat-set-insert-screw-kit.html) |
| B13 | Cavetto siliconico 26 AWG + JST-XH | kit | 3–5 | [cerca](https://it.aliexpress.com/w/wholesale-26awg-silicone-wire-jst-xh-connector.html) |
| B14 | Rete anti-polvere + biadesivo 3M VHB | 1 | 2–3 | [cerca](https://it.aliexpress.com/w/wholesale-speaker-dust-mesh-fabric.html) |
| B15 | Viti di sicurezza Torx pin M2,5 × 8 | conf. 20 | 3–5 | [cerca](https://it.aliexpress.com/w/wholesale-torx-pin-security-screw-m2.5.html) |
| B16 | DS3231 modulo RTC | 1 | 2 | [cerca](https://it.aliexpress.com/w/wholesale-ds3231-rtc-module.html) |

Attenzione su tre voci:

- **B2** deve essere **NTAG213** (ISO 14443A). Non NTAG215/216 «amiibo»,
  non Mifare Classic: il PN5180 li legge, ma il firmware è tarato su 213.
- **B3** la versione **USB-C a 6 pin**, non micro-USB: quella a 6 pin ha la
  protezione da sovrascarica.
- **B6** niente moduli con **AMS1117 + 74LVC125**: sono per 5 V e rovinano
  i livelli dell'ESP32.

**Totale B: 40–68 €.**

---

## C · Filamento — negozio o Amazon

| | | € | |
| --- | --- | --- | --- |
| C1 | PETG bianco, 1 kg | ~25 | [cerca](https://www.amazon.it/s?k=filamento+PETG+bianco+1kg+1.75mm) |
| C2 | TPU 95A, 500 g | ~15 | [cerca](https://www.amazon.it/s?k=filamento+TPU+95A+500g+1.75mm) |
| C3 | PLA per provini e dischi | avanzi | |

Dalla Cina il filamento non conviene: pesa, e la spedizione si mangia il
risparmio.

---

## Totale

| | |
| --- | --- |
| A · Amazon | 65–95 € |
| B · AliExpress | 40–68 € |
| C · filamento | ~40 € |
| **Tutto** | **145–205 €** |

## Appena arriva la parte A

1. Misura col calibro **altoparlante, PN5180, portabatteria** e aggiorna
   `modelli-3d/sorgenti/parametri.scad`.
2. `./modelli-3d/genera-stl.sh` e stampa **provino NFC** e **calibro parti
   piccole**: sono pochi grammi e servono alla prima prova.
3. Prova l'**LPCD**: è la domanda che decide il piano B, e il piano B
   (RC522) va comprato su Amazon, non in Cina.
