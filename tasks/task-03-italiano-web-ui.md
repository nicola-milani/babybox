# Task 3 · Italiano nella web UI

Aggiungere l'italiano alle lingue della web UI e ai messaggi di log visibili all'utente, con il meccanismo di traduzione già presente in ESPuino. Si può fare subito, senza hardware.

**Dove mettere le mani (verificato su ESPuino 3.1):**
- Web UI: `html/locales/` contiene `de.json`, `en.json`, `fr.json` → aggiungere `it.json`.
- Messaggi di log: `src/LogMessages_DE.cpp` / `_EN` / `_FR` e `src/logmessages.h` → aggiungere `LogMessages_IT.cpp`.
- Poi `#define LANGUAGE IT` in `firmware/config/settings-override.h` (adesso è `EN` apposta: senza il file italiano non compila).

## Accettazione
- [ ] Ogni testo delle pagine è in italiano
- [ ] Traduzione proposta al progetto originale con una pull request (aprirla basta per la 1.0)
