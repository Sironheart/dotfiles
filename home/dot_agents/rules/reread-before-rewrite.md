# Re-read before rewriting

- Never do a full-file overwrite of an existing file the user may have touched since my last read. Re-read it first.
- Prefer targeted edits over wholesale rewrites for any file I did not create in this turn.
- If a full rewrite is unavoidable, diff my last known content against the current file and carry over any user additions (e.g. shell completions, local tweaks) before writing.
