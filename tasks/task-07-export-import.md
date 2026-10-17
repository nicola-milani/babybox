# Task 7 · Esportazione e importazione (M3)

Backup, sostituzione di un box rotto, passaggio di personaggi ad altre famiglie. ESPuino fa già il backup delle associazioni; noi lo estendiamo.

- **Esporta configurazione** (priorità 1.0): JSON con associazioni, titoli, modalità, impostazioni, regole del controllo genitori, nome del box.
- **Esporta personaggio** (se c'è tempo, altrimenti 1.1): TAR non compresso generato al volo, con la cartella audio della statuina e la sua associazione.
- **Esporta tutto:** la web UI spiega di copiare la microSD dal PC.
- **Importa:** caricando JSON o TAR la web UI mostra cosa cambia (nuove, sovrascritte, regole) e applica solo dopo conferma. Associazioni legate all'UID del tag.
- Numero di versione del formato nel file.

## Web UI: pagina "Backup"
Esporta configurazione, esporta personaggio, importa con anteprima.

## Accettazione
- [ ] Configurazione esportata da un box e importata su un box vuoto con la stessa microSD: statuine e regole funzionano senza altri passaggi
