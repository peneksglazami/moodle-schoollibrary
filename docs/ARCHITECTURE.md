# Bootstrap architecture

- The repository root is the plugin root and is installed as `<moodle-root>/mod/schoollibrary`; Moodle core is never vendored here.
- Standard Moodle APIs are preferred. The bootstrap deliberately includes no speculative loan domain model.
- GitHub Actions is the authoritative automated quality gate.
- Exactly Moodle 4.4.1 is the mandatory primary deployment target, tested with PHP 8.3. Other-version checks are secondary and cannot replace it.
- PostgreSQL is the preferred development database unless a concrete incompatibility is found.
- Generated Moodle core, data roots, test data, browser state, and local configuration live in a sibling `.schoollibrary-dev` directory outside this Git repository.
- `dev/versions.env` is the common immutable version source for scripts and CI.

