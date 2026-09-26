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

namespace mod_schoollibrary;

/**
 * Tests activity lifecycle callbacks.
 *
 * @coversNothing
 */
final class lib_test extends \advanced_testcase {
    public function test_instance_lifecycle(): void {
        global $DB;
        $this->resetAfterTest();
        $course = $this->getDataGenerator()->create_course();
        $instance = $this->getDataGenerator()->create_module('schoollibrary', ['course' => $course->id, 'name' => 'Library']);
        $this->assertTrue($DB->record_exists('schoollibrary', ['id' => $instance->id]));
        $data = (object) ['instance' => $instance->id, 'course' => $course->id, 'name' => 'Updated'];
        $this->assertTrue(schoollibrary_update_instance($data));
        $this->assertSame('Updated', $DB->get_field('schoollibrary', 'name', ['id' => $instance->id]));
        $this->assertTrue(schoollibrary_delete_instance($instance->id));
        $this->assertFalse($DB->record_exists('schoollibrary', ['id' => $instance->id]));
    }
}
