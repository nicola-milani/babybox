// ============================================================
// sportellino-batteria.scad — coperchio del vano 18650
// ------------------------------------------------------------
// Si avvita sul fondo con 4 viti autofilettanti M2,5: si
// cambia la cella senza smontare la scatola né toccare i fili
// dell'interruttore. Le asole servono allo sfiato.
//
// STAMPA: faccia esterna sul piano.
// ============================================================
include <../../sorgenti/libreria.scad>

sportellino();

module sportellino() {
    difference() {
        union() {
            piastra(SPORT_PIASTRA_X, SPORT_PIASTRA_Y, SPORT_RABBET, 4);
            translate([0, 0, SPORT_RABBET - 0.01])
                piastra(SPORT_X - 0.6, SPORT_Y - 0.6,
                        SPORT_SP - SPORT_RABBET + 0.01, 3.5);
        }
        for (sx = [-1, 1], sy = [-1, 1])
            translate([sx * SPORT_VITI_DX, sy * SPORT_VITI_DY, 0])
                foro_svasato(SPORT_SP, VITE_FORO, VITE_TESTA_D, 1.4);
        // sfiati
        for (i = [-2 : 2])
            translate([0, i * 9, -0.1])
                rotate([0, 0, 90]) fessura(18, 3, SPORT_SP + 0.2);
    }
}
