# Test-driven development (project-owned code logic)

- Write tests only for logic implemented by this project's code: decisions, transformations, validation, and error handling. Each test must catch a bug in that logic, not prove that a dependency works.
- For changes to that logic: **red → green → refactor**.
- Write or extend a **failing test first**. Do not implement production code until that failure is observed (or clearly would fail if run).
- Do **not** treat TDD as optional, “later”, or limited to smoke/health/bootstrap paths.
- Prefer the lowest useful test: unit for pure logic; integration when project-owned logic crosses I/O boundaries. Assert the project's decisions and outcomes, not the dependency's contract.
- Green before expanding the logic change's scope.

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

## Outside test scope

- Binaries: installation, executable presence, startup, version/help output, and packaged artifacts.
- Structs, models, DTOs, and records: field layouts, serialization round trips, and data-definition fixtures or snapshots. Test project logic that uses them instead.
- Configuration and declarative wiring: settings, manifests, templates, task definitions, Docker/compose wiring, and infrastructure declarations.
- Frameworks and libraries: their documented behavior, built-in validation, serialization, routing, lifecycle, and other functionality they own. Using a dependency in a test of project logic is fine; making the dependency the test subject is not.
- Docs, pure renames, generated files, and scaffolding without project-owned logic.

Use existing builds, typechecks, parsers, schema validators, and checks for these changes instead of adding custom tests. If a script or configuration embeds real code logic, test only that logic.
