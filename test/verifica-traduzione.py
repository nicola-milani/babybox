#!/usr/bin/env python3
"""
Verifica di accettazione del task 3 (italiano nella web UI).

    python3 test/verifica-traduzione.py

Controlla quattro cose, tutte automatiche:

 1. it.json ha esattamente le stesse chiavi di en.json (niente mancanti,
    niente di troppo): una chiave mancante in i18next si vede come testo
    inglese in mezzo alla pagina.
 2. I segnaposto {{...}} coincidono chiave per chiave: se in italiano
    manca {{rfidId}} il messaggio esce monco.
 3. LogMessages_IT.cpp definisce esattamente gli stessi simboli di
    LogMessages_EN.cpp, e con gli stessi specificatori printf nello
    stesso ordine. Questo e' il controllo che conta davvero: un %s al
    posto di un %u fa crashare il box, non e' un refuso estetico.
 4. Il selettore della lingua in management.html offre l'italiano.

Esce con codice 1 se qualcosa non va, cosi' si puo' mettere in CI.
"""
import json
import re
import sys
from pathlib import Path

RADICE = Path(__file__).resolve().parent.parent
FORK = RADICE / "firmware" / "ESPuino"
LOCALES = FORK / "html" / "locales"
SRC = FORK / "src"

errori = []
avvisi = []


def chiavi(d, prefisso=""):
    """Tutte le chiavi foglia, in notazione puntata."""
    out = {}
    for k, v in d.items():
        nome = f"{prefisso}{k}"
        if isinstance(v, dict):
            out.update(chiavi(v, nome + "."))
        else:
            out[nome] = v
    return out


def controlla_locales():
    en_file, it_file = LOCALES / "en.json", LOCALES / "it.json"
    if not it_file.is_file():
        errori.append(f"manca {it_file.relative_to(RADICE)}")
        return
    en = chiavi(json.loads(en_file.read_text(encoding="utf-8")))
    it = chiavi(json.loads(it_file.read_text(encoding="utf-8")))

    for k in sorted(set(en) - set(it)):
        errori.append(f"locales: chiave mancante in italiano: {k}")
    for k in sorted(set(it) - set(en)):
        errori.append(f"locales: chiave di troppo in italiano: {k}")

    for k in sorted(set(en) & set(it)):
        a = sorted(re.findall(r"\{\{\s*([\w.]+)\s*\}\}", str(en[k])))
        b = sorted(re.findall(r"\{\{\s*([\w.]+)\s*\}\}", str(it[k])))
        if a != b:
            errori.append(f"locales: segnaposto diversi in «{k}»: {a} -> {b}")
        if str(en[k]).strip() and not str(it[k]).strip():
            errori.append(f"locales: traduzione vuota in «{k}»")

    uguali = [k for k in set(en) & set(it) if str(en[k]) == str(it[k])]
    if uguali:
        avvisi.append(
            f"locales: {len(uguali)} voci identiche all'inglese "
            f"(spesso giuste: OK, WiFi, MQTT...): {', '.join(sorted(uguali)[:8])}"
            + (" ..." if len(uguali) > 8 else "")
        )


RE_SIMBOLO = re.compile(r'const\s+char\s+(\w+)\s*\[\s*\]\s*=\s*(".*?")\s*;', re.S)
RE_FORMATO = re.compile(r"%[-+ #0]*[\d.*]*(?:hh|h|ll|l|j|z|t|L)?[diouxXeEfgGaAcspn%]")


def stringhe(percorso):
    testo = percorso.read_text(encoding="utf-8")
    return {m.group(1): m.group(2) for m in RE_SIMBOLO.finditer(testo)}


def controlla_logmessages():
    en_file, it_file = SRC / "LogMessages_EN.cpp", SRC / "LogMessages_IT.cpp"
    if not it_file.is_file():
        errori.append(f"manca {it_file.relative_to(RADICE)}")
        return
    en, it = stringhe(en_file), stringhe(it_file)

    for s in sorted(set(en) - set(it)):
        errori.append(f"LogMessages: simbolo mancante in italiano: {s}")
    for s in sorted(set(it) - set(en)):
        errori.append(f"LogMessages: simbolo di troppo in italiano: {s}")

    for s in sorted(set(en) & set(it)):
        a = [f for f in RE_FORMATO.findall(en[s]) if f != "%%"]
        b = [f for f in RE_FORMATO.findall(it[s]) if f != "%%"]
        if a != b:
            errori.append(
                f"LogMessages: specificatori diversi in «{s}»: {a} -> {b} "
                "(questo fa crashare il box)"
            )

    if not (SRC / "values.h").read_text(encoding="utf-8").count("#define IT"):
        errori.append("values.h: manca «#define IT» fra le lingue")
    guardia = it_file.read_text(encoding="utf-8")
    if "#if (LANGUAGE == IT)" not in guardia:
        errori.append("LogMessages_IT.cpp: manca la guardia #if (LANGUAGE == IT)")


def controlla_interfaccia():
    html = (FORK / "html" / "management.html").read_text(encoding="utf-8")
    if 'value="it"' not in html:
        errori.append("management.html: l'italiano non e' nel selettore della lingua")
    py = (FORK / "processHtml.py").read_text(encoding="utf-8")
    if "locales/it.json" not in py:
        errori.append("processHtml.py: it.json non e' fra i file da incorporare")


def main():
    if not FORK.is_dir():
        print("Manca il fork: ./firmware/setup-fork.sh")
        return 1
    controlla_locales()
    controlla_logmessages()
    controlla_interfaccia()

    for a in avvisi:
        print(f"  nota: {a}")
    if errori:
        print(f"\n{len(errori)} problemi:\n")
        for e in errori:
            print(f"  - {e}")
        return 1
    print("\nTraduzione italiana: tutte le verifiche passate.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
