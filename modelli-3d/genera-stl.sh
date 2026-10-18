#!/usr/bin/env bash
# Rigenera tutti gli STL dai sorgenti OpenSCAD.
# Uso:  ./modelli-3d/genera-stl.sh
# Richiede OpenSCAD:  brew install --cask openscad@snapshot
set -euo pipefail
cd "$(dirname "$0")"

OPENSCAD=${OPENSCAD:-openscad}
command -v "$OPENSCAD" >/dev/null || {
  echo "OpenSCAD non trovato. brew install --cask openscad@snapshot"; exit 1; }

genera() {              # genera <cartella> <nome>
  local dir=$1 nome=$2
  mkdir -p "$dir/stl"
  echo "  $nome"
  "$OPENSCAD" --export-format binstl -o "$dir/stl/$nome.stl" \
              -D 'RISOLUZIONE=96' "$dir/sorgenti/$nome.scad" 2>&1 \
    | grep -Ei 'warning|error' || true
}

echo "Case:"
for n in scocca fondo piatto-nfc pomello-cursore culla-cursore \
         camera-altoparlante sportellino-batteria sportello-usb; do genera case "$n"; done
echo "Raccoglitori:"
for n in raccoglitore-carte raccoglitore-dischi; do genera raccoglitori "$n"; done
echo "Dischi della musica:"
genera vinili vinile

# Le statuine non fanno piu' parte della 1.0: le storie stanno su carte di
# PVC comprate gia' pronte. I sorgenti restano in modelli-3d/statuine/ per
# chi volesse stampare un personaggio.
echo "Console v2 (variante):"
for n in scocca-v2 retro-v2 coperchio-vano; do genera v2-console "$n"; done

echo "Provini:"
for n in provino-nfc calibro-parti-piccole; do genera provini "$n"; done
echo "Fatto."
