---
name: http-method-semantics
description: When adding or proposing HTTP routes or RPC-style server functions (Axum, Dioxus, etc.) — pick the HTTP method matching the operation.
---

# HTTP method semantics

- When adding or proposing HTTP routes or RPC-style server functions (Dioxus `#[get]`/`#[post]`/…, Axum, etc.), use the method that matches the operation: `GET` read, `POST` create, `PUT`/`PATCH` update, `DELETE` remove.
- Do not default to `POST` for non-create mutations just because neighbouring endpoints use it.

```rust
// ❌ BAD
#[post("/api/bookmarks/{bookmark_id}/delete")]

// ✅ GOOD
#[delete("/api/bookmarks/{bookmark_id}")]
```
