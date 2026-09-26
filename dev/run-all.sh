#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/common.sh"
"$DEV_DIR/check-environment.sh"
"$DEV_DIR/run-static.sh"
"$DEV_DIR/run-unit.sh"
"$DEV_DIR/run-behat.sh"
