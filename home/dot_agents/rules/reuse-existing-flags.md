# Reuse existing flags in fixes

- When a bug comes from code bypassing an existing helper or flag (e.g. raw `mergeRequestId` instead of `isFeatureDeployment`), fix the call sites to use that helper. Do not redefine or reshape the helper itself.
- For such one-line wiring fixes, do not propose or write a new test unless the user asks; existing tests plus typecheck are the verification.

```ts
// ❌ BAD — rewrites the shared helper
export const mergeRequestId = isFeatureDeployment ? process.env.CI_MERGE_REQUEST_IID : undefined;

// ✅ GOOD — call sites use the existing flag
isFeatureDeployment ? `mr${mergeRequestId}` : undefined,
```
