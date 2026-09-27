# Development environment

The direct Linux environment uses PHP 8.3, PostgreSQL, Git, Composer, a PHP built-in development server, and Moodle core in `../.schoollibrary-dev`. Install PHP extensions required by Moodle 4.4 before starting (notably pgsql, sodium, intl, mbstring, xml, curl, zip, gd and soap), generate the `en_AU.UTF-8` locale, and ensure the current PostgreSQL user can create a database. On Ubuntu this is typically `sudo locale-gen en_AU.UTF-8` after installing the required PHP/PostgreSQL packages.

```bash
git clone <plugin-repository-url> moodle-schoollibrary
cd moodle-schoollibrary
dev/setup.sh
dev/start.sh
```

Setup checks out the immutable Moodle commit in `dev/versions.env`, creates the PostgreSQL database, symlinks this repository to `mod/schoollibrary`, installs Moodle and the plugin, and initializes PHPUnit and Behat. Configuration can be overridden without committing secrets:

```bash
MOODLE_DB_HOST=localhost MOODLE_DB_USER="$USER" MOODLE_DB_PASSWORD='<local password>' dev/setup.sh
```

Open `http://127.0.0.1:8000`; stop with `dev/stop.sh`. `dev/reset.sh` deletes all generated state so `dev/setup.sh` can prove a clean rebuild. The bootstrap Behat feature creates its course and users through Moodle's standard fixture generators; PHPUnit uses Moodle data generators. Future manual fixture tooling should use the same supported APIs and represent `Test School Course`, `teacher1`, groups 5A/5B/an empty group, their specified students, a suspended student, an out-of-group enrollee, and a non-enrolled user.
