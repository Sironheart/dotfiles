# Test-driven development (project code)

- For **project** behavior changes (domain logic, API, DB, UI contracts, app refactors that alter outcomes): **red → green → refactor**.
- Write or extend a **failing test first**. Do not implement production code until that failure is observed (or clearly would fail if run).
- Do **not** treat TDD as optional, “later”, or limited to smoke/health/bootstrap paths.
- Prefer the lowest useful test: unit where pure; integration (e.g. testcontainers) where I/O/boundaries matter.
- Green before expanding scope. No drive-by features without tests.
- **Skip TDD** for repo scaffolding around the app: mise tasks, shell glue, Docker/compose wiring, docs, pure renames, generated noise — unless that glue embeds product behavior worth asserting.

## Existing tests are given

- Treat existing tests as the fixed contract: never edit, weaken, or delete them to make a run green.
- Only touch them when the underlying structure or data they cover actually changes (signature, schema, persisted format).
- If an existing test looks wrong or outdated, **ask before correcting it** — propose the fix, wait for approval.
