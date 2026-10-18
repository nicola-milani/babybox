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
            pad_sportello_v2();
            sede_tasto_genitori_v2();
        }
        sedi_coperchio();
        apertura_vano();
        cava_sportello_v2();
        foro_usb_v2();
        taglio_interruttore_v2();
        foro_tasto_genitori_v2();
        sfiati_batteria();
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
                   V2_BATT_Z + sz * V2_BATT_BRACCI])
            difference() {
                cube([BATT_HOLDER_X + 2*2.4, V2_RETRO_PROF - V2_PARETE, 6], center = true);
                translate([0, -2, 0])
                    cube([BATT_HOLDER_X + GIOCO, V2_RETRO_PROF, 7], center = true);
            }
    // asole per una fascetta: la cella non salta via se la console cade
    for (sz = [-1, 1])
        translate([V2_BATT_X, V2_PARETE + 1.5, V2_BATT_Z + sz * V2_BATT_FASCETTE])
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
// Carte e dischi stanno di piatto, uno sull'altro: il vano e' 96 x 64 e
// profondo 13. Una CR80 e' 85,6 x 54, quindi ci sta distesa con cinque
// millimetri di margine; in piedi non ci starebbe mai, perche' in piedi
// vorrebbe 85,6 mm di profondita' e ce ne sono 13. Sei carte fanno 5 mm,
// tre dischi da 4 ne fanno 12: il fondo della profondita' e' dimensionato
// sui dischi.
//
// Niente divisori, quindi. Per tirare fuori una carta si apre il
// coperchio e si inclina la console: con 5 mm di margine il dito da solo
// non passa, ma basta ribaltarla.
module pareti_vano() {
    // cassa del vano, aperta verso il retro
    translate([V2_VANO_X0, V2_RETRO_PROF - V2_VANO_PROF/2 - V2_PARETE,
               V2_VANO_Z0 + V2_VANO_Z/2])
        difference() {
            cube([V2_VANO_X + 2*V2_PARETE, V2_VANO_PROF + V2_PARETE,
                  V2_VANO_Z + 2*V2_PARETE], center = true);
            cube([V2_VANO_X, V2_VANO_PROF + V2_PARETE + 1, V2_VANO_Z], center = true);
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
// USB-C sul bordo inferiore, con la porticina scorrevole
// ------------------------------------------------------------------
// La presa resta un po' arretrata (sotto ci passa l'ispessimento della
// gola), quindi il tunnel e' piu' generoso che sul cubo: ci deve entrare
// il guscio dello spinotto, non solo la punta.
module foro_usb_v2() {
    translate([V2_USB_X, V2_RETRO_PROF/2, (V2_PARETE + V2_SPORT_PAD)/2 - 0.1])
        cube([V2_USB_W, V2_USB_H, V2_PARETE + V2_SPORT_PAD + 2], center = true);
}

// Ispessimento interno sopra la corsa: una parete da 2,4 non contiene una
// gola da 3.
module pad_sportello_v2() {
    lung = V2_SPORT_X2 - V2_SPORT_X1 + 12;
    translate([(V2_SPORT_X1 + V2_SPORT_X2)/2, V2_RETRO_PROF/2,
               V2_PARETE + V2_SPORT_PAD/2])
        cube([lung, V2_SPORT_GOLA + 6, V2_SPORT_PAD], center = true);
}

// Cava della porticina: dentro e' piu' alta della fessura a vista, cosi'
// la piastrina resta prigioniera e non diventa un pezzo che si stacca.
module cava_sportello_v2() {
    centro = (V2_SPORT_X1 + V2_SPORT_X2) / 2;
    corsa  = V2_SPORT_X2 - V2_SPORT_X1;
    translate([centro, V2_RETRO_PROF/2, V2_SPORT_PROF_GOLA/2 - 0.01])
        cube([corsa, V2_SPORT_GOLA, V2_SPORT_PROF_GOLA], center = true);
    translate([centro, V2_RETRO_PROF/2, V2_SPORT_PROF_APE/2 - 0.06])
        cube([corsa, V2_SPORT_APERTURA, V2_SPORT_PROF_APE + 0.1], center = true);
}

// ------------------------------------------------------------------
// Comandi dell'adulto: interruttore generale e tasto genitori
// ------------------------------------------------------------------
module taglio_interruttore_v2() {
    // passaggio della levetta
    translate([V2_SW_X, V2_RETRO_PROF - V2_PARETE/2, V2_SW_Z])
        cava_y(SW_FORO_X, SW_FORO_Y, V2_PARETE + 1, r = 1);
    // incasso del corpo dall'esterno: la levetta non sporge dal profilo
    translate([V2_SW_X, V2_RETRO_PROF - SW_INCASSO/2 + 0.05, V2_SW_Z])
        cava_y(SW_VITI + 6, SW_FORO_Y + 6, SW_INCASSO + 0.1, r = 1.5);
    // viti di fissaggio
    for (sx = [-1, 1])
        translate([V2_SW_X + sx * SW_VITI/2, V2_RETRO_PROF + 0.5, V2_SW_Z])
            rotate([90, 0, 0])
                cylinder(h = V2_PARETE + 1, d = 2.4);
}

// Foro da 6 mm in un pozzetto: ci entra il polpastrello di un adulto, non
// il dito di un bambino di due anni.
module foro_tasto_genitori_v2() {
    translate([V2_GEN_X, V2_RETRO_PROF + 0.5, V2_GEN_Z])
        rotate([90, 0, 0])
            cylinder(h = V2_PARETE + 1, d = GEN_FORO_D);
    translate([V2_GEN_X, V2_RETRO_PROF + 0.05, V2_GEN_Z])
        rotate([90, 0, 0])
            cylinder(h = GEN_POZZO_H + 0.1, d = GEN_POZZO_D);
}

// Nicchia che tiene fermo il micropulsante 6x6, con un lato aperto per i
// due fili.
module sede_tasto_genitori_v2() {
    lato = 6.6;
    sp   = 1.8;
    h    = 3.5;
    translate([V2_GEN_X, V2_RETRO_PROF - V2_PARETE - h/2, V2_GEN_Z])
        difference() {
            cube([lato + 2*sp, h, lato + 2*sp], center = true);
            translate([0, -0.2, 0]) cube([lato, h + 0.3, lato], center = true);
            translate([0, 0, -(lato/2 + sp/2)]) cube([4, h + 0.4, sp + 0.4], center = true);
        }
}

// Sfiati dietro la batteria, come sul cubo: una cella che si carica scalda
// poco, ma l'aria deve poter uscire.
module sfiati_batteria() {
    for (i = [-1, 0, 1])
        translate([V2_BATT_X, V2_RETRO_PROF - V2_PARETE/2, V2_BATT_Z + i * 20])
            cava_y(6, 16, V2_PARETE + 1, r = 2);
}

module fori_viti_retro() {
    for (p = V2_VITI)
        translate([p[0], V2_RETRO_PROF + 0.1, V2_Z/2 + p[1]])
            rotate([90, 0, 0])
                foro_svasato(V2_RETRO_PROF + 0.2);
}
