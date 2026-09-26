#!/usr/bin/env bash
set -euo pipefail
DEV_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_DIR="$(cd "$DEV_DIR/.." && pwd)"
# shellcheck source=versions.env
source "$DEV_DIR/versions.env"
STATE_DIR="${SCHOOLLIBRARY_STATE_DIR:-$(cd "$PLUGIN_DIR/.." && pwd)/.schoollibrary-dev}"
MOODLE_DIR="${MOODLE_DIR:-$STATE_DIR/moodle}"
MOODLEDATA_DIR="${MOODLEDATA_DIR:-$STATE_DIR/moodledata}"
BEHATDATA_DIR="${BEHATDATA_DIR:-$STATE_DIR/behatdata}"
PHPUNITDATA_DIR="${PHPUNITDATA_DIR:-$STATE_DIR/phpunitdata}"
DB_HOST="${DB_HOST:-127.0.0.1}"
DB_PORT="${DB_PORT:-5432}"
DB_NAME="${DB_NAME:-schoollibrary}"
DB_USER="${DB_USER:-schoollibrary}"
: "${DB_PASSWORD:=schoollibrary_local_only}"
export DEV_DIR PLUGIN_DIR STATE_DIR MOODLE_DIR MOODLEDATA_DIR BEHATDATA_DIR PHPUNITDATA_DIR
# Moodle requires this setting; keep it local to project scripts.
php() { command php -d max_input_vars=5000 "$@"; }
