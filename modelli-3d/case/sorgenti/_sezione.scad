include <../../sorgenti/libreria.scad>
use <scocca.scad>
// zoom sulla coda di rondine di destra, sezione a z=38
intersection() {
    scocca();
    translate([58, 30, 38]) cube([24, 30, 4], center = true);
}
