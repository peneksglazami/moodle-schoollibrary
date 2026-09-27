#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/common.sh"
for command in git php composer psql pg_isready; do command -v "$command" >/dev/null || { echo "Missing required command: $command" >&2; exit 1; }; done
mkdir -p "$STATE_DIR" "$MOODLEDATA_DIR" "$BEHATDATA_DIR" "$PHPUNITDATA_DIR"
if [[ ! -d "$MOODLE_DIR/.git" ]]; then git clone --filter=blob:none https://github.com/moodle/moodle.git "$MOODLE_DIR"; fi
git -C "$MOODLE_DIR" fetch --depth=1 origin "$MOODLE_GIT_REF"
git -C "$MOODLE_DIR" checkout --detach "$MOODLE_GIT_REF"
[[ "$(git -C "$MOODLE_DIR" rev-parse HEAD)" == "$MOODLE_GIT_REF" ]] || { echo 'Immutable Moodle commit mismatch' >&2; exit 1; }
rm -rf "$MOODLE_DIR/mod/schoollibrary"
ln -s "$PLUGIN_DIR" "$MOODLE_DIR/mod/schoollibrary"
"$DEV_DIR/check-environment.sh"
composer install --no-interaction --prefer-dist --working-dir="$MOODLE_DIR"
composer global config allow-plugins.dealerdirect/phpcodesniffer-composer-installer true
composer global require --no-interaction moodlehq/moodle-cs:^3
pg_isready -h "$DB_HOST" -p "$DB_PORT" >/dev/null || { echo "PostgreSQL unavailable at $DB_HOST:$DB_PORT" >&2; exit 1; }
export PGPASSWORD="$DB_PASSWORD"
if ! psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d postgres -Atqc "SELECT 1 FROM pg_database WHERE datname = '$DB_NAME'" | grep -q 1; then createdb -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" "$DB_NAME"; fi
if [[ ! -f "$MOODLE_DIR/config.php" ]]; then
  php "$MOODLE_DIR/admin/cli/install.php" --non-interactive --agree-license --wwwroot="${MOODLE_WWWROOT:-http://127.0.0.1:8000}" --dataroot="$MOODLEDATA_DIR" --dbtype=pgsql --dbhost="$DB_HOST" --dbport="$DB_PORT" --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASSWORD" --fullname="School Library Development" --shortname="SchoolLib" --adminuser="${MOODLE_ADMIN_USER:-admin}" --adminpass="${MOODLE_ADMIN_PASSWORD:-Admin1!local}" --adminemail="admin@example.test"
else php "$MOODLE_DIR/admin/cli/upgrade.php" --non-interactive; fi
if ! grep -q 'School Library test configuration' "$MOODLE_DIR/config.php"; then
cat >> "$MOODLE_DIR/config.php" <<PHP

// School Library test configuration (generated outside the plugin repository).
\$CFG->phpunit_prefix = 'phpu_';
\$CFG->phpunit_dataroot = '$PHPUNITDATA_DIR';
\$CFG->behat_prefix = 'bht_';
\$CFG->behat_dataroot = '$BEHATDATA_DIR';
\$CFG->behat_wwwroot = '${BEHAT_WWWROOT:-http://127.0.0.1:8001}';
\$CFG->behat_profiles = ['default' => ['browser' => 'chrome', 'wd_host' => '${SELENIUM_URL:-http://127.0.0.1:4444/wd/hub}']];
PHP
fi
touch "$MOODLE_DIR/composer.phar"
php "$MOODLE_DIR/admin/tool/phpunit/cli/init.php" --disable-composer
php "$MOODLE_DIR/admin/tool/behat/cli/init.php"
"$DEV_DIR/check-environment.sh"
echo "Setup complete. Generated state: $STATE_DIR"
