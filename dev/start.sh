#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/common.sh"
"$DEV_DIR/check-environment.sh"
mkdir -p "$STATE_DIR"
if [[ -f "$STATE_DIR/server.pid" ]] && kill -0 "$(cat "$STATE_DIR/server.pid")" 2>/dev/null; then echo 'Moodle already running'; exit 0; fi
php -S 127.0.0.1:8000 -t "$MOODLE_DIR" >"$STATE_DIR/server.log" 2>&1 & echo $! > "$STATE_DIR/server.pid"
echo 'Moodle started at http://127.0.0.1:8000'
