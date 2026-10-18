#!/usr/bin/env python3
"""
Banco di prova della web UI, senza hardware.

    python3 test/webui-locale/server.py
    poi apri http://localhost:8081 (anche dal telefono, con l'IP del Mac)

Serve le pagine vere di ESPuino (firmware/ESPuino/html) e finge il box:
risponde alle chiamate REST con dati plausibili, così l'interfaccia si
carica, cambia lingua e si naviga come se il box ci fosse.

A cosa serve davvero:
 - verificare la traduzione italiana pagina per pagina (task 3);
 - disegnare e cronometrare le pagine nuove, "Controllo genitori" (task 6)
   e "Backup" (task 7), senza aspettare i componenti;
 - misurare il criterio di accettazione "una statuina nuova si associa dal
   telefono in meno di 30 secondi".

Quello che NON fa: niente audio, niente lettore NFC, niente SD vera.
Le risposte sono finte e stanno qui sotto, in STATO.
"""
import json
import re
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path

RADICE = Path(__file__).resolve().parent.parent.parent
HTML = RADICE / "firmware" / "ESPuino" / "html"
PORTA = 8081

# Stato finto del box: basta a far vivere l'interfaccia.
STATO = {
    "settings": {
        "general": {
            "initVolume": 6, "maxVolumeSpeaker": 14, "maxVolumeHeadphone": 10,
            "minVolume": 2, "sleepInactivity": 10, "language": 4,
        },
        "wifi": {"hostname": "faba-cucina", "scanWiFiOnStart": True},
        "led": {"initBrightness": 16, "nightBrightness": 2, "numLeds": 0},
        "battery": {
            "warningLowVoltage": 3.4, "voltageIndicatorLow": 3.0,
            "voltageIndicatorHigh": 4.2, "batteryCheckInterval": 10,
        },
        "rfid": {"readerType": 3, "pn5180Lpcd": True, "pn5180Debounce": 500},
        "playback": {
            "pauseWhenRfidRemoved": True, "savePlayPosShutdown": True,
            "savePlayPosRfidChange": True,
        },
    },
    "info": {
        "software": "boxstorie 1.0-dev", "git": "0b316c4", "branch": "main",
        "ipv4": "192.168.1.42", "rssi": -58, "freeHeap": 142000,
        "freePSRam": 7900000, "hwmodel": "ESP32-S3", "hwrevision": 0,
        "hwfreq": 240,
    },
    "status": {
        "volume": 6, "playstate": "pause", "currentTrack": "La volpe e il bosco",
        "trackNumber": 2, "trackCount": 5, "batteryVoltage": 3.92,
        "batterySoc": 74.0,
    },
    # due statuine e un vinile gia' associati, per avere qualcosa in elenco
    "rfid": [
        {"id": "044213706D5E80", "fileOrUrl": "/storie/La volpe e il bosco",
         "playMode": 3, "lastPlayPos": 0, "trackLastPlayed": 0},
        {"id": "04A1B2C3D4E5F6", "fileOrUrl": "/storie/Il drago gentile",
         "playMode": 3, "lastPlayPos": 0, "trackLastPlayed": 0},
        {"id": "04FFEEDDCCBBAA", "fileOrUrl": "/musica/Ninna nanna",
         "playMode": 1, "lastPlayPos": 0, "trackLastPlayed": 0},
    ],
}

ALBERO_SD = {
    "/": [
        {"name": "storie", "dir": True},
        {"name": "musica", "dir": True},
        {"name": "sistema", "dir": True},
        {"name": "nanna", "dir": True},
    ],
    "/storie": [
        {"name": "La volpe e il bosco", "dir": True},
        {"name": "Il drago gentile", "dir": True},
    ],
    "/storie/La volpe e il bosco": [
        {"name": "01 - inizio.mp3", "dir": False, "size": 2411520},
        {"name": "02 - il bosco.mp3", "dir": False, "size": 3014656},
    ],
    "/musica": [{"name": "Ninna nanna", "dir": True}],
    "/sistema": [{"name": "avvio.mp3", "dir": False, "size": 51200}],
    "/nanna": [{"name": "nanna-01.mp3", "dir": False, "size": 61440}],
}


# ESPuino costruisce il percorso dei dizionari come "http://<host>/locales/..."
# senza la porta, perche' sul box vero la web UI sta sulla 80. Qui gira sulla
# 8081, quindi la richiesta fallirebbe e le pagine resterebbero con le chiavi
# grezze al posto del testo. Serviamo la pagina con quel percorso reso
# relativo: e' una correzione del banco di prova, il fork non si tocca.
PATCH = [
    ('"http://" + host + "/locales/{{lng}}.json"', '"/locales/{{lng}}.json"'),
]


class Finto(SimpleHTTPRequestHandler):
    def __init__(self, *a, **kw):
        super().__init__(*a, directory=str(HTML), **kw)

    def _servi_html(self, nome):
        testo = (HTML / nome).read_text(encoding="utf-8")
        for prima, dopo in PATCH:
            testo = testo.replace(prima, dopo)
        corpo = testo.encode("utf-8")
        self.send_response(200)
        self.send_header("Content-Type", "text/html; charset=utf-8")
        self.send_header("Content-Length", str(len(corpo)))
        self.end_headers()
        self.wfile.write(corpo)

    def log_message(self, formato, *args):
        if "/locales/" in self.path or self.path.endswith((".js", ".css")):
            return
        super().log_message(formato, *args)

    # ---------- risposte finte ----------
    def _json(self, payload, codice=200):
        corpo = json.dumps(payload).encode("utf-8")
        self.send_response(codice)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(corpo)))
        self.send_header("Access-Control-Allow-Origin", "*")
        self.end_headers()
        self.wfile.write(corpo)

    def do_GET(self):
        percorso = self.path.split("?")[0]
        if percorso == "/":
            self.send_response(302)
            self.send_header("Location", "/management.html")
            self.end_headers()
            return
        if percorso.startswith("/api/") or percorso in ("/settings", "/info"):
            return self._api_get(percorso)
        if percorso.endswith(".html") and (HTML / percorso.lstrip("/")).is_file():
            return self._servi_html(percorso.lstrip("/"))
        return super().do_GET()

    def _api_get(self, percorso):
        if "settings" in percorso:
            return self._json(STATO["settings"])
        if "info" in percorso:
            return self._json(STATO["info"])
        if "status" in percorso or "track" in percorso:
            return self._json(STATO["status"])
        if "rfid" in percorso or "nvs" in percorso:
            return self._json(STATO["rfid"])
        if "explorer" in percorso or "files" in percorso:
            cartella = re.sub(r".*path=", "", self.path) if "path=" in self.path else "/"
            cartella = cartella.replace("%2F", "/") or "/"
            return self._json(ALBERO_SD.get(cartella.rstrip("/") or "/", []))
        return self._json({"ok": True})

    def do_POST(self):
        lunghezza = int(self.headers.get("Content-Length", 0) or 0)
        corpo = self.rfile.read(lunghezza) if lunghezza else b""
        print(f"  POST {self.path}: {corpo[:160].decode('utf-8', 'replace')}")
        self._json({"ok": True})

    do_PUT = do_POST
    do_DELETE = do_POST


def main():
    if not HTML.is_dir():
        raise SystemExit(f"Manca {HTML}: lancia prima ./firmware/setup-fork.sh")
    print(f"Web UI di prova su http://localhost:{PORTA}  (Ctrl+C per fermare)")
    print(f"Dal telefono: http://<ip-del-mac>:{PORTA}\n")
    ThreadingHTTPServer(("0.0.0.0", PORTA), Finto).serve_forever()


if __name__ == "__main__":
    main()
