# Renovate Mise and automerge

- Mise keeps backend prefixes such as `npm:` in `depName`, but strips them from `packageName`. Use the unprefixed name with `matchPackageNames`; use the prefixed name only with `matchDepNames`.
- Use platform-native automerge for CI-gated automerge unless an exact merge window is required. Rely on required platform checks to prevent merging before CI succeeds.
- `platformAutomerge: true` cannot enforce `automergeSchedule`. Use `schedule` only to limit branch/PR creation, and state that platform merge may happen later outside that window.
- Run and merge lock-file maintenance only on Monday from 00:00 through 03:59: set both `schedule` and `automergeSchedule` to `["* 0-3 * * 1"]`, and set `platformAutomerge: false`.
