# Acceptance scenarios

`docs/TZ.md` remains authoritative. This list separates bootstrap proof from future business acceptance.

## Bootstrap scenarios

1. Install the plugin without errors on the exact Moodle 4.4.1 release.
2. Confirm Moodle recognises `mod_schoollibrary`, its English/Russian strings, capabilities, and icon.
3. As a teacher in Test School Course, add a School Library activity and open it; a student cannot access it.
4. Update and delete an instance cleanly.

## Future functional scenarios (not implemented here)

- A teacher and manager can access management; students are restricted.
- A teacher selects Moodle course groups, sees only active enrolled students in the selected group, and receives an explanation for an empty group.
- The server rejects deleted, inactive, suspended, unenrolled, non-student, or non-member users even if identifiers are forged.
- Create a loan with free-text book name; reject return dates before issue date and apply configured defaults.
- Automatically mark overdue loans; return a book with an actual date; manually mark it lost.
- Filter by status/group and search by student/book.
- Import valid UTF-8 CSV by email and report invalid rows; export the filtered list as semicolon-separated UTF-8 CSV.
- Send issue, return, upcoming-due, and overdue notifications through Moodle Messaging API; exclude returned/lost loans.
- A scheduled task performs overdue processing and reminders idempotently.
- Privacy API exports and deletes applicable personal data.
- Backup and restore preserve settings and records with correct user mapping.
