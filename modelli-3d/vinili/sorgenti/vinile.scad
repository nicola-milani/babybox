// ============================================================
// vinile.scad — disco per le canzoni
// ------------------------------------------------------------
// Stesso tag NTAG213 delle statuine, stessa sede a 1 mm dal
// fondo. Bordi raccordati, nessun foro centrale.
//
// STAMPA: appoggiato, pausa (M600) a Z = 2,0 mm per inserire
// il tag. Etichetta centrale in rilievo: con un cambio colore
// alla quota dell'etichetta viene bicolore.
// ============================================================
include <../../sorgenti/libreria.scad>

vinile();

module vinile() {
    difference() {
        union() {
            disco();
            solchi();
            etichetta();
        }
        translate([0, 0, ST_TAG_FONDO])
            cylinder(h = ST_TAG_SEDE_H, d = ST_TAG_SEDE_D);
    }
}

// Disco con bordo raccordato (profilo ruotato).
module disco() {
    rotate_extrude($fn = RISOLUZIONE * 2)
        offset(r = VIN_RAGGIO) offset(delta = -VIN_RAGGIO)
            square([VIN_D/2, VIN_H]);
}

module solchi() {
    for (r = [VIN_ETICH_D/2 + 2 : 1.8 : VIN_D/2 - 3])
        translate([0, 0, VIN_H - 0.01])
            difference() {
                cylinder(h = VIN_SOLCO_H, r = r + 0.45);
                translate([0, 0, -0.1])
                    cylinder(h = VIN_SOLCO_H + 0.2, r = r - 0.45);
            }
}

module etichetta() {
    translate([0, 0, VIN_H - 0.01])
        cylinder(h = 0.6, d = VIN_ETICH_D);
    // nota musicale in rilievo sull'etichetta
    translate([0, 0, VIN_H + 0.59]) nota();
}

module nota() {
    alt = 0.6;
    translate([-2.5, -3, 0]) linear_extrude(alt) circle(d = 6);
    translate([0.6, -3, 0])   linear_extrude(alt) square([1.6, 11]);
    translate([0.6, 6.5, 0])  linear_extrude(alt) square([6, 1.6]);
}
