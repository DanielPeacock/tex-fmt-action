#!/bin/bash -eu

#!/bin/bash -euo pipefail

FILES=$(find "$INPUT_INPUTS" \( -name "*.tex" -o -name "*.bib" -o -name "*.cls" -o -name "*.sty" \))

if [[ -z "$FILES" ]]; then
  echo "No files found to check"
  exit 0
fi

FAIL=0
for file in $FILES; do
  tex-fmt $INPUT_OPTS "$file" || FAIL=1
done

exit $FAIL

