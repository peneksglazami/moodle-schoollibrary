#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/common.sh"
"$DEV_DIR/check-environment.sh"
php "$MOODLE_DIR/admin/tool/behat/cli/init.php" --disable-composer
php "$MOODLE_DIR/admin/tool/behat/cli/run.php" --tags=@mod_schoollibrary
