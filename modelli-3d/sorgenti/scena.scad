// ============================================================
// scena.scad — vista d'insieme, serve solo per le immagini
// ------------------------------------------------------------
// Non si stampa: mette insieme box, raccoglitori, una carta e i
// dischi per i render della documentazione.
// ============================================================
include <libreria.scad>
use <../case/sorgenti/scocca.scad>
use <../case/sorgenti/piatto-nfc.scad>
use <../vinili/sorgenti/vinile.scad>
use <../raccoglitori/sorgenti/raccoglitore-carte.scad>
use <../raccoglitori/sorgenti/raccoglitore-dischi.scad>

scocca();
translate([NFC_X, NFC_Y, BOX_Z - TOP_SP]) piatto_nfc();

// una carta appoggiata sul vassoio
color("#E9A95C")
    translate([NFC_X, NFC_Y, BOX_Z - NFC_PROF + 0.2])
        piastra(CARTA_X, CARTA_Y, CARTA_SP, 3.2);

// i raccoglitori agganciati alle fiancate
translate([BOX_X/2, 0, CODA_Z1 + 17]) raccoglitore_carte();
mirror([1, 0, 0]) translate([BOX_X/2, 0, CODA_Z1 + 16]) raccoglitore_dischi();
