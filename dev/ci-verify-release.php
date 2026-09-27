<?php
// This file is part of Moodle - https://moodle.org/

if ($argc !== 3 || !is_file($argv[1])) {
    fwrite(STDERR, "Usage: php dev/ci-verify-release.php <Moodle version.php> <expected release>\n");
    exit(2);
}

define('MOODLE_INTERNAL', true);
define('MATURITY_ALPHA', 50);
define('MATURITY_BETA', 100);
define('MATURITY_RC', 150);
define('MATURITY_STABLE', 200);
$version = null;
$release = null;
require $argv[1];
$fullrelease = (string) $release;
$actual = explode(' ', $fullrelease, 2)[0];
fwrite(STDOUT, "Expected Moodle release: {$argv[2]}\nActual Moodle release:   {$actual}\n");
if ($actual !== $argv[2]) {
    fwrite(STDERR, "Release mismatch; refusing to test.\n");
    exit(1);
}
