// ============================================================
// pomello-cursore.scad — pomello del volume
// ------------------------------------------------------------
// Il pomello attraversa una fessura di soli 3,2 mm: una lama
// scende fino al potenziometro e due gambette stringono la
// levetta. Così la fessura resta stretta (briciole) e il
// pomello resta largo (mano di un bambino).
//
// Dopo aver misurato il potenziometro vero, controllare
// CURSORE_LEVA_X / CURSORE_LEVA_Y in parametri.scad e
// ristampare: è un pezzo da 10 minuti.
//
// STAMPA: appoggiato su un fianco (faccia Y sul piano),
// nessun supporto: le gambette vengono più robuste.
// ============================================================
include <../../sorgenti/libreria.scad>

pomello();

POM_X  = 26;                          // lunghezza del cappello
POM_Y  = 17;                          // larghezza del cappello
POM_H  = 7;                           // altezza del cappello
LAMA_X = 11;
LAMA_Y = CURSORE_FESSURA_W - 0.5;     // passa nella fessura con gioco
LAMA_H = TOP_SP + CURSORE_Z_SOTTO;    // dal piano del coperchio al corpo
PRESA_H = 6;                          // quanto scende la forcella sulla levetta

module pomello() {
    union() {
        cappello();
        lama();
    }
}

// Cappello bombato, comodo da spingere con un dito o col palmo.
module cappello() {
    hull() {
        piastra(POM_X, POM_Y, 0.02, 4);
        translate([0, 0, POM_H - 2.5]) piastra(POM_X - 3, POM_Y - 3, 0.02, 3.5);
        translate([0, 0, POM_H])       piastra(POM_X - 9, POM_Y - 8, 0.02, 2);
    }
}

// Lama forcellata: scende nella fessura e abbraccia la levetta.
module lama() {
    translate([0, 0, -LAMA_H + LAMA_H/2])
        difference() {
            cube([LAMA_X, LAMA_Y, LAMA_H], center = true);
            // intaglio centrale: le due gambette stringono la levetta
            translate([0, 0, -(LAMA_H - PRESA_H)/2 - 0.1])
                cube([CURSORE_LEVA_X + 0.4, LAMA_Y + 1, PRESA_H + 0.2],
                     center = true);
            // inviti sulle punte, per infilarlo senza forzare
            for (sx = [-1, 1])
                translate([sx * (CURSORE_LEVA_X/2 + 0.2), 0, -LAMA_H/2])
                    rotate([0, sx * 45, 0])
                        cube([1.2, LAMA_Y + 1, 1.2], center = true);
        }
}
