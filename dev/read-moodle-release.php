<?php
// This file is part of Moodle - http://moodle.org/
//
// Moodle is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Moodle is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Moodle.  If not, see <https://www.gnu.org/licenses/>.

/**
 * Reads the release number from a Moodle version.php file.
 *
 * This script deliberately parses the file instead of executing Moodle bootstrap code.
 *
 * @package    mod_schoollibrary
 * @copyright  2026 School Library contributors
 * @license    http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */

// This standalone helper intentionally does not bootstrap Moodle.
// phpcs:disable moodle.Files.MoodleInternal.MoodleInternalGlobalState

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
