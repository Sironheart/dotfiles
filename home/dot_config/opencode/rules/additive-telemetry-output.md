# Additive Telemetry and Log Output

- When adding default upstream log messages or standardizing report formats, keep existing custom metrics and precomputed derived logs intact.
- Treat upstream default logs and custom downstream telemetry as additive, not mutually exclusive.
- Do not remove or replace existing derived telemetry unless explicitly requested.
