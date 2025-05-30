#!/bin/bash -euo pipefail

# Split $INPUT_INPUTS into an array
read -r -a paths <<< "$INPUT_INPUTS"

# Collect files
files=()
for path in "${paths[@]}"; do
  if [[ -e "$path" || -d "$path" ]]; then
    found=$(find "$path" \( -name "*.tex" -o -name "*.bib" -o -name "*.cls" -o -name "*.sty" \))
    files+=($found)
  else
    echo "Warning: '$path' does not exist"
  fi
done

if [[ ${#files[@]} -eq 0 ]]; then
  echo "No files found to check"
  exit 0
fi

# Run tex-fmt and fail if any file fails
FAIL=0
for file in "${files[@]}"; do
  tex-fmt $INPUT_OPTS "$file" || FAIL=1
done

exit $FAIL
