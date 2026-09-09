---
name: pulumi-resource-style
description: When writing Pulumi TypeScript — resource args must be object literals; functions/apply only for single values.
---

# Pulumi constructor style

- Always pass **object literals / object constants** as the 2nd (args) and 3rd (opts) parameters to `new Resource(...)`.
- Prefer shared opts constants (`k8sResourceOpts`, `awsResourceOpts`) — never `opts()` helper **functions**.
- Functions / `.apply` are only for computing **single values** (strings, numbers, arrays of data) used inside args.
- Do **not** create Pulumi resources inside functions, loops-in-`.apply`, or factory helpers that “write entire jobs”.
- Prefer Pulumi/provider defaults. Omit arguments that only restate defaults; override them only for required behavior and document why.
