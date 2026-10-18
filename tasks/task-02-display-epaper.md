# Task 2 · Display e-paper — ANNULLATO il 18 ottobre 2026

> Questo task non si fa. Il file resta come memoria della decisione: se un
> domani il display torna in discussione, qui c'è il perché è uscito e cosa
> ne ha preso il posto.

## Perché è stato tolto

Lo stato del box lo sanno già due canali che esistono senza schermo:

- **Il genitore** apre la web UI dal telefono: cosa sta suonando, che traccia,
  che batteria, se è in fascia di riposo.
- **Il bambino** ha in mano la statuina, e non sa leggere: l'adesivo sulla
  statuina gli dice cosa sta ascoltando meglio di qualunque titolo scritto.

Quello che restava scoperto era la **batteria scarica**, e lo copre una
funzione che ESPuino ha già: l'annuncio vocale quando la tensione scende sotto
la soglia (web UI → Generale → Batteria → «Avvisa a voce quando la batteria è
scarica», con il file in `/sistema`). Per un bambino di due anni una voce
funziona meglio di un'icona.

## Cosa si è risparmiato

| | |
| --- | --- |
| Soldi | 12–18 € per box |
| Tempo | Una settimana di lavoro (era la settimana 3) |
| Pin | Sei GPIO (12–17), e il pinout era pieno |
| Case | Niente finestra sul fronte: meno pezzi, meno polvere, stampa più semplice |
| Rischio | Cade il vincolo «il display non deve mai causare salti audio» |

## Cosa ne ha preso il posto

| Serviva a mostrare | Adesso |
| --- | --- |
| Cosa sta suonando | Web UI, pagina casa (task 9) |
| Traccia N di M | Web UI |
| Batteria | Web UI, più l'annuncio vocale di batteria scarica |
| «È ora di dormire» | Il messaggio della nanna registrato dai genitori (task 6) |
| Rete e indirizzo in setup | Pagina del primo avvio (task 9) e comando «annuncia l'indirizzo IP» |

## Se un giorno lo si rimette

Nei modelli 3D basta `CON_DISPLAY = true` in `modelli-3d/sorgenti/parametri.scad`
e rigenerare la scocca: la finestra e la sede del modulo sono ancora lì, dietro
quell'interruttore. I GPIO 12–17 sono liberi apposta.
