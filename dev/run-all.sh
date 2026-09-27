#!/usr/bin/env bash
set -euo pipefail
DEV_DIR="$(cd "$(dirname "$0")" && pwd)"
"$DEV_DIR/check-environment.sh"
"$DEV_DIR/run-static.sh"
"$DEV_DIR/run-unit.sh"
"$DEV_DIR/run-behat.sh"
