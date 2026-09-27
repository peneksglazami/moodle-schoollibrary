#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/common.sh"

require_command php
[[ -f "$MOODLE_DIR/version.php" ]] || { echo "Moodle not found at $MOODLE_DIR. Run dev/setup.sh." >&2; exit 1; }
actualphp="$(php -r 'echo PHP_MAJOR_VERSION.".".PHP_MINOR_VERSION;')"
[[ "$actualphp" == "$PHP_RUNTIME" ]] || { echo "Expected PHP runtime: $PHP_RUNTIME; actual: $actualphp" >&2; exit 1; }
fullrelease="$(MOODLE_VERSION_FILE="$MOODLE_DIR/version.php" php -r '
define("MOODLE_INTERNAL", true); define("MATURITY_ALPHA", 50); define("MATURITY_BETA", 100);
define("MATURITY_RC", 150); define("MATURITY_STABLE", 200); $version = null; $release = null;
require getenv("MOODLE_VERSION_FILE"); echo $release;
')"
actualrelease="${fullrelease%% *}"
printf 'Expected Moodle release: %s\nActual Moodle release:   %s\n' "$MOODLE_RELEASE" "$actualrelease"
[[ "$actualrelease" == "$MOODLE_RELEASE" ]] || { echo "Wrong Moodle release; refusing to test." >&2; exit 1; }
[[ -L "$MOODLE_DIR/mod/schoollibrary" || -d "$MOODLE_DIR/mod/schoollibrary" ]] || { echo "Plugin is not installed at $MOODLE_DIR/mod/schoollibrary" >&2; exit 1; }
php "$MOODLE_DIR/admin/cli/cfg.php" --name=version >/dev/null
echo "Environment verified: Moodle $fullrelease, PHP $(php -r 'echo PHP_VERSION;'), PostgreSQL database $DB_NAME."
