# Coding agent guide

## Source of truth and target

- `docs/TZ.md` is authoritative. Explicit constraints in GitHub Issues are also binding.
- This activity module is `mod_schoollibrary`, installed at `/mod/schoollibrary`.
- General compatibility is Moodle >= 4.0 and PHP >= 8.0, subject to each Moodle release's supported PHP versions.
- Moodle **4.4.1 compatibility is mandatory and release-blocking**. The primary runtime is exactly Moodle 4.4.1 with PHP 8.3.

## Development rules

- Use standard Moodle APIs and mechanisms rather than custom equivalents. Do not add third-party PHP libraries without explicit justification.
- Put every user-facing string in both `lang/en` and `lang/ru`; never hardcode Russian UI text in PHP.
- Management pages require correct authentication, context, capability checks, parameter validation, output escaping, Moodle DML, and sesskey validation for state changes.
- Treat all client-provided IDs and status values as untrusted. Use Moodle course groups; never create a custom group model/table.
- Keep business logic unit-testable. Normally cover new behavior with PHPUnit and important workflows with Behat. Never weaken/delete tests to get a pass.
- Before completion, run the relevant commands in `docs/TESTING.md`.

## Moodle group security rule

Server-side code must verify that a selected student is active, not deleted, actively enrolled in the current course, appropriate for the student role, and a member of the selected Moodle group. UI filtering alone is insufficient.

## Review checklist

Review `require_login`, capabilities, module/course contexts, sesskeys, parameters, escaping, DML, course/group/enrolment validation, Moodle 4.4.1 API availability, PHP compatibility, and test coverage. Reject accidental reliance on APIs added after Moodle 4.4.1.

