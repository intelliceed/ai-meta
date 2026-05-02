#!/bin/bash
# Test: fresh install with all defaults.
# Prompts: y (no git), Enter (project name), Enter (skills=all), Enter (agents=all), Enter (hooks=skip)
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TMPDIR_TEST="$(mktemp -d)"
trap 'rm -rf "$TMPDIR_TEST"' EXIT

PASS=0; FAIL=0
pass() { printf "  PASS  %s\n" "$1"; PASS=$((PASS + 1)); }
fail() { printf "  FAIL  %s\n" "$1"; FAIL=$((FAIL + 1)); }
assert_exists() {
  if [[ -e "$TMPDIR_TEST/$1" ]]; then pass "$1"; else fail "$1 (missing)"; fi
}

echo "=== Test: fresh-install ==="
echo ""

SETUP_OUT=$(cd "$TMPDIR_TEST" && printf "y\n\n\n\n\n" | bash "$REPO_DIR/setup.sh" 2>&1) || {
  echo "  ERROR: setup.sh exited non-zero"
  echo "$SETUP_OUT" | sed 's/^/    /'
  exit 1
}

assert_exists ".claude/CLAUDE.md"
assert_exists ".claude/TODO.md"
assert_exists ".claude/settings.json"
assert_exists ".claude/start-claude.sh"
assert_exists ".claude/.gitignore"
assert_exists ".claude/documents/.gitkeep"
assert_exists ".claude/skills"
assert_exists ".claude/agents"

SKILL_COUNT=$(find "$TMPDIR_TEST/.claude/skills" -name "SKILL.md" | wc -l | tr -d ' ')
if [[ "$SKILL_COUNT" -gt 0 ]]; then
  pass "skills installed ($SKILL_COUNT)"
else
  fail "no skills installed"
fi

AGENT_COUNT=$(find "$TMPDIR_TEST/.claude/agents" -name "*.md" | wc -l | tr -d ' ')
if [[ "$AGENT_COUNT" -gt 0 ]]; then
  pass "agents installed ($AGENT_COUNT)"
else
  fail "no agents installed"
fi

echo ""
echo "  $PASS passed, $FAIL failed"
if [[ $FAIL -eq 0 ]]; then exit 0; else exit 1; fi