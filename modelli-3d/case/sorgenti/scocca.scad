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
            pad_sportello();   // ispessisce la parete dove corre la porticina
            pad_code();        // ... e dove sono scavate le code di rondine
        }
        tagli_coperchio();
        tagli_frontale();
        tagli_retro();
        tagli_fiancate();
    }
    appoggio_fondo();
    pilastrini_fondo();
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
    // Il vassoio è un foro passante (niente isole da stampare in aria) e si
    // chiude con il piatto-nfc, che entra dal basso: sotto si restringe di
    // mezzo millimetro per lato, così il piatto si incastra e non può essere
    // spinto dentro. Il PN5180 sta incollato sotto al piatto.
    lx = NFC_X_LUNG + GIOCO_FORO;
    ly = NFC_Y_LARG + GIOCO_FORO;
    translate([NFC_X, NFC_Y, BOX_Z - NFC_PROF])
        piastra(lx, ly, NFC_PROF + 0.1, NFC_RAGGIO);
    translate([NFC_X, NFC_Y, BOX_Z - TOP_SP - 0.01])
        hull() {
            piastra(lx - 0.9, ly - 0.9, 0.02, NFC_RAGGIO - 0.45);
            translate([0, 0, TOP_SP - NFC_PROF])
                piastra(lx, ly, 0.02, NFC_RAGGIO);
        }
    // tacche sui lati lunghi: con un dito si solleva la carta o il disco
    for (sy = [-1, 1])
        translate([NFC_X, NFC_Y + sy * ly/2, BOX_Z - NFC_PROF])
            cylinder(h = NFC_PROF + 0.1, d = NFC_TACCA_D);
    // smusso di invito sul bordo del vassoio
    translate([NFC_X, NFC_Y, BOX_Z - 0.9])
        hull() {
            piastra(lx, ly, 0.02, NFC_RAGGIO);
            translate([0, 0, 1.0])
                piastra(lx + 1.6, ly + 1.6, 0.02, NFC_RAGGIO + 0.8);
        }

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
    // Finestrella del LED di stato: la parete resta, assottigliata.
    translate([LED_X, -BOX_Y/2 + LED_PARETE, LED_Z])
        rotate([-90, 0, 0])
            cylinder(h = PARETE - LED_PARETE + LED_SEDE_PROF, d = LED_FINESTRA_D);
    translate([LED_X, -BOX_Y/2 + PARETE + 0.01, LED_Z])
        rotate([-90, 0, 0])
            cylinder(h = LED_SEDE_PROF, d = LED_SEDE_D);

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
// Ispessimento interno attorno alla porticina: la parete da 2,4 non basta
// a contenere una cava da 3 mm.
PAD_SPORT_SP = 3.4;

module pad_sportello() {
    lung = SPORT_CORSA_X2 - SPORT_CORSA_X1 + 12;
    translate([(SPORT_CORSA_X1 + SPORT_CORSA_X2)/2,
               BOX_Y/2 - PARETE - PAD_SPORT_SP/2, USB_Z])
        cube([lung, PAD_SPORT_SP, SPORT_GOLA + 10], center = true);
}

module tagli_retro() {
    centro = (SPORT_CORSA_X1 + SPORT_CORSA_X2) / 2;
    corsa = SPORT_CORSA_X2 - SPORT_CORSA_X1;

    // Cava della porticina: dentro è più alta della fessura a vista, così
    // la porticina resta prigioniera e non si può sfilare.
    translate([centro, BOX_Y/2 - SPORT_PROF_GOLA/2 + 0.01, USB_Z])
        cube([corsa, SPORT_PROF_GOLA, SPORT_GOLA], center = true);
    translate([centro, BOX_Y/2 - SPORT_PROF_APE/2 + 0.01, USB_Z])
        cube([corsa, SPORT_PROF_APE + 0.1, SPORT_APERTURA], center = true);

    // USB-C del modulo di ricarica, in fondo alla corsa
    translate([USB_X, BOX_Y/2 - PARETE - PAD_SPORT_SP/2, USB_Z])
        cava_y(USB_W, USB_H, PARETE + PAD_SPORT_SP + 1, r = 1.2);
    // Sfiati dietro la batteria, sopra la corsa della porticina: più in
    // basso si fonderebbero con la sua cava.
    for (i = [0 : 4])
        translate([-24 + i * 12, BOX_Y/2 - PARETE/2 - 0.1, 48])
            cava_y(6, 22, PARETE + 1, r = 2);
}

// ---------- code di rondine per i raccoglitori ----------
// La cava si allarga verso il fondo: il raccoglitore si infila dall'alto e
// non si stacca tirandolo di lato. Verticale, quindi si stampa da sola.
module pad_code() {
    for (sx = [-1, 1], sy = [-1, 1])
        translate([sx * (BOX_X/2 - PARETE - CODA_PAD/2),
                   sy * CODA_INTERASSE/2, (CODA_Z1 + CODA_Z2)/2])
            cube([CODA_PAD, CODA_FONDO + 8, CODA_Z2 - CODA_Z1 + 8], center = true);
}

module tagli_fiancate() {
    for (sx = [-1, 1], sy = [-1, 1])
        translate([sx * BOX_X/2, sy * CODA_INTERASSE/2, 0])
            rotate([0, 0, sx > 0 ? 0 : 180])
                coda_cava();
}

// Cava a sezione trapezia, aperta verso l'esterno (+X) e verso l'alto.
module coda_cava() {
    translate([-CODA_PROF, 0, CODA_Z1])
        rotate([0, 0, 0])
            linear_extrude(height = CODA_Z2 - CODA_Z1 + 40)
                polygon([[0, -CODA_FONDO/2], [0, CODA_FONDO/2],
                         [CODA_PROF + 0.2, CODA_BOCCA/2],
                         [CODA_PROF + 0.2, -CODA_BOCCA/2]]);
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
