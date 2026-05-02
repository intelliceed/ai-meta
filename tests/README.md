# Tests

Scripts for testing `setup.sh` locally — both automated assertions and manual inspection.

---

## Run All Automated Tests

```bash
for t in tests/fresh-install.sh tests/update-mode.sh tests/skills-only.sh tests/agents-only.sh tests/hooks-only.sh; do
  bash "$t"
done
```

---

## Individual Tests

Each script runs `setup.sh` against a temp directory with pre-piped answers and reports PASS/FAIL.

| Script | What it tests |
|--------|---------------|
| `fresh-install.sh` | First run with all defaults — asserts full scaffold is generated |
| `update-mode.sh` | Re-run on existing `.claude/` — asserts `CLAUDE.md` and `settings.json` are untouched |
| `skills-only.sh` | `--skills` flag — asserts skills installed, agents absent |
| `agents-only.sh` | `--agents` flag — asserts agents installed, skills absent |
| `hooks-only.sh` | `--hooks` flag (all bundles) — asserts hook scripts installed |

```bash
bash tests/fresh-install.sh
bash tests/update-mode.sh
bash tests/skills-only.sh
bash tests/agents-only.sh
bash tests/hooks-only.sh
```

---

## Manual Inspection (`run-local.sh`)

Runs `setup.sh` interactively against `dist/` so you can answer prompts and inspect the generated output.

```bash
bash tests/run-local.sh             # full setup
bash tests/run-local.sh --skills    # skills only
bash tests/run-local.sh --agents    # agents only
bash tests/run-local.sh --hooks     # hooks only
```

Output lands in `dist/.claude/`. The `dist/` folder is gitignored — safe to experiment freely.

On first run, `run-local.sh` initializes a standalone git repo in `dist/` so `setup.sh` treats it as a project root. This is a one-time step.

To reset and start fresh:

```bash
rm -rf dist/
bash tests/run-local.sh
```