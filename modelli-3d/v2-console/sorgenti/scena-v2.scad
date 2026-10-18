// Vista d'insieme della console v2: serve solo per le immagini.
include <parametri-v2.scad>
include <../../sorgenti/libreria.scad>
use <scocca-v2.scad>
use <retro-v2.scad>
use <coperchio-vano.scad>

scocca_v2();
translate([0, V2_SPLIT, 0]) retro_v2();

// una carta infilata, con il centimetro che sporge
color("#E9A95C")
    translate([0, 9.5 + CARTA_SP/2, V2_Z + V2_SPORGE - CARTA_Y/2])
        rotate([90, 0, 0])
            piastra(CARTA_X, CARTA_Y, CARTA_SP, 3.2);
