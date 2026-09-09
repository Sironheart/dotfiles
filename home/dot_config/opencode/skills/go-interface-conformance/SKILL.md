---
name: go-interface-conformance
description: When writing Go types that implement an interface — add compile-time conformance checks (var _ Iface = (*Impl)(nil)).
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
