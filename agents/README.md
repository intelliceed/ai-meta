# Agents

Reusable Claude Code agent definitions copied to user projects by `setup.sh`.

## What Are Agents?

Agents are subprocesses that Claude spawns to handle complex, multi-step tasks autonomously. Each agent has a defined role, a set of available tools, and a system prompt that shapes its behavior. They run independently and return a result to the main conversation.

**Important**: Agents are not invoked by slash commands. Claude decides to launch them based on context, or the user can reference them explicitly (e.g., "use the code-reviewer agent").

## Module Structure

```
agents/
  setup.sh              ← installer (auto-discovers *.md files)
  code-reviewer.md
  diagram-generator.md
  security-auditor.md
```

Each file is a single Markdown file with YAML frontmatter.

## Available Agents

| Agent | Trigger | Purpose |
|---|---|---|
| `code-reviewer` | After code changes | Reviews code for quality, patterns, best practices |
| `diagram-generator` | When visualizing systems | Creates architecture, data flow, component diagrams |
| `security-auditor` | Before deploy / on request | Audits code for vulnerabilities and unsafe patterns |

## How to Add a New Agent

Create `agents/my-agent.md` — that's it. Auto-discovery picks it up automatically.

```markdown
---
name: my-agent
description: "Use this agent when <trigger condition>. This includes <examples>."
model: sonnet
color: blue
---

You are a <role> specializing in <domain>.

## Your Process

1. **Step one**: ...
2. **Step two**: ...

## Your Principles
- ...
```

**Frontmatter fields:**

| Field | Required | Notes |
|---|---|---|
| `name` | yes | matches filename without `.md` |
| `description` | yes | Claude uses this to decide when to spawn the agent — be specific. First 60 chars shown in setup pick menu. |
| `model` | yes | `sonnet`, `opus`, or `haiku` |
| `color` | no | UI label color: `purple`, `blue`, `green`, `red`, `orange` |

`setup.sh` copies `agents/my-agent.md` → `.claude/agents/my-agent.md` on install.

## Agent Design Guidelines

### The `description` Field is Critical

Claude uses the `description` to decide when to spawn this agent. Be explicit:

```markdown
# Too vague — Claude won't know when to use it
description: "Helps with code"

# Good — specific trigger conditions with examples
description: "Use this agent when code changes have been made and need to be reviewed.
This includes after implementing features, refactoring, fixing bugs, or any code modifications."
```

### System Prompt Structure
- **Role statement**: Who is this agent? What is its expertise?
- **Process**: Numbered steps the agent follows
- **Output format**: What structure should the response have?
- **Principles**: Behavioral constraints (consistency, citation style, etc.)

### Best Practices
- **Generic, not project-specific**: Agents read `CLAUDE.md` to learn project context — don't hardcode it
- **Instruct to read context first**: Always have the agent read `.claude/CLAUDE.md` as step 1
- **Define output format**: Structured output (sections, severity levels) is easier to act on
- **Set boundaries**: Tell the agent what it should NOT do (e.g., "do not make changes, only review")

### Model Selection

| Task type | Recommended model |
|---|---|
| Deep analysis, complex reasoning | `opus` |
| Most tasks (review, diagram, audit) | `sonnet` |
| Fast, lightweight checks | `haiku` |

## How Claude Uses Agents

Claude spawns agents automatically based on context, or the user can ask explicitly:

| User says | Agent spawned |
|---|---|
| "Review this code" / after implementing a feature | `code-reviewer` |
| "Security audit" / before deploying | `security-auditor` |
| "Generate a diagram" / "visualize the architecture" | `diagram-generator` |

Agents always read `.claude/CLAUDE.md` first to understand the project before acting. They analyze and report — they do not modify code unless explicitly instructed to.

## Skills vs Agents

| | Skills | Agents |
|---|---|---|
| **Invoked by** | User (`/slash-command`) | Claude (internally) or user request |
| **File format** | Markdown prompt | Markdown with YAML frontmatter |
| **Scope** | Focused, single task | Multi-step, autonomous workflows |
| **Examples** | generate commit, write tests | review PR, audit security, draw diagram |
