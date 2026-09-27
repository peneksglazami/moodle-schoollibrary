#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/common.sh"
if [[ -f "$STATE_DIR/server.pid" ]]; then kill "$(cat "$STATE_DIR/server.pid")" 2>/dev/null || true; rm -f "$STATE_DIR/server.pid"; fi
echo 'Moodle development server stopped'
