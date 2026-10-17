// ============================================================
// base-statuina.scad — base con sede del tag NFC
// ------------------------------------------------------------
// Cilindro Ø40 x 8 con la sede del tag a 1 mm dal fondo: fra
// tag e antenna restano 1 mm di base + 2 mm di piatto NFC.
// Sopra ci va il personaggio (statuina-orso.scad) oppure si
// incolla una figurina comprata.
//
// STAMPA: appoggiata sul piano. Mettere una pausa (M600 /
// "change filament") alla quota Z = ST_TAG_FONDO + ST_TAG_SEDE_H
// (2,0 mm): si appoggia il tag nella sede e si riprende.
// In alternativa stampare con TAPPO = true e incollare il
// dischetto dopo aver messo il tag.
// ============================================================
include <../../sorgenti/libreria.scad>

TAPPO = false;   // true = sede aperta sotto + tappo da incollare

base_statuina();
if (TAPPO) translate([ST_BASE_D + 8, 0, 0]) tappo_base();

module base_statuina() {
    difference() {
        corpo_base();
        sede_tag();
    }
}

module corpo_base() {
    // cilindro con smussi sopra e sotto: nessuno spigolo vivo
    hull() {
        translate([0, 0, 0])
            cylinder(h = 0.01, d = ST_BASE_D - 2*ST_SMUSSO);
        translate([0, 0, ST_SMUSSO])
            cylinder(h = ST_BASE_H - 2*ST_SMUSSO, d = ST_BASE_D);
        translate([0, 0, ST_BASE_H - 0.01])
            cylinder(h = 0.01, d = ST_BASE_D - 2*ST_SMUSSO);
    }
}

module sede_tag() {
    if (TAPPO) {
        // sede aperta verso il basso, si chiude col tappo
        translate([0, 0, -0.1])
            cylinder(h = ST_TAG_FONDO + ST_TAG_SEDE_H + 0.1, d = ST_TAG_SEDE_D);
    } else {
        translate([0, 0, ST_TAG_FONDO])
            cylinder(h = ST_TAG_SEDE_H, d = ST_TAG_SEDE_D);
    }
}

// Tappo da incollare quando non si usa la pausa in stampa.
module tappo_base() {
    cylinder(h = ST_TAG_FONDO - 0.2, d = ST_TAG_SEDE_D - 0.3);
}
