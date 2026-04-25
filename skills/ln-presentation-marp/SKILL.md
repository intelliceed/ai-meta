# Skill Template: Marp Demo Creator

## Purpose

Turn any topic, investigation, or feature into a clean Marp presentation styled with the Live Nation (LN) brand theme.
Works from whatever context is already in the conversation — no project scan required.

## LN Brand Reference

| Token | Value | Usage |
|-------|-------|-------|
| LN Red | `#E21836` | Headings accent bar, h3 subtitles, bold text, table headers |
| Black | `#000000` | Heading text, footer bar, table header bg |
| Dark | `#1F1F1F` | Cover background, code blocks |
| Gray | `#6E6E6E` | Blockquote text, muted elements |
| White | `#FFFFFF` | Body background, footer text |
| Major font | `Arial Black` | Headings (ALL CAPS) |
| Minor font | `Arial` | Body text, subtitles |

Cover background image: `ln-cover-bg.png` — bundled in this skill directory, copied to `.claude/skills/ln-presentation-marp/` on install.

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

1. **Topic / subject** — what is this demo about?
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

Create `.claude/documents/{topic-slug}-demo.md` using the exact front matter and style block below.

#### Front matter

```markdown
---
marp: true
theme: default
paginate: true
footer: "LIVE NATION"
---
```

#### LN Theme — embed this `<style>` block verbatim after the front matter

```markdown
<style>
/* ================================
   LN DECK TEMPLATE THEME
   Color scheme: LN Colors
   Red:   #E21836  Black: #000000
   Dark:  #1F1F1F  Gray:  #6E6E6E
   Major font: Arial Black
   Minor font: Arial
   ================================ */

/* Base — explicit 28px so em units are predictable */
section {
  font-family: 'Arial', sans-serif;
  font-size: 28px;
  background: #FFFFFF;
  color: #1F1F1F;
  padding: 48px 60px 72px 60px;
}

/* ── Cover slide ─────────────────────────────────── */
section.lead {
  background: #1F1F1F;
  color: #FFFFFF;
  display: flex;
  flex-direction: column;
  justify-content: flex-end;
  padding: 60px 60px 80px 60px;
  text-align: left;
}
section.lead h1 {
  font-family: 'Arial Black', 'Arial Bold', Arial, sans-serif;
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
  color: rgba(255, 255, 255, 0.7);
  font-size: 0.82em;
  margin: 0.1em 0;
}
section.lead strong { color: #FFFFFF; font-weight: 700; }
section.lead footer {
  background: transparent !important;
  color: #E21836 !important;
  letter-spacing: 0.16em;
}
section.lead::after { color: rgba(255, 255, 255, 0.6); }

/* ── Content headings ────────────────────────────── */
h1, h2 {
  font-family: 'Arial Black', 'Arial Bold', Arial, sans-serif;
  font-weight: 900;
  text-transform: uppercase;
  color: #000000;
  letter-spacing: 0.03em;
  font-size: 1.7em;
  line-height: 1.1;
  border-bottom: 2px solid #000000;
  padding-bottom: 6px;
  margin-top: 0;
  margin-bottom: 14px;
}
h1::before, h2::before {
  content: '';
  display: block;
  width: 26px;
  height: 5px;
  background: #E21836;
  margin-bottom: 8px;
}
h3 {
  font-family: 'Arial', sans-serif;
  font-size: 0.85em;
  font-weight: 700;
  color: #E21836;
  margin-top: -8px;
  margin-bottom: 12px;
  letter-spacing: 0;
}

/* ── Body ────────────────────────────────────────── */
ul, ol { margin-left: 1.1em; }
li { margin-bottom: 0.3em; }
p { margin: 0.4em 0; }
strong { color: #E21836; }

/* ── Tables ──────────────────────────────────────── */
table { width: 100%; border-collapse: collapse; font-size: 0.78em; }
table th {
  background: #000000;
  color: #FFFFFF;
  font-family: 'Arial Black', Arial, sans-serif;
  font-weight: 900;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  padding: 9px 12px;
}
table td { padding: 7px 12px; border-bottom: 1px solid #E0E0E0; }
table tr:nth-child(even) td { background: #F5F5F5; }

/* ── Code ────────────────────────────────────────── */
pre {
  background: #1F1F1F !important;
  border-left: 4px solid #E21836;
  border-radius: 3px;
  font-size: 0.68em;
  margin: 8px 0;
}
code {
  background: #EEEEEE;
  color: #1F1F1F;
  padding: 1px 4px;
  border-radius: 2px;
  font-size: 0.85em;
}
pre code { background: transparent; color: #FFFFFF; padding: 0; }
.hljs-string { color: #E8B86D; }   /* amber — URLs and strings */

/* ── Blockquotes ─────────────────────────────────── */
blockquote {
  border-left: 4px solid #E21836;
  background: #F8F8F8;
  padding: 8px 16px;
  color: #6E6E6E;
  margin: 10px 0;
  font-style: italic;
}
blockquote p { margin: 0; }

/* ── Footer bar (content slides) ─────────────────── */
footer {
  position: absolute;
  bottom: 0; left: 0; right: 0;
  background: #000000;
  color: #FFFFFF;
  font-family: 'Arial Black', Arial, sans-serif;
  font-size: 0.48em;
  font-weight: 900;
  letter-spacing: 0.16em;
  text-transform: uppercase;
  padding: 0 40px;
  height: 32px;
  line-height: 32px;
}
section::after {
  color: #FFFFFF;
  font-size: 0.48em;
  font-family: 'Arial', sans-serif;
  bottom: 8px;
  right: 40px;
}
</style>
```

#### Cover slide

Always use this pattern for slide 1:

```markdown
<!-- _class: lead -->

![bg](../skills/ln-presentation-marp/ln-cover-bg.png)

# Slide Title Here
**One-line summary of what this is**

Team Name · Year
```

- The `![bg]` path is relative to the generated `.md` file in `.claude/documents/`
- If the image is missing, the dark `#1F1F1F` background from `section.lead` still applies as fallback

#### Content slides

Use `---` as slide separator. One idea per slide.

**Writing conventions:**

| Element | How to write | Result |
|---------|-------------|--------|
| Slide title | Normal case — CSS uppercases it | ALL CAPS black heading |
| Subtitle | `### Subtitle text` | Red bold line under heading |
| Emphasis | `**word**` | Renders in LN red |
| Code with URL/string | Use language tag ` ```bash ` | Strings render amber |
| Inline code | `` `code` `` | Light gray chip |
| Callout | `> blockquote` | Red left-border box |

**Slide structure by audience:**

| Audience | Style |
|----------|-------|
| Engineers | Concrete, code/structure examples, technical detail |
| Leadership | Outcome-focused, minimal jargon, clear ask/decision |
| Cross-team | Problem → solution → impact, avoid team-specific terms |

**General slide flow (adapt as needed):**
1. Title — topic + one-line summary + context (team, date)
2. Problem / Background — why this matters
3. Key findings / How it works — the substance (split across slides if needed)
4. Demo / Before-After / Example — concrete illustration
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

**Platform tool / setup demo** (engineers + leadership):
```
Slides: Problem → Solution → Live demo (before/after) →
        What you get → Vision → How to start
```

## Usage

`/create-demo`

Then describe what you want to present. Claude will:
1. Check Marp availability
2. Ask any missing clarifying questions
3. Use context already in the conversation
4. Generate a Marp `.md` in `.claude/documents/` with the LN theme embedded
5. Print the conversion command