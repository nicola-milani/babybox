# Piano di lavoro — consegna venerdì 20 novembre 2026

Partenza: sabato 17 ottobre 2026. Aggiornato **domenica 18 ottobre**: mancano
**33 giorni**, poco meno di cinque settimane.

## Cosa significa "pronto" il 20 novembre

Un box completo e funzionante (milestone M1–M5 in versione essenziale):

- case in PETG chiuso, elettronica su millefori, batteria 18650 con ricarica USB-C;
- almeno **5 statuine** con storie registrate e **3 vinili** con canzoni;
- firmware: statuine, pausa/ripresa, cursore volume, tasti, deep sleep, e-paper, web UI in italiano, controllo genitori;
- test d'uso con un bambino superato; repository pubblico con README e STL.

**Fuori dal 20 novembre** (dopo la 1.0): PCB custom, M6 kit per altre famiglie, esportazione "personaggio" in TAR se il tempo stringe.

**Non si fa:** nessuna pull request verso ESPuino o altri progetti altrui. Correzioni e traduzione restano nel fork.

## Dove siamo, in due righe

Il software è **avanti di due settimane** sul piano; l'hardware **non è ancora
partito**, perché l'ordine non è stato fatto. Tutto il rischio della consegna
si è concentrato in un punto solo: la data in cui arrivano i pezzi.

### Fatto nel fine settimana (17–18 ottobre)

| | |
| --- | --- |
| Repository | Progetto e fork di ESPuino, pubblici, con licenze (GPL-3.0 e CC BY-SA 4.0). 19 + 9 commit |
| Firmware | **Compila** per ESP32-S3 N16R8: RAM 15,1 %, flash 46,0 %, zero avvisi |
| Task 3 · italiano | **Finito** (era previsto per la settimana 1): 0 etichette non tradotte su 2426 |
| Task 6 · controllo genitori | **Software finito** (era previsto per la settimana 3): logica con 47 verifiche, innesto nel firmware, pagina web. Manca la prova sul box |
| Modelli 3D | **12 STL pronti**: case in 7 pezzi, statuina, vinile, provino NFC, calibro parti piccole |
| Progetto elettrico | Lista d'ordine, schema di cablaggio, pinout chiuso |
| Banco di prova | Verifiche che girano sul Mac in un secondo; web UI navigabile senza hardware |
| Mockup | Pagina "casa" per i genitori, provabile dal telefono |

### Non fatto, e blocca tutto

- [ ] **Ordinare i componenti** (`hardware/ordine.md`, parte A su Amazon)
- [ ] Stampare provino NFC e calibro parti piccole
- [ ] Confermare l'elenco delle 5 storie e 3 canzoni
- [ ] Installare l'estensione PlatformIO in VS Code (per compilare senza riga di comando)

## Il rischio principale: l'ordine non è ancora partito

Era il rischio numero uno del piano, e si è avverato in parte. Oggi, 18 ottobre:

- **Amazon** (parte A: scheda, lettore, tag, amplificatore, altoparlante, display, batteria, carica, cursore, tasti, microSD): ordinando lunedì 19 arrivano **mercoledì 21 o giovedì 22**. La settimana 1 si salva.
- **AliExpress** (parte B: orologio, regolatore, portabatteria, interruttore, minuteria, viti di sicurezza): 10–20 giorni, quindi **fine ottobre – inizio novembre**. In tempo per il montaggio della settimana 4, ma **non** per la breadboard: senza regolatore e portabatteria si lavora alimentando da USB.

**Se l'ordine slitta di una settimana**, M1 slitta con lui e il piano perde il
suo margine: resta la 1.0, ma senza test di autonomia e senza il secondo giro
di stampa del case.

## Settimana per settimana (riscritto)

| Settimana | Firmware (io) | Hardware / 3D (tu) | Contenuti (tu) | Uscita (gate) |
| --- | --- | --- | --- | --- |
| ~~0 · 17–18 ott~~ | ~~fork, compilazione~~ **+ task 3 e 6** | ordine **da fare** | elenco **da fare** | ✅ firmware compila |
| **1 · 19–25 ott** | Pagina "casa" vera; sfoltire la web UI; fuso orario in memoria; modulo DS3231 | **Ordine lunedì.** Stampa provino NFC, calibro, statuina, vinile. Breadboard appena arrivano i pezzi | Elenco definitivo; registrare 2 storie | **M1:** statuina → storia in meno di 1 s |
| **2 · 26 ott–1 nov** | Task 1: cursore, tasti, deep sleep, taratura batteria. Prova dell'LPCD | Alimentazione su breadboard; stampa case v1 | Altre 2 storie; suoni di sistema | **M2:** sleep < 1 mA, batteria ±3 punti. **Avviare il test di autonomia** (serve una giornata) |
| **3 · 2–8 nov** | Task 2 (e-paper); task 8 (vinili); prova sul banco del task 6 + dissolvenza | Correzioni → case v2; statuine e vinili col tag (pausa M600) | 5ª storia; 3 canzoni; messaggi della nanna | Display corretto entro 2 s; blocco nanna vero |
| **4 · 9–15 nov** | Task 7 (export/import); task 5 (allineamento ESPuino); OTA | Montaggio su millefori dentro il case; verifiche del prototipo | Normalizzazione a −16 LUFS | **M3 + M4:** statuina associata dal telefono in 30 s; verifiche superate |
| **5 · 16–20 nov** | Solo correzioni. **Freeze mercoledì 18** | Ritocchi, verniciatura EN 71-3 | — | **M5:** test con un bambino, README, release venerdì 20 |

M3 (firmware) e M4 (case) vanno in parallelo dalla settimana 2.

## Lavoro firmware rimasto, in ordine di priorità

| | Cosa | Serve hardware? | Quando |
| --- | --- | --- | --- |
| 1 | **Task 1**: cursore a slitta, tasti, deep sleep, taratura della batteria | sì | sett. 1–2 |
| 2 | **Pagina "casa"** dal mockup, e sfoltire la web UI di ESPuino | no | sett. 1 |
| 3 | **Fuso orario in memoria** (oggi è compilato nel firmware) e primo avvio | no | sett. 1 |
| 4 | **Modulo DS3231**: ESPuino non lo supporta, usa l'RTC interno via NTP | si scrive senza, si prova con | sett. 1–2 |
| 5 | **Task 2**: display e-paper | sì | sett. 3 |
| 6 | **Task 8**: tipo del tag e flusso "nuovo vinile" | in parte | sett. 3 |
| 7 | **Dissolvenza** negli ultimi 30 s: il controllo genitori la chiede già, il player non la fa | sì | sett. 3 |
| 8 | **Task 7**: esporta e importa la configurazione in JSON | no | sett. 4 |
| 9 | **Task 5**: primo allineamento col master di ESPuino | no | sett. 4 |
| 10 | **OTA**: aggiornamento dal browser | sì | sett. 4 |

## Margini e piano B

- Se il PN5180 non arriva o l'LPCD non sveglia il box: RC522 per il prototipo, senza risveglio all'appoggio. Si decide in settimana 2.
- Se l'e-paper slitta: la 1.0 esce senza display (stato via suoni), il task 2 diventa 1.1.
- Se il DS3231 non arriva in tempo: si resta sull'RTC interno con NTP. Il controllo genitori funziona lo stesso, ma un box riacceso lontano dal WiFi parte con la regola più restrittiva.
- Se il test di autonomia (10 h) non è chiuso: va comunque avviato in settimana 2, perché richiede una giornata intera.
- Se i contenuti sono in ritardo: la 1.0 può uscire con 3 storie invece di 5. È l'unico taglio che non tocca il firmware né il case.
