// ============================================================
// libreria.scad — forme di base riusate da tutti i pezzi
// ============================================================
include <parametri.scad>

$fn = RISOLUZIONE;

// Prisma a sezione rettangolare con angoli arrotondati.
module piastra(x, y, h, r) {
    linear_extrude(height = h)
        offset(r = r) square([x - 2*r, y - 2*r], center = true);
}

// Scatola piena con angoli verticali arrotondati (rv) e bordo
// superiore raccordato (rt). Il raccordo è approssimato a gradini
// uniti con hull(): resta liscio e si stampa senza supporti.
module scatola_arrotondata(x, y, z, rv, rt, passi = 12) {
    union() {
        piastra(x, y, z - rt, rv);
        for (i = [0 : passi - 1]) {
            a0 = 90 * i / passi;
            a1 = 90 * (i + 1) / passi;
            k0 = rt * (1 - cos(a0));  k1 = rt * (1 - cos(a1));
            h0 = rt * sin(a0);        h1 = rt * sin(a1);
            hull() {
                translate([0, 0, z - rt + h0])
                    piastra(x - 2*k0, y - 2*k0, 0.02, max(rv - k0, 0.6));
                translate([0, 0, z - rt + h1])
                    piastra(x - 2*k1, y - 2*k1, 0.02, max(rv - k1, 0.6));
            }
        }
    }
}

// Foro di passaggio per vite con svasatura della testa (testa in basso,
// si avvita dal basso verso l'alto).
module foro_svasato(h = 10, d = VITE_FORO, testa_d = VITE_TESTA_D, testa_h = 1.6) {
    translate([0, 0, -0.1]) cylinder(h = h + 0.2, d = d);
    translate([0, 0, -0.1]) cylinder(h = testa_h + 0.1, d1 = testa_d, d2 = d);
}

// Pilastrino con sede per inserto a caldo M2,5 (si inserisce dal basso).
module boss_inserto(h = 12, d = BOSS_D) {
    difference() {
        cylinder(h = h, d = d);
        translate([0, 0, -0.1]) cylinder(h = INSERTO_H + 0.1, d = INSERTO_D);
        // scarico sopra l'inserto, per la punta della vite
        translate([0, 0, INSERTO_H]) cylinder(h = h, d = VITE_D + 0.4);
    }
}

// Griglia di fori a nido d'ape dentro un cerchio di diametro d_area.
module griglia_tonda(d_area, spessore, d_foro = ALT_GRIGLIA_D, passo = 3.2) {
    n = ceil(d_area / passo) + 2;
    for (i = [-n : n], j = [-n : n]) {
        x = i * passo + (abs(j) % 2) * passo / 2;
        y = j * passo * 0.866;
        if (sqrt(x*x + y*y) <= (d_area - d_foro) / 2)
            translate([x, y, -0.1]) cylinder(h = spessore + 0.2, d = d_foro);
    }
}

// Fessura allungata (slot) con estremi arrotondati, asse X.
module fessura(lung, larg, h) {
    hull() {
        translate([-(lung - larg)/2, 0, 0]) cylinder(h = h, d = larg);
        translate([ (lung - larg)/2, 0, 0]) cylinder(h = h, d = larg);
    }
}

// Scritta in rilievo (per i provini e le etichette).
module scritta(t, dim = 6, alt = 0.6) {
    linear_extrude(height = alt)
        text(t, size = dim, halign = "center", valign = "center",
             font = "Helvetica:style=Bold");
}

// Freccia piena, punta verso +X, usata per le icone dei tasti.
module freccia(lung = 16, larg = 14, alt = 0.8) {
    gambo = larg / 5;          // mezza larghezza del gambo
    testa = lung * 0.45;       // lunghezza della punta
    linear_extrude(height = alt)
        polygon([[-lung/2, -gambo], [lung/2 - testa, -gambo],
                 [lung/2 - testa, -larg/2], [lung/2, 0],
                 [lung/2 - testa, larg/2], [lung/2 - testa, gambo],
                 [-lung/2, gambo]]);
}

// Icona "volume": tre barrette crescenti, asse X.
module icona_volume(n = 3, alt = 0.8, passo = 3.2, base = 2.0, cresc = 1.6) {
    for (i = [0 : n - 1])
        translate([i * passo, 0, 0])
            linear_extrude(height = alt)
                square([1.8, base + i * cresc], center = true);
}

// Cava a sezione rettangolare arrotondata, asse di estrusione Y.
// Utile per finestre e fessure nelle pareti verticali.
module cava_y(x, z, prof, r = 1.5) {
    rotate([90, 0, 0])
        linear_extrude(height = prof, center = true)
            offset(r = r) square([x - 2*r, z - 2*r], center = true);
}

// Pilastrino che parte dal piano del fondo e ospita un inserto a caldo
// (inserito dal basso). La punta conica in alto lo rende stampabile
// anche a scatola capovolta.
module boss_fondo(h = 12) {
    union() {
        difference() {
            cylinder(h = h, d = BOSS_D);
            translate([0, 0, -0.1]) cylinder(h = INSERTO_H + 0.1, d = INSERTO_D);
            translate([0, 0, INSERTO_H]) cylinder(h = h, d = VITE_D + 0.6);
        }
        translate([0, 0, h]) cylinder(h = BOSS_D/2, d1 = BOSS_D, d2 = 0.4);
    }
}

// Pilastrino appeso al soffitto (coperchio): l'inserto entra dal basso.
module boss_soffitto(h = 7) {
    difference() {
        translate([0, 0, -h]) cylinder(h = h, d = BOSS_D);
        translate([0, 0, -h - 0.1]) cylinder(h = INSERTO_H + 0.1, d = INSERTO_D);
    }
}
