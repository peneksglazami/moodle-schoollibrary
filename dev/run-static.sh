#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/common.sh"
require_command php
find "$PLUGIN_DIR" -type f -name '*.php' -not -path '*/.git/*' -print0 | xargs -0 -n1 php -l
if [[ -x "$WORK_DIR/tools/vendor/bin/phpcs" ]]; then
    "$WORK_DIR/tools/vendor/bin/phpcs" --standard="$PLUGIN_DIR/phpcs.xml.dist"
else
    echo "Moodle PHPCS is unavailable; run dev/setup.sh first." >&2
    exit 1
fi
