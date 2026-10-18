// ============================================================
// piatto-nfc.scad — fondo del vassoio di appoggio
// ------------------------------------------------------------
// È la superficie su cui si appoggiano le carte delle storie e i
// dischi della musica, e l'unico diaframma fra tag e antenna: 2 mm.
// Entra dal basso e si incastra (il foro si restringe), poi si
// incolla. Il PN5180 va fissato con biadesivo sotto, centrato.
//
// STAMPA: appoggiato, faccia a vista sul piano. Bello in un colore
// diverso dalla scocca: è la parte che si guarda di più.
// ============================================================
include <../../sorgenti/libreria.scad>

piatto_nfc();

module piatto_nfc() {
    h = TOP_SP - NFC_PROF;                        // 2,0 mm
    lx_basso = NFC_X_LUNG + GIOCO_FORO - 0.9 - GIOCO;
    ly_basso = NFC_Y_LARG + GIOCO_FORO - 0.9 - GIOCO;
    lx_alto  = NFC_X_LUNG + GIOCO_FORO - GIOCO;
    ly_alto  = NFC_Y_LARG + GIOCO_FORO - GIOCO;

    difference() {
        union() {
            // tronco di piramide: si incastra nel foro che si restringe
            hull() {
                piastra(lx_basso, ly_basso, 0.02, NFC_RAGGIO - 0.45);
                translate([0, 0, h - 0.4])
                    piastra(lx_alto, ly_alto, 0.02, NFC_RAGGIO);
            }
            // ultimo scalino, a filo del fondo del vassoio
            translate([0, 0, h - 0.4])
                piastra(lx_alto, ly_alto, 0.4, NFC_RAGGIO);
        }
        // segno leggero che dice dove appoggiare: il contorno di una carta
        translate([0, 0, h - 0.35])
            difference() {
                piastra(CARTA_X + 1.2, CARTA_Y + 1.2, 0.45, 4);
                translate([0, 0, -0.1])
                    piastra(CARTA_X - 0.4, CARTA_Y - 0.4, 0.65, 3.4);
            }
    }
}
