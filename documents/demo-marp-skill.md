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

# Demo-Marp Skill

**Branded presentations from a single slash command**

Intelliceed Team · 2026

---

## The Problem

### Making slides is a tax on engineering time

- Branded decks require manual styling — fonts, colours, logo placement
- Most devs either skip the brand or copy-paste from old files
- Result: inconsistent decks, wasted time, death by PowerPoint

> Every time you present, you shouldn't have to fight your tools.

---

## What is /demo-marp

### One command — describe your topic — get a deck

- A Claude Code **skill** that generates a full Marp `.md` presentation
- Styled with the **Intelliceed brand theme** out of the box
- Works from **whatever context is already in the conversation** — no file scan
- Output is **plain Markdown** — editable, version-controllable, diff-friendly

```bash
# Invoke in any Claude Code session
/demo-marp
```

Then just describe what you want to present.

---

## How it Works

### Invoke → clarify → generate → convert

| Step | What happens |
|------|-------------|
| 1. `/demo-marp` | Skill loads, Marp CLI check runs |
| 2. Clarify | Claude asks: topic, audience, length, emphasis |
| 3. Generate | `.claude/documents/{slug}.md` written with full theme |
| 4. Convert | One command → HTML or PDF |

- Cover + closing slides wired up automatically
- Logo, backgrounds, CSS — all embedded, nothing to configure

---

## AI Context

### The skill uses what's already in the conversation

Claude draws from the **current session context** — no extra project scan needed:

- Specs or docs you've already read
- Investigation findings you've described
- Decisions and outcomes discussed in chat

**Feed it better context → get better slides:**

- Paste a summary of your feature / incident / design
- Share key bullet points or a rough outline
- Mention the audience — engineers vs. leadership changes the tone

> The more context in the conversation, the less you need to explain.

---

## Setup

### Add the skill to your project in one command

```bash
# Run Intelliceed AI Meta setup from your project root
curl -fsSL "https://github.com/intelliceed/ai-meta/archive/refs/heads/main.tar.gz" \
  | tar -xzf - -C /tmp/ \
  && bash /tmp/ai-meta-main/setup.sh
```

- Select **`demo-marp`** when prompted for skills
- Assets (`logo.svg`, `i-bg-1.webp`, `i-bg-2.webp`) are copied to `.claude/skills/demo-marp/`
- Re-run any time to update to the latest skill version

**Requires:** Node.js (for Marp CLI) · Claude Code CLI

---

## What You Get

### A self-contained branded deck — ready to ship

- **Intelliceed theme** embedded — navy `#0A1628`, white text, Inter font
- **Cover slide** — title bottom-left, background image, LN-style layout
- **Content slides** — UPPERCASE headings, white accent bar, structured flow
- **Closing slide** — thank-you layout with second background image
- **Tables, code blocks, blockquotes** — all themed, no extra work

Output lives in `.claude/documents/` — gitignored by default, yours to promote.

---

## Convert to HTML or PDF

### One command from the generated `.md`

```bash
# HTML — open in any browser
marp documents/demo-marp-skill.md -o .claude/documents/demo-marp-skill.html

# PDF
marp documents/demo-marp-skill.md --pdf -o .claude/documents/demo-marp-skill.pdf
```

**Install Marp CLI if needed:**

```bash
npm install -g @marp-team/marp-cli   # global
brew install marp-cli                 # macOS
npx @marp-team/marp-cli              # no install
```

---

<!-- _class: lead -->

![bg opacity:0.35](../skills/demo-marp/i-bg-2.webp)

# Start Presenting

**`/demo-marp` — describe your topic — ship your deck.**

Intelliceed Team · Questions? Reach us in #<your-channel>