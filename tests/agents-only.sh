#!/bin/bash
# Test: --agents flag installs agents, leaves skills absent.
# Prompts: y (no git), Enter (project name), Enter (agents=all)
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TMPDIR_TEST="$(mktemp -d)"
trap 'rm -rf "$TMPDIR_TEST"' EXIT

PASS=0; FAIL=0
pass() { printf "  PASS  %s\n" "$1"; PASS=$((PASS + 1)); }
fail() { printf "  FAIL  %s\n" "$1"; FAIL=$((FAIL + 1)); }

echo "=== Test: agents-only (--agents) ==="
echo ""

SETUP_OUT=$(cd "$TMPDIR_TEST" && printf "y\n\n\n" | bash "$REPO_DIR/setup.sh" --agents 2>&1) || {
  echo "  ERROR: setup.sh failed"
  echo "$SETUP_OUT" | sed 's/^/    /'
  exit 1
}

AGENT_COUNT=$(find "$TMPDIR_TEST/.claude/agents" -name "*.md" | wc -l | tr -d ' ')
if [[ "$AGENT_COUNT" -gt 0 ]]; then
  pass "agents installed ($AGENT_COUNT)"
else
  fail "no agents installed"
fi

SKILL_COUNT=$(find "$TMPDIR_TEST/.claude/skills" -name "SKILL.md" 2>/dev/null | wc -l | tr -d ' ')
if [[ "$SKILL_COUNT" -eq 0 ]]; then
  pass "skills absent (correct for --agents)"
else
  fail "skills were installed (unexpected for --agents)"
fi

echo ""
echo "  $PASS passed, $FAIL failed"
if [[ $FAIL -eq 0 ]]; then exit 0; else exit 1; fi