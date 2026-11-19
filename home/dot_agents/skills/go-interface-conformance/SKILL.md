---
name: go-interface-conformance
description: When writing, reviewing, or cleaning up Go types that implement an interface — add and keep compile-time conformance checks (var _ Iface = (*Impl)(nil)).
---

# Go: compile-time interface conformance checks

When a type purposefully implements an interface, add a nil-value compile-time
check on the implementing side:

```go
var _ Store = (*S3Store)(nil)      // pointer receiver methods
var _ Crypter = fakeCrypter{}      // value receiver methods
```

- Applies to production types and test fakes/stubs.
- Includes stdlib interfaces (`error`, `http.Handler`) when implemented deliberately.
- If the implementing package would import the interface's package and create a
  cycle, place the check next to the interface definition instead, with a short
  comment saying why.

## Keep existing checks

- These lines are deliberate. Keep them, even when another call site already
  forces the same check.
- Do not flag them as redundant or lean findings, and do not delete them in
  cleanups.
- When narrowing an interface, retarget the check to the new interface instead
  of dropping it.

```go
// ❌ BAD — "NewHealthCheck already returns it as HealthCheck", check deleted

// ✅ GOOD
var _ HealthCheck = (*healthcheck)(nil)
var _ cacheSyncer = (*blockingCache)(nil)
```
