#!/usr/bin/env python3
"""
Verifica che dentro la console i pezzi non si pestino i piedi.

    python3 modelli-3d/v2-console/verifica-ingombri.py

Confronta a coppie i volumi occupati da ogni componente e dalle cave.
Non sostituisce la prova col pezzo in mano, ma prende gli errori che a
occhio in un render non si vedono: una cava che taglia la camera
acustica si nota solo quando il suono esce male.
"""
import itertools, subprocess, sys, tempfile
from pathlib import Path

P = Path(__file__).parent / "sorgenti"

NOMI = ["V2_X", "V2_Z", "V2_Y", "V2_PARETE", "V2_SPLIT", "V2_FESS_LARG",
        "V2_FESS_SPESS", "V2_FESS_PROF", "V2_TASTO_X", "V2_TASTO_Z", "V2_ALT_Z",
        "V2_CURSORE_Z", "V2_CURSORE_Y", "V2_CURSORE_X", "V2_ALT_X", "V2_CURSORE_COLLARE", "V2_CURSORE_VITI", "V2_LED_Z", "V2_VANO_X", "V2_VANO_Z", "V2_VANO_PROF",
        "V2_VANO_X0", "V2_VANO_Z0", "V2_BATT_X", "V2_BATT_Z", "V2_BATT_Y",
        "V2_BASETTA_X", "V2_BASETTA_Z", "V2_BASETTA_CX", "V2_BASETTA_CZ",
        "V2_USB_X", "V2_TP_X", "V2_TP_Z", "V2_FERRITE_Z",
        "ALT_TUBO_OD", "ALT_TUBO_LUNG", "PN_X", "PN_Y", "PN_ALT",
        "TASTO_CAPPUCCIO", "CURSORE_CORSA", "CURSORE_LARG", "BATT_HOLDER_X",
        "BATT_HOLDER_Y", "BATT_HOLDER_Z", "LED_SEDE_D", "LED_SEDE_PROF"]


def parametri():
    """Li chiede a OpenSCAD: molti sono formule, non numeri scritti a mano."""
    sorgente = "include <parametri-v2.scad>\n" + "".join(
        f'echo("@", "{n}", {n});\n' for n in NOMI)
    with tempfile.NamedTemporaryFile("w", suffix=".scad", dir=P, delete=False) as f:
        f.write(sorgente)
        tmp = Path(f.name)
    try:
        r = subprocess.run(["openscad", "-o", "/dev/null", "--export-format", "asciistl",
                            str(tmp)], capture_output=True, text=True)
    finally:
        tmp.unlink()
    val = {}
    for riga in r.stderr.splitlines():
        if riga.startswith('ECHO: "@"'):
            parti = riga.split(",")
            val[parti[1].strip().strip('"')] = float(parti[2].strip())
    mancanti = [n for n in NOMI if n not in val]
    if mancanti:
        sys.exit(f"parametri non letti: {mancanti}")
    return val


v = parametri()

carta_y = 9.5
fondo_tasca = v["V2_Z"] - v["V2_FESS_PROF"]
ant_y = carta_y + v["V2_FESS_SPESS"] / 2 + 2.4

# (nome, x0, x1, y0, y1, z0, z1)
pezzi = [
    ("cava della fessura", -v["V2_FESS_LARG"]/2, v["V2_FESS_LARG"]/2,
     carta_y - v["V2_FESS_SPESS"]/2, carta_y + v["V2_FESS_SPESS"]/2,
     fondo_tasca, v["V2_Z"]),
    ("lettore PN5180", -(v["PN_X"]+5)/2, (v["PN_X"]+5)/2, ant_y, ant_y + v["PN_ALT"],
     fondo_tasca + v["PN_Y"]/2 - 2 - (v["PN_Y"]+5)/2, fondo_tasca + v["PN_Y"]/2 - 2 + (v["PN_Y"]+5)/2),
    ("ferrite", -32, 32, ant_y + v["PN_ALT"], ant_y + v["PN_ALT"] + 1.1,
     fondo_tasca + v["PN_Y"]/2 - 2 - v["V2_FERRITE_Z"]/2, fondo_tasca + v["PN_Y"]/2 - 2 + v["V2_FERRITE_Z"]/2),
    ("camera altoparlante", v["V2_ALT_X"] - v["ALT_TUBO_OD"]/2, v["V2_ALT_X"] + v["ALT_TUBO_OD"]/2,
     v["V2_PARETE"], v["V2_PARETE"] + v["ALT_TUBO_LUNG"],
     v["V2_ALT_Z"] - v["ALT_TUBO_OD"]/2, v["V2_ALT_Z"] + v["ALT_TUBO_OD"]/2),
    ("tasto sinistro", -v["V2_TASTO_X"] - v["TASTO_CAPPUCCIO"]/2, -v["V2_TASTO_X"] + v["TASTO_CAPPUCCIO"]/2,
     0, 12, v["V2_TASTO_Z"] - v["TASTO_CAPPUCCIO"]/2, v["V2_TASTO_Z"] + v["TASTO_CAPPUCCIO"]/2),
    ("tasto destro", v["V2_TASTO_X"] - v["TASTO_CAPPUCCIO"]/2, v["V2_TASTO_X"] + v["TASTO_CAPPUCCIO"]/2,
     0, 12, v["V2_TASTO_Z"] - v["TASTO_CAPPUCCIO"]/2, v["V2_TASTO_Z"] + v["TASTO_CAPPUCCIO"]/2),
    ("cursore volume, culla compresa", v["V2_CURSORE_X"] - v["V2_CURSORE_VITI"] - 4, v["V2_CURSORE_X"] + v["V2_CURSORE_VITI"] + 4,
     v["V2_CURSORE_Y"] - (v["CURSORE_LARG"]+7)/2, v["V2_CURSORE_Y"] + (v["CURSORE_LARG"]+7)/2,
     0, 16),
    ("LED di stato", -v["V2_TASTO_X"] - 8 - v["LED_SEDE_D"]/2, -v["V2_TASTO_X"] - 8 + v["LED_SEDE_D"]/2,
     0, v["V2_PARETE"] + v["LED_SEDE_PROF"],
     v["V2_LED_Z"] - v["LED_SEDE_D"]/2, v["V2_LED_Z"] + v["LED_SEDE_D"]/2),
    ("batteria", v["V2_BATT_X"] - v["BATT_HOLDER_X"]/2, v["V2_BATT_X"] + v["BATT_HOLDER_X"]/2,
     v["V2_BATT_Y"] - v["BATT_HOLDER_Z"]/2, v["V2_BATT_Y"] + v["BATT_HOLDER_Z"]/2,
     v["V2_BATT_Z"] - v["BATT_HOLDER_Y"]/2, v["V2_BATT_Z"] + v["BATT_HOLDER_Y"]/2),
    ("basetta millefori", v["V2_BASETTA_CX"] - v["V2_BASETTA_X"]/2, v["V2_BASETTA_CX"] + v["V2_BASETTA_X"]/2,
     v["V2_SPLIT"] + 2, v["V2_SPLIT"] + 18,
     v["V2_BASETTA_CZ"] - v["V2_BASETTA_Z"]/2, v["V2_BASETTA_CZ"] + v["V2_BASETTA_Z"]/2),
    ("vano collezione", v["V2_VANO_X0"] - v["V2_VANO_X"]/2, v["V2_VANO_X0"] + v["V2_VANO_X"]/2,
     v["V2_Y"] - v["V2_VANO_PROF"] - v["V2_PARETE"], v["V2_Y"],
     v["V2_VANO_Z0"], v["V2_VANO_Z0"] + v["V2_VANO_Z"]),
    ("modulo di ricarica", v["V2_TP_X"] - 15, v["V2_TP_X"] + 15,
     v["V2_SPLIT"], v["V2_SPLIT"] + 12, v["V2_TP_Z"] - 11, v["V2_TP_Z"] + 11),
]

def sovrappone(a, b):
    s = []
    for i, asse in enumerate("xyz"):
        lo = max(a[1 + 2*i], b[1 + 2*i])
        hi = min(a[2 + 2*i], b[2 + 2*i])
        if hi <= lo:
            return None
        s.append((asse, round(hi - lo, 1)))
    return s

print("Ingombri interni della console v2\n")
problemi = 0
for a, b in itertools.combinations(pezzi, 2):
    s = sovrappone(a, b)
    if s:
        problemi += 1
        dett = ", ".join(f"{asse} {q} mm" for asse, q in s)
        print(f"  SI PESTANO: {a[0]} e {b[0]}  ({dett})")

# dentro il guscio?
for p in pezzi:
    if p[1] < -v["V2_X"]/2 + v["V2_PARETE"] or p[2] > v["V2_X"]/2 - v["V2_PARETE"] \
       or p[5] < 0 or p[6] > v["V2_Z"] or p[4] > v["V2_Y"]:
        problemi += 1
        print(f"  FUORI DAL GUSCIO: {p[0]}")

print(f"\n{len(pezzi)} pezzi confrontati, {problemi} problemi")
sys.exit(1 if problemi else 0)
