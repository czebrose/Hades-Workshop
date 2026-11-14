#!/usr/bin/env bash
# Rebuild the Memoria mod folder from scratch:
#   unmodified game + every change file in src/ (in name order) -> save steam into MOD_DIR.
#
# Hades Workshop always starts from the unmodified game, and `save steam` writes only what was
# changed in that run. So the mod must always be rebuilt from ALL change files at once;
# never "add" to the mod with a one-off run.
#
# Error line numbers (Error L42: ...) refer to build/build.txt, where each change file
# starts with a "# --- src/<file>" marker.
set -uo pipefail
cd "$(dirname "$0")/.."
source ./mod.conf
mkdir -p build
shopt -s nullglob
files=(src/*.txt)
if [ ${#files[@]} -eq 0 ]; then echo "No change files in src/"; exit 1; fi
{
  echo "open \"$FF9_LAUNCHER\""
  echo "config auto_load true"
  for f in "${files[@]}"; do
    echo "# --- $f"
    cat "$f"
    echo
  done
  echo "# --- build"
  echo "save steam \"$MOD_DIR\" csv asset"
} > build/build.txt
"$HW_EXE" -q -i build/build.txt -o build/build.log > /dev/null
code=$?
cat build/build.log
exit $code
