---
marp: true
theme: default
paginate: true
header: "![](../skills/demo-marp/logo.svg) Intelliceed"
footer: "INTELLICEED"
---

<style>
/* ================================
   INTELLICEED DECK TEMPLATE THEME
   LN structure + Intelliceed palette
   Navy bg: #0A1628   Text: #FFFFFF
   Accent:  #FFFFFF   (LN red → white)
   Font:    Inter / Arial, sans-serif
   ================================ */

/* Base */
section {
  font-family: 'Inter', 'Arial', sans-serif;
  font-size: 28px;
  background: #0A1628;
  color: #FFFFFF;
  padding: 56px 60px 72px 60px;
}

/* ── Header bar (logo + rule) ────────────────────── */
header {
  position: absolute;
  top: 0; left: 0; right: 0;
  background: #0A1628;
  color: #FFFFFF;
  font-family: 'Inter', 'Arial', sans-serif;
  font-size: 0.5em;
  font-weight: 700;
  letter-spacing: 0.1em;
  padding: 0 40px;
  height: 44px;
  line-height: 44px;
  border-bottom: 1px solid rgba(255, 255, 255, 0.25);
  white-space: nowrap;
  overflow: hidden;
}
header img {
  height: 18px;
  vertical-align: middle;
  margin-right: 6px;
  filter: brightness(0) invert(1);
}

/* ── Cover slide (LN layout — title bottom-left) ─── */
section.lead {
  background: #0A1628;
  color: #FFFFFF;
  display: flex;
  flex-direction: column;
  justify-content: flex-end;
  padding: 60px 60px 80px 60px;
  text-align: left;
}
section.lead header { display: none; }
section.lead h1 {
  font-family: 'Inter', Arial, sans-serif;
  font-size: 3.4em;
  font-weight: 900;
  text-transform: uppercase;
  color: #FFFFFF;
  letter-spacing: 0.02em;
  line-height: 1.0;
  border: none;
  margin-bottom: 0.25em;
}
section.lead h1::before { display: none; }
section.lead p {
  color: rgba(255, 255, 255, 0.65);
  font-size: 0.82em;
  margin: 0.1em 0;
}
section.lead strong { color: #FFFFFF; font-weight: 700; }
section.lead footer {
  background: transparent !important;
  color: rgba(255, 255, 255, 0.35) !important;
  letter-spacing: 0.16em;
  border-top: none !important;
}
section.lead::after { color: rgba(255, 255, 255, 0.4); }

/* ── Content headings (LN structure, white accent) ─ */
h1, h2 {
  font-family: 'Inter', Arial, sans-serif;
  font-weight: 900;
  text-transform: uppercase;
  color: #FFFFFF;
  letter-spacing: 0.03em;
  font-size: 1.7em;
  line-height: 1.1;
  border-bottom: 2px solid rgba(255, 255, 255, 0.25);
  padding-bottom: 6px;
  margin-top: 0;
  margin-bottom: 14px;
}
h1::before, h2::before {
  content: '';
  display: block;
  width: 26px;
  height: 5px;
  background: #FFFFFF;
  margin-bottom: 8px;
}
h3 {
  font-family: 'Inter', 'Arial', sans-serif;
  font-size: 0.82em;
  font-weight: 700;
  color: rgba(255, 255, 255, 0.55);
  text-transform: uppercase;
  letter-spacing: 0.06em;
  margin-top: -8px;
  margin-bottom: 12px;
}

/* ── Body ────────────────────────────────────────── */
ul, ol { margin-left: 1.1em; }
li { margin-bottom: 0.3em; }
p { margin: 0.4em 0; }
strong { font-weight: 900; color: #FFFFFF; }

/* ── Tables ──────────────────────────────────────── */
table { width: 100%; border-collapse: collapse; font-size: 0.78em; }
table thead tr { background: rgba(255, 255, 255, 0.18) !important; }
table tbody tr { background: #0A1628 !important; }
table tbody tr:nth-child(even) { background: #0d1f38 !important; }
table th {
  color: #FFFFFF !important;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  padding: 9px 12px;
  border-bottom: 2px solid rgba(255, 255, 255, 0.35);
}
table td {
  padding: 7px 12px;
  border-bottom: 1px solid rgba(255, 255, 255, 0.12);
  color: #FFFFFF !important;
}

/* ── Code ────────────────────────────────────────── */
pre {
  background: rgba(0, 0, 0, 0.4) !important;
  border-left: 4px solid rgba(255, 255, 255, 0.45);
  border-radius: 3px;
  font-size: 0.68em;
  margin: 8px 0;
}
code {
  background: rgba(255, 255, 255, 0.12);
  color: #FFFFFF;
  padding: 1px 4px;
  border-radius: 2px;
  font-size: 0.85em;
}
pre code { background: transparent; color: rgba(255, 255, 255, 0.9); padding: 0; }

/* ── Blockquotes ─────────────────────────────────── */
blockquote {
  border-left: 4px solid rgba(255, 255, 255, 0.45);
  background: rgba(255, 255, 255, 0.06);
  padding: 8px 16px;
  color: rgba(255, 255, 255, 0.65);
  margin: 10px 0;
  font-style: italic;
}
blockquote p { margin: 0; }

/* ── Footer bar (content slides) ─────────────────── */
footer {
  position: absolute;
  bottom: 0; left: 0; right: 0;
  background: rgba(255, 255, 255, 0.04);
  color: rgba(255, 255, 255, 0.65) !important;
  font-family: 'Inter', Arial, sans-serif;
  font-size: 0.44em;
  font-weight: 700;
  letter-spacing: 0.16em;
  text-transform: uppercase;
  padding: 0 40px;
  height: 32px;
  line-height: 32px;
  border-top: 1px solid rgba(255, 255, 255, 0.12);
}
section::after {
  color: rgba(255, 255, 255, 0.45);
  font-size: 0.44em;
  font-family: 'Inter', 'Arial', sans-serif;
  bottom: 8px;
  right: 40px;
}
</style>

<!-- _class: lead -->

![bg opacity:0.35](../skills/demo-marp/i-bg-1.webp)

# Sharing AI Experience Across Teams

**One command to get Claude Code up to speed on any project**

Intelliceed Team · 2026

[//]: # (marp documents/ai-meta.md --html -o .claude/documents/ai-meta.html)
---

# What Is Claude Code?
### An AI that lives inside your terminal and understands your codebase

- Anthropic's AI coding assistant — runs in your terminal, not a browser tab
- Reads your project files, understands structure, follows your conventions
- You teach it about your project once — it remembers across sessions
- Works via `.claude/` folder: project context, skills, agents, hooks

---

# The Problem
### Every team reinvents the same AI prompts

- Teams adopt Claude Code → each builds their own prompts, agents, workflows
- No sharing mechanism → duplicated effort, inconsistent quality
- Good patterns stay siloed inside one team's repo
- When someone leaves, the knowledge leaves too

---

# Skills, Agents, and Hooks
### Three ways to teach Claude how your team works

| | **Skills** | **Agents** | **Hooks** |
|---|---|---|---|
| **What** | One-time actions | Specialist roles | Automated guards |
| **Example** | "Generate tests for this file" | "Review this code" | Run before every file write |
| **Use case** | "Write a commit message" | "Audit for security issues" | Catch secrets, quality issues |

> These live in `.claude/` — Claude's brain for your project.
> Every team builds their own. No two repos are the same.

---

# Our Solution: ai-meta
### One repo. One command. Consistent AI experience.

- Central repo of battle-tested skills, agents, and hooks
- `setup.sh` scaffolds any project in seconds
- Conservative defaults — opt in to what you need
- Update path built in — re-run to pull latest templates
- Cross-platform: macOS, Linux, Windows (Git Bash / WSL)

---

# How It Works
### One command from your project root

```bash
curl -fsSL "https://github.com/intelliceed/ai-meta/archive/refs/heads/main.tar.gz" \
  | tar -xzf - -C /tmp/ && bash /tmp/ai-meta-main/setup.sh
```

The script asks you:
- What's the project name?
- Which **skills**? numbered menu — `1) skip` · `2) all` · `3) pick`
- Which **agents**? numbered menu — `1) skip` · `2) all` · `3) pick`
- Which **hooks**?  numbered menu — `1) skip` · `2) all` · `3) pick`

Then it handles the rest: auto-detects repo URL, language, run/test/build commands → generates `.claude/` → cleans up after itself.

Need only one module? Use flags: `--skills` · `--agents` · `--hooks`

---

# Live Demo
### Before → After

```
my-project/               my-project/
├── src/                  ├── src/
├── tests/                ├── tests/
└── README.md             ├── README.md
                          └── .claude/
                              ├── CLAUDE.md       ← knows your project
                              ├── TODO.md         ← persistent task tracker
                              ├── .gitignore      ← documents/, TODO.md
                              ├── documents/      ← gitignored workspace
                              ├── skills/         ← test generator, commit helper
                              ├── agents/         ← code review, security audit
                              ├── hooks/          ← automated quality gates
                              └── start-claude.sh ← launcher for next session
```

---

# What You Get
### From zero to AI-ready in 60 seconds

```
.claude/
├── CLAUDE.md               ← project identity, commands, structure (auto-filled)
├── TODO.md                 ← persistent task tracker, read every session
├── skills/
│   ├── test-generator/     ← "generate tests matching your style"
│   └── commit-helper/      ← "write commits in your format"
├── agents/
│   ├── code-reviewer.md
│   ├── security-auditor.md
│   └── diagram-generator.md
├── hooks/
│   └── *.sh                ← secrets detection, command blocking
└── start-claude.sh         ← run this to start Claude next time
```

> Skills and agents are **generic templates** — Claude reads them, then reads your existing code to learn your conventions. Same template, different projects = different output.

---

# Re-run to Update
### Pull the latest templates without losing your context

Run the same command again in your project root:

| Component | On re-run |
|-----------|-----------|
| `CLAUDE.md` | **Never touched** |
| `TODO.md` | **Never touched** |
| `skills/` | Selected: re-copied. Deselected: untouched. |
| `agents/` | Selected: re-copied. Deselected: untouched. |
| `hooks/` | Explicit selection: updated. Skip: untouched. |

Update only what you need:
```bash
bash setup.sh --skills    # skills only
bash setup.sh --hooks     # hooks only
```

---

# The Vision
### A company-wide AI knowledge base

- **Today**: Intelliceed team's skills, agents, and hooks
- **Near future**: Teams contribute their own — security team adds audit agent, data team adds pipeline skill
- **Goal**: Centralised, versioned, standardised AI experience for the whole company

One source of truth → teams pull what they need, contribute what they build.

---

# Get Involved
### The repo is public — contributions welcome

**1. Run it on your project today**
Copy the command from the [ai-meta](https://github.com/intelliceed/ai-meta) README

**2. Have a skill or agent that works well for your team?**
Open a merge request — anyone can contribute

**3. Have feedback or ideas?**
Ping us in `#<your-channel>` or open a merge request

---

<!-- _class: lead -->

![bg opacity:0.35](../skills/demo-marp/i-bg-2.webp)

# Thanks for Your Attention

**Questions? Let's talk.**

Ping us in `#<your-channel>` or open a merge request on `ai-meta`
