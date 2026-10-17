# Task 6 · Controllo genitori (M3)

Nuovo modulo che decide se il box può riprodurre, impostabile solo dalla web UI. Parte da sleep timer e blocco comandi di ESPuino; usa il DS3231, sincronizzato via NTP quando c'è WiFi.

## Regole impostabili
- Fasce orarie di riposo per giorno della settimana (es. nanna 13:00–15:30, notte 20:30–07:00).
- Storie concesse per fascia: default 1; con 0 solo messaggio.
- Modalità nanna manuale: "da adesso" per 30/60/90 minuti o fino alla mattina.
- Volume ridotto nelle fasce (es. metà del massimo: il cursore tutto a destra arriva solo lì) e dissolvenza negli ultimi 30 s della storia concessa.
- Messaggio di blocco: audio registrato dai genitori, più versioni riprodotte a caso.

## Comportamento in fascia di riposo
1. La prima statuina avvia normalmente la sua storia.
2. Finita la storia → stato **Riposo bloccato**: luna e "È ora di dormire".
3. Ogni tentativo successivo (altra statuina, stessa rimessa, tasti) → messaggio a volume basso, poi sleep.
4. Togliere e rimettere la stessa statuina *durante* la storia concessa non conta: riprende.
5. A fine fascia il box torna normale.
6. Una canzone (vinile) conta come una storia.

## Requisiti
- Regole e stato in memoria non volatile: spegnere e riaccendere non azzera il blocco.
- Ora non affidabile (DS3231 mai sincronizzato) → regola più restrittiva, segnalata in web UI.

## Web UI: pagina "Controllo genitori"
Fasce per giorno, storie concesse, volume nelle fasce, pulsante "Nanna adesso", caricamento messaggi, ora del box.

## Accettazione
- [ ] Con fascia attiva la prima storia suona completa; il secondo tentativo produce solo il messaggio entro 2 s
- [ ] Le modifiche dal telefono valgono dal tentativo successivo, senza toccare il box
