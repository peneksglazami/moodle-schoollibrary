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
 * School Library activity module.
 *
 * @package    mod_schoollibrary
 * @copyright  2026 School Library contributors
 * @license    http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */

/**
 * Data generator for School Library tests.
 */
class mod_schoollibrary_generator extends testing_module_generator {
    /**
     * Creates an activity instance.
     *
     * @param array|stdClass|null $record Instance fields.
     * @param array|null $options Generator options.
     * @return stdClass
     */
    public function create_instance($record = null, ?array $options = null): stdClass {
        $record = (object) ($record ?? []);
        $record->name = $record->name ?? 'School Library';
        return parent::create_instance($record, $options);
    }
}
