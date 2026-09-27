# Acceptance scenarios

## Bootstrap acceptance (this task)

1. A clean setup checks out the pinned upstream commit and proves the actual release is exactly Moodle 4.4.1 on PHP 8.3 with PostgreSQL.
2. Moodle installs and recognises `mod_schoollibrary`; install/uninstall metadata and capabilities are valid.
3. A teacher can add the activity to `Test School Course` and open its minimal authenticated view; a student cannot view it.
4. Lifecycle PHPUnit tests pass, and the Behat smoke feature can add an instance in browser CI.
5. English and Russian names and a module icon are available.

## Future functional acceptance (out of bootstrap scope)

- Teachers and managers can manage the activity; students cannot access management.
- The issue form uses Moodle course groups. Selecting 5A shows only its active students, selecting 5B shows only its members, and an empty group gives a useful empty state.
- The server rejects deleted, suspended, inactive/non-enrolled, wrong-role, and out-of-group students even if a request is forged.
- A teacher creates a loan with free-text book name; receipt/due/return dates obey defaults and reject a return before receipt.
- Overdue status is assigned automatically; return records the actual date and Returned status; Lost can be set manually.
- Status/group/student/book filters return the expected records.
- CSV import accepts the specified date formats, resolves email, validates enrolment/group membership, and reports row errors. Filtered CSV export is UTF-8 and semicolon-separated.
- Moodle Messaging sends configured issued, returned, due-soon, and overdue notifications; returned/lost loans receive no overdue notification.
- The scheduled task deterministically updates overdue state and sends each due notification as designed.
- Privacy API metadata, export, and deletion cover all personal data.
- Moodle backup captures activity data and restore recreates it correctly in another course.
- Plugin install, all workflows, backup, and restore remain compatible with exactly Moodle 4.4.1.

