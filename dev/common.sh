#!/usr/bin/env bash
set -euo pipefail

DEV_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_DIR="$(cd "$DEV_DIR/.." && pwd)"
# shellcheck source=versions.env
source "$DEV_DIR/versions.env"
WORK_DIR="${SCHOOLLIBRARY_WORK_DIR:-$(dirname "$PLUGIN_DIR")/.schoollibrary-dev}"
MOODLE_DIR="${MOODLE_DIR:-$WORK_DIR/moodle}"
MOODLEDATA_DIR="${MOODLEDATA_DIR:-$WORK_DIR/moodledata}"
BEHAT_DATA_DIR="${BEHAT_DATA_DIR:-$WORK_DIR/behatdata}"
DB_NAME="${MOODLE_DB_NAME:-schoollibrary_moodle}"
DB_USER="${MOODLE_DB_USER:-$(id -un)}"
WWW_ROOT="${MOODLE_WWW_ROOT:-http://127.0.0.1:8000}"
DB_HOST="${MOODLE_DB_HOST:-/var/run/postgresql}"

require_command() {
    command -v "$1" >/dev/null 2>&1 || { echo "Required command not found: $1" >&2; exit 1; }
}
