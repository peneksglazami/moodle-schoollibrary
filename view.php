<?php
// This file is part of Moodle - https://moodle.org/
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
 * School Library activity module.
 *
 * @package    mod_schoollibrary
 * @copyright  2026 School Library contributors
 * @license    http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */

require_once(__DIR__ . '/../../config.php');

$id = required_param('id', PARAM_INT);
$cm = get_coursemodule_from_id('schoollibrary', $id, 0, false, MUST_EXIST);
$course = get_course($cm->course);
$schoollibrary = $DB->get_record('schoollibrary', ['id' => $cm->instance], '*', MUST_EXIST);

require_login($course, true, $cm);
$context = context_module::instance($cm->id);
require_capability('mod/schoollibrary:view', $context);

$PAGE->set_url('/mod/schoollibrary/view.php', ['id' => $cm->id]);
$PAGE->set_title(format_string($schoollibrary->name));
$PAGE->set_heading(format_string($course->fullname));

echo $OUTPUT->header();
echo $OUTPUT->heading(format_string($schoollibrary->name));
if (trim((string) $schoollibrary->intro) !== '') {
    echo $OUTPUT->box(format_module_intro('schoollibrary', $schoollibrary, $cm->id), 'generalbox mod_introbox');
}
echo $OUTPUT->notification(get_string('bootstrapnotice', 'mod_schoollibrary'), 'info');
echo $OUTPUT->footer();
