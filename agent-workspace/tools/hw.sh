#!/usr/bin/env bash
# Run Hades Workshop commands against the unmodified game and print the output.
# The game is opened and auto_load is enabled for you, so only write the commands themselves.
#
#   tools/hw.sh <<'EOF'
#   select spell 12
#   get spell.name
#   get spell.power
#   EOF
#
#   tools/hw.sh some_commands.txt      # same, reading the commands from a file
#
# Exit code: 0 success, 1 errors, 2 warnings only (Hades Workshop's own code).
set -uo pipefail
cd "$(dirname "$0")/.."
source ./mod.conf
mkdir -p build
{
  echo "open \"$FF9_LAUNCHER\""
  echo "config auto_load true"
  if [ $# -ge 1 ]; then cat "$1"; else cat; fi
  echo
} > build/query.txt
"$HW_EXE" -q -i build/query.txt -o build/query.log > /dev/null
code=$?
cat build/query.log
exit $code
