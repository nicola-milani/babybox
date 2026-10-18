# Task 9 · Pagina "casa" per i genitori

Nato dall'osservazione del 18 ottobre: la web UI di ESPuino ha 155 campi e 11
linguette, ed è fatta per chi costruisce il box, non per chi mette a letto un
bambino. Sei funzioni intere (LED, encoder, Bluetooth, MQTT, FTP, cuffie) sono
mostrate anche se il nostro firmware le ha spente.

**Mockup già pronto e provabile:** `python3 test/webui-locale/server.py`, poi
`http://localhost:8081/casa`. Da lì si copia struttura, testi e gesti.

## Due interventi, indipendenti

### 9a · Sfoltire la web UI di ESPuino
Far sparire dalla pagina ciò che il firmware ha spento, usando il meccanismo
`data-visible` che ESPuino già usa per MQTT e FTP. Da 11 linguette a sei.

### 9b · La pagina "casa"
Nuova pagina servita su `/`, pensata per il telefono: in alto il coperchio
disegnato con lo stato reale (cosa suona, batteria, WiFi, ora), sotto quattro
azioni — **nuova carta**, **nuovo disco**, **nanna**, **carica storie** —
e in fondo un link discreto alle impostazioni avanzate, che restano quelle di
ESPuino.

Serve anche la **prima accensione**: scelta del WiFi, nome del box, lingua,
fuso orario, ora. ESPuino ha già la pagina dell'access point: va rivestita.

## Fatto il 18 ottobre: come si entra in configurazione fuori casa

ESPuino apre già la propria rete all'accensione **se nessuna rete conosciuta
è a portata**, con captive portal: fuori casa funziona da solo. Due buchi
però c'erano, e sono chiusi:

- la rete si chiudeva dopo 5 minuti (`ApTimeout`, impostabile dalla web UI);
- una volta chiusa non si riapriva più senza spegnere e riaccendere, perché
  l'access point partiva solo al primo tentativo dopo l'avvio.

Adesso una **pressione lunga sul tasto genitori** (sul fondo, incassato)
chiama `Wlan_ForceAccessPoint()` e apre la rete in qualunque momento, anche
col WiFi di casa a portata. Il box lo dice a voce con
`/sistema/modalita-configurazione.mp3` e lo segnala col LED: senza display
non c'è altro modo di accorgersene.

## Vincoli
- **Niente risorse da internet**: caratteri, stili e immagini stanno sul box.
  I caratteri vanno ritagliati con `pyftsubset` (nel mockup: 36 KB in tutto).
- Bersagli da toccare con una mano sola, mai sotto i 3,5 rem.
- Scura di partenza: si usa alle 7 del mattino e alle 20:30.

## Accettazione
- [ ] Una carta nuova si associa dal telefono in meno di 30 s
- [ ] Un disco nuovo suona in meno di 60 s
- [ ] La pagina si apre e funziona con il telefono collegato alla rete del box,
      senza internet
- [ ] Un genitore che non ha mai visto il box arriva in fondo al primo avvio
      senza chiedere aiuto
