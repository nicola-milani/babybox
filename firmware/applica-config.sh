#!/usr/bin/env bash
# Porta la nostra configurazione dentro il fork di ESPuino.
#
#   ./firmware/applica-config.sh
#
# settings-override.h e platformio-override.ini sono in .gitignore dentro
# ESPuino (sono i punti di personalizzazione previsti): li colleghiamo con
# un symlink, così si modificano da un posto solo.
# settings-custom.h invece è un file tracciato dal fork: va copiato, e la
# modifica si vede come differenza del submodule. È voluto.
set -euo pipefail
cd "$(dirname "$0")/.."

FORK=firmware/ESPuino
[ -d "$FORK/src" ] || { echo "Manca $FORK: lancia prima ./firmware/setup-fork.sh"; exit 1; }

collega() {   # collega <sorgente> <destinazione>
  local src=$1 dst=$2
  ln -sf "$(cd "$(dirname "$src")" && pwd)/$(basename "$src")" "$dst"
  echo "  symlink  $dst"
}

collega firmware/config/settings-override.h   "$FORK/src/settings-override.h"
collega firmware/config/platformio-override.ini "$FORK/platformio-override.ini"
cp firmware/config/settings-custom.h "$FORK/src/settings-custom.h"
echo "  copia    $FORK/src/settings-custom.h"

echo
echo "Fatto. Compila con:  pio run -e boxstorie -d firmware/ESPuino"
