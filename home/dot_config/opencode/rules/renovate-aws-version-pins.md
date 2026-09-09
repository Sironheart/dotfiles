# Renovate for AWS version pins

When adding or changing **hard-coded AWS version/engine/image pins** in Pulumi, Terraform, CloudFormation, Helm values, YAML, or similar IaC, **also wire Renovate** so updates are discovered. Do not leave silent pins.

## In-scope examples

- RDS / Aurora `engineVersion`
- ElastiCache / MemoryDB / DocumentDB / Neptune / MSK engine versions
- EKS addon versions (`vpc-cni`, `coredns`, `kube-proxy`, …)
- AMI IDs (`ami-…`) and launch-template image pins
- Other AWS API-versioned fields that teams pin in code

## Required actions (same change / PR)

1. Prefer official Renovate AWS datasources when they fit:
   - [`aws-rds`](https://docs.renovatebot.com/modules/datasource/aws-rds/) — `rdsFilter=…` (minified `DescribeDBEngineVersions` filters)
   - [`aws-machine-image`](https://docs.renovatebot.com/modules/datasource/aws-machine-image/) — `amiFilter=…`
   - [`aws-eks-addon`](https://docs.renovatebot.com/modules/datasource/aws-eks-addon/) — `eksAddonsFilter=…`
2. If no official datasource exists, use a `customDatasources` / regex manager (or say so and stop) — do not invent silent pins.
3. Add a **regex `customManagers` entry** in the repo `renovate.json` / `renovate.json5` (or confirm an existing manager already matches the file + annotation).
4. Put a **Renovate annotation comment immediately above the pin** (allowed exception to “no narrating comments” — this is machine config).
5. Prefer pinning within the current major/line via the filter (e.g. Postgres `14.x`), not open-ended majors, unless the user asks for majors.
6. Keep AWS datasource updates **non-automerge** / dashboard-approved unless the user says otherwise.

## Pattern (Pulumi / TypeScript)

```typescript
// renovate: rdsFilter=[{"Name":"engine","Values":["postgres"]},{"Name":"engine-version","Values":["14"]}] depName=postgres versioning=loose
engineVersion: "14.22",
```

```json
{
  "customManagers": [
    {
      "customType": "regex",
      "managerFilePatterns": ["/deploy\\/src\\/.*\\.ts$/"],
      "matchStrings": [
        "//\\s*renovate:\\s*rdsFilter=(?<packageName>\\S+)\\s+depName=(?<depName>\\S+)\\s+versioning=(?<versioning>\\S+)\\s*\\n\\s*engineVersion:\\s*\"(?<currentValue>[^\"]+)\""
      ],
      "datasourceTemplate": "aws-rds"
    }
  ]
}
```

Adapt comment syntax (`#` / `//`) and `managerFilePatterns` to the language and path. Verify the regex matches the file before finishing.
