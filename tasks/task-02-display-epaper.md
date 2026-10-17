# Task 2 · Modulo display e-paper (M3)

Unico modulo davvero nuovo. GxEPD2 su bus SPI separato dal PN5180, task FreeRTOS a bassa priorità.

- Legge lo stato (player, titolo, volume, batteria, WiFi) senza modificare la logica del resto.
- Schermate: **Riposo** ("Appoggia un personaggio" + batteria), **In riproduzione** (titolo, traccia N di M, volume, batteria), **Setup** (rete, indirizzo pagina, QR code), **Batteria scarica**, **Spento**; per la musica nota musicale + titolo (task 8); luna + "È ora di dormire" in riposo bloccato (task 6).
- Aggiorna solo quando cambia qualcosa; refresh parziale per volume e traccia, completo ogni 20 aggiornamenti.
- Titolo dal tag ID3 del primo file o dal nome della cartella; font con lettere accentate.
- Prima del deep sleep disegna sempre Riposo o Spento.

## Accettazione
- [ ] Nessun salto audio durante l'aggiornamento
- [ ] Lo schermo corrisponde allo stato reale entro 2 s
