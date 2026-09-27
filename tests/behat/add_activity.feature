@mod @mod_schoollibrary
Feature: Add a School Library activity
  In order to prepare library management for a course
  As a teacher
  I need to add a School Library activity

  Background:
    Given the following "courses" exist:
      | fullname           | shortname | category |
      | Test School Course | TSC        | 0        |
    And the following "users" exist:
      | username | firstname | lastname | email                |
      | teacher1 | Test      | Teacher  | teacher1@example.com |
    And the following "course enrolments" exist:
      | user     | course | role           |
      | teacher1 | TSC    | editingteacher |

  @javascript
  Scenario: A teacher adds the activity
    Given I am on the "Test School Course" course page logged in as teacher1
    When I turn editing mode on
    And I add a "School Library" to section "1" and I fill the form with:
      | School Library name | Main library |
    Then I should see "Main library"
    And I should see "The School Library development skeleton is installed"

