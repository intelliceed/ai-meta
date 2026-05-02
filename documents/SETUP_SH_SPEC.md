# setup.sh — Specification (Intelliceed AI Meta)

> **Last Updated**: 2026-05-02
> **Status**: Spec v16

## Purpose

Modular shell script system that scaffolds `.claude/` for any project in a single command.
Compatible with macOS, Linux, and Windows (Git Bash / WSL).

---

## Distribution

```bash
curl -fsSL "https://github.com/intelliceed/ai-meta/archive/refs/heads/main.tar.gz" | tar -xzf - -C /tmp/ && bash /tmp/ai-meta-main/setup.sh
```

Repo is public — no token required. Archive extracts to `/tmp/ai-meta-main/`. `setup.sh` uses `$(dirname "$0")` to locate modules. Cleanup only runs when `ARCHIVE_DIR` is under `/tmp/` — local runs are always safe.

---

## Module Architecture

| File | Responsibility |
|------|----------------|
| `setup.sh` | Orchestrator — root check, re-run detection, flag parsing, banner, cleanup |
| `output.sh` | Auto-detect commands, scaffold dirs, project name prompt, CLAUDE.md, TODO.md, start-claude.sh, .gitignore. **First run only.** |
| `skills/setup.sh` | Auto-discovers `skills/*/`. skip/all/pick prompt with descriptions. Copies selected only. |
| `agents/setup.sh` | Auto-discovers `agents/*.md`. skip/all/pick prompt with descriptions. Copies selected only. |
| `hooks/setup.sh` | Auto-discovers `hooks/bundles/*/`. skip/all/pick prompt with descriptions. Installs `settings.json` + scripts. |
| `mcp/setup.sh` | TODO stub |

All modules are **sourced** — share globals with the orchestrator.

**Flags:**
```bash
bash setup.sh --skills --agents --hooks --mcp   # individual modules
bash setup.sh                                    # default: all
```

---

## How It Works

| Step | First run | Re-run |
|------|-----------|--------|
| Root check | Warn if not git root, offer auto-cd | same |
| Detect mode | `.claude/` absent → first run | `.claude/` exists → update |
| `output.sh` | Run — scaffold + generate files | **Skipped** |
| Module prompts | skills → agents → hooks | same |
| Cleanup | `rm -rf` only if running from `/tmp/` | same |

---

## Prompts

| Prompt | Module | First run | Re-run | Default |
|--------|--------|-----------|--------|---------|
| Project name | `output.sh` | Yes | No | folder name |
| Skills | `skills/setup.sh` | Yes | Yes | all |
| Agents | `agents/setup.sh` | Yes | Yes | all |
| Hooks | `hooks/setup.sh` | Yes | Yes | skip |

Each module prompt shows a numbered menu (1/2/3) with the default marked. User presses Enter or types a number — no keywords to memorize. Invalid input falls back to the default. `pick` mode then shows a numbered item list with descriptions.

---

## Auto-Detection (output.sh, first run only)

| Value | Source |
|-------|--------|
| Repo URL | `git remote get-url origin` |
| Package manager | `pnpm-lock.yaml` → pnpm, `yarn.lock` → yarn, else npm |
| Install / Run / Test / Build | `package.json` scripts (root → app/ → src/ → frontend/ → backend/ → client/ → server/ → web/) |
| Python | `pyproject.toml` or `requirements.txt` |
| Go | `go.mod` |
| Ruby | `Gemfile` |

---

## Component Installation

All components copied from `$ARCHIVE_DIR` — no extra network calls.

**Settings** → `.claude/settings.json` (copied from `$ARCHIVE_DIR/settings.json`, first run only)

**Skills** → `.claude/skills/{name}/SKILL.md` (auto-discovered from `skills/*/`)

**Agents** → `.claude/agents/{name}.md` (auto-discovered from `agents/*.md`)

**Hooks** (auto-discovered from `hooks/bundles/*/`):
- Each bundle has `settings.json` + `scripts.txt` (list of scripts to copy from `hooks/scripts/`)
- Multi-bundle: scripts unioned (deduped); last selected bundle's `settings.json` wins
- Scripts copied to `.claude/hooks/` and made executable

---

## Scaffold Output

```
{project-root}/
└── .claude/
    ├── .gitignore              ← documents/*, !documents/.gitkeep, TODO.md
    ├── CLAUDE.md               ← project knowledge base
    ├── TODO.md                 ← session task list (gitignored)
    ├── settings.json           ← permissionMode, allowedTools, deniedTools
    ├── documents/              ← gitignored, .gitkeep
    ├── skills/{name}/SKILL.md  ← gitkeep if none selected
    ├── agents/{name}.md        ← gitkeep if none selected
    ├── hooks/{script}.sh       ← only if hooks selected
    └── start-claude.sh         ← launches Claude with TODO prompt
```

---

## Re-run / Update Mode

| Component | Behaviour |
|-----------|-----------|
| `CLAUDE.md` | Never touched |
| `TODO.md` | Never touched |
| `settings.json` | Never touched (first run only) |
| `skills/` | Selected: re-copied. Deselected: untouched. |
| `agents/` | Selected: re-copied. Deselected: untouched. |
| `hooks/` | Explicit selection: re-copied, deselected scripts removed. Skip or invalid input: untouched. |
| `documents/` | Never touched |
| `start-claude.sh`, `.gitignore` | Never touched (first run only) |

---

## CLAUDE.md Sections

| Section | Source |
|---------|--------|
| Project Identity (name, date, repo) | Auto-filled |
| Commands (install/run/test/build) | Auto-detected, falls back to TODO |
| Project Structure | 3-level tree, gitignored entries excluded |
| Engineer Role, Stack, Architecture, Key Files, Coding Conventions, Business Domain, Known Gotchas, Links | TODO — Claude fills at first session |
| TODO Protocol, Strict Planning Protocol, Document Creation Protocol | Static |

---

## Open Questions

- MCP setup: planned — auto-discover `mcp/integrations/*/`, skip/all/pick, merge `mcpServers` into `.claude/settings.json`
- Key Files auto-detection (scan for common entry points)
- Support pinning to a specific branch/tag in the install command

---

## Change Log

| Version | Date | Notes |
|---------|------|-------|
| v1–v11 | 2026-04-13 to 2026-04-15 | POC → public archive fetch, token removal, modular split |
| v12 | 2026-04-16 | Modular architecture, --flags, .gitkeep, output.sh extracted |
| v13 | 2026-04-17 | Modules self-contained, skip/all/pick prompts, auto-detection into output.sh |
| v14 | 2026-04-17 | Auto-discovery via find, hooks bundles structure, hooks merge fix |
| v15 | 2026-04-17 | Spec trimmed to match implementation — removed unimplemented sections |
| v16 | 2026-05-02 | settings.json added to scaffold with permissionMode, allowedTools, deniedTools |