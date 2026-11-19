# Follow-up fixes inside an approved task

- Once the user approved a goal (e.g. "move CI to mise", "make the MR green"), a failure that blocks that goal is part of the same task.
- After diagnosing such a failure, apply the in-scope fix and verify it. Do not stop to ask "Should I make that edit?".
- Still ask first for changes outside the approved scope: other repos, shared presets/images, deploys, destructive or irreversible actions.

```text
❌ "Root cause: pnpm 11 needs libatomic. Proposed fix: pin pnpm 12. Should I make that edit?"
✅ "Root cause: pnpm 11 needs libatomic. Pinned pnpm 12.15.0, frozen install verified."
```
