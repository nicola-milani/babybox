// ============================================================
// scena-colori.scad — la console montata, per le immagini
// ------------------------------------------------------------
// Non serve a stampare niente: mette insieme i pezzi veri con i
// componenti comprati (tasti, pomello, altoparlante, carta) e li
// colora come verrebbero davvero, corpo bianco e comandi a
// colori. Si usa per i render del README.
//
//   openscad -o fuori.png --camera=0,20,55,70,0,30,470 \
//            --projection=p scena-colori.scad
//
// I pezzi stampati sono gli stessi file degli STL: se cambia il
// modello, cambia anche questa scena.
// ============================================================
include <parametri-v2.scad>
include <../../sorgenti/libreria.scad>
use <scocca-v2.scad>
use <retro-v2.scad>
use <coperchio-vano.scad>
use <paracolpi-v2.scad>
use <sportello-usb-v2.scad>
use <../../case/sorgenti/pomello-cursore.scad>

// ---------- colori ----------
BIANCO     = "#fbfaf6";   // PETG bianco: il corpo
GRIGIO     = "#d7dad4";   // coperchio del vano
ANTRACITE  = "#333a3f";   // TPU dei paracolpi
TASTO_SX   = "#e2574c";   // indietro
TASTO_DX   = "#2fb3a8";   // avanti
GIALLO     = "#f4b63f";   // pomello del volume
CARTA_COL  = "#e9a23b";   // la carta della storia
NERO       = "#262626";   // altoparlante dietro la griglia
METALLO    = "#9aa3ab";   // porticina della USB

MOSTRA_CARTA     = true;
MOSTRA_COPERCHIO = true;   // false: vano aperto, con la collezione dentro
COLLEZIONE = ["#e2574c", "#2fb3a8", "#f4b63f", "#8e7cc3"];

// ---------- pezzi stampati ----------
color(BIANCO) scocca_v2();
color(BIANCO) translate([0, V2_SPLIT, 0]) retro_v2();

if (MOSTRA_COPERCHIO)
    color(GRIGIO)
        translate([V2_VANO_X0, V2_Y, V2_VANO_Z0 + V2_VANO_Z/2])
            rotate([90, 0, 0]) coperchio_vano();
else
    // la collezione: carte di piatto, una sull'altra
    for (i = [0 : len(COLLEZIONE) - 1])
        color(COLLEZIONE[i])
            translate([V2_VANO_X0, 42.4 - (i + 1) * (CARTA_SP + 0.1),
                       V2_VANO_Z0 + V2_VANO_Z/2])
                rotate([-90, 0, 0])
                    piastra(CARTA_X, CARTA_Y, CARTA_SP, 3.2);

// porticina chiusa sopra la presa
color(METALLO)
    translate([V2_USB_X - 12, V2_SPLIT + (V2_Y - V2_SPLIT)/2, 0])
        rotate([180, 0, 0]) sportello_v2();

// i quattro angoli morbidi: il pezzo e' modellato in alto a sinistra
color(ANTRACITE) {
    paracolpo();
    mirror([1, 0, 0]) paracolpo();
    translate([0, 0, V2_Z]) mirror([0, 0, 1]) paracolpo();
    translate([0, 0, V2_Z]) mirror([0, 0, 1]) mirror([1, 0, 0]) paracolpo();
}

// interruttore generale e tasto genitori, sul retro
color(NERO) {
    translate([V2_SW_X, V2_Y - SW_INCASSO - 1.2, V2_SW_Z])
        cube([SW_VITI + 4, 2.6, SW_FORO_Y + 4], center = true);
    translate([V2_SW_X - 3, V2_Y - SW_INCASSO + 0.6, V2_SW_Z])
        cube([4, 3, 5], center = true);
    translate([V2_GEN_X, V2_Y - GEN_POZZO_H - 0.8, V2_GEN_Z])
        rotate([-90, 0, 0]) cylinder(h = 1, d = GEN_FORO_D - 0.4);
}

// ---------- componenti comprati ----------
// tasti arcade: cappello bombato che sporge di tre millimetri
module tasto(c) {
    color(c)
        hull() {
            translate([0, 0, -0.01]) cylinder(h = 0.02, d = TASTO_CAPPUCCIO);
            translate([0, 0, 2.6]) cylinder(h = 0.02, d = TASTO_CAPPUCCIO - 7);
        }
}
translate([-V2_TASTO_X, 0, V2_TASTO_Z]) rotate([90, 0, 0]) tasto(TASTO_SX);
translate([ V2_TASTO_X, 0, V2_TASTO_Z]) rotate([90, 0, 0]) tasto(TASTO_DX);

// il LED di stato acceso: nel pezzo vero sta dietro 0,8 mm di parete, qui
// e' un dischetto verde per far vedere dov'e'
color("#7bd389")
    translate([V2_LED_X, -0.05, V2_LED_Z])
        rotate([-90, 0, 0]) cylinder(h = 0.2, d = LED_FINESTRA_D);

// pomello del volume, a meta' corsa
color(GIALLO)
    translate([V2_CURSORE_X, 0, V2_CURSORE_Z])
        rotate([90, 0, 0]) pomello();

// altoparlante dietro la griglia: si intravede dai fori
color(NERO)
    translate([V2_ALT_X, V2_PARETE + 0.2, V2_ALT_Z])
        rotate([-90, 0, 0]) cylinder(h = 0.6, d = ALT_D);

// la carta infilata, con il centimetro che sporge
if (MOSTRA_CARTA)
    color(CARTA_COL)
        translate([0, 9.5 + CARTA_SP/2, V2_Z + V2_SPORGE - CARTA_Y/2])
            rotate([90, 0, 0])
                piastra(CARTA_X, CARTA_Y, CARTA_SP, 3.2);
