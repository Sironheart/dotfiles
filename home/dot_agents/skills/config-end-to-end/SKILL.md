---
name: config-end-to-end
description: When asked to make something configurable — wire it through app config, Helm chart (values, schema, templates, README) and tests in the same change.
---

# Configurable means end to end

When asked to make something configurable, wire it through every layer users deploy with, in the same change:

- App config key (with default and validation).
- Helm chart: `values.yaml` key, `values.schema.json` entry, template usage everywhere the value matters (env var, `containerPort`, probes, Service, NetworkPolicy), chart README row.
- Tests for the new value (Helm unit test for a non-default value).

Do not stop at the app layer and hardcode the chart side, even if a similar existing setting does. If an existing setting is only half-wired, mention it instead of copying the gap.
