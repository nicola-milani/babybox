// Raccoglitore per sei dischi della musica (Ø60).
include <raccoglitore.scad>

raccoglitore_dischi();

module raccoglitore_dischi() {
    raccoglitore(n = RACC_DISCHI_N, passo = RACC_DISCHI_PASSO, fessura = VIN_H + 1.4,
             largo = VIN_D + 1.5, alto_fessura = 24,
             sporge = RACC_DISCHI_N * RACC_DISCHI_PASSO + 4);
}
