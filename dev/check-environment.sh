#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/common.sh"
[[ -f "$MOODLE_DIR/version.php" ]] || { echo "Moodle is absent at $MOODLE_DIR; run dev/setup.sh" >&2; exit 1; }
actual="$(php "$DEV_DIR/read-moodle-release.php" "$MOODLE_DIR/version.php")"
echo "Expected Moodle release: $MOODLE_RELEASE"
echo "Actual Moodle release:   $actual"
[[ "$actual" == "$MOODLE_RELEASE" ]] || { echo "Release mismatch" >&2; exit 1; }
actualphp="$(php -r 'echo PHP_MAJOR_VERSION.".".PHP_MINOR_VERSION;')"
echo "Expected PHP runtime:    $PHP_VERSION"
echo "Actual PHP runtime:      $actualphp ($(php -r 'echo PHP_VERSION;'))"
[[ "$actualphp" == "$PHP_VERSION" ]] || { echo "PHP runtime mismatch" >&2; exit 1; }
[[ -L "$MOODLE_DIR/mod/schoollibrary" && "$(readlink -f "$MOODLE_DIR/mod/schoollibrary")" == "$PLUGIN_DIR" ]] || { echo "Plugin is not linked at $MOODLE_DIR/mod/schoollibrary" >&2; exit 1; }
