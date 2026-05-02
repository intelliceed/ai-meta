#!/bin/bash
# Test: --skills flag installs skills, leaves agents absent.
# Prompts: y (no git), Enter (project name), Enter (skills=all)
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TMPDIR_TEST="$(mktemp -d)"
trap 'rm -rf "$TMPDIR_TEST"' EXIT

PASS=0; FAIL=0
pass() { printf "  PASS  %s\n" "$1"; PASS=$((PASS + 1)); }
fail() { printf "  FAIL  %s\n" "$1"; FAIL=$((FAIL + 1)); }

echo "=== Test: skills-only (--skills) ==="
echo ""

SETUP_OUT=$(cd "$TMPDIR_TEST" && printf "y\n\n\n" | bash "$REPO_DIR/setup.sh" --skills 2>&1) || {
  echo "  ERROR: setup.sh failed"
  echo "$SETUP_OUT" | sed 's/^/    /'
  exit 1
}

SKILL_COUNT=$(find "$TMPDIR_TEST/.claude/skills" -name "SKILL.md" | wc -l | tr -d ' ')
if [[ "$SKILL_COUNT" -gt 0 ]]; then
  pass "skills installed ($SKILL_COUNT)"
else
  fail "no skills installed"
fi

AGENT_COUNT=$(find "$TMPDIR_TEST/.claude/agents" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
if [[ "$AGENT_COUNT" -eq 0 ]]; then
  pass "agents absent (correct for --skills)"
else
  fail "agents were installed (unexpected for --skills)"
fi

echo ""
echo "  $PASS passed, $FAIL failed"
if [[ $FAIL -eq 0 ]]; then exit 0; else exit 1; fi