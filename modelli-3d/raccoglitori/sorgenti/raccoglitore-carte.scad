// Raccoglitore per sei carte delle storie (CR80, 85,6 x 54).
// Le carte stanno in piedi e si vedono: il bambino sceglie guardando.
include <raccoglitore.scad>

raccoglitore_carte();

module raccoglitore_carte() {
    raccoglitore(n = RACC_CARTE_N, passo = RACC_CARTE_PASSO, fessura = CARTA_SP + 0.9,
             largo = CARTA_X + 1.5, alto_fessura = 26,
             sporge = RACC_CARTE_N * RACC_CARTE_PASSO + 4);
}
