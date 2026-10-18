# Task 8 · Musica e dischi (M3)

Ogni tag ha un tipo, **storia** o **musica**. I dischi usano gli stessi NTAG213 e lo stesso lettore.

| Aspetto | Storia (carta) | Musica (disco) |
| --- | --- | --- |
| Contenuto | Cartella con più tracce | Una canzone o piccola raccolta |
| Modalità di default | Audiolibro con ripresa | Riparte sempre dall'inizio |
| Opzioni | Casuale, traccia singola | Ripeti, una volta, raccolta casuale |
| Schermo | Titolo, traccia N di M | Nota musicale e titolo |
| Togliendo il tag | Pausa | Stop |

- **Caricamento in un passo:** pulsante "Nuovo disco" → appoggia il disco → scegli la canzone dal telefono. Il box crea `/musica/<titolo>/`, salva il file, crea l'associazione di tipo musica, titolo da ID3 o nome file.
- **Formati:** MP3 e AAC (M4A), fino a 20 MB.
- **Volume uniforme:** ReplayGain se presente, per allineare canzoni e storie.
- **Controllo genitori:** una canzone conta come una storia.
- **Esportazione:** "Esporta personaggio" vale anche per i vinili.

## Accettazione
- [ ] Da telefono, dal disco appena stampato alla canzone che suona: meno di 60 s
- [ ] Togliendo e rimettendo il disco la canzone riparte dall'inizio
