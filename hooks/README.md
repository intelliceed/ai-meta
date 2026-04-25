# Hook Templates

Template configurations for Claude Code hooks.

## What Are Claude Code Hooks?

Hooks run shell commands at specific events in Claude Code workflow:
- **PreToolUse**: Before Claude runs a tool (Edit, Write, Bash, etc.)
- **PostToolUse**: After tool completes successfully
- **SessionStart**: When a Claude Code session begins
- **UserPromptSubmit**: When user submits a prompt

They can block actions or add context to Claude's workflow.

**Important**: These are NOT git hooks (pre-commit, pre-push). These are Claude Code-specific events.

## Module Structure

```
hooks/
  setup.sh              ← installer (auto-discovers bundles — do not hardcode here)
  scripts/              ← reusable hook scripts
    scan-secrets.sh     ← blocks hardcoded secrets on Edit/Write
    check-quality.sh    ← code quality stub (adapt to project)
    check-command.sh    ← blocks dangerous bash commands
  bundles/              ← installable presets
    basic-security/
      settings.json     ← Claude Code hook config referencing .claude/hooks/*.sh
      description       ← one-liner shown in setup.sh prompt
      scripts.txt       ← which scripts/ files to copy on install
    comprehensive/
      settings.json
      description
      scripts.txt
```

## Available Bundles

### basic-security
Prevents hardcoded secrets in code.
- **Scripts**: `scan-secrets.sh`
- **Triggers**: PreToolUse on Edit|Write
- **Blocks**: Content matching credential patterns

### comprehensive
Full quality gate with multiple checks.
- **Scripts**: `scan-secrets.sh`, `check-command.sh`
- **Triggers**: PreToolUse on Edit|Write and Bash
- **Blocks**: Secrets, quality violations, dangerous commands

## How to Add a New Hook

Two steps — no edits to existing files required:

**Step 1 — Add your script to `scripts/`:**

```bash
# hooks/scripts/my-check.sh
#!/bin/bash
# PreToolUse hook: describe what this checks
# Receives tool input JSON on stdin.
#
# Exit codes: 0 = allow, 1 = block (error), 2 = block (warn)

input=$(cat)
# ... your checks ...
exit 0
```

**Step 2 — Create a bundle in `bundles/`:**

```
bundles/my-bundle/
  settings.json   ← Claude Code hook config
  description     ← one-liner for the setup prompt
  scripts.txt     ← newline-separated list of scripts/ files to install
```

`settings.json` format:
```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [{"type": "command", "command": ".claude/hooks/my-check.sh"}]
      }
    ]
  }
}
```

`setup.sh` auto-discovers your bundle — it will appear in the menu immediately.

## Hook Script Guidelines

### Structure
```bash
#!/bin/bash
# Brief description of what this checks

# Exit codes:
# 0 = allow action
# 1 = block action (hard error)
# 2 = block action (warning, user can override)

input=$(cat)
content=$(printf '%s' "$input" | jq -r '(.new_string // .content) // ""' 2>/dev/null || echo "")
[[ -z "$content" ]] && exit 0

# Your checks here
```

### Best Practices
- **Fast**: Complete in < 5 seconds
- **Specific**: Clear error messages with context
- **Focused**: One category per script (secrets, quality, commands)
- **Safe**: Handle empty input and binary files gracefully

### Input
Scripts receive context via:
- **stdin**: Tool input as JSON (`{"new_string": "...", "command": "...", ...}`)
- **Environment**: `CLAUDE_TOOL_NAME`, `CLAUDE_FILE_PATH` (when available)

### Output
- **stdout**: Messages shown to Claude and user
- **stderr**: Debug info (not shown to user)
- **Exit code**: 0=allow, 1=block hard, 2=block warn

## Adaptation Required

Scripts are starting points. After install, adapt them to project specifics:

**Example: secrets detection for an AWS/Python project**
```bash
# Add to scan-secrets.sh patterns array:
'AKIA[0-9A-Z]{16}'           # AWS access key ID
'aws_secret_access_key\s*='  # AWS secret key assignment
```

**Example: quality check for a Node.js project**
```bash
# In check-quality.sh:
if echo "$content" | grep -qE 'console\.log\('; then
  echo "check-quality: console.log detected — use logger instead" >&2
  exit 2
fi
```

## Multi-bundle Installs

When multiple bundles are selected (via `all` or comma-separated `pick`):
- Scripts are **unioned** (deduped) — no duplicates installed
- `settings.json` — **last selected bundle wins** (alphabetical order, so `comprehensive` always wins over `basic-security`)

To combine hook configs from multiple bundles into one `settings.json`, create a new bundle that explicitly includes all desired hooks.

## Debugging Hooks

1. **Check format**: Event names (`PreToolUse` not `pre-commit`), matcher regex
2. **Check script path**: Relative to project root (`.claude/hooks/script.sh`)
3. **Check permissions**: `chmod +x .claude/hooks/*.sh`
4. **Test manually**: `echo '{"new_string":"test"}' | .claude/hooks/scan-secrets.sh`
5. **Check logs**: Claude Code shows hook stdout on block

## See Also

- Claude Code hooks docs: https://code.claude.com/docs/en/hooks.md
- Intelliceed AI Meta skills: `../skills/`
- Intelliceed AI Meta agents: `../agents/`
