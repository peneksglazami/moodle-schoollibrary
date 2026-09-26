<?php
// Reads Moodle release metadata without executing Moodle bootstrap code.

if ($argc !== 2 || !is_readable($argv[1])) {
    fwrite(STDERR, "Usage: read-moodle-release.php /path/to/version.php\n");
    exit(2);
}
$contents = file_get_contents($argv[1]);
if (!preg_match('/^\$release\s*=\s*[\'\"]([^\'\"]+)[\'\"]/m', $contents, $matches)) {
    fwrite(STDERR, "Unable to read Moodle release\n");
    exit(2);
}
echo strtok($matches[1], ' ');
