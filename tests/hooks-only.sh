#!/bin/bash
# Test: --hooks flag with all bundles installs hook scripts.
# Prompts: y (no git), Enter (project name), 2 (hooks=all)
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TMPDIR_TEST="$(mktemp -d)"
trap 'rm -rf "$TMPDIR_TEST"' EXIT

PASS=0; FAIL=0
pass() { printf "  PASS  %s\n" "$1"; PASS=$((PASS + 1)); }
fail() { printf "  FAIL  %s\n" "$1"; FAIL=$((FAIL + 1)); }

echo "=== Test: hooks-only (--hooks, all bundles) ==="
echo ""

SETUP_OUT=$(cd "$TMPDIR_TEST" && printf "y\n\n2\n" | bash "$REPO_DIR/setup.sh" --hooks 2>&1) || {
  echo "  ERROR: setup.sh failed"
  echo "$SETUP_OUT" | sed 's/^/    /'
  exit 1
}

HOOK_COUNT=$(find "$TMPDIR_TEST/.claude/hooks" -name "*.sh" 2>/dev/null | wc -l | tr -d ' ')
if [[ "$HOOK_COUNT" -gt 0 ]]; then
  pass "hook scripts installed ($HOOK_COUNT)"
else
  fail "no hook scripts installed"
fi

if [[ -f "$TMPDIR_TEST/.claude/settings.json" ]]; then
  pass "settings.json installed by hooks"
else
  fail "settings.json missing"
fi

echo ""
echo "  $PASS passed, $FAIL failed"
if [[ $FAIL -eq 0 ]]; then exit 0; else exit 1; fi