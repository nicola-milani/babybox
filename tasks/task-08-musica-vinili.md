# Task 8 · Musica e vinili (M3)

Ogni tag ha un tipo, **storia** o **musica**. I vinili usano gli stessi NTAG213 e lo stesso lettore.

| Aspetto | Storia (statuina) | Musica (vinile) |
| --- | --- | --- |
| Contenuto | Cartella con più tracce | Una canzone o piccola raccolta |
| Modalità di default | Audiolibro con ripresa | Riparte sempre dall'inizio |
| Opzioni | Casuale, traccia singola | Ripeti, una volta, raccolta casuale |
| Schermo | Titolo, traccia N di M | Nota musicale e titolo |
| Togliendo il tag | Pausa | Stop |

- **Caricamento in un passo:** pulsante "Nuovo vinile" → appoggia il vinile → scegli la canzone dal telefono. Il box crea `/musica/<titolo>/`, salva il file, crea l'associazione di tipo musica, titolo da ID3 o nome file.
- **Formati:** MP3 e AAC (M4A), fino a 20 MB.
- **Volume uniforme:** ReplayGain se presente, per allineare canzoni e storie.
- **Controllo genitori:** una canzone conta come una storia.
- **Esportazione:** "Esporta personaggio" vale anche per i vinili.

## Accettazione
- [ ] Da telefono, dal vinile appena stampato alla canzone che suona: meno di 60 s
- [ ] Togliendo e rimettendo il vinile la canzone riparte dall'inizio
