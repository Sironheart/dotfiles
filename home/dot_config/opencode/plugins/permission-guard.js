// Token-based backstop for the shell denylist: prefix patterns miss
// wrapped invocations (`sudo git commit`, `env FOO=1 brew install`), so match
// shell tokens by basename instead. Mirrors the old Cursor hooks.
const KUBECTL_VERBS = ["apply", "create", "delete", "edit", "exec", "patch", "run", "set"]

export default {
  id: "permission-guard",
  async setup(ctx) {
    await ctx.tool.hook("execute.before", (event) => {
      if (event.tool !== "shell") return
      const command = String(event.input?.command ?? "")
      // shortcut: whitespace tokens are only a backstop, use a shell parser for complete syntax coverage.
      const tokens = command.split(/\s+/).map((t) => t.split("/").pop())
      const has = (name) => tokens.includes(name)

      if (has("brew") || /homebrew\/install/i.test(command) || /brew\.sh/.test(command)) {
        throw new Error("Blocked: Homebrew (brew) is not allowed. Use mise instead (mise install / mise use).")
      }
      if (has("git") && (has("commit") || has("push"))) {
        throw new Error("Blocked: git commit/push. Ask the user to run it manually if they really want it.")
      }
      if (has("kubectl")) {
        const verb = KUBECTL_VERBS.find((v) => has(v))
        if (verb) {
          throw new Error(`Blocked: kubectl ${verb}. Ask the user to run it manually if they really want it.`)
        }
      }
    })
  },
}
