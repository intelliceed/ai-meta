# Intelliceed AI Meta

**One command scaffolds a full Claude Code setup for any project.**

Generic templates + your existing code = output that matches YOUR project's style and conventions.

---

## Quick Start

Run from your project root — no cloning required:

```bash
curl -fsSL "https://github.com/intelliceed/ai-meta/archive/refs/heads/main.tar.gz" | tar -xzf - -C /tmp/ && bash /tmp/ai-meta-main/setup.sh
```

Follow the prompts, then start Claude:

```bash
bash .claude/start-claude.sh
```

### What the Script Does

1. Prompts for project name, hooks, skills, and agents
2. Auto-detects repo URL, package manager, and run/test/build commands
3. Copies selected skills, agents, and hook scripts to `.claude/`
4. Generates `.claude/CLAUDE.md` with your project's context
5. Creates `.claude/start-claude.sh` launcher for future sessions
6. Cleans up — removes extracted files, leaves no setup artifacts

### What the Script Asks

| Prompt | Default | Options |
|--------|---------|---------|
| Project name | folder name | |
| Skills | all | `skip` / `all` / `pick` (shows descriptions) |
| Agents | all | `skip` / `all` / `pick` (shows descriptions) |
| Hooks | skip | `skip` / `all` / `pick` (shows descriptions) |

Stack, role, status, owner — Claude fills these in at your first session via `TODO.md`.

### Re-run to Update

Run the same command again in your project root. It detects existing `.claude/`, re-fetches selected components with the latest versions. Deselected components are left untouched. `CLAUDE.md` and `TODO.md` are never touched.

---

## How It Works

```
Generic Template → Analyze Your Code → Adapted Output
```

Skills and agents are intentionally generic. When invoked, Claude reads the template, then analyzes your existing code to learn your project's conventions — framework, style, patterns — and produces output that fits.

**Example**: `/generate-tests auth.py`

1. Claude reads `skills/test-generator/SKILL.md` — generic instructions
2. Claude reads your existing `tests/test_*.py` files
3. Claude learns: pytest, async fixtures, moto mocking
4. Claude generates a test matching your project's style — not a generic boilerplate

Same template, different projects = different results.

---

## Modules

| Module | What it provides | Docs |
|--------|-----------------|------|
| **Skills** | Slash-command workflows: generate tests, write commits | [skills/README.md](skills/README.md) |
| **Agents** | Autonomous reviewers: code review, security audit, diagrams | [agents/README.md](agents/README.md) |
| **Hooks** | Automated quality gates: secrets detection, command blocking | [hooks/README.md](hooks/README.md) |
| **MCP** | External tool integrations: draw.io diagramming _(coming soon — will be prompted during setup)_ | [mcp/README.md](mcp/README.md) |

---

## Advanced

Run individual modules instead of the full setup.

Update skills only:
```bash
curl -fsSL "https://github.com/intelliceed/ai-meta/archive/refs/heads/main.tar.gz" | tar -xzf - -C /tmp/ && bash /tmp/ai-meta-main/setup.sh --skills
```

Update agents only:
```bash
curl -fsSL "https://github.com/intelliceed/ai-meta/archive/refs/heads/main.tar.gz" | tar -xzf - -C /tmp/ && bash /tmp/ai-meta-main/setup.sh --agents
```

Update hooks only:
```bash
curl -fsSL "https://github.com/intelliceed/ai-meta/archive/refs/heads/main.tar.gz" | tar -xzf - -C /tmp/ && bash /tmp/ai-meta-main/setup.sh --hooks
```

Update MCP only:
```bash
curl -fsSL "https://github.com/intelliceed/ai-meta/archive/refs/heads/main.tar.gz" | tar -xzf - -C /tmp/ && bash /tmp/ai-meta-main/setup.sh --mcp
```

---

*Last Updated: 2026-04-25*
