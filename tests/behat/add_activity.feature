@mod @mod_schoollibrary
Feature: Add a School Library activity
  In order to prepare a course library
  As a teacher
  I need to add a School Library activity

  Background:
    Given the following "courses" exist:
      | fullname           | shortname | category |
      | Test School Course | SCHOOL    | 0        |
    And the following "users" exist:
      | username | firstname | lastname | email                |
      | teacher1 | Test      | Teacher  | teacher1@example.test |
    And the following "course enrolments" exist:
      | user     | course | role           |
      | teacher1 | SCHOOL | editingteacher |

  @javascript
  Scenario: A teacher adds the activity
    When I am on the "Test School Course" course page logged in as "teacher1"
    And I turn editing mode on
    And I add a "School Library" to section "1" and I fill the form with:
      | School Library name | Course library |
    Then I should see "Course library"
