// ============================================================
// statuina-orso.scad — personaggio di esempio
// ------------------------------------------------------------
// Forme piene e compatte, baricentro basso, niente parti
// sottili che possano staccarsi: tutto è ottenuto con hull()
// di sfere, quindi non ci sono colli sottili.
// Altezza totale ~70 mm, base compresa.
//
// STAMPA: in piedi, senza supporti, 3 perimetri, 40% di
// riempimento (deve reggere i morsi e le cadute).
// Usare questo file come modello per gli altri personaggi:
// si cambia solo la parte "personaggio".
// ============================================================
include <../../sorgenti/libreria.scad>
use <base-statuina.scad>

statuina();

module statuina() {
    base_statuina();
    translate([0, 0, ST_BASE_H - 2]) personaggio();
}

module personaggio() {
    corpo();
    testa();
    zampe();
}

module corpo() {
    hull() {
        translate([0, 0, 13]) sphere(r = 14);
        translate([0, 0, 30]) sphere(r = 11);
    }
}

module testa() {
    hull() {
        translate([0, 0, 42])   sphere(r = 11.5);
        translate([0, -7, 40])  sphere(r = 7);     // muso
    }
    // orecchie: fuse nella testa con hull, niente collo sottile
    for (sx = [-1, 1])
        hull() {
            translate([sx * 7.5, 0, 50]) sphere(r = 5.5);
            translate([sx * 4, 0, 45])   sphere(r = 7);
        }
}

module zampe() {
    for (sx = [-1, 1])
        hull() {
            translate([sx * 12, 0, 16]) sphere(r = 6.5);
            translate([sx * 8,  0, 22]) sphere(r = 7);
        }
    for (sx = [-1, 1])
        hull() {
            translate([sx * 7, -3, 3]) sphere(r = 6);
            translate([sx * 6,  2, 4]) sphere(r = 6);
        }
}
