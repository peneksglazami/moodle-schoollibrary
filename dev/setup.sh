#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/common.sh"

for command in git php composer psql createdb; do require_command "$command"; done
locale -a | tr '[:upper:]' '[:lower:]' | grep -Eq '^en_au\.utf-?8$' || {
    echo "Required locale en_AU.UTF-8 is missing. Generate it before running setup (for example: sudo locale-gen en_AU.UTF-8)." >&2
    exit 1
}
mkdir -p "$WORK_DIR" "$MOODLEDATA_DIR" "$BEHAT_DATA_DIR"
if [[ ! -d "$MOODLE_DIR/.git" ]]; then
    git clone --filter=blob:none https://github.com/moodle/moodle.git "$MOODLE_DIR"
fi
git -C "$MOODLE_DIR" fetch --depth=1 origin "$MOODLE_GIT_REF"
git -C "$MOODLE_DIR" checkout --detach "$MOODLE_GIT_REF"
actualcommit="$(git -C "$MOODLE_DIR" rev-parse HEAD)"
[[ "$actualcommit" == "$MOODLE_GIT_REF" ]] || { echo "Moodle commit mismatch: $actualcommit" >&2; exit 1; }
ln -sfn "$PLUGIN_DIR" "$MOODLE_DIR/mod/schoollibrary"

if ! psql --host="$DB_HOST" --username="$DB_USER" -d postgres -Atqc "SELECT 1 FROM pg_database WHERE datname = '$DB_NAME'" | grep -qx 1; then
    createdb --host="$DB_HOST" --username="$DB_USER" "$DB_NAME"
fi
if [[ ! -f "$MOODLE_DIR/config.php" ]]; then
    php "$MOODLE_DIR/admin/cli/install.php" --non-interactive --agree-license \
        --lang=en --wwwroot="$WWW_ROOT" --dataroot="$MOODLEDATA_DIR" \
        --dbtype=pgsql --dbhost="$DB_HOST" --dbname="$DB_NAME" \
        --dbuser="$DB_USER" --dbpass="${MOODLE_DB_PASSWORD:-}" \
        --fullname="School Library Development" --shortname="SLDEV" \
        --adminuser=admin --adminpass="${MOODLE_ADMIN_PASSWORD:-Admin1!development}" \
        --adminemail=admin@example.invalid
fi
php "$MOODLE_DIR/admin/cli/upgrade.php" --non-interactive
composer --working-dir="$MOODLE_DIR" install --no-interaction --prefer-dist
# Moodle 4.4's test initialisers require a local composer.phar even when dependency updates are disabled.
if [[ ! -s "$MOODLE_DIR/composer.phar" ]]; then
    composerbin="${MOODLE_COMPOSER_PHAR:-$(command -v composer)}"
    if command -v phpenv >/dev/null 2>&1; then
        composerbin="${MOODLE_COMPOSER_PHAR:-$(phpenv which composer)}"
    fi
    head -n 1 "$composerbin" | grep -q 'php' || {
        echo "Set MOODLE_COMPOSER_PHAR to the real Composer PHP executable (not a shell shim)." >&2
        exit 1
    }
    cp "$composerbin" "$MOODLE_DIR/composer.phar"
fi
mkdir -p "$WORK_DIR/tools"
if [[ ! -x "$WORK_DIR/tools/vendor/bin/phpcs" ]]; then
    cat > "$WORK_DIR/tools/composer.json" <<'EOF'
{
  "require-dev": {"moodlehq/moodle-cs": "^3"},
  "config": {"allow-plugins": {"dealerdirect/phpcodesniffer-composer-installer": true}}
}
EOF
    composer --working-dir="$WORK_DIR/tools" update --no-interaction
fi

if ! grep -q 'schoollibrary bootstrap test configuration' "$MOODLE_DIR/config.php"; then
    testconfig="$(mktemp)"
    cat > "$testconfig" <<EOF
// schoollibrary bootstrap test configuration
\$CFG->phpunit_prefix = 'phpu_';
\$CFG->phpunit_dataroot = '${WORK_DIR}/phpunitdata';
\$CFG->behat_prefix = 'bht_';
\$CFG->behat_dataroot = '${BEHAT_DATA_DIR}';
\$CFG->behat_wwwroot = '${MOODLE_BEHAT_WWWROOT:-http://localhost:8000}';
EOF
    sed -i "/require_once.*lib\/setup.php/e cat $testconfig" "$MOODLE_DIR/config.php"
    rm -f "$testconfig"
fi
php "$MOODLE_DIR/admin/tool/phpunit/cli/init.php" --disable-composer
php "$MOODLE_DIR/admin/tool/behat/cli/init.php" --disable-composer
"$DEV_DIR/check-environment.sh"
echo "Setup complete. Generated state is in $WORK_DIR (outside the plugin repository)."
