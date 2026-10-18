// ============================================================
// sportello-usb-v2.scad — porticina della presa, versione console
// ------------------------------------------------------------
// Stessa idea di quella del cubo: scorre nella cava del bordo
// inferiore e non si sfila, perché dentro la gola è più alta
// della fessura a vista. Qui è più bassa (gola 12 invece di 16):
// il bordo della console è profondo 19 mm e con la gola del cubo
// resterebbero due binari da 1,5 mm.
//
// Perché scorrevole e non un tappo: un tappo si perde, e passa
// dal calibro delle parti piccole (Ø31,7). Questa no, perché non
// esce dalla console.
//
// STAMPA: appoggiata, bottoncino verso l'alto. Niente supporti.
// Se scorre dura, 0,1 mm in meno di SPORT_SPESS e si rifà.
// ============================================================
include <parametri-v2.scad>
include <../../sorgenti/libreria.scad>

sportello_v2();

module sportello_v2() {
    altezza = V2_SPORT_GOLA - 0.6;   // gioco nella cava
    lung = 24;
    union() {
        // piastrina che corre nella gola
        linear_extrude(height = SPORT_SPESS)
            offset(r = 1.5) square([lung - 3, altezza - 3], center = true);
        // bottoncino che sporge dalla fessura: è la presa per il dito
        translate([0, 0, SPORT_SPESS - 0.01])
            hull() {
                linear_extrude(height = 0.02)
                    offset(r = 1.5) square([11, V2_SPORT_APERTURA - 4.5], center = true);
                translate([0, 0, SPORT_PRESA])
                    linear_extrude(height = 0.02)
                        offset(r = 1.5) square([8, V2_SPORT_APERTURA - 5.5], center = true);
            }
        // righine antiscivolo sul bottoncino
        for (i = [-1, 0, 1])
            translate([i * 3, 0, SPORT_SPESS + SPORT_PRESA - 0.3])
                cube([1.2, V2_SPORT_APERTURA - 5.5, 0.8], center = true);
    }
}
