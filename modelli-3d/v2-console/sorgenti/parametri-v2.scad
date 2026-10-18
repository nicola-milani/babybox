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
V2_FERRITE_SP = 1.0;  // foglio di ferrite dietro l'antenna: senza, il
                      // lettore vedrebbe le carte nel vano sul retro

// ---------- comandi sul fronte ----------
V2_TASTO_X    = 62;   // sotto i pollici
V2_TASTO_Z    = 62;
V2_ALT_Z      = 58;   // altoparlante al centro
V2_LED_Z      = 88;
V2_CURSORE_Z  = 20;   // cursore in basso, lontano dai pollici

// ---------- vano della collezione, sul retro ----------
V2_VANO_X     = 96;   // ci stanno 6 carte in piedi, o 3 dischi
V2_VANO_Z     = 64;
V2_VANO_PROF  = 13;
V2_VANO_X0    = 30;   // spostato a destra: a sinistra c'è la batteria
V2_VANO_Z0    = 30;

// ---------- USB-C sul bordo inferiore ----------
V2_USB_X      = -50;
