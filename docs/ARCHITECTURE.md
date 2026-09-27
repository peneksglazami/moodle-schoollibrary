# Bootstrap architecture

The repository root is the Moodle plugin root; installation links it at `/mod/schoollibrary`. Moodle core and all generated data stay in a sibling `.schoollibrary-dev` directory outside this Git repository.

Standard Moodle APIs are preferred. This bootstrap deliberately provides only the instance table and lifecycle needed for a valid activity; `docs/TZ.md` governs later functionality.

Moodle 4.4.1 at immutable commit `db07c09afc52f67a7fa3dc41ba1707ed7f99b58a`, with PHP 8.3, is the primary mandatory deployment target. PostgreSQL is the preferred development database. Other compatible Moodle versions are secondary and never replace the exact 4.4.1 gate.

GitHub Actions is the authoritative automated quality gate. Local scripts mirror its checks and read `dev/versions.env` as the version source of truth.
