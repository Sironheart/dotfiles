# One-sided optional booleans

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
