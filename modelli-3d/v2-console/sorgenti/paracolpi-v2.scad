// ============================================================
// paracolpi-v2.scad — i quattro angoli morbidi della console
// ------------------------------------------------------------
// Si infilano sugli spigoli e si tengono da soli per attrito.
// Vanno stampati in TPU (shore 95A): è l'unico pezzo del
// progetto che non è in PETG, ed è anche il motivo per cui sono
// separati — così il resto si stampa senza cambiare materiale.
//
// Se non hai TPU, la console funziona lo stesso: questi servono
// solo a far sopravvivere meglio le cadute.
//
// STAMPA: in piedi, 3 perimetri, niente riempimento, niente
// supporti. In TPU rallenta: 20 mm/s.
// ============================================================
include <parametri-v2.scad>
include <../../sorgenti/libreria.scad>

PARA_LATO   = 24;    // quanto risale lungo i bordi: oltre arriva ai tasti
PARA_SP     = 2.6;   // spessore del cappuccio
PARA_GIOCO  = 0.25;  // il TPU è elastico: serve meno gioco del PETG

paracolpo();

module paracolpo() {
    intersection() {
        difference() {
            guscio_angolo(PARA_SP);
            guscio_angolo(0);
        }
        // tiene solo l'angolo in alto a sinistra: gli altri tre si
        // ottengono specchiando in stampa (o stampando quattro volte
        // questo e girandolo).
        translate([-V2_X/2 - PARA_SP - 1, -PARA_SP - 1, V2_Z - PARA_LATO])
            cube([PARA_LATO + PARA_SP + 1, V2_Y + 2*PARA_SP + 2,
                  PARA_LATO + PARA_SP + 1]);
    }
}

// Il cappuccio segue il profilo della console, ingrossato di sp.
module guscio_angolo(sp) {
    translate([0, V2_Y + sp, V2_Z/2])
        rotate([90, 0, 0])
            linear_extrude(height = V2_Y + 2 * sp)
                offset(r = sp + PARA_GIOCO)
                    offset(r = V2_RAGGIO)
                        square([V2_X - 2*V2_RAGGIO, V2_Z - 2*V2_RAGGIO], center = true);
}
