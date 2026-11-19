# Official SDKs over hand-rolled protocol layers

- When implementing or porting a protocol server/client (MCP, OAuth, OIDC, gRPC, etc.), use the official SDK for the target language (e.g. `github.com/modelcontextprotocol/go-sdk` for MCP in Go).
- If a requirement (e.g. "100% backwards compatible") seems to rule the SDK out, do not silently hand-roll the protocol. Ask first, listing the concrete SDK differences that would become client-visible.
- Hand-roll only after the user explicitly accepts that trade-off.
- Bigger features (auth, OAuth/OIDC, token handling, transports, persistence): before writing or porting code, check for an official SDK/framework (vendor or language team first, then de-facto standards, labelled as such). Introduce it to the user with what it replaces, concrete benefits, and client-visible differences, then ask whether to adopt it. Do not adopt or reject it silently.
- Logging: use the language's idiomatic structured logging (Go: `log/slog`) unless the user asks for byte-identical log output.
