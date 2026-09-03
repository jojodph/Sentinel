#!/usr/bin/env bash

set -euo pipefail


_log() {
    local level="$1"
    local message="$2"
    local timestamp

    timestamp="$(date '+%Y-%m-%d %H:%M:%S')"

    printf '[%s] [%s] %s\n' "$timestamp" "$level" "$message" >&2
}

log_info() {
    local message="$1"
    _log "INFO" "$message"
}

log_warn() {
    local message="$1"
    _log "WARN" "$message"
}

log_error() {
    local message="$1"
    _log "ERROR" "$message"
}

log_section() {
    local title="$1"

    printf '\n=== %s ===\n' "$title" >&2
}

require_command() {
    local command_name="$1"

    if ! command -v "$command_name" >/dev/null 2>&1; then
        log_error "Kommandoen findes ikke: $command_name"
        exit 1
    fi
}