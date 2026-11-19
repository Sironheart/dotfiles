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

## No refactors just for testability

- TDD applies when a test fits the existing structure. Keep the diff to the lines the change needs.
- Do not extract functions, split `main`, or add seams/constructors only so a test can reach the code.
- If the change can't be tested without such a refactor, make the minimal change without a test and say so in the summary. Offer the refactor plus a test as a separate option.

```go
// ❌ BAD — main() split into newApp() so a help-output test can call it
func main() { newApp().Run(...) }
func newApp() *cli.Command { ... }

// ✅ GOOD — only the needed field added
EnableShellCompletion: true,
ConfigureShellCompletionCommand: func(c *cli.Command) { c.Hidden = false },
```

## No tests for plain data types

- Do not write tests whose subject is a struct/model definition (`type Foo struct`, DTOs, records): JSON round trips, field-layout snapshots, serialization fixtures, "decodes record X" tables.
- Test behaviour that uses the types (store, handler, client logic). Models are covered through those tests.
- Do not add JSON fixture files or `testdata/` golden files for models. When removing such fixtures, delete the model tests too; do not inline them.
- Exception: the user explicitly asks for a serialization/compatibility test.
