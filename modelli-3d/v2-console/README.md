# Console da viaggio (v2) — alternativa al cubo

Stessa elettronica, stesso firmware, forma diversa: **180 × 110 × 45 mm**, si
tiene con due mani, carte e dischi si infilano in una fessura sul bordo
superiore, la collezione sta in un vano sul retro.

Nata dal documento `docs/varianti/v3-console-da-viaggio.md` del 18 ottobre e
modellata la sera stessa, perché la stampa non era ancora partita: adesso si
può scegliere con gli STL in mano invece che con un disegno.

## Come si infila la carta — il punto che decide tutto

La carta CR80 entra **di lato corto**: dentro 44 mm dei suoi 54, fuori un
centimetro per afferrarla.

Non è un dettaglio di comodità. L'antenna di una CR80 è una spira che corre
lungo tutto il bordo della carta: infilandola a metà, metà spira resta fuori
dal campo del lettore e la lettura diventa un'incognita. Con un centimetro
fuori la spira è tutta dentro, appoggiata all'antenna del PN5180. In più la
tasca è profonda 50 mm invece di 78, e dentro un corpo alto 110 mm è la
differenza fra «ci sta» e «non ci sta nient'altro».

Il disco Ø60 usa la stessa fessura: entra 50 mm, il tag centrale arriva
davanti all'antenna.

## I pezzi

| Pezzo | Misure | Stampa |
| --- | --- | --- |
| `scocca-v2` | 180 × 112 × 26 | faccia in giù, nessun supporto |
| `retro-v2` | 180 × 110 × 19 | faccia posteriore in giù |
| `coperchio-vano` | 103 × 70 × 4 | appoggiato, ganci in alto |

Si riusano dal cubo: `pomello-cursore`, `culla-cursore`,
`camera-altoparlante`, `sportello-usb`. Le carte si comprano, i dischi si
stampano da `vinili/`.

## Scelte diverse dal cubo, e perché

**Il coperchio del vano è a scatto, non scorrevole.** Per scoprire
un'apertura da 96 mm una porticina scorrevole avrebbe bisogno di una corsa
più lunga della console. E un coperchio di 96 × 64 **non passa dal calibro
delle parti piccole** (Ø31,7): qui un pezzo removibile è sicuro, a differenza
del tappo della USB, che resta scorrevole proprio perché è piccolo.

**Serve un foglio di ferrite** dietro l'antenna: senza, il lettore vedrebbe
le carte nel vano sul retro e farebbe partire storie da solo. È la cosa più
importante da ricordare se si sceglie questa strada, e non serve al cubo.

**Il LED di stato** sta in alto a sinistra invece che al centro: la tasca
della fessura occupa tutta la parte alta della faccia.

## Cosa manca ancora, se la scegliamo

Questo è un primo giro, fatto in una sera per poter decidere. Prima di
stampare per davvero:

- [ ] **Sostegni interni**: batteria, basetta e PN5180 non hanno ancora
      colonnine né fermi. Nel cubo ci sono.
- [ ] **Verifica degli ingombri**: sulla carta non si pestano i piedi
      (fessura y 6,8–12,2, altoparlante fino a y 14,4, vano dal 32), ma va
      controllato con i componenti veri in mano.
- [ ] **Angoli in TPU**: previsti dal documento, non ancora modellati. Si
      possono fare come pezzi separati da infilare sui quattro spigoli.
- [ ] **Pulizia della fessura**: oggi la tasca è chiusa in fondo. Un bambino
      ci infila briciole, e per toglierle bisogna aprire i due gusci. Va
      deciso se farci un'uscita.
- [ ] **La prova che conta**: una CR80 inserita per 44 mm si legge? Si
      misura col provino NFC appena arriva il PN5180, in dieci minuti.

## Come si sceglie

| | Cubo (v1) | Console (v2) |
| --- | --- | --- |
| Pronto a stampare | **sì**, 13 STL verificati | 3 STL, mancano i sostegni interni |
| Gesto | appoggi la carta sul vassoio | la infili nella fessura |
| Collezione | due raccoglitori ai lati, 6+6 | vano sul retro, 6 carte o 3 dischi |
| In viaggio | i raccoglitori si sfilano e si perdono | tutto dentro |
| Sul tavolo | sta fermo, il bambino lo guarda dall'alto | va tenuto o appoggiato di piatto |
| Rischi aperti | nessuno grosso | lettura a 44 mm, briciole nella fessura |
| Componenti in più | — | ferrite (~4 €) |

Il cubo è la scelta sicura per il 20 novembre. La console è più bella da
portare in giro e più divertente da usare, ma ha due incognite che si
chiudono solo col lettore in mano.
