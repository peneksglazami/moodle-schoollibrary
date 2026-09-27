#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/common.sh"
pidfile="$WORK_DIR/php-server.pid"
if [[ -f "$pidfile" ]]; then kill "$(cat "$pidfile")" 2>/dev/null || true; rm -f "$pidfile"; fi
echo "Moodle development server stopped."

