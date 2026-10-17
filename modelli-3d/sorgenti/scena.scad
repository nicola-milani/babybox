// ============================================================
// scena.scad — vista d'insieme, serve solo per le immagini
// ------------------------------------------------------------
// Non si stampa: mette insieme box, statuina e vinile per i
// render della documentazione.
//   openscad -o scena.png --camera=... sorgenti/scena.scad
// ============================================================
include <libreria.scad>
use <../case/sorgenti/scocca.scad>
use <../case/sorgenti/piatto-nfc.scad>
use <../statuine/sorgenti/statuina-orso.scad>
use <../vinili/sorgenti/vinile.scad>

MOSTRA_BOX = true;

if (MOSTRA_BOX) {
    scocca();
    translate([NFC_X, NFC_Y, BOX_Z - TOP_SP]) piatto_nfc();
    translate([NFC_X, NFC_Y, BOX_Z - NFC_PROF]) statuina();
}
translate([-95, -20, 0]) vinile();
translate([-95, 45, 0]) statuina();
