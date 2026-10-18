#!/usr/bin/env bash
# Esegue le verifiche dei nostri moduli sul Mac, senza hardware.
#
#   ./firmware/prove.sh
#
# I moduli in firmware/moduli/ sono scritti apposta senza niente di Arduino
# dentro: ricevono ora e stato dall'esterno e restituiscono una decisione.
# Per questo si compilano e si provano qui in un secondo, invece che a ogni
# giro di flash sul box.
set -euo pipefail
cd "$(dirname "$0")/.."

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

# Scegli un compilatore che sappia davvero compilare C++: su questo Mac il
# clang dei Command Line Tools non trova i propri header (<cstdio> & co.),
# quindi si ripiega su quello di Homebrew.
scegli_compilatore() {
  printf '#include <cstdio>\nint main(){}\n' > "$TMP/sonda.cpp"
  for c in ${CXX:-} c++ clang++ g++-16 g++-15 g++-14 g++; do
    [ -n "$c" ] || continue
    command -v "$c" >/dev/null 2>&1 || continue
    if "$c" -std=c++17 "$TMP/sonda.cpp" -o "$TMP/sonda" >/dev/null 2>&1; then
      echo "$c"; return 0
    fi
  done
  echo "Nessun compilatore C++ utilizzabile. Prova: brew install gcc" >&2
  return 1
}

CXX_OK=$(scegli_compilatore)
echo "Compilatore: $CXX_OK"

esegui() {   # esegui <nome> <sorgenti...>
  local nome=$1; shift
  printf '\n=== %s ===\n' "$nome"
  "$CXX_OK" -std=c++17 -Wall -Wextra -Werror -O1 -o "$TMP/$nome" "$@"
  "$TMP/$nome"
}

esegui controllo-genitori \
  firmware/moduli/prove/prove-controllo-genitori.cpp \
  firmware/moduli/controllo-genitori/ControlloGenitori.cpp

echo
echo "Tutte le verifiche passate."
