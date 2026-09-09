# Renovate Custom Managers

- Capture dependency name, version, and digest directly from target field when possible.
- Use `datasourceTemplate` and `versioningTemplate` when those values are fixed.
- Add annotation only when required metadata cannot be inferred or one generic manager covers different dependency types.
- For mutable Docker tags, capture `currentDigest` so Renovate can update pinned content.
