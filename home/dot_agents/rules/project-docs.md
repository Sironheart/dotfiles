# Project docs and agent instructions

## Project-specific content only

When writing or editing project docs (README, AGENTS.md, etc.):

- **Never document tool/command usage** — no invocation lists, flag explanations, or per-command summaries. Tool usage is documented in the tool's own definition (e.g. mise task descriptions in `mise.toml`) or nowhere. Reference tasks by name, don't spell out invocations.
- **Never document the usage or functionality of shared/third-party components** (CI components, libraries, platform features). Describe only the steps, jobs, and wiring the project itself adds.
- Component constraints only earn a mention as the *why* behind a project-specific line (e.g. an override exists because the component behaves a certain way).

```markdown
# ❌ BAD
- **release**: the shared release component creates the next X.Y.Z tag from conventional commits. Requires GITLAB_TOKEN.
- **build**: runs `pnpm install && pnpm run build`.

# ✅ GOOD
- **build** (`build:npm:tag` on tags): compiles the package; the tag build stamps the tag as the package version.
```

## Remove stale instructions

- After a rewrite, migration, or tooling change, search the repo for instructions that describe the old state: agent files (`.instructions.md`, `AGENTS.md`, `CLAUDE.md`, `.cursor/rules`), README, runbooks, skills, `docs/`.
- Delete instruction files that are wholly obsolete; fix stale lines (paths, commands, log formats, library names) in files that are still valid.
- Do this in the same change without asking. Leave dated historical reports (reviews, postmortems) untouched.
- Verify claims you rewrite against the code (e.g. a header really is propagated, a log field really exists).
