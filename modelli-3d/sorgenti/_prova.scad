include <libreria.scad>
scatola_arrotondata(40,30,20,6,3);
translate([50,0,0]) boss_inserto();
translate([80,0,0]) scritta("Prova");
translate([110,0,0]) freccia();
translate([140,0,0]) icona_volume();
translate([0,50,0]) difference(){ cylinder(h=2,d=30); griglia_tonda(28,2);}
translate([0,-50,0]) fessura(40,4,3);
