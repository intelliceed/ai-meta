# MCP Integrations

MCP (Model Context Protocol) server configurations for Claude Code.

> **Status**: In progress — MCP will be offered as a prompted option during `setup.sh` (same `skip/all/pick` flow as skills, agents, and hooks). Until then, configure manually using the steps below.

## What Is MCP?

MCP servers extend Claude Code with new tools — for example, the ability to interact with draw.io diagrams, query databases, or call external APIs. They are configured in `.claude/settings.json` under `mcpServers`.

## Module Structure

```
mcp/
  setup.sh          ← stub (not yet implemented)
  drawio/
    README.md       ← installation and usage guide for draw.io MCP
    DIAGRAM_RULES.md ← diagramming conventions for Claude
```

## Available Integrations

| Integration | Purpose | Status |
|---|---|---|
| `drawio` | Create and edit diagrams directly from Claude Code | Manual install only |

## How to Add a New MCP Integration

**Step 1 — Create a directory under `mcp/`:**

```
mcp/my-integration/
  README.md         ← installation steps, usage guide, available tools
  settings.json     ← the mcpServers config snippet to merge into .claude/settings.json
```

`settings.json` format:
```json
{
  "mcpServers": {
    "my-integration": {
      "command": "npx",
      "args": ["-y", "my-mcp-server-package"]
    }
  }
}
```

**Step 2 — Write a `README.md`** covering:
1. What Claude gains from this integration (new tools/capabilities)
2. Prerequisites (npm package, browser extension, external service, etc.)
3. Installation steps
4. Quick start example
5. Available MCP tool reference
6. Troubleshooting

**Step 3 — Register in `mcp/setup.sh`** _(once the module is implemented)_:

The MCP setup module is not yet built. When implemented, it will follow the same `skip/all/pick` pattern as skills, agents, and hooks — auto-discovering integrations from `mcp/*/settings.json`.

## Manual Installation (Current)

Until `setup.sh` wires MCP, install any integration manually:

```bash
# 1. Merge mcpServers config into your project's .claude/settings.json
#    (jq or manual edit)

# 2. Follow the integration's README.md for prerequisites

# 3. Restart Claude Code
claude
```

## MCP Design Guidelines

### settings.json
- Use `npx -y <package>` for zero-install npm servers
- Document any required environment variables (`SOME_API_KEY`, etc.)
- Never hardcode credentials — use env var references

### README.md
- Lead with "what Claude can now do" — not the technical setup
- Include a Quick Start that works in under 5 minutes
- List every available MCP tool with a one-line description
- Cover the most common failure mode in Troubleshooting

### When to Add an MCP vs a Skill/Agent

| Use MCP when | Use Skill/Agent when |
|---|---|
| Claude needs to interact with an external tool or UI (diagrams, databases, APIs) | Claude needs to reason about or generate content |
| Real-time two-way communication with an external system is required | The task can be done with Claude's built-in tools (Read, Write, Bash, etc.) |
| A dedicated server/extension is available for the integration | No external server is needed |
