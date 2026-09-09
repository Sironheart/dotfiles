// Token-based backstop for the permission.bash denylist: prefix patterns miss
// wrapped invocations (`sudo git commit`, `env FOO=1 brew install`), so match
// shell tokens by basename instead. Mirrors the old Cursor hooks.
const KUBECTL_VERBS = ["apply", "create", "delete", "edit", "exec", "patch", "run", "set"]

export const PermissionGuard = async () => ({
  "tool.execute.before": async (input, output) => {
    if (input.tool !== "bash") return
    const command = String(output.args?.command ?? "")
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
  },
})
