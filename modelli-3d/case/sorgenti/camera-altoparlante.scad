// ============================================================
// camera-altoparlante.scad — camera chiusa dietro il cono
// ------------------------------------------------------------
// Si innesta nel controforo del tubo portaltoparlante: blocca
// l'altoparlante contro la parete, chiude la camera acustica e
// tiene il magnete lontano dall'antenna NFC.
// Incollare con silicone o colla a caldo (serve tenuta d'aria).
//
// STAMPA: fondo chiuso sul piano, apertura verso l'alto.
// ============================================================
include <../../sorgenti/libreria.scad>

camera();

INNESTO_D = ALT_CAMERA_SEDE - 0.4;
INNESTO_H = 5;
PARETE_C  = 2;

module camera() {
    difference() {
        union() {
            // corpo della camera
            cylinder(h = ALT_CAMERA_PROF, d = ALT_TUBO_OD);
            // innesto nel controforo del tubo
            translate([0, 0, -INNESTO_H])
                cylinder(h = INNESTO_H + 0.1, d = INNESTO_D);
        }
        // volume interno
        translate([0, 0, -INNESTO_H + PARETE_C])
            cylinder(h = ALT_CAMERA_PROF + INNESTO_H, d = INNESTO_D - 2*PARETE_C);
        // passaggio dei due fili, sul bordo dell'innesto
        translate([INNESTO_D/2 - 1, 0, -INNESTO_H - 0.1])
            cylinder(h = INNESTO_H + 1, d = 3.2);
    }
}
