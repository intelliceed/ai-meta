#!/bin/bash
# Test: re-run (update mode) leaves CLAUDE.md and settings.json untouched.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TMPDIR_TEST="$(mktemp -d)"
trap 'rm -rf "$TMPDIR_TEST"' EXIT

PASS=0; FAIL=0
pass() { printf "  PASS  %s\n" "$1"; PASS=$((PASS + 1)); }
fail() { printf "  FAIL  %s\n" "$1"; FAIL=$((FAIL + 1)); }

echo "=== Test: update-mode ==="
echo ""

# Step 1: fresh install
SETUP_OUT=$(cd "$TMPDIR_TEST" && printf "y\n\n\n\n\n" | bash "$REPO_DIR/setup.sh" 2>&1) || {
  echo "  ERROR: fresh install failed"
  echo "$SETUP_OUT" | sed 's/^/    /'
  exit 1
}
echo "  fresh install: done"

cp "$TMPDIR_TEST/.claude/CLAUDE.md" "$TMPDIR_TEST/claude_snapshot.md"
cp "$TMPDIR_TEST/.claude/settings.json" "$TMPDIR_TEST/settings_snapshot.json"

# Step 2: re-run (update mode — .claude/ already exists, output.sh skipped)
# Prompts: y (no git), Enter (skills), Enter (agents), Enter (hooks)
SETUP_OUT=$(cd "$TMPDIR_TEST" && printf "y\n\n\n\n" | bash "$REPO_DIR/setup.sh" 2>&1) || {
  echo "  ERROR: update run failed"
  echo "$SETUP_OUT" | sed 's/^/    /'
  exit 1
}
echo "  update run: done"
echo ""

if diff -q "$TMPDIR_TEST/.claude/CLAUDE.md" "$TMPDIR_TEST/claude_snapshot.md" > /dev/null 2>&1; then
  pass "CLAUDE.md untouched"
else
  fail "CLAUDE.md was modified"
fi

if diff -q "$TMPDIR_TEST/.claude/settings.json" "$TMPDIR_TEST/settings_snapshot.json" > /dev/null 2>&1; then
  pass "settings.json untouched"
else
  fail "settings.json was modified"
fi

echo ""
echo "  $PASS passed, $FAIL failed"
if [[ $FAIL -eq 0 ]]; then exit 0; else exit 1; fi