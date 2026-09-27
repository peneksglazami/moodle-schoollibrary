# Testing

Run commands from the plugin root after `./dev/setup.sh`:

```bash
./dev/check-environment.sh  # verifies actual Moodle release 4.4.1 and PHP 8.3
./dev/run-static.sh         # PHP syntax and Moodle coding standard
./dev/run-unit.sh           # mod_schoollibrary PHPUnit suite
./dev/run-behat.sh          # @mod_schoollibrary browser smoke scenario
./dev/run-all.sh            # all checks above
```

The release check reads Moodle's checked-out `version.php`; it does not trust a branch name. The Behat runner starts a temporary test web server on port 8001 and requires Selenium/Chrome at `SELENIUM_URL` (default `http://127.0.0.1:4444/wd/hub`). Setup performs Behat initialization even where browser infrastructure is unavailable.
