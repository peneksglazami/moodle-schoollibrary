#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/common.sh"
"$DEV_DIR/check-environment.sh"
php "$MOODLE_DIR/admin/tool/phpunit/cli/init.php" --disable-composer
"$MOODLE_DIR/vendor/bin/phpunit" -c "$MOODLE_DIR/phpunit.xml" --testsuite mod_schoollibrary_testsuite
