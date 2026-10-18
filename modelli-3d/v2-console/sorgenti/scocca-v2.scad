// ============================================================
// scocca-v2.scad — guscio anteriore della console da viaggio
// ------------------------------------------------------------
// Porta la faccia che si guarda e si tocca — due tasti sotto i
// pollici, griglia dell'altoparlante, cursore del volume,
// finestrella del LED — e la fessura dove si infilano carte e
// dischi, con la guida che li accompagna fino all'antenna.
//
// La carta entra di lato corto e ne sporge un centimetro: la
// spira del tag, che corre lungo tutto il bordo della CR80,
// finisce così davanti all'antenna invece che a metà fuori.
// È la differenza fra una lettura sicura e un'incognita.
//
// STAMPA: faccia in giù sul piano, come il cubo. La superficie
// che si vede è il primo strato, i fori sono passanti e la
// fessura è aperta in alto: nessun supporto.
// ============================================================
include <parametri-v2.scad>
include <../../sorgenti/libreria.scad>

scocca_v2();

// ------------------------------------------------------------------
// Il guscio: sezione a rettangolo arrotondato nel piano della faccia,
// estrusa in profondità, col bordo anteriore raccordato.
// ------------------------------------------------------------------
module sezione_faccia(x, z, altezza, r) {
    translate([0, 0, z / 2])
        rotate([-90, 0, 0])
            linear_extrude(height = altezza)
                offset(r = r) square([x - 2*r, z - 2*r], center = true);
}

module corpo_v2(prof, bordo = 3, passi = 10) {
    union() {
        translate([0, bordo, 0]) sezione_faccia(V2_X, V2_Z, prof - bordo, V2_RAGGIO);
        for (i = [0 : passi - 1]) {
            a0 = 90 * i / passi;
            a1 = 90 * (i + 1) / passi;
            k0 = bordo * (1 - cos(a0));  k1 = bordo * (1 - cos(a1));
            y0 = bordo - bordo * sin(a0); y1 = bordo - bordo * sin(a1);
            hull() {
                translate([0, y0, 0])
                    sezione_faccia(V2_X - 2*k0, V2_Z - 2*k0, 0.02, max(V2_RAGGIO - k0, 0.6));
                translate([0, y1, 0])
                    sezione_faccia(V2_X - 2*k1, V2_Z - 2*k1, 0.02, max(V2_RAGGIO - k1, 0.6));
            }
        }
    }
}

module scocca_v2() {
    difference() {
        union() {
            guscio();
            guida_fessura();
            tubo_altoparlante_v2();
            pad_led();
        }
        cava_fessura();
        fori_tasti();
        fessura_cursore_v2();
        finestra_led_v2();
        sede_altoparlante_v2();
        griglia_v2();
        fori_viti();
    }
    colonnine_viti();
    sedi_antenna();
    culla_cursore_v2();
    culla_batteria_v2();
}

module guscio() {
    difference() {
        corpo_v2(V2_SPLIT);
        // cavità: aperta verso il retro
        translate([0, V2_PARETE, 0])
            sezione_faccia(V2_X - 2*V2_PARETE, V2_Z - 2*V2_PARETE,
                           V2_SPLIT, V2_RAGGIO - V2_PARETE);
    }
}

// ------------------------------------------------------------------
// Fessura e guida
// ------------------------------------------------------------------
// Il piano della carta sta a V2_CARTA_Y dal fronte: davanti ci passa
// la sede del LED, dietro l'antenna.
V2_CARTA_Y = 9.5;
V2_FONDO_TASCA = V2_Z - V2_FESS_PROF;

module guida_fessura() {
    // due pareti che accompagnano la carta, più il fondo su cui si ferma
    for (sy = [-1, 1])
        translate([0, V2_CARTA_Y + sy * (V2_FESS_SPESS/2 + 1.1),
                   V2_FONDO_TASCA + V2_FESS_PROF/2])
            cube([V2_FESS_LARG + 7, 2.2, V2_FESS_PROF], center = true);
    // fondo della tasca
    translate([0, V2_CARTA_Y, V2_FONDO_TASCA - 1.5])
        cube([V2_FESS_LARG + 7, V2_FESS_SPESS + 4.4, 3], center = true);
    // fianchi, perché la carta non scappi di lato
    for (sx = [-1, 1])
        translate([sx * (V2_FESS_LARG/2 + 1.6), V2_CARTA_Y,
                   V2_FONDO_TASCA + V2_FESS_PROF/2])
            cube([3.2, V2_FESS_SPESS + 4.4, V2_FESS_PROF], center = true);
}

module cava_fessura() {
    // il canale vero, aperto in alto
    translate([0, V2_CARTA_Y, V2_FONDO_TASCA + V2_FESS_PROF/2 + 1])
        cube([V2_FESS_LARG, V2_FESS_SPESS, V2_FESS_PROF + 4], center = true);
    // imbuto d'ingresso: si infila anche al buio, senza prendere la mira
    translate([0, V2_CARTA_Y, V2_Z - V2_IMBUTO/2 + 0.01])
        hull() {
            cube([V2_FESS_LARG, V2_FESS_SPESS, 0.02], center = true);
            translate([0, 0, V2_IMBUTO])
                cube([V2_FESS_LARG + 5, V2_FESS_SPESS + 5, 0.02], center = true);
        }
}

// Sede del PN5180 e del foglio di ferrite, subito dietro la guida.
//
// La ferrite e' un foglio magnetico adesivo che si incolla sul retro
// dell'antenna: concentra il campo verso la carta infilata e fa da
// schermo verso il vano, altrimenti il lettore leggerebbe le carte in
// deposito a 12-18 mm e partirebbe una storia da sola. Qui c'e' la sede
// che la tiene piatta; si ritaglia con le forbici 5-10 mm piu' grande
// della spira.
V2_ANT_Y = V2_CARTA_Y + V2_FESS_SPESS/2 + 2.4;   // 14,4: subito dietro la guida

module sedi_antenna() {
    // telaio che trattiene il modulo: tre lati chiusi, il quarto aperto
    // per infilarlo dall'alto a guscio aperto
    translate([0, V2_ANT_Y + PN_ALT/2, V2_FONDO_TASCA + PN_Y/2 - 2])
        difference() {
            cube([PN_X + 5, PN_ALT, PN_Y + 5], center = true);
            cube([PN_X + GIOCO, PN_ALT + 1, PN_Y + GIOCO], center = true);
            translate([0, 0, PN_Y/2 + 2]) cube([PN_X - 12, PN_ALT + 2, 6], center = true);
        }
    // appoggio della ferrite, dietro l'antenna
    translate([0, V2_ANT_Y + PN_ALT + V2_FERRITE_SP/2 + 0.3,
               V2_FONDO_TASCA + PN_Y/2 - 2])
        difference() {
            cube([V2_FERRITE_X + 4, V2_FERRITE_SP + 0.6, V2_FERRITE_Z + 4], center = true);
            cube([V2_FERRITE_X + GIOCO, V2_FERRITE_SP + 1.6, V2_FERRITE_Z + GIOCO], center = true);
        }
}

// ------------------------------------------------------------------
// Culla del cursore e collare anti-briciole, come sul cubo
// ------------------------------------------------------------------
module culla_cursore_v2() {
    // pilastrini con inserto a caldo: ci si avvita la culla del
    // potenziometro, cosi' la levetta resta allineata alla fessura
    for (sx = [-1, 1])
        translate([V2_CURSORE_X + sx * V2_CURSORE_VITI, V2_PARETE, V2_CURSORE_Z])
            rotate([-90, 0, 0])
                difference() {
                    cylinder(h = CURSORE_Z_SOTTO, d = BOSS_D);
                    translate([0, 0, CURSORE_Z_SOTTO - INSERTO_H])
                        cylinder(h = INSERTO_H + 0.1, d = INSERTO_D);
                }
    // collare: le briciole che entrano dalla fessura restano qui
    sp = 2;
    translate([V2_CURSORE_X, V2_PARETE, V2_CURSORE_Z])
        rotate([-90, 0, 0])
            difference() {
                piastra(V2_CURSORE_COLLARE, CURSORE_LARG + 2*sp + 3, TOP_SP + 1, 2);
                translate([0, 0, -0.1])
                    piastra(V2_CURSORE_COLLARE - 2*sp, CURSORE_LARG + 3, TOP_SP + 1.2, 1);
            }
}

// ------------------------------------------------------------------
// Culla anteriore della batteria
// ------------------------------------------------------------------
// Il portabatteria e' alto 20 mm e la meta' posteriore ne offre 16,6:
// sta a cavallo dei due gusci, con una culla per parte. In una versione
// da viaggio e' anche piu' solido che appoggiarlo da un lato solo.
module culla_batteria_v2() {
    // la batteria sta in piedi: le culle sono due, sopra e sotto
    for (sz = [-1, 1])
        translate([V2_BATT_X, V2_PARETE + (V2_SPLIT - V2_PARETE)/2,
                   V2_BATT_Z + sz * (BATT_HOLDER_Y/2 - 4)])
            difference() {
                cube([BATT_HOLDER_X + 2*2.4, V2_SPLIT - V2_PARETE, 6], center = true);
                translate([0, 2, 0])
                    cube([BATT_HOLDER_X + GIOCO, V2_SPLIT, 7], center = true);
            }
}

// ------------------------------------------------------------------
// Comandi sulla faccia
// ------------------------------------------------------------------
module fori_tasti() {
    for (sx = [-1, 1])
        translate([sx * V2_TASTO_X, -1, V2_TASTO_Z])
            rotate([-90, 0, 0])
                cylinder(h = V2_PARETE + 2, d = TASTO_FORO + GIOCO_FORO);
}

// Il cursore sta sulla faccia, come sul cubo: in basso a sinistra, sotto il
// tasto, con le icone del volume incise ai due capi. Era finito sul bordo
// inferiore quando la griglia dell'altoparlante stava al centro e sulla
// faccia non restavano i 52 mm che servono; spostata la griglia a destra,
// lo spazio c'e' e il comando torna dove il bambino lo vede.
module fessura_cursore_v2() {
    translate([V2_CURSORE_X, -1, V2_CURSORE_Z])
        rotate([-90, 0, 0])
            fessura(CURSORE_CORSA + 9, CURSORE_FESSURA_W, V2_PARETE + 2);
    prof = 0.8;
    for (sx = [-1, 1])
        translate([V2_CURSORE_X + sx * (CURSORE_CORSA/2 + 8), -0.1, V2_CURSORE_Z])
            rotate([-90, 0, 0])
                icona_volume(n = sx > 0 ? 3 : 1, alt = prof + 0.1,
                             passo = 4.4, base = 3.5, cresc = 2.5);
}

module pad_led() {
    translate([V2_LED_X, V2_PARETE + 2, V2_LED_Z])
        cube([LED_SEDE_D + 4, 4.4, LED_SEDE_D + 4], center = true);
}

module finestra_led_v2() {
    x = V2_LED_X;
    translate([x, LED_PARETE, V2_LED_Z])
        rotate([-90, 0, 0])
            cylinder(h = V2_PARETE - LED_PARETE + LED_SEDE_PROF, d = LED_FINESTRA_D);
    translate([x, V2_PARETE, V2_LED_Z])
        rotate([-90, 0, 0])
            cylinder(h = LED_SEDE_PROF, d = LED_SEDE_D);
}

// ------------------------------------------------------------------
// Altoparlante
// ------------------------------------------------------------------
module tubo_altoparlante_v2() {
    translate([V2_ALT_X, V2_PARETE + ALT_TUBO_LUNG/2, V2_ALT_Z])
        rotate([-90, 0, 0])
            cylinder(h = ALT_TUBO_LUNG, d = ALT_TUBO_OD, center = true);
}

module sede_altoparlante_v2() {
    sede = ALT_ALT + 1;
    translate([V2_ALT_X, V2_PARETE + sede/2 - 0.05, V2_ALT_Z])
        rotate([-90, 0, 0])
            cylinder(h = sede + 0.1, d = ALT_D + GIOCO_FORO, center = true);
    translate([V2_ALT_X, V2_PARETE + sede + (ALT_TUBO_LUNG - sede)/2, V2_ALT_Z])
        rotate([-90, 0, 0])
            cylinder(h = ALT_TUBO_LUNG - sede + 0.2, d = ALT_CAMERA_SEDE, center = true);
}

module griglia_v2() {
    translate([V2_ALT_X, -0.1, V2_ALT_Z])
        rotate([-90, 0, 0])
            griglia_tonda(ALT_D - 4, V2_PARETE + 0.4);
}

// ------------------------------------------------------------------
// Viti fra i due gusci
// ------------------------------------------------------------------
V2_VITI = [[-V2_X/2 + 9, -V2_Z/2 + 9], [V2_X/2 - 9, -V2_Z/2 + 9],
           [-V2_X/2 + 9, V2_Z/2 - 9], [V2_X/2 - 9, V2_Z/2 - 9]];

module colonnine_viti() {
    for (p = V2_VITI)
        translate([p[0], V2_PARETE, V2_Z/2 + p[1]])
            rotate([-90, 0, 0])
                difference() {
                    cylinder(h = V2_SPLIT - V2_PARETE, d = BOSS_D);
                    translate([0, 0, V2_SPLIT - V2_PARETE - INSERTO_H])
                        cylinder(h = INSERTO_H + 0.1, d = INSERTO_D);
                }
}

module fori_viti() { } // i fori stanno nel guscio posteriore
