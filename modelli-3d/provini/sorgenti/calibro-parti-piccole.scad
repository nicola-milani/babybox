// ============================================================
// calibro-parti-piccole.scad — cilindro EN 71-1
// ------------------------------------------------------------
// Strumento di verifica, non fa parte del box: se un pezzo
// (una statuina, un orecchio staccato, un pomello) entra tutto
// nel cilindro, per la norma sui giocattoli è una "parte
// piccola" e non va bene sotto i 3 anni.
// Ø interno 31,7 mm, fondo inclinato da 25,4 a 57,1 mm.
//
// STAMPA: in piedi, nessun supporto (il fondo è a 45 gradi).
// ============================================================
include <../../sorgenti/libreria.scad>

H_EST = CAL_H_MAX + 3;

calibro();

module calibro() {
    difference() {
        union() {
            cylinder(h = H_EST, d = CAL_D + 8);
            cylinder(h = 4, d = CAL_D + 20);        // base d'appoggio
        }
        cavita();
        translate([0, (CAL_D + 20)/2 - 0.4, 2])
            rotate([90, 0, 0]) scritta("31,7", dim = 5, alt = 0.8);
    }
}

module cavita() {
    difference() {
        translate([0, 0, H_EST - CAL_H_MAX])
            cylinder(h = CAL_H_MAX + 1, d = CAL_D);
        // piano inclinato a 45 gradi che forma il fondo
        translate([0, 0, H_EST - CAL_H_MIN - CAL_D/2])
            rotate([0, 45, 0]) translate([-200, -200, -400]) cube([400, 400, 400]);
    }
}
