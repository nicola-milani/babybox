// ============================================================
// sportello-usb.scad — porticina della presa di ricarica
// ------------------------------------------------------------
// Scorre nella cava sul retro e non si sfila: la cava interna è
// più alta della fessura a vista, quindi la piastrina resta
// prigioniera. Si monta una volta sola, inclinandola per farla
// entrare dalla fessura.
//
// Perché scorrevole e non un tappo: un tappo si perde, e passa
// dal calibro delle parti piccole (Ø31,7). Questa no, perché non
// esce dal box.
//
// STAMPA: appoggiata, bottoncino verso l'alto. Niente supporti.
// Se scorre dura, 0,1 mm in meno di SPORT_SPESS e si rifà: sono
// cinque minuti di stampa.
// ============================================================
include <../../sorgenti/libreria.scad>

sportello();

module sportello() {
    altezza = SPORT_GOLA - 0.6;      // gioco nella cava
    lung = SPORT_PIASTRA_L;
    union() {
        // piastrina che corre nella gola
        linear_extrude(height = SPORT_SPESS)
            offset(r = 1.5) square([lung - 3, altezza - 3], center = true);
        // bottoncino che sporge dalla fessura: è la presa per il dito
        translate([0, 0, SPORT_SPESS - 0.01])
            hull() {
                linear_extrude(height = 0.02)
                    offset(r = 2) square([12, SPORT_APERTURA - 5], center = true);
                translate([0, 0, SPORT_PRESA])
                    linear_extrude(height = 0.02)
                        offset(r = 2) square([9, SPORT_APERTURA - 7], center = true);
            }
        // tre righine antiscivolo sul bottoncino
        for (i = [-1, 0, 1])
            translate([i * 3, 0, SPORT_SPESS + SPORT_PRESA - 0.3])
                cube([1.2, SPORT_APERTURA - 7, 0.8], center = true);
    }
}
