import { existsSync, readFileSync } from "node:fs";
import { join } from "node:path";
import { type ExtensionAPI, getAgentDir, parseFrontmatter } from "@earendil-works/pi-coding-agent";

const readOnlyAgent = "general-purpose";
const shellDenylist: Record<string, readonly string[]> = {
  git: ["commit", "push"],
  kubectl: [
    "apply", "create", "delete", "edit", "exec", "patch", "run", "set", "replace",
    "scale", "autoscale", "expose", "label", "annotate", "taint", "cordon", "uncordon",
    "drain", "attach", "cp", "restart", "undo", "pause", "resume", "approve", "deny",
    "set-context", "set-cluster", "set-credentials", "use-context", "unset",
    "delete-context", "delete-cluster", "delete-user", "rename-context",
  ],
  helm: ["install", "upgrade", "uninstall", "delete", "rollback", "test", "push"],
  terraform: ["apply", "destroy", "import", "refresh", "taint", "untaint", "force-unlock"],
  tofu: ["apply", "destroy", "import", "refresh", "taint", "untaint", "force-unlock"],
  pulumi: ["up", "destroy", "refresh", "import", "cancel"],
  docker: [
    "run", "exec", "attach", "cp", "start", "stop", "restart", "kill", "pause", "unpause",
    "rm", "rmi", "prune", "create", "update", "rename", "push", "up", "down",
    "scale", "deploy", "rollback", "leave", "init", "join", "promote", "demote",
    "connect", "disconnect", "reload",
  ],
  systemctl: ["start", "stop", "restart", "reload", "enable", "disable", "mask", "unmask", "daemon-reload", "kill", "reboot", "poweroff"],
  launchctl: ["load", "unload", "bootstrap", "bootout", "kickstart", "start", "stop", "enable", "disable", "kill", "submit", "remove"],
};

function blockedShellCommand(command: string): string | undefined {
  // Like OpenCode's guard, this is a token backstop, not a shell sandbox.
  const tokens = command.split(/[\s;|&()<>`]+/)
    .map((token) => token.replace(/["']/g, "").split("/").pop() ?? "");
  if (tokens.includes("brew") || /homebrew\/install|brew\.sh/i.test(command)) return "brew";
  const gitAlias = tokens.find((token) => token === "git-commit" || token === "git-push");
  if (gitAlias) return gitAlias;
  return Object.entries(shellDenylist)
    .filter(([tool]) => tokens.includes(tool))
    .flatMap(([tool, verbs]) => verbs.filter((verb) => tokens.includes(verb)).map((verb) => `${tool} ${verb}`))
    .at(0);
}

export default function policyGuard(pi: ExtensionAPI) {
  const readySessions = new Set<string>();
  pi.events.on("permissions:ready", (event) => {
    readySessions.add((event as { sessionId: string }).sessionId);
  });

  pi.on("tool_call", (event, ctx) => {
    if (!readySessions.has(ctx.sessionManager.getSessionId())) {
      return { block: true, reason: "Permission enforcement is unavailable in this session. Stop and repair the extension setup." };
    }
    if (event.toolName === "bash" && typeof event.input.command === "string") {
      const blocked = blockedShellCommand(event.input.command);
      if (blocked) return { block: true, reason: `${blocked} is reserved for the human. Run it yourself outside the agent tool.` };
    }
    if (event.toolName !== "subagent") return;

    // The subagent package discovers project profiles even when Pi project trust is denied.
    if (existsSync(join(ctx.cwd, ".pi", "agents"))) {
      return { block: true, reason: "Delegation is blocked while this project has .pi/agents overrides. Use the reviewed global profiles." };
    }
    if (event.input.subagent_type !== readOnlyAgent) {
      return { block: true, reason: `Use the read-only ${readOnlyAgent} profile for research and review.` };
    }
    try {
      const { frontmatter } = parseFrontmatter(readFileSync(join(getAgentDir(), "agents", `${readOnlyAgent}.md`), "utf8"));
      if (ctx.modelRegistry.getAvailable().some((model) => `${model.provider}/${model.id}` === frontmatter.model)) return;
      return { block: true, reason: "The configured smaller model is unavailable. Ask the human before changing models." };
    } catch {
      return { block: true, reason: "The reviewed global agent profile could not be loaded." };
    }
  });
}
