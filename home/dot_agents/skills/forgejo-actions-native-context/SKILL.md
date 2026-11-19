---
name: forgejo-actions-native-context
description: When writing or editing Forgejo Actions workflows (.forgejo/workflows) or Forgejo releases — prefer SHA-pinned actions, use forgejo.* context directly, and release Go containers via GoReleaser ko.
---

# Forgejo Actions and Releases

- Prefer SHA-pinned Forgejo-compatible actions over shell scripts when an action exists.
- Use `forgejo.*` context values directly in action inputs, image names, tags, and labels. Do not duplicate them in workflow environment variables or hardcode repository coordinates.
- Keep shell steps only where no suitable Forgejo-compatible action exists.
- For Go container releases, prefer GoReleaser's `ko` integration over Dockerfile or Buildx unless explicitly requested otherwise.
