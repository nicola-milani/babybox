// ============================================================
// fondo.scad — piastra di fondo avvitata (4 viti di sicurezza)
// ------------------------------------------------------------
// STAMPA: faccia esterna sul piano, colonnine verso l'alto.
// Nessun supporto.
//
// Porta: interruttore generale, tasto genitori incassato,
// sportellino batteria, colonnine della basetta millefori.
// ============================================================
include <../../sorgenti/libreria.scad>

fondo();

FONDO_X = BOX_X - 2*PARETE - 2*GIOCO;
FONDO_Y = BOX_Y - 2*PARETE - 2*GIOCO;
FONDO_R = RAGGIO_VERT - PARETE - GIOCO;
BOSS_POS_X = BOX_X/2 - RAGGIO_VERT;
BOSS_POS_Y = BOX_Y/2 - RAGGIO_VERT;
MILLE_VITI_X = MILLEFORI_VITI_X;
MILLE_VITI_Y = MILLEFORI_VITI_Y;

module fondo() {
    difference() {
        union() {
            piastra(FONDO_X, FONDO_Y, FONDO_SP, FONDO_R);
            colonnine_millefori();
            bossi_sportello();
            sede_tasto_genitori();
        }
        viti_scocca();
        apertura_sportello();
        taglio_interruttore();
        foro_tasto_genitori();
    }
}

// ---------- viti verso la scocca ----------
module viti_scocca() {
    for (sx = [-1, 1], sy = [-1, 1])
        translate([sx * BOSS_POS_X, sy * BOSS_POS_Y, 0])
            foro_svasato(FONDO_SP);
}

// ---------- colonnine della basetta millefori ----------
module colonnine_millefori() {
    h = MILLEFORI_Z - FONDO_SP;
    for (sx = [-1, 1], sy = [-1, 1])
        translate([sx * MILLE_VITI_X, sy * MILLE_VITI_Y, FONDO_SP])
            difference() {
                union() {
                    cylinder(h = h, d = 7.5);
                    cylinder(h = 3, d1 = 11, d2 = 7.5);   // raccordo di base
                }
                translate([0, 0, h - 9]) cylinder(h = 9.1, d = AUTOFIL_D);
            }
}

// ---------- sportellino batteria ----------
module apertura_sportello() {
    // passaggio della cella
    translate([BATT_X, BATT_Y, -0.1])
        piastra(SPORT_X, SPORT_Y, FONDO_SP + 0.2, 4);
    // incasso della piastrina, dal lato esterno
    translate([BATT_X, BATT_Y, -0.1])
        piastra(SPORT_PIASTRA_X + 2*GIOCO, SPORT_PIASTRA_Y + 2*GIOCO,
                SPORT_RABBET + 0.1, 4);
    // fori delle viti dello sportellino
    for (sx = [-1, 1], sy = [-1, 1])
        translate([BATT_X + sx * SPORT_VITI_DX, BATT_Y + sy * SPORT_VITI_DY, -0.1])
            cylinder(h = FONDO_SP + 0.2, d = AUTOFIL_D);
}

module bossi_sportello() {
    for (sx = [-1, 1], sy = [-1, 1])
        translate([BATT_X + sx * SPORT_VITI_DX, BATT_Y + sy * SPORT_VITI_DY, FONDO_SP])
            cylinder(h = 6, d = 7);
}

// ---------- interruttore generale ----------
module taglio_interruttore() {
    translate([SW_X, SW_Y, -0.1])
        cube([SW_FORO_X, SW_FORO_Y, FONDO_SP + 0.2], center = true);
    // incasso del corpo, così non sporge dal fondo
    translate([SW_X, SW_Y, -0.1])
        cube([SW_VITI + 6, SW_FORO_Y + 6, 2*SW_INCASSO], center = true);
    for (sx = [-1, 1])
        translate([SW_X + sx * SW_VITI/2, SW_Y, -0.1])
            cylinder(h = FONDO_SP + 0.2, d = 2.4);
}

// ---------- tasto genitori ----------
module foro_tasto_genitori() {
    translate([GEN_X, GEN_Y, -0.1])
        cylinder(h = FONDO_SP + 0.2, d = GEN_FORO_D);
    translate([GEN_X, GEN_Y, -0.1])
        cylinder(h = GEN_POZZO_H + 0.1, d = GEN_POZZO_D);
}

// Nicchia quadrata che tiene in posizione il micropulsante 6x6.
// Un lato è aperto per far uscire i due fili.
module sede_tasto_genitori() {
    lato_int = 6.6;
    sp = 1.8;
    h = 3.5;
    translate([GEN_X, GEN_Y, FONDO_SP])
        difference() {
            translate([0, 0, h/2])
                cube([lato_int + 2*sp, lato_int + 2*sp, h], center = true);
            translate([0, 0, h/2 - 0.1])
                cube([lato_int, lato_int, h + 0.3], center = true);
            translate([0, -(lato_int/2 + sp/2), h/2 + 0.6])
                cube([4, sp + 0.4, h], center = true);
        }
}
