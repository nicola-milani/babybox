#!/usr/bin/env bash
# Crea il fork di ESPuino sul tuo account GitHub e lo aggancia come
# submodule in firmware/ESPuino.
#
# Prima volta:  gh auth login
# Poi:          ./firmware/setup-fork.sh
set -euo pipefail
cd "$(dirname "$0")/.."

UPSTREAM="biologist79/ESPuino"
DEST="firmware/ESPuino"

command -v gh >/dev/null || { echo "Serve gh: brew install gh"; exit 1; }
gh auth status >/dev/null 2>&1 || { echo "Prima: gh auth login"; exit 1; }

UTENTE=$(gh api user --jq .login)
echo "Account GitHub: $UTENTE"

if gh repo view "$UTENTE/ESPuino" >/dev/null 2>&1; then
  echo "Fork già presente: $UTENTE/ESPuino"
else
  echo "Creo il fork di $UPSTREAM..."
  gh repo fork "$UPSTREAM" --clone=false --remote=false
fi

if [ -e "$DEST" ]; then
  echo "$DEST esiste già: niente da fare."
else
  git submodule add "https://github.com/$UTENTE/ESPuino.git" "$DEST"
  git -C "$DEST" remote add upstream "https://github.com/$UPSTREAM.git" || true
  git -C "$DEST" fetch upstream --quiet
  echo "Submodule aggiunto. 'upstream' punta a $UPSTREAM per gli allineamenti (task 5)."
fi

cat <<'FINE'

Fatto. Prossimi passi:
  1. git add .gitmodules firmware/ESPuino && git commit -m "Fork di ESPuino come submodule"
  2. In VS Code: estensione PlatformIO IDE, poi apri boxaudiobimbo.code-workspace
  3. Prima compilazione SENZA modifiche per l'ambiente ESP32-S3 (deve passare)
FINE
