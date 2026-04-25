# Skills

Reusable Claude Code skill templates copied to user projects by `setup.sh`.

## What Are Skills?

Skills are Markdown instruction files that tell Claude how to perform a specific recurring task — for example, generating tests or writing commit messages. They are invoked by the user with a `/slash-command` and guide Claude's behavior step-by-step.

**Important**: Skills are prompts, not code. They contain instructions for Claude, not shell scripts or source files.

## Module Structure

```
skills/
  setup.sh              ← installer (auto-discovers skill directories)
  commit-helper/
    SKILL.md            ← the skill prompt installed to .claude/skills/commit-helper/
  test-generator/
    SKILL.md
```

## Available Skills

| Skill | Slash Command | Purpose |
|---|---|---|
| `commit-helper` | `/commit` | Generates commit messages matching the project's git conventions |
| `test-generator` | `/generate-tests <file>` | Generates tests matching the project's framework and patterns |

## How to Add a New Skill

Create `skills/my-skill/SKILL.md` — that's it. Auto-discovery picks it up automatically.

```markdown
# Skill Template: My Skill

## Purpose
One sentence describing what this skill does. (First 60 chars shown in setup pick menu.)

## Instructions for Claude
When this skill is invoked:

### Step 1: ...
### Step 2: ...
### Step N: ...

## Usage
`/my-command`

Claude will:
1. ...
```

`setup.sh` copies `skills/my-skill/SKILL.md` → `.claude/skills/my-skill/SKILL.md` on install.

## Skill Design Guidelines

### Structure
- **Purpose**: One sentence — what does invoking this skill do?
- **Instructions for Claude**: Numbered steps Claude follows each time
- **What to Learn**: What project-specific context Claude should read first
- **Example Adaptation**: Concrete before/after showing how output varies by project
- **Usage**: The slash command and what Claude does

### Best Practices
- **Generic, not project-specific**: Skills are templates — no hardcoded paths, team names, or conventions
- **Self-contained**: A skill should work in any project after Claude reads CLAUDE.md
- **Teach, don't assume**: Instruct Claude to *learn* project patterns first, then act
- **Show variance**: Include 2+ examples showing how the skill adapts to different project types

### What Makes a Good Skill

Good candidate for a skill:
- Recurring task a developer repeats multiple times
- Task that requires learning project-specific patterns (style, conventions, framework)
- Output that must be consistent with existing project artifacts

Poor candidate for a skill:
- One-time setup tasks (use setup.sh instead)
- Tasks that don't vary by project (just use a direct prompt)
- Tasks better handled by an agent (longer multi-step workflows with tool use)

## How Claude Uses Skills (Adaptation Workflow)

When a skill is invoked in a user project:

```
1. User runs:   /generate-tests auth.py
2. Claude reads: .claude/skills/test-generator/SKILL.md  (the template)
3. Claude reads: .claude/CLAUDE.md                        (project context)
4. Claude scans: tests/*.py                               (existing test patterns)
5. Claude learns: framework, fixtures, mocking approach, naming style
6. Claude generates: test file matching the project's patterns
```

The template instructs Claude *what to look for* — the project's code provides *the actual patterns*. The same `SKILL.md` produces different output in a pytest/async project vs a Jest/React project.

## Skills vs Agents

| | Skills | Agents |
|---|---|---|
| **Invoked by** | User (`/slash-command`) | Claude (internally via Agent tool) |
| **File format** | Markdown prompt | Markdown with YAML frontmatter |
| **Scope** | Focused, single task | Multi-step, autonomous workflows |
| **Tool use** | Claude's own tools | Specialized agent toolset |
| **Examples** | generate commit, write tests | review PR, audit security, draw diagram |
