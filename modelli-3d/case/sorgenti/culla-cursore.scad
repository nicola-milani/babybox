// ============================================================
// culla-cursore.scad — supporto del potenziometro a slitta
// ------------------------------------------------------------
// Il potenziometro appoggia nella culla, la culla si avvita in
// alto nei due pilastrini sotto al coperchio: la levetta resta
// così allineata alla fessura senza dipendere dai fori di
// fissaggio del potenziometro (che cambiano da marca a marca).
// Due fascette passanti nelle asole lo bloccano.
//
// STAMPA: appoggiata sul piano (lato aperto verso l'alto).
// ============================================================
include <../../sorgenti/libreria.scad>

culla();

CULLA_VITI_X = CURSORE_LUNG/2 + 8;      // deve coincidere con scocca.scad
PARETE_C = 2;
INT_X = CURSORE_LUNG + 1.5;
INT_Y = CURSORE_LARG + 0.8;
PROF  = CURSORE_ALT + 1.5;
TAB   = 3;                              // spessore delle alette avvitate

module culla() {
    difference() {
        union() {
            // cassetta
            translate([0, 0, -PROF/2])
                piastra(INT_X + 2*PARETE_C, INT_Y + 2*PARETE_C, PROF, 2);
            // alette di fissaggio, a filo del bordo superiore
            for (sx = [-1, 1])
                translate([sx * CULLA_VITI_X, 0, -TAB])
                    cylinder(h = TAB, d = BOSS_D + 2);
            for (sx = [-1, 1])
                translate([sx * (INT_X/2 + CULLA_VITI_X)/2, 0, -TAB])
                    cube([CULLA_VITI_X - INT_X/2, BOSS_D + 2, TAB], center = true);
        }
        // vano del potenziometro
        translate([0, 0, -PROF - 0.1])
            piastra(INT_X, INT_Y, PROF + 0.2, 1);
        // finestra sul fondo per i piedini di saldatura
        translate([0, 0, -PROF - 0.2])
            piastra(INT_X - 12, INT_Y - 3, PARETE_C + 0.4, 1);
        // fori delle viti
        for (sx = [-1, 1])
            translate([sx * CULLA_VITI_X, 0, -TAB - 0.1])
                cylinder(h = TAB + 0.2, d = VITE_FORO);
        // asole per le fascette
        for (sx = [-1, 1])
            translate([sx * (INT_X/2 - 7), 0, -PROF/2])
                cube([3.4, INT_Y + 2*PARETE_C + 2, PROF - 2.5], center = true);
    }
}
