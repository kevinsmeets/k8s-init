#!/bin/bash
set -euo pipefail

# Only versioned CLI installers belong in the image, not cluster or host setup scripts.
pin='^([A-Z][A-Z0-9_]*)_VERSION=([0-9][0-9A-Za-z.+_-]*)([[:space:]]+#.*)?[[:space:]]*$'
while IFS= read -r line || [[ -n "$line" ]]; do
    [[ "$line" =~ ^[[:space:]]*(#|$) ]] && continue
    if [[ ! "$line" =~ $pin ]]; then
        printf 'Invalid tool pin in versions.env: %s\n' "$line" >&2
        exit 1
    fi
    tool="${BASH_REMATCH[1],,}"
    version="${BASH_REMATCH[2]}"
    bash -e "inits/get-$tool.sh" --version "$version" </dev/null
done < versions.env
