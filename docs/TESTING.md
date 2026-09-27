# Testing

Run these from the plugin repository root after `dev/setup.sh`:

```bash
# Verify the installed release, runtime, plugin link, and installed Moodle.
dev/check-environment.sh

# PHP syntax and Moodle coding standard.
dev/run-static.sh

# Reinitialize and run this component's PHPUnit suite.
dev/run-unit.sh

# Reinitialize Behat and run the browser smoke scenario (requires Selenium/Chrome).
dev/run-behat.sh

# Run every check above.
dev/run-all.sh
```

`check-environment.sh` reads the actual `$release` from Moodle's checked-out `version.php` and fails unless it is exactly `4.4.1`; it does not trust a branch name. For browser testing, start a Selenium server compatible with Moodle and set `$CFG->behat_config` locally when the default WebDriver endpoint is unsuitable.

