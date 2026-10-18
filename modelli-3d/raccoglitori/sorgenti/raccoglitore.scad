// ============================================================
// raccoglitore.scad — il corpo comune dei due raccoglitori
// ------------------------------------------------------------
// Si infila dall'alto nelle due code di rondine della fiancata e
// sta su da solo: niente viti, e si sfila per portare in giro il
// box senza la collezione.
//
// Lo usano raccoglitore-carte.scad e raccoglitore-dischi.scad,
// che cambiano solo passo e profondità delle fessure.
//
// STAMPA: appoggiato sulla schiena (la faccia delle code sul
// piano), fessure verso l'alto. Niente supporti.
// ============================================================
include <../../sorgenti/libreria.scad>

// raccoglitore(n, passo, fessura, largo, alto_fessura, sporge)
//   n            quante cose ci stanno
//   passo        distanza fra una fessura e l'altra
//   fessura      larghezza della singola fessura
//   largo        lunghezza utile della fessura (lato Y)
//   alto_fessura quanto è profonda la tasca che trattiene
//   sporge       quanto sporge dal box
module raccoglitore(n, passo, fessura, largo, alto_fessura, sporge) {
    sp = 2.0;                       // pareti
    corpo_y = largo + 2 * sp;
    corpo_x = sporge;
    corpo_z = alto_fessura + sp;
    schiena_z = corpo_z + 8;        // appena più alta della vasca: le code
                                    // prendono su tutta l'altezza e il
                                    // raccoglitore resta un blocchetto

    difference() {
        union() {
            // schiena, appoggiata alla fiancata
            translate([0, 0, schiena_z/2 - corpo_z/2])
                cube([sp, corpo_y, schiena_z], center = true);
            // vasca
            translate([corpo_x/2 + sp/2, 0, 0])
                cube([corpo_x, corpo_y, corpo_z], center = true);
            // le due code
            for (sy = [-1, 1])
                translate([-sp/2 + 0.01, sy * CODA_INTERASSE/2, -corpo_z/2])
                    coda_maschio_verticale(schiena_z - 4);
        }
        // le fessure
        for (i = [0 : n - 1]) {
            x = sp + passo * (i + 0.5) + (corpo_x - n * passo) / 2;
            translate([x, 0, sp + corpo_z/2 - sp/2 + 0.1])
                cube([fessura, largo, corpo_z], center = true);
        }
    }
}

// La coda va estrusa lungo Z (si stampa in piedi), non lungo Y.
module coda_maschio_verticale(altezza) {
    gioco = 0.35;
    linear_extrude(height = altezza)
        polygon([[0, -(CODA_BOCCA - gioco)/2], [0, (CODA_BOCCA - gioco)/2],
                 [-(CODA_PROF - 0.3), (CODA_FONDO - gioco)/2],
                 [-(CODA_PROF - 0.3), -(CODA_FONDO - gioco)/2]]);
}
