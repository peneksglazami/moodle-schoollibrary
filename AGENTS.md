# Agent instructions

## Source of truth
- `docs/TZ.md` is authoritative. Explicit constraints in GitHub Issues are also binding.
- Moodle 4.4.1 compatibility is mandatory and release-blocking.

## Target
- Component: `mod_schoollibrary`; installed at `/mod/schoollibrary`.
- General compatibility: Moodle >= 4.0 and PHP >= 8.0, subject to each Moodle release's supported PHP versions.
- Mandatory deployment target and primary runtime: Moodle 4.4.1 with PHP 8.3.

## Development rules
- Use standard Moodle APIs and mechanisms; add no third-party PHP library without explicit justification.
- Put every user-facing string in both `lang/en` and `lang/ru`; never hardcode Russian UI text in PHP.
- Management pages require correct authentication, context and capability checks. Validate sesskeys for state changes.
- Treat userid, groupid, status, and all client identifiers as untrusted and validate them server-side.
- Use Moodle course groups; never create a custom group model/table.
- Keep business logic unit-testable. Normally cover new business behaviour with PHPUnit and important workflows with Behat.
- Never weaken or delete tests to pass a task. Run relevant commands in `docs/TESTING.md` before completion.

## Moodle group security rule
A selected student must be validated server-side as active, not deleted, actively enrolled as an appropriate student in the current course, and a member of the selected Moodle group. UI filtering is insufficient.

## Code review rules
Check `require_login`, capabilities, module/course context, sesskeys, parameters, escaping, Moodle DML, course/group/enrolment validation, Moodle 4.4.1 API availability, PHP compatibility, and test coverage.
