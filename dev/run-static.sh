#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/common.sh"
find "$PLUGIN_DIR" -path "$PLUGIN_DIR/.git" -prune -o -name '*.php' -print0 | xargs -0 -n1 php -l
PHPCS="$(composer global config bin-dir --absolute)/phpcs"
[[ -x "$PHPCS" ]] || { echo 'PHPCS unavailable; run dev/setup.sh' >&2; exit 1; }
"$PHPCS" --standard=Moodle --extensions=php --ignore=.git,dev "$PLUGIN_DIR"
