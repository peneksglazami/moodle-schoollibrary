# Development

## Prerequisites

A Linux host needs PHP 8.3 with Moodle-required extensions and `max_input_vars >= 5000`, the `en_AU.UTF-8` locale, Composer, Git, PostgreSQL client/server, and (for Behat) Chrome/Chromium plus Selenium on `http://127.0.0.1:4444/wd/hub`. Create a local PostgreSQL role/database without putting credentials in Git, for example:

```bash
sudo -u postgres createuser --createdb schoollibrary
sudo -u postgres psql -c "ALTER USER schoollibrary PASSWORD 'schoollibrary_local_only';"
```

Defaults are strictly local conveniences and can be overridden with `DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USER`, and `DB_PASSWORD`. Override `MOODLE_ADMIN_PASSWORD` outside source control on shared machines.

## Fresh setup

From the plugin repository root:

```bash
./dev/setup.sh
./dev/start.sh
```

Setup clones Moodle outside the repository, checks out the immutable 4.4.1 commit, links this directory at `mod/schoollibrary`, installs Moodle and the plugin, and initializes PHPUnit and Behat. Browse to `http://127.0.0.1:8000`. Stop with `./dev/stop.sh`.

To recreate everything, use `CONFIRM_RESET=yes ./dev/reset.sh` and rerun setup. `SCHOOLLIBRARY_STATE_DIR` relocates generated state.

Test fixtures use Moodle's generators: PHPUnit uses `getDataGenerator()` and Behat feature tables. The smoke feature deterministically creates **Test School Course** and **teacher1**. Future scenarios should add Group 5A (`student_a1`, `student_a2`), Group 5B (`student_b1`), an empty group, a suspended enrolment, an enrolled non-member, an unenrolled user, and optionally another teacher through standard generators.
