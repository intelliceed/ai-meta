# Skill: Marp Presentation — Intelliceed Theme (demo-marp)

## Purpose

Turn any topic, investigation, or feature into a clean Marp presentation styled with the
Intelliceed brand theme: dark navy background, white text, logo header bar with horizontal
rule — matching the onboarding deck at `/Users/sajera/Downloads/onboarding.pdf`.

Works from whatever context is already in the conversation — no project scan required.

## Intelliceed Brand Reference

| Token | Value | Usage |
|-------|-------|-------|
| Navy bg | `#0A1628` | All slide backgrounds |
| Navy alt | `#0d1f38` | Table even-row stripe |
| White | `#FFFFFF` | Headings, body text, accent bar |
| Muted white | `rgba(255,255,255,0.55–0.65)` | Subtitles, footer text, page numbers |
| Font | `Inter`, `Arial` | All text |
| Heading style | Bold (900), UPPERCASE, LN-style accent bar | White 5px bar before heading + bottom rule |

Header bar: logo SVG + "Intelliceed" text + thin horizontal rule.
Cover: LN layout — title bottom-left, UPPERCASE, `i-bg-1.webp` at `opacity:0.35` over navy.
Closing slide: same lead layout, `i-bg-2.webp` at `opacity:0.35`, thank-you message.
Footer: subtle bg tint + "INTELLICEED" uppercase label, `rgba(255,255,255,0.65)` contrast.

## Bundled Assets

All assets live in `.claude/skills/demo-marp/` and are referenced relative to the generated `.md` in `.claude/documents/`:

| File | Usage |
|------|-------|
| `logo.svg` | Header bar logo — rendered white via CSS filter |
| `i-bg-1.webp` | Cover slide background (team/tech visual) |
| `i-bg-2.webp` | Closing slide background (laptop/code visual) |

## Instructions for Claude

When this skill is invoked:

### Step 0: Check Marp Availability

```bash
command -v marp || npx --yes @marp-team/marp-cli --version 2>/dev/null
```

- **Marp found** → note the command to use at the end
- **Marp not found** → inform the user:
  > Marp CLI is not installed. I'll generate the `.md` file and you can convert it later.
  > Install: `npm install -g @marp-team/marp-cli` · `brew install marp-cli` · or use `npx`

Continue regardless — the `.md` file is the primary output.

### Step 1: Clarify (ask before writing)

If the user hasn't already provided these, ask:

1. **Topic / subject** — what is this presentation about?
2. **Audience** — engineers / leadership / cross-team / other?
3. **Length** — ~5 slides (quick overview) / ~10 slides (standard) / custom?
4. **Anything to emphasise** — specific points, decisions, outcomes, next steps?

Skip questions already answered by context in the conversation.

### Step 2: Use Available Context

Do NOT re-scan project files. Draw from:
- What the user has described in the current conversation
- Documents or specs already read in this session
- Any prior demos or slides already discussed

### Step 3: Generate Slides

Create `.claude/documents/{topic-slug}.md` using the exact front matter and style block below.

#### Front matter

```markdown
---
marp: true
theme: default
paginate: true
header: "![](../skills/demo-marp/logo.svg) Intelliceed"
footer: "INTELLICEED"
---
```

- `header` renders the logo SVG bundled in this skill directory + brand name
- `logo.svg` lives at `.claude/skills/demo-marp/logo.svg` — path is relative to the generated `.md` in `.claude/documents/`
- Logo is rendered white via CSS `filter: brightness(0) invert(1)`

#### Intelliceed Theme — embed this `<style>` block verbatim after the front matter

```markdown
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
```

#### Cover slide

Always use this pattern for slide 1:

```markdown
<!-- _class: lead -->

![bg opacity:0.35](../skills/demo-marp/i-bg-1.webp)

# Presentation Title

**One-line summary**

Team Name · Year
```

- Title renders bottom-left, UPPERCASE (LN-style)
- `i-bg-1.webp` at `opacity:0.35` overlays the dark navy — keeps text readable
- `**bold**` renders as white on the cover

#### Closing slide

Always end with this pattern:

```markdown
---

<!-- _class: lead -->

![bg opacity:0.35](../skills/demo-marp/i-bg-2.webp)

# Thanks for Your Attention

**Questions? Let's talk.**

How to reach us / next steps
```

#### Content slides

Use `---` as slide separator. One idea per slide.

**Writing conventions:**

| Element | How to write | Result |
|---------|-------------|--------|
| Slide title | Normal case — CSS uppercases it | UPPERCASE white heading + accent bar |
| Subtitle | `### Subtitle text` | Muted uppercase label below heading |
| Emphasis | `**word**` | Bold white (weight 900) |
| Code block | Use language tag ` ```bash ` | Dark panel with white left border |
| Inline code | `` `code` `` | Semi-transparent chip |
| Callout | `> blockquote` | White left-border italic box |

**Slide structure by audience:**

| Audience | Style |
|----------|-------|
| Engineers | Concrete, code/structure examples, technical detail |
| Leadership | Outcome-focused, minimal jargon, clear ask/decision |
| Cross-team | Problem → solution → impact, avoid team-specific terms |

**General slide flow (adapt as needed):**
1. Cover — company name + presentation title + context
2. Problem / Background — why this matters
3. Key findings / How it works — the substance (split across slides if needed)
4. Demo / Before–After / Example — concrete illustration
5. Outcome / What you get
6. Next steps / Get involved

### Step 4: Output the Conversion Command

```bash
# HTML (open in browser)
npx @marp-team/marp-cli .claude/documents/{filename}.md -o .claude/documents/{filename}.html

# PDF
npx @marp-team/marp-cli .claude/documents/{filename}.md --pdf -o .claude/documents/{filename}.pdf
```

If `marp` CLI is installed globally, use `marp` instead of `npx @marp-team/marp-cli`.

## Example Adaptations

**Investigation findings** (engineers):
```
Slides: Background → What we investigated → Key findings →
        Root cause → Proposed fix → Open questions
```

**New feature rollout** (cross-team):
```
Slides: The problem → Our solution → How it works →
        What changes for you → Timeline → Get involved
```

**Onboarding / process walkthrough** (any audience):
```
Slides: Welcome → Team / contacts → Tools setup →
        Key processes → Where to find things → Next steps
```

## Usage

`/demo-marp`

Then describe what you want to present. Claude will:
1. Check Marp availability
2. Ask any missing clarifying questions
3. Use context already in the conversation
4. Generate a Marp `.md` in `.claude/documents/` with the Intelliceed theme embedded
5. Print the conversion command