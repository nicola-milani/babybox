// ============================================================
// parametri-v2.scad — console da viaggio (variante v2)
// ------------------------------------------------------------
// Alternativa al cubo: si tiene con due mani, carte e dischi si
// infilano in una fessura sul bordo superiore, la collezione sta
// in un vano sul retro.
//
// Le misure del cubo (parametri.scad) restano valide per tutto
// quello che non cambia: componenti, tolleranze, viti, cursore,
// tasti, altoparlante, LED. Qui c'è solo ciò che è diverso.
// ============================================================
include <../../sorgenti/parametri.scad>

// ---------- corpo ----------
V2_X         = 180;   // larghezza: due mani
V2_Z         = 110;   // altezza
V2_Y         = 45;    // spessore
V2_RAGGIO    = 10;    // raggio degli angoli, generoso: si prende e cade
V2_PARETE    = 2.4;
V2_SPLIT     = 26;    // a che profondità si dividono i due gusci (dal fronte)

// ---------- fessura ----------
// La carta entra di lato corto e ne sporge un centimetro: così la
// spira del tag, che corre lungo il bordo della CR80, finisce tutta
// davanti all'antenna. Prima l'idea era infilarla di lato lungo per
// metà, e la lettura restava un'incognita.
V2_FESS_LARG  = CARTA_X + 2.4;      // 88,0: ci passa anche il disco Ø60
V2_FESS_SPESS = 5.4;                // carta 0,84, disco 4: passa tutto
V2_SPORGE     = 10;                 // quanto resta fuori per afferrare
V2_FESS_PROF  = CARTA_Y - V2_SPORGE + 6;  // 50: tasca sotto la fessura
V2_IMBUTO     = 2.5;                // svasatura d'ingresso, per infilare al buio

// ---------- antenna e schermo ----------
V2_PN_Y       = 9;    // dove sta il PN5180, dal fronte

// ---------- comandi sul fronte ----------
V2_TASTO_X    = 67;   // sotto i pollici
V2_TASTO_Z    = 70;   // alti: sotto restano liberi i 52 mm della camera
// Altoparlante in basso e un po' a destra: sopra c'e' la tasca della
// fessura (la sua cava taglierebbe la camera acustica) e a sinistra passa
// il cursore. Fuori centro si nota appena, e il suono non cambia.
V2_ALT_X      = 32;
V2_ALT_Z      = 26;
V2_LED_Z      = 100;  // sopra il tasto sinistro
// Il cursore del volume passa sul bordo INFERIORE, non sulla faccia: sulla
// faccia, fra camera acustica e tasca, restavano 32 mm e ne servono 52.
// Sul bordo sta comodo al pollice e non si preme appoggiando la console.
V2_CURSORE_X  = -41;  // sul bordo in basso a sinistra, lontano dalla camera
V2_CURSORE_VITI = CURSORE_LUNG/2 + 4.5;   // dove si avvita la culla
V2_CURSORE_COLLARE = CURSORE_CORSA + 14;  // piu' stretto che sul cubo: il
                                          // bordo e' lungo 180 e il collare
                                          // largo non ci starebbe
V2_CURSORE_Y  = 9;    // quanto e' arretrato dal fronte
V2_CURSORE_Z  = 0;    // sul bordo inferiore

// ---------- vano della collezione, sul retro ----------
V2_VANO_X     = 96;   // ci stanno 6 carte in piedi, o 3 dischi
V2_VANO_Z     = 64;
V2_VANO_PROF  = 13;
V2_VANO_X0    = 30;   // spostato a destra: a sinistra c'è la batteria
V2_VANO_Z0    = 30;

// ---------- USB-C sul bordo inferiore ----------
// Sotto il vano, non sotto la batteria: li' c'e' posto per il TP4056.
V2_USB_X      = 20;

// ---------- disposizione interna ----------
// La batteria sta in orizzontale in basso a sinistra, a cavallo dei due
// gusci: da sola la meta' posteriore e' profonda 16,6 mm e il
// portabatteria ne vuole 20. Le culle la tengono da entrambe le parti,
// che per una versione da viaggio e' anche meglio.
// In orizzontale il portabatteria (78 mm) non ci starebbe: fra la parete
// sinistra e il vano della collezione ce ne sono 70. Quindi va in piedi.
V2_BATT_X     = -70;
V2_BATT_Z     = 55;
V2_BATT_Y     = 32;    // a cavallo dello stacco (26): la culla e' divisa

V2_BASETTA_X  = 36;    // stretta: ci sta la DevKitC-1 (63 x 25) per il verso
V2_BASETTA_Z  = 80;    // lungo, con una decina di millimetri per i fili
V2_BASETTA_CX = -38;   // fra la batteria e il vano
V2_BASETTA_CZ = 55;
V2_BASETTA_Y  = 6;     // quanto sta sollevata dal fondo del guscio posteriore

V2_TP_X       = 20;    // modulo di ricarica, allineato alla presa
V2_TP_Z       = 13;

// ---------- ferrite ----------
V2_FERRITE_X  = 60;    // ritagliata piu' grande della spira dell'antenna
V2_FERRITE_Z  = 50;
V2_FERRITE_SP = 0.5;
