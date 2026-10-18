// ============================================================
// scocca.scad — pareti + coperchio in un pezzo unico
// ------------------------------------------------------------
// STAMPA: capovolta, coperchio sul piano, apertura in alto.
// Nessun supporto: tutti gli scassi sono fori passanti, i
// pilastrini hanno la punta conica e il bordo di appoggio del
// fondo è un cuneo a 45 gradi.
//
// Sistema di riferimento: origine al centro della pianta,
// z = 0 sulla faccia inferiore (dove si avvita il fondo),
// z = BOX_Z sulla faccia superiore, +Y verso il retro.
// ============================================================
include <../../sorgenti/libreria.scad>

scocca();

module scocca() {
    difference() {
        union() {
            difference() {
                scatola_arrotondata(BOX_X, BOX_Y, BOX_Z, RAGGIO_VERT, RAGGIO_TOP);
                cavita_interna();
            }
            if (CON_DISPLAY) pad_display();
            tubo_altoparlante();
        }
        tagli_coperchio();
        tagli_frontale();
        tagli_retro();
    }
    appoggio_fondo();
    pilastrini_fondo();
    nervature_pn5180();
    collare_cursore();
    bosses_cursore();
}

// ---------- cavità ----------
module cavita_interna() {
    translate([0, 0, -1])
        piastra(BOX_X - 2*PARETE, BOX_Y - 2*PARETE,
                BOX_Z - TOP_SP + 1, RAGGIO_VERT - PARETE);
}

// ---------- coperchio: zona NFC, cursore, tasti ----------
module tagli_coperchio() {
    // Foro passante a gradino per il piatto NFC:
    // Ø NFC_D per NFC_PROF dall'alto, poi Ø (NFC_D - 2*spalla) passante.
    // Il foro è passante (niente isole in stampa) e si chiude con il
    // piatto-nfc incollato: sotto lo scasso si restringe, così il piatto
    // si incastra dal basso e non può essere spinto dentro.
    translate([NFC_X, NFC_Y, BOX_Z - NFC_PROF])
        cylinder(h = NFC_PROF + 0.1, d = NFC_D + GIOCO_FORO);
    translate([NFC_X, NFC_Y, BOX_Z - TOP_SP - 0.01])
        cylinder(h = TOP_SP - NFC_PROF + 0.02,
                 d1 = NFC_D + GIOCO_FORO - 0.9, d2 = NFC_D + GIOCO_FORO);
    // tacche laterali per sollevare il vinile con un dito
    for (sx = [-1, 1])
        translate([NFC_X + sx * NFC_D/2, NFC_Y, BOX_Z - NFC_PROF])
            cylinder(h = NFC_PROF + 0.1, d = NFC_TACCA_D);
    // smusso di invito sul bordo del piatto
    translate([NFC_X, NFC_Y, BOX_Z - 0.8])
        cylinder(h = 0.9, d1 = NFC_D + GIOCO_FORO, d2 = NFC_D + GIOCO_FORO + 1.6);

    // fessura del cursore (passante)
    translate([0, CURSORE_Y, BOX_Z - TOP_SP - 0.1])
        fessura(CURSORE_CORSA + 9, CURSORE_FESSURA_W, TOP_SP + 0.2);

    // fori dei tasti arcade
    for (sx = [-1, 1])
        translate([sx * TASTO_X, TASTO_Y, BOX_Z - TOP_SP - 0.1])
            cylinder(h = TOP_SP + 0.2, d = TASTO_FORO + GIOCO_FORO);

    // icone incise sul coperchio (incise e non in rilievo perché la
    // faccia superiore è il primo strato di stampa)
    incisioni_coperchio();
}

module incisioni_coperchio() {
    prof = 0.8;
    // volume: una barretta a sinistra, tre crescenti a destra
    translate([-(CURSORE_CORSA/2 + 8.5), CURSORE_Y, BOX_Z - prof])
        icona_volume(n = 1, alt = prof + 0.1, passo = 4.4, base = 3.5, cresc = 2.5);
    translate([CURSORE_CORSA/2 + 7, CURSORE_Y, BOX_Z - prof])
        icona_volume(n = 3, alt = prof + 0.1, passo = 4.4, base = 3.5, cresc = 2.5);
    // frecce ai lati dei tasti: indietro a sinistra, avanti a destra
    translate([-(TASTO_X + TASTO_CAPPUCCIO/2 + 5.5), TASTO_Y, BOX_Z - prof])
        rotate([0, 0, 180]) freccia(lung = 11, larg = 11, alt = prof + 0.1);
    translate([TASTO_X + TASTO_CAPPUCCIO/2 + 5.5, TASTO_Y, BOX_Z - prof])
        freccia(lung = 11, larg = 11, alt = prof + 0.1);
}

// ---------- parete frontale: display e altoparlante ----------
PAD_EPD_X = EPD_PCB_X + 11;
PAD_EPD_Z = EPD_PCB_Z + 13;
PAD_EPD_SP = 5;                       // spessore aggiunto all'interno
Y_INT = -(BOX_Y/2 - PARETE);          // faccia interna della parete frontale
EPD_FONDO = 1.6;                      // cornice davanti al vetro del display

module pad_display() {
    translate([0, Y_INT + PAD_EPD_SP/2, EPD_Z])
        cube([PAD_EPD_X, PAD_EPD_SP, PAD_EPD_Z], center = true);
}

module tubo_altoparlante() {
    translate([0, Y_INT + ALT_TUBO_LUNG/2, ALT_Z]) rotate([90, 0, 0])
        cylinder(h = ALT_TUBO_LUNG, d = ALT_TUBO_OD, center = true);
}

module tagli_frontale() {
    if (CON_DISPLAY) {
        // sede del modulo e-paper, aperta verso l'interno
        prof_sede = PARETE + PAD_EPD_SP - EPD_FONDO;
        translate([0, -BOX_Y/2 + EPD_FONDO + prof_sede/2, EPD_Z])
            cube([EPD_PCB_X + 1.6, prof_sede + 0.1, EPD_PCB_Z + 1.6], center = true);
        // finestra visibile
        translate([0, -BOX_Y/2 + EPD_FONDO/2, EPD_Z])
            cava_y(EPD_FIN_X, EPD_FIN_Z, EPD_FONDO + 0.2, r = 2);
    }
    // sede dell'altoparlante, appoggiato contro la parete
    sede = ALT_ALT + 1;
    translate([0, Y_INT + sede/2 - 0.05, ALT_Z]) rotate([90, 0, 0])
        cylinder(h = sede + 0.1, d = ALT_D + GIOCO_FORO, center = true);
    // controforo in cui si innesta la camera chiusa
    translate([0, Y_INT + sede + (ALT_TUBO_LUNG - sede)/2, ALT_Z]) rotate([90, 0, 0])
        cylinder(h = ALT_TUBO_LUNG - sede + 0.2, d = ALT_CAMERA_SEDE, center = true);
    // griglia
    translate([0, -BOX_Y/2 - 0.1, ALT_Z]) rotate([-90, 0, 0])
        griglia_tonda(ALT_D - 4, PARETE + 0.4);
}

// ---------- parete di fondo: USB-C, microSD, sfiati ----------
module tagli_retro() {
    // USB-C del modulo di ricarica
    translate([USB_X, BOX_Y/2 - PARETE/2 - 0.1, USB_Z])
        cava_y(USB_W, USB_H, PARETE + 1, r = 1.2);
    // svasatura esterna per infilare il cavo senza forzare
    translate([USB_X, BOX_Y/2 - 0.6, USB_Z])
        cava_y(USB_W + 3, USB_H + 3, 1.4, r = 1.2);
    // fessura microSD
    translate([SD_X, BOX_Y/2 - PARETE/2 - 0.1, SD_Z])
        cava_y(SD_W, SD_H, PARETE + 1, r = 1.0);
    translate([SD_X, BOX_Y/2 - 0.6, SD_Z])
        cava_y(SD_W + 4, SD_H + 3, 1.4, r = 1.0);
    // sfiati dietro la batteria
    for (i = [0 : 4])
        translate([-24 + i * 12, BOX_Y/2 - PARETE/2 - 0.1, 34])
            cava_y(6, 20, PARETE + 1, r = 2);
}

// ---------- appoggio e viti del fondo ----------
BOSS_POS_X = BOX_X/2 - RAGGIO_VERT;
BOSS_POS_Y = BOX_Y/2 - RAGGIO_VERT;

module pilastrini_fondo() {
    for (sx = [-1, 1], sy = [-1, 1])
        translate([sx * BOSS_POS_X, sy * BOSS_POS_Y, FONDO_SP])
            boss_fondo(12);
}

// Cuneo perimetrale: il fondo ci appoggia sopra, la rampa a 45 gradi
// lo rende stampabile a scatola capovolta.
module appoggio_fondo() {
    lar = 3;
    alt = 5;
    difference() {
        translate([0, 0, FONDO_SP])
            hull() {
                piastra(BOX_X - 2*PARETE, BOX_Y - 2*PARETE, 0.02, RAGGIO_VERT - PARETE);
                translate([0, 0, alt])
                    piastra(BOX_X - 2*PARETE - 2*lar, BOX_Y - 2*PARETE - 2*lar,
                            0.02, max(RAGGIO_VERT - PARETE - lar, 0.6));
            }
        translate([0, 0, FONDO_SP - 0.1])
            piastra(BOX_X - 2*PARETE - 2*lar, BOX_Y - 2*PARETE - 2*lar,
                    alt + 0.2, max(RAGGIO_VERT - PARETE - lar, 0.6));
    }
}

// ---------- nervature di contenimento del PN5180 ----------
module nervature_pn5180() {
    sp = 2;
    alt = 7;
    translate([NFC_X, NFC_Y, BOX_Z - TOP_SP - alt])
        difference() {
            piastra(PN_X + 2*sp + GIOCO, PN_Y + 2*sp + GIOCO, alt, 2);
            translate([0, 0, -0.1])
                piastra(PN_X + GIOCO, PN_Y + GIOCO, alt + 0.2, 1);
            // lato aperto verso il davanti: il modulo entra a scorrere
            translate([0, -(PN_Y/2 + sp), -0.1])
                cube([PN_X - 14, 2*sp + 1, alt + 0.2], center = true);
        }
}

// ---------- cursore: collare anti-briciole e pilastrini della culla ----------
module collare_cursore() {
    sp = 2;
    alt = TOP_SP + 1;   // scende fin quasi al corpo del potenziometro
    translate([0, CURSORE_Y, BOX_Z - TOP_SP - alt])
        difference() {
            piastra(CURSORE_CORSA + 22, CURSORE_LARG + 2*sp + 3, alt, 2);
            translate([0, 0, -0.1])
                piastra(CURSORE_CORSA + 22 - 2*sp, CURSORE_LARG + 3, alt + 0.2, 1);
        }
}

CULLA_VITI_X = CURSORE_LUNG/2 + 8;    // interasse delle viti della culla

module bosses_cursore() {
    for (sx = [-1, 1])
        translate([sx * CULLA_VITI_X, CURSORE_Y, BOX_Z - TOP_SP])
            boss_soffitto(CURSORE_Z_SOTTO);
}
