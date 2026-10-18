// ============================================================
// retro-v2.scad — guscio posteriore della console
// ------------------------------------------------------------
// Chiude la console e porta il vano della collezione: sei carte
// in piedi, oppure tre dischi, o un misto. Il coperchio è a
// scatto, con tre ganci da un lato — un coperchio di 96 x 64 non
// passa dal calibro delle parti piccole, quindi qui togliersi si
// può, a differenza del tappo della USB.
//
// Dentro, sul lato sinistro, il vano della batteria.
//
// STAMPA: faccia posteriore sul piano, apertura verso l'alto.
// Nessun supporto.
// ============================================================
include <parametri-v2.scad>
include <../../sorgenti/libreria.scad>

retro_v2();

V2_RETRO_PROF = V2_Y - V2_SPLIT;   // 19 mm
V2_COP_SP      = 1.8;   // spessore del coperchio del vano
V2_COP_BATTUTA = 3.0;   // quanto appoggia tutt'intorno
V2_VITI = [[-V2_X/2 + 9, -V2_Z/2 + 9], [V2_X/2 - 9, -V2_Z/2 + 9],
           [-V2_X/2 + 9, V2_Z/2 - 9], [V2_X/2 - 9, V2_Z/2 - 9]];

module retro_v2() {
    difference() {
        union() {
            guscio_retro();
            pareti_vano();
        }
        sedi_coperchio();
        apertura_vano();
        foro_usb_v2();
        fori_viti_retro();
    }
    culla_batteria_retro();
    colonnine_basetta();
    sede_ricarica();
}

// ------------------------------------------------------------------
// Sostegni interni
// ------------------------------------------------------------------
// Culla posteriore della batteria: l'altra meta' sta nel guscio
// anteriore. Chiudendo i due gusci il portabatteria resta stretto fra
// le due culle e non si muove negli urti, che su una versione da
// viaggio e' il caso normale, non l'eccezione.
module culla_batteria_retro() {
    for (sz = [-1, 1])
        translate([V2_BATT_X, (V2_RETRO_PROF - V2_PARETE)/2 + V2_PARETE,
                   V2_BATT_Z + sz * (BATT_HOLDER_Y/2 - 4)])
            difference() {
                cube([BATT_HOLDER_X + 2*2.4, V2_RETRO_PROF - V2_PARETE, 6], center = true);
                translate([0, -2, 0])
                    cube([BATT_HOLDER_X + GIOCO, V2_RETRO_PROF, 7], center = true);
            }
    // asole per una fascetta: la cella non salta via se la console cade
    for (sz = [-1, 1])
        translate([V2_BATT_X, V2_PARETE + 1.5, V2_BATT_Z + sz * (BATT_HOLDER_Y/2 + 5)])
            cube([BATT_HOLDER_X + 8, 3, 2.5], center = true);
}

// Colonnine della basetta millefori: 60 x 68, piu' piccola di quella
// del cubo perche' qui il vano della collezione si prende meta' spazio.
module colonnine_basetta() {
    for (sx = [-1, 1], sz = [-1, 1])
        translate([V2_BASETTA_CX + sx * (V2_BASETTA_X/2 - 4), V2_PARETE,
                   V2_BASETTA_CZ + sz * (V2_BASETTA_Z/2 - 4)])
            rotate([-90, 0, 0])
                difference() {
                    union() {
                        cylinder(h = V2_BASETTA_Y, d = 7);
                        cylinder(h = 2.5, d1 = 10, d2 = 7);
                    }
                    translate([0, 0, 1]) cylinder(h = V2_BASETTA_Y, d = AUTOFIL_D);
                }
}

// Sede del modulo di ricarica, allineata alla presa sul bordo inferiore:
// se balla, la USB-C non si infila piu' dritta.
module sede_ricarica() {
    for (sx = [-1, 1])
        translate([V2_TP_X + sx * 14, V2_PARETE + 4, V2_TP_Z])
            cube([2.4, 8, 22], center = true);
    translate([V2_TP_X, V2_PARETE + 4, V2_TP_Z - 11])
        cube([30, 8, 2.4], center = true);
}

module sezione_faccia(x, z, altezza, r) {
    translate([0, 0, z / 2])
        rotate([-90, 0, 0])
            linear_extrude(height = altezza)
                offset(r = r) square([x - 2*r, z - 2*r], center = true);
}

module corpo_retro(prof, bordo = 3, passi = 10) {
    union() {
        sezione_faccia(V2_X, V2_Z, prof - bordo, V2_RAGGIO);
        for (i = [0 : passi - 1]) {
            a0 = 90 * i / passi;
            a1 = 90 * (i + 1) / passi;
            k0 = bordo * (1 - cos(a0));  k1 = bordo * (1 - cos(a1));
            y0 = bordo * sin(a0);        y1 = bordo * sin(a1);
            hull() {
                translate([0, prof - bordo + y0, 0])
                    sezione_faccia(V2_X - 2*k0, V2_Z - 2*k0, 0.02, max(V2_RAGGIO - k0, 0.6));
                translate([0, prof - bordo + y1, 0])
                    sezione_faccia(V2_X - 2*k1, V2_Z - 2*k1, 0.02, max(V2_RAGGIO - k1, 0.6));
            }
        }
    }
}

module guscio_retro() {
    difference() {
        corpo_retro(V2_RETRO_PROF);
        translate([0, -1, 0])
            sezione_faccia(V2_X - 2*V2_PARETE, V2_Z - 2*V2_PARETE,
                           V2_RETRO_PROF - V2_PARETE + 1, V2_RAGGIO - V2_PARETE);
    }
}

// ------------------------------------------------------------------
// Vano della collezione
// ------------------------------------------------------------------
// Le carte stanno in piedi in sei fessure; i dischi appoggiati di
// piatto nella parte larga. Chi vuole solo dischi toglie il
// divisorio stampando con V2_VANO_FESSURE = false.
V2_VANO_FESSURE = true;

module pareti_vano() {
    // cassa del vano, aperta verso il retro
    translate([V2_VANO_X0, V2_RETRO_PROF - V2_VANO_PROF/2 - V2_PARETE,
               V2_VANO_Z0 + V2_VANO_Z/2])
        difference() {
            cube([V2_VANO_X + 2*V2_PARETE, V2_VANO_PROF + V2_PARETE,
                  V2_VANO_Z + 2*V2_PARETE], center = true);
            cube([V2_VANO_X, V2_VANO_PROF + V2_PARETE + 1, V2_VANO_Z], center = true);
        }
    // fessure per tenere le carte in piedi
    if (V2_VANO_FESSURE)
        for (i = [0 : RACC_CARTE_N - 1]) {
            x = V2_VANO_X0 - V2_VANO_X/2 + 8 + i * RACC_CARTE_PASSO;
            translate([x, V2_RETRO_PROF - V2_VANO_PROF/2 - V2_PARETE, V2_VANO_Z0 + 6])
                cube([1.4, V2_VANO_PROF - 1, 12], center = true);
        }
}

module apertura_vano() {
    translate([V2_VANO_X0, V2_RETRO_PROF - V2_PARETE/2 + 0.1,
               V2_VANO_Z0 + V2_VANO_Z/2])
        cube([V2_VANO_X, V2_PARETE + 1, V2_VANO_Z], center = true);
}

// Coperchio del vano: a scatto, non scorrevole.
// Per scoprire un'apertura da 96 mm una porticina scorrevole avrebbe
// bisogno di una corsa più lunga della console. E un coperchio di
// 96 x 64 non passa dal calibro delle parti piccole (Ø31,7): qui
// togliersi si può, a differenza del tappo della USB.
// Tre ganci da un lato, uno scatto dall'altro, come il vano pile di
// un telecomando.
V2_GANCI = 3;

module sedi_coperchio() {
    // battuta su cui appoggia il coperchio, tutt'intorno all'apertura
    translate([V2_VANO_X0, V2_RETRO_PROF - V2_COP_SP/2 + 0.01,
               V2_VANO_Z0 + V2_VANO_Z/2])
        difference() {
            cube([V2_VANO_X + 2*V2_COP_BATTUTA, V2_COP_SP + 0.1,
                  V2_VANO_Z + 2*V2_COP_BATTUTA], center = true);
            cube([V2_VANO_X - 0.4, V2_COP_SP + 1, V2_VANO_Z - 0.4], center = true);
        }
    // feritoie dove entrano i ganci, sul lato sinistro
    for (i = [0 : V2_GANCI - 1]) {
        z = V2_VANO_Z0 + 10 + i * (V2_VANO_Z - 20) / (V2_GANCI - 1);
        translate([V2_VANO_X0 - V2_VANO_X/2 - V2_COP_BATTUTA/2,
                   V2_RETRO_PROF - V2_COP_SP - 1.4, z])
            cube([V2_COP_BATTUTA + 1, 2.0, 9], center = true);
    }
}

// ------------------------------------------------------------------
// USB-C sul bordo inferiore, con la stessa porticina del cubo
// ------------------------------------------------------------------
module foro_usb_v2() {
    translate([V2_USB_X, V2_RETRO_PROF/2, -0.1])
        cube([USB_W, USB_H, V2_PARETE + 2], center = true);
}

module fori_viti_retro() {
    for (p = V2_VITI)
        translate([p[0], V2_RETRO_PROF + 0.1, V2_Z/2 + p[1]])
            rotate([90, 0, 0])
                foro_svasato(V2_RETRO_PROF + 0.2);
}
