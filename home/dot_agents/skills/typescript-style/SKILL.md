---
name: typescript-style
description: >-
  When writing TypeScript/JavaScript — transform collections with map/flatMap/filter/reduce pipelines instead of loops, and type optional flags with a clear default as one-sided `?: true` / `?: false`.
---

# TypeScript style

## Array pipelines over loops

- Transform collections with `map` / `flatMap` / `filter` / `reduce` chains instead of `for` / `for...of` loops.
- Nested loops become `flatMap` (flatten) followed by `map` (produce result).
- Use `Object.entries(...)` to pipe over object-literal config.
- Return the mapped result (e.g. created resources) instead of discarding it in a loop.
- Keep plain loops only for early exit (`break`/`return`) or sequential `await`.

```ts
// ❌ BAD
for (const [key, { values }] of Object.entries(config)) {
  for (const [env, value] of Object.entries(values)) {
    new Resource(`${key}-${env}`, { key, env, value });
  }
}

// ✅ GOOD
return Object.entries(config)
  .flatMap(([key, { values }]) =>
    Object.entries(values).map(([env, value]) => ({ key, env, value })),
  )
  .map(({ key, env, value }) => new Resource(`${key}-${env}`, { key, env, value }));
```

## One-sided optional booleans

When an optional flag has a clear default and callers only ever need the non-default:

- Type it as `field?: true` (opt-in) or `field?: false` (opt-out), not `boolean`.
- Treat `undefined` / omitted as the default; only handle the literal override.
- Do **not** allow writing the default value (`true` on an opt-out, `false` on an opt-in).

```ts
// ❌ BAD — both directions legal; default not encoded in the type
renovateUpdates?: boolean; // default true

// ✅ GOOD — only the opt-out is expressible
renovateUpdates?: false;
const enabled = args.renovateUpdates !== false;
```

```ts
// ✅ GOOD — opt-in presence flag
pulumi?: true;
```

Keep `boolean` when both directions are real overrides, or when other inputs conditionally flip the effective default (e.g. auto-enable from related config).
