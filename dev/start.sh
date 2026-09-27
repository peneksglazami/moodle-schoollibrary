#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/common.sh"
require_command php
[[ -f "$MOODLE_DIR/config.php" ]] || { echo "Run dev/setup.sh first." >&2; exit 1; }
pidfile="$WORK_DIR/php-server.pid"
if [[ -f "$pidfile" ]] && kill -0 "$(cat "$pidfile")" 2>/dev/null; then echo "Moodle is already running."; exit 0; fi
php -S "${MOODLE_LISTEN:-127.0.0.1:8000}" -t "$MOODLE_DIR" >"$WORK_DIR/php-server.log" 2>&1 &
echo $! > "$pidfile"
echo "Moodle started at $WWW_ROOT (PID $(cat "$pidfile"))."

