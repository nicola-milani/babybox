# Task 6 · Controllo genitori (M3)

Nuovo modulo che decide se il box può riprodurre, impostabile solo dalla web UI. Parte da sleep timer e blocco comandi di ESPuino; usa il DS3231, sincronizzato via NTP quando c'è WiFi.

## Regole impostabili
- Fasce orarie di riposo per giorno della settimana (es. nanna 13:00–15:30, notte 20:30–07:00).
- Storie concesse per fascia: default 1; con 0 solo messaggio.
- Modalità nanna manuale: "da adesso" per 30/60/90 minuti o fino alla mattina.
- Volume ridotto nelle fasce (es. metà del massimo: il cursore tutto a destra arriva solo lì) e dissolvenza negli ultimi 30 s della storia concessa.
- Messaggio di blocco: audio registrato dai genitori, più versioni riprodotte a caso.

## Comportamento in fascia di riposo
1. La prima carta avvia normalmente la sua storia.
2. Finita la storia → stato **Riposo bloccato**. Senza display (task 2 annullato) non c'è nessuna luna da mostrare: lo dice il messaggio registrato dai genitori, e la web UI lo segna.
3. Ogni tentativo successivo (altra carta, stessa rimessa, tasti) → messaggio a volume basso, poi sleep.
4. Togliere e rimettere la stessa carta *durante* la storia concessa non conta: riprende.
5. A fine fascia il box torna normale.
6. Una canzone (disco) conta come una storia.

## Requisiti
- Regole e stato in memoria non volatile: spegnere e riaccendere non azzera il blocco.
- Ora non affidabile (DS3231 mai sincronizzato) → regola più restrittiva, segnalata in web UI.

## Web UI: pagina "Controllo genitori"
Fasce per giorno, storie concesse, volume nelle fasce, pulsante "Nanna adesso", caricamento messaggi, ora del box.

## Accettazione
- [x] Con fascia attiva la prima storia suona completa; il secondo tentativo
      produce solo il messaggio — **verificato in logica** (`./firmware/prove.sh`).
      I 2 s vanno misurati sul box: dipendono dalla lettura della SD.
- [x] Le modifiche dal telefono valgono dal tentativo successivo — verificato
      in logica e con la pagina vera nel banco di prova
- [ ] Prova sul box: serve l'hardware (e i messaggi in `/nanna`)

## Fatto il 18 ottobre

**Il cuore** — `firmware/ESPuino/src/ControlloGenitori.{h,cpp}`: decide e basta,
senza niente di Arduino dentro. Fasce per giorno (anche quelle che scavalcano
la mezzanotte, che restano una fascia sola), storie concesse, volume ridotto,
dissolvenza sull'ultima, nanna manuale, regola più restrittiva quando l'ora non
è affidabile. **47 verifiche** in `firmware/moduli/prove/`, scritte prima del
codice: `./firmware/prove.sh`, un secondo sul Mac.

**I fili** — `ControlloGenitoriBox.{h,cpp}`: legge l'ora, salva lo stato in NVS
(così spegnere non azzera il blocco), limita il volume del player, sceglie a
caso un messaggio da `/nanna` e lo riproduce con l'annuncio di ESPuino, poi
manda il box a dormire. Agganciato in quattro punti del firmware: tag
appoggiato (`RfidCommon`), fine scaletta (`AudioPlayer`), tag tolto
(`RfidPn5180`), avvio (`main`).

**La pagina** — linguetta «Genitori» nella web UI, con l'ora del box, i
pulsanti «Nanna adesso», la tabella delle fasce per i sette giorni e le altre
impostazioni. Rotte `/genitori` (GET e POST) in `Web.cpp`.

### Cosa manca al task 6
- Prova sul box vero, quando arriva l'hardware.
- **DS3231**: ESPuino non lo supporta, usa l'RTC interno sincronizzato via NTP.
  Finché non scriviamo il modulo, dopo uno spegnimento senza WiFi l'ora non è
  affidabile e scatta la regola più restrittiva — che è il comportamento
  previsto, ma non è l'orologio che volevamo. Il punto dove innestarlo è
  segnato nel codice (`adesso()` in `ControlloGenitoriBox.cpp`).
- La dissolvenza finale: il modulo dice *quando* sfumare, il player non la fa
  ancora.
- Il **fuso orario** è una costante compilata nel firmware (`settings.h`): va
  spostato in memoria non volatile ed esposto nella pagina, altrimenti le fasce
  orarie di un box spostato di fuso restano sbagliate e il primo avvio non può
  chiederlo.
