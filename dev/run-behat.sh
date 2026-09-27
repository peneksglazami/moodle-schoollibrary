#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/common.sh"
"$DEV_DIR/check-environment.sh"
config="$BEHATDATA_DIR/behatrun/behat/behat.yml"
[[ -f "$config" ]] || { echo 'Behat is not initialized; run dev/setup.sh' >&2; exit 1; }
serverpid=''
cleanup() { [[ -z "$serverpid" ]] || kill "$serverpid" 2>/dev/null || true; }
trap cleanup EXIT
if ! curl -fsS "${BEHAT_WWWROOT:-http://127.0.0.1:8001}" >/dev/null 2>&1; then
    php -S 127.0.0.1:8001 -t "$MOODLE_DIR" >"$STATE_DIR/behat-server.log" 2>&1 &
    serverpid=$!
    sleep 1
fi
"$MOODLE_DIR/vendor/bin/behat" --config "$config" --tags=@mod_schoollibrary
