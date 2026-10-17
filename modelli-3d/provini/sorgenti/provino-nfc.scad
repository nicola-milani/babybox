// ============================================================
// provino-nfc.scad — PRIMO PEZZO DA STAMPARE
// ------------------------------------------------------------
// Serve a misurare a che distanza il PN5180 legge il tag
// attraverso la plastica, prima di stampare il case intero.
// Quattro gradini da 1,0 / 1,5 / 2,0 / 2,5 mm: si appoggia il
// tag sopra ogni gradino e si guarda da quale spessore in poi
// la lettura diventa incerta. Nel box reale fra tag e antenna
// ci sono 1 mm (base statuina) + 2 mm (piatto NFC).
//
// STAMPA: appoggiato, 3 perimetri, stesso materiale del case.
// ============================================================
include <../../sorgenti/libreria.scad>

SPESSORI = [1.0, 1.5, 2.0, 2.5];
PAD = 30;
GAP = 2;

provino();

module provino() {
    for (i = [0 : len(SPESSORI) - 1])
        translate([i * (PAD + GAP), 0, 0]) gradino(SPESSORI[i]);
    // ponticelli: resta un pezzo solo, senza aggiungere spessore ai gradini
    for (i = [0 : len(SPESSORI) - 2])
        translate([i * (PAD + GAP) + PAD/2 + GAP/2, -(PAD + 10)/2 + 7, 0])
            cube([GAP + 1, 12, 1.0], center = true);
}

module gradino(sp) {
    difference() {
        piastra(PAD, PAD + 10, sp, 3);
        // numero inciso, leggibile anche col tag appoggiato sopra
        translate([0, -(PAD + 10)/2 + 6, sp - 0.5])
            scritta(str(sp), dim = 6, alt = 0.6);
    }
    // cornice che tiene il tag centrato sul gradino
    difference() {
        translate([0, 3, 0]) piastra(ST_TAG_D + 3.6, ST_TAG_D + 3.6, sp + 1.2, 2);
        translate([0, 3, -0.1]) piastra(ST_TAG_D + 1.2, ST_TAG_D + 1.2, sp + 1.5, 1);
    }
}
