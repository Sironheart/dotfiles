# Corrections become persistent rules

If you're being corrected to do something differently, create or update a rule, skill, or plugin (whichever fits) so the mistake is not repeated. Persist shared guidance in the dotfiles repo under `home/dot_agents/` (`AGENTS.md.tmpl`, `rules/`, `skills/`); keep harness-specific settings and plugins in that harness's source directory. Never edit deployed guidance or harness configuration directly — chezmoi manages it. Follow the human-approval requirement before editing.
