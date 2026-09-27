#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/common.sh"
"$DEV_DIR/stop.sh"
printf 'Reset removes generated state at %s. Set CONFIRM_RESET=yes to continue.\n' "$STATE_DIR"
[[ "${CONFIRM_RESET:-no}" == yes ]] || exit 2
[[ "$STATE_DIR" != / && -n "$STATE_DIR" ]] || exit 1
rm -rf "$STATE_DIR"
