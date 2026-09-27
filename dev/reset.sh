#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/common.sh"
"$DEV_DIR/stop.sh"
require_command dropdb
dropdb --if-exists --host="$DB_HOST" --username="$DB_USER" "$DB_NAME"
[[ "$WORK_DIR" != / && -n "$WORK_DIR" ]] || { echo "Unsafe work directory." >&2; exit 1; }
rm -rf "$WORK_DIR"
echo "Removed generated development state: $WORK_DIR"
