# Task 3 · Italiano nella web UI

Aggiungere l'italiano alle lingue della web UI e ai messaggi di log visibili all'utente, con il meccanismo di traduzione già presente in ESPuino. Si può fare subito, senza hardware. La traduzione resta nel nostro fork: non si propone a monte.

**Dove mettere le mani (verificato su ESPuino 3.1):**
- Web UI: `html/locales/` contiene `de.json`, `en.json`, `fr.json` → aggiungere `it.json`.
- Messaggi di log: `src/LogMessages_DE.cpp` / `_EN` / `_FR` e `src/logmessages.h` → aggiungere `LogMessages_IT.cpp`.
- Poi `#define LANGUAGE IT` in `firmware/config/settings-override.h` (adesso è `EN` apposta: senza il file italiano non compila).

## Accettazione
- [x] Ogni testo delle pagine è in italiano — verificato caricando la web UI
      in locale: **0 etichette non tradotte su 2426**
- [x] Verifica automatica: `python3 test/verifica-traduzione.py` (chiavi,
      segnaposto, simboli dei log e specificatori printf)
- [x] Compila con `LANGUAGE IT`: il linker non segnala simboli mancanti
- [x] ~~Pull request a monte~~ — **annullato**: su questo progetto non si
      aprono pull request verso progetti altrui (decisione del 18 ottobre).
      Il ramo `italiano` resta comunque staccato da `master`, perché tiene la
      traduzione separata dalle personalizzazioni del box e rende più
      semplici gli allineamenti mensili del task 5.

## Fatto il 17-18 ottobre

Cinque file nel fork, sul ramo `italiano` staccato da `master` (così la PR
contiene solo la traduzione, senza le personalizzazioni del nostro box):

| File | Cosa |
| --- | --- |
| `html/locales/it.json` | traduzione completa di `en.json` |
| `src/LogMessages_IT.cpp` | messaggi di log |
| `src/values.h` | `#define IT 4` |
| `processHtml.py` | incorpora `it.json` nel firmware |
| `html/management.html` | «Italiano» nel selettore della lingua |

Per rivedere le pagine senza hardware: `python3 test/webui-locale/server.py`
e poi `http://localhost:8081`.
