// ============================================================
// parametri.scad — tutte le misure del progetto, in millimetri
// ------------------------------------------------------------
// Unica fonte di verità per la geometria: se cambia un
// componente, si cambia QUI e si rigenerano gli STL con
//   ./modelli-3d/genera-stl.sh
//
// Le misure marcate [VERIFICARE] vanno ricontrollate col
// calibro quando arrivano i pezzi, prima di stampare il case.
// ============================================================

// Risoluzione delle curve: 48 per lavorare, 96 per gli STL finali.
RISOLUZIONE = 64;

// ---------- Tolleranze di stampa (Kobra S2 / S3 Max, ugello 0,4) ----------
GIOCO        = 0.35;  // gioco fra due pezzi stampati che si accoppiano
GIOCO_FORO   = 0.25;  // sovramisura dei fori per i componenti
PARETE_MIN   = 1.6;   // spessore minimo di una parete portante (4 linee)

// ---------- Scocca ----------
// Scocca = pareti + coperchio in UN SOLO pezzo (si stampa capovolta).
// Il fondo è una piastra separata, avvitata dall'esterno.
BOX_X        = 130;   // larghezza
BOX_Y        = 130;   // profondità
BOX_Z        = 100;   // altezza totale, fondo compreso
PARETE       = 2.4;   // spessore pareti (3 perimetri a 0,8)
TOP_SP       = 5.0;   // spessore del coperchio (serve per il dado del tasto arcade)
RAGGIO_VERT  = 8;     // raggio degli angoli verticali (spec: >= 5)
RAGGIO_TOP   = 3;     // raccordo del bordo superiore
FONDO_SP     = 3.0;   // spessore della piastra di fondo
FONDO_INCASSO = FONDO_SP;  // il fondo è incassato e a filo con le pareti

// ---------- Vassoio di appoggio sul coperchio ----------
// Ci si appoggiano due cose diverse, e il vassoio deve accettarle entrambe:
//   - le carte delle storie, PVC formato CR80 (85,6 x 54, come una carta
//     di credito), con il tag NTAG213 dentro;
//   - i dischi della musica, stampati da noi, Ø60.
// Da qui le misure: lungo quanto una carta con un filo di gioco, largo
// quanto un disco. La carta balla 4 mm sul lato corto: è un vassoio, non
// un alloggiamento, e a due anni infilare una carta in una fessura esatta
// sarebbe una pretesa.
CARTA_X      = 85.6;  // CR80, misura standard
CARTA_Y      = 54;
CARTA_SP     = 0.84;
NFC_X_LUNG   = CARTA_X + 2.4;   // 88,0
NFC_Y_LARG   = 62;  // tanto quanto il disco più il gioco
NFC_RAGGIO   = 6;     // raccordo degli angoli del vassoio
NFC_PROF     = 3.0;   // profondità
NFC_X        = 0;     // posizione del centro (X=0 = centro scatola)
NFC_Y        = 28;    // spostato verso il retro, davanti ci stanno i comandi
NFC_TACCA_D  = 14;    // tacche sui lati lunghi per sollevare carta e disco
// Fondo del vassoio = il pezzo piatto-nfc, 2,0 mm (limite di specifica)

// ---------- Cursore volume (potenziometro a slitta B10K) ----------
CURSORE_CORSA   = 60;    // corsa utile [VERIFICARE sul pezzo]
CURSORE_LUNG    = 75;    // lunghezza totale del corpo [VERIFICARE]
CURSORE_LARG    = 9;     // larghezza del corpo [VERIFICARE]
CURSORE_ALT     = 9;     // altezza del corpo sopra il PCB [VERIFICARE]
CURSORE_LEVA_X  = 2.0;   // spessore della levetta
CURSORE_LEVA_Y  = 6.0;   // larghezza della levetta
CURSORE_FESSURA_W = 3.2; // larghezza della fessura nel coperchio
CURSORE_Y       = -16;   // posizione sul coperchio
CURSORE_Z_SOTTO = 7;     // quota del corpo del potenziometro sotto la faccia interna

// ---------- Tasti arcade ----------
// "30 mm" è il diametro del cappuccio: il foro di montaggio è 28 mm
// sui modelli con ghiera filettata. [VERIFICARE col pezzo in mano]
TASTO_FORO   = 28.0;
TASTO_CAPPUCCIO = 33;
TASTO_X      = 35;    // centri a +/- 35 -> 70 mm fra i centri
TASTO_Y      = -42;

// ---------- Display e-paper: TOLTO il 18 ottobre ----------
// Lo stato (cosa suona, batteria) si legge dalla web UI; al bambino lo dice
// la statuina che ha in mano, e la batteria scarica la annuncia a voce il box.
// Via il display: 12-18 euro, una settimana di lavoro e sei GPIO risparmiati,
// e il fronte del case resta chiuso.
// Per rimetterlo: CON_DISPLAY = true e si rigenera la scocca.
CON_DISPLAY  = false;
EPD_PCB_X    = 59.2;  // [VERIFICARE] — usati solo se CON_DISPLAY = true
EPD_PCB_Z    = 29.2;
EPD_PCB_SP   = 1.2;
EPD_FIN_X    = 50;
EPD_FIN_Z    = 25.5;
EPD_Z        = 76;
EPD_PARETE   = 1.2;

// ---------- Altoparlante ----------
ALT_D        = 40;    // diametro esterno [VERIFICARE]
ALT_ALT      = 6;     // altezza col magnete [VERIFICARE]
ALT_Z        = 48;    // quota del centro: con la finestra del display tolta,
                      // la griglia va al centro ottico della faccia
ALT_GRIGLIA_D   = 1.8; // fori della griglia (spec: <= 2 mm)
ALT_CAMERA_PROF = 12;  // profondità della camera chiusa dietro il cono
ALT_TUBO_OD     = 52;  // diametro esterno del tubo portaltoparlante
ALT_TUBO_LUNG   = 12;  // lunghezza del tubo verso l'interno
ALT_CAMERA_SEDE = 46.4;// controforo in cui si innesta la camera

// ---------- LED di stato ----------
// Un WS2812 dietro una finestrella: la parete resta, assottigliata a 0,8 mm,
// e il PETG la diffonde. Niente foro passante: non entra polvere e non si
// vede il modulo dentro.
LED_X        = 0;     // centrato sul fronte, sopra la griglia
LED_Z        = 78;
LED_FINESTRA_D = 9;   // il tondo che si illumina
LED_PARETE   = 0.8;   // quanto resta davanti al LED
LED_SEDE_D   = 12.5;  // sede del modulino, dall'interno
LED_SEDE_PROF = 4;

// ---------- Lettore PN5180 ----------
// Fissato sotto il coperchio con biadesivo + nervature di contenimento.
// Le nervature sono aperte su un lato: il modulo entra a scorrere.
PN_X         = 58;    // ingombro del modulo, lato X [VERIFICARE]
PN_Y         = 47;    // ingombro del modulo, lato Y [VERIFICARE]
PN_ALT       = 8;     // altezza totale coi componenti [VERIFICARE]

// ---------- Retro: solo la USB-C, dietro una porticina ----------
// La microSD sta dentro: si raggiunge svitando il fondo. Fuori resta la
// sola presa di ricarica, chiusa da una porticina che scorre e non si
// sfila: un tappo si perderebbe, e passerebbe dal calibro delle parti
// piccole.
USB_X        = -40;   // il foro sta a un'estremità della corsa
USB_Z        = 18;
USB_W        = 11.0;  // foro per il connettore USB-C del TP4056
USB_H        = 6.0;
SPORT_CORSA_X1 = -52; // la cava della porticina va da qui...
SPORT_CORSA_X2 = 0;   // ...a qui: 52 mm, la porticina ne occupa 24
SPORT_APERTURA = 13;  // altezza della fessura a vista
SPORT_GOLA     = 16;  // altezza della cava interna: la porticina non esce
SPORT_PROF_APE = 1.6; // profondità della fessura
SPORT_PROF_GOLA = 3.0;// profondità della cava
SPORT_PIASTRA_L = 24; // lunghezza della porticina
SPORT_SPESS    = 1.2; // spessore della porticina
SPORT_PRESA    = 2.2; // quanto sporge il bottoncino per il dito

// ---------- Fondo: interruttore, tasto genitori, vano batteria ----------
SW_X         = -40;   // interruttore a slitta da pannello
SW_Y         = -53;
SW_FORO_X    = 13.0;  // [VERIFICARE: SS12D00 o simile]
SW_FORO_Y    = 8.0;
SW_VITI      = 19.5;  // distanza fra le due viti di fissaggio
SW_INCASSO   = 1.6;   // incasso per non sporgere dal fondo

GEN_X        = 40;    // tasto genitori (tattile 6 mm), incassato
GEN_Y        = -53;
GEN_FORO_D   = 6.0;   // passa un polpastrello adulto, non la mano di un bimbo
GEN_POZZO_D  = 11;    // pozzetto di incasso
GEN_POZZO_H  = 1.8;

// Portabatteria con l'asse lungo su Y, sul lato destro: la basetta
// millefori gli passa sopra senza toccarlo.
// Come sta ferma la cella. Su Amazon le 18650 nude si trovano male (la
// vendita di celle sfuse e' limitata) e quasi tutto quello che si trova e'
// un pacco gia' precablato con fili e connettore. Vanno bene tutti e due,
// basta dirlo qui:
//
//   "portabatteria"  cella nuda dentro un supporto a molle (24 x 78 x 20)
//   "cella"          pacco precablato, tenuto dalle fascette della culla
//
// Cambiando questa riga le culle nei due gusci si rifanno da sole.
BATT_TIPO = "portabatteria";

BATT_CELLA_D = 19.5;  // 18650 col termoretraibile, con un filo di gioco
BATT_CELLA_L = 72;    // 65 nuda, 69-70 protetta, qualcosa in piu' coi fili

BATT_HOLDER_X = BATT_TIPO == "cella" ? BATT_CELLA_D : 24;   // larghezza [VERIFICARE]
BATT_HOLDER_Y = BATT_TIPO == "cella" ? BATT_CELLA_L : 78;   // lunghezza [VERIFICARE]
BATT_HOLDER_Z = BATT_TIPO == "cella" ? BATT_CELLA_D : 20;
BATT_X        = 24;   // centro del vano batteria
BATT_Y        = 0;
SPORT_X       = 26;   // apertura dello sportellino batteria
SPORT_Y       = 72;
SPORT_PIASTRA_X = 40; // piastrina dello sportellino
SPORT_PIASTRA_Y = 82;
SPORT_SP      = 2.5;  // spessore dello sportellino
SPORT_RABBET  = 1.2;  // incasso dello sportellino (resta a filo)
SPORT_VITI_DX = 14;   // viti dello sportellino, scostamento da BATT_X
SPORT_VITI_DY = 36;
AUTOFIL_D     = 2.1;  // preforo per vite autofilettante M2,5 nel PETG

// ---------- Viti e inserti ----------
VITE_D       = 2.5;        // M2,5
VITE_FORO    = 2.8;        // passaggio della vite
VITE_TESTA_D = 5.0;        // svasatura della testa
INSERTO_D    = 3.6;        // inserto a caldo M2,5 [VERIFICARE col lotto]
INSERTO_H    = 5.0;
BOSS_D       = 7.5;        // diametro del pilastrino che ospita l'inserto
BOSS_OFF     = 6;          // distanza del pilastrino dalla parete interna

// ---------- Elettronica interna ----------
MILLEFORI_X  = 90;    // basetta millefori (90 x 70)
MILLEFORI_Y  = 70;
MILLEFORI_Z  = 28;    // quota della basetta sopra il fondo
MILLEFORI_SP = 1.6;
MILLEFORI_VITI_X = 41; // colonnine di sostegno
MILLEFORI_VITI_Y = 31;

// ---------- Statuine ----------
ST_BASE_D    = 40;    // cilindro di base
ST_BASE_H    = 8;
ST_TAG_D     = 25;    // tag NTAG213 adesivo
ST_TAG_SEDE_D = 26.4; // sede del tag, con gioco
ST_TAG_SEDE_H = 1.0;  // profondità della sede
ST_TAG_FONDO = 1.0;   // spessore sotto il tag (spec: 1 mm dal fondo)
ST_SMUSSO    = 1.5;   // smusso del bordo della base

// ---------- Vinili ----------
VIN_D        = 60;
VIN_H        = 4;
VIN_SOLCO_H  = 0.4;   // rilievo dei solchi
VIN_ETICH_D  = 24;    // etichetta centrale
VIN_RAGGIO   = 1.2;   // raccordo del bordo

// ---------- Calibro parti piccole (EN 71-1) ----------
CAL_D        = 31.7;
CAL_H_MIN    = 25.4;
CAL_H_MAX    = 57.1;

// ---------- Aggancio dei raccoglitori sulle fiancate ----------
// Due code di rondine verticali per lato, scavate nella parete: il box da
// solo resta liscio e largo 130, i raccoglitori si infilano dall'alto e
// stanno su da soli. Si stampano senza supporti perché la cava corre nella
// direzione di crescita della stampa.
CODA_INTERASSE = 60;   // distanza fra le due code, lungo Y
CODA_BOCCA     = 7;    // larghezza della cava in superficie
CODA_FONDO     = 11;   // larghezza in fondo: è questa che trattiene
CODA_PROF      = 2.6;
CODA_Z1        = 10;   // da che quota parte
CODA_Z2        = 74;   // a che quota arriva
CODA_PAD       = 3.2;  // ispessimento interno, se no la parete è troppo sottile

// ---------- Raccoglitori ----------
RACC_CARTE_N   = 6;
RACC_CARTE_PASSO = 3.4;   // spazio per carta: CR80 è 0,84, il resto è dito
RACC_DISCHI_N  = 6;
RACC_DISCHI_PASSO = 7.0;  // disco 4-5 mm più il gioco
