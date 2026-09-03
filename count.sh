#!/usr/bin/env bash
set -euo pipefail

source "./lib/lib_log.sh"

if [[ $# -lt 1 ]]; then
    log_error "brug: $0 FIL"
    exit 1
fi

file="$1"

if [[ ! -f "$file" ]]; then
    log_error "Filen findes ikke: $file"
    exit 1
fi

wc -l < "$file"

exit 0