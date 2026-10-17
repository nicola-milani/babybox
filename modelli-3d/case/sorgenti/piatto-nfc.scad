// ============================================================
// piatto-nfc.scad — fondo dello scasso di appoggio
// ------------------------------------------------------------
// Disco che chiude dal basso il foro del coperchio: è la
// superficie su cui si appoggiano statuine e vinili, ed è
// l'unico diaframma fra tag e antenna (2 mm).
// Si incolla dall'interno; il modulo PN5180 subito sotto fa
// da battuta di sicurezza.
//
// STAMPA: appoggiato, faccia a vista sul piano. Ottimo in un
// colore diverso dalla scocca.
// ============================================================
include <../../sorgenti/libreria.scad>

piatto_nfc();

module piatto_nfc() {
    h = TOP_SP - NFC_PROF;                    // 2,0 mm
    d_basso = NFC_D + GIOCO_FORO - 0.9 - 0.3;
    d_alto  = NFC_D + GIOCO_FORO - 0.3;
    difference() {
        union() {
            cylinder(h = h - 0.4, d1 = d_basso, d2 = d_alto - 0.2);
            translate([0, 0, h - 0.4])
                cylinder(h = 0.4, d1 = d_alto - 0.2, d2 = d_alto - 0.8);
        }
    }
}
