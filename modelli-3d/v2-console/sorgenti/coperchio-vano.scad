// ============================================================
// coperchio-vano.scad — chiude il vano della collezione
// ------------------------------------------------------------
// Tre ganci da un lato entrano nelle feritoie, poi il coperchio
// si abbassa e fa scatto sull'altro lato. Si apre con l'unghia
// dall'incavo. È grande 102 x 70: non passa dal calibro delle
// parti piccole, quindi può essere removibile senza problemi.
//
// STAMPA: appoggiato, ganci verso l'alto. Niente supporti.
// ============================================================
include <parametri-v2.scad>
include <../../sorgenti/libreria.scad>

V2_COP_SP      = 1.8;
V2_COP_BATTUTA = 3.0;
V2_GANCI       = 3;

coperchio_vano();

module coperchio_vano() {
    lx = V2_VANO_X + 2*V2_COP_BATTUTA - 0.5;
    lz = V2_VANO_Z + 2*V2_COP_BATTUTA - 0.5;
    difference() {
        union() {
            piastra(lx, lz, V2_COP_SP, 3);
            // ganci
            for (i = [0 : V2_GANCI - 1]) {
                z = -lz/2 + 13 + i * (lz - 26) / (V2_GANCI - 1);
                translate([-lx/2 + 1.2, z, V2_COP_SP - 0.01])
                    rotate([0, 0, 0])
                        hull() {
                            cube([2.2, 8, 0.02], center = true);
                            translate([-1.4, 0, 2.2]) cube([2.2, 8, 0.02], center = true);
                        }
            }
            // dentino di scatto sul lato opposto
            translate([lx/2 - 1.6, 0, V2_COP_SP])
                rotate([0, -90, 0])
                    cylinder(h = 3.2, d = 1.6, center = true, $fn = 24);
        }
        // incavo per l'unghia
        translate([lx/2 - 1, 0, -0.1])
            rotate([0, 0, 0])
                scale([1, 2.6, 1]) cylinder(h = V2_COP_SP + 0.2, d = 7, $fn = 32);
    }
}
