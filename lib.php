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

/**
 * Declares supported Moodle features.
 *
 * @param string $feature Feature name.
 * @return bool|null
 */
function schoollibrary_supports(string $feature): ?bool {
    return match ($feature) {
        FEATURE_MOD_ARCHETYPE => MOD_ARCHETYPE_OTHER,
        FEATURE_MOD_INTRO => true,
        FEATURE_SHOW_DESCRIPTION => true,
        FEATURE_GROUPS => true,
        FEATURE_BACKUP_MOODLE2 => false,
        default => null,
    };
}

/**
 * Creates an activity instance.
 *
 * @param stdClass $data Form data.
 * @param mod_schoollibrary_mod_form|null $mform Form object.
 * @return int New record id.
 */
function schoollibrary_add_instance(stdClass $data, ?mod_schoollibrary_mod_form $mform = null): int {
    global $DB;

    $data->timecreated = time();
    $data->timemodified = $data->timecreated;
    return $DB->insert_record('schoollibrary', $data);
}

/**
 * Updates an activity instance.
 *
 * @param stdClass $data Form data.
 * @param mod_schoollibrary_mod_form|null $mform Form object.
 * @return bool
 */
function schoollibrary_update_instance(stdClass $data, ?mod_schoollibrary_mod_form $mform = null): bool {
    global $DB;

    $data->id = $data->instance;
    $data->timemodified = time();
    return $DB->update_record('schoollibrary', $data);
}

/**
 * Deletes an activity instance.
 *
 * @param int $id Instance id.
 * @return bool
 */
function schoollibrary_delete_instance(int $id): bool {
    global $DB;

    if (!$DB->record_exists('schoollibrary', ['id' => $id])) {
        return false;
    }
    $DB->delete_records('schoollibrary', ['id' => $id]);
    return true;
}
