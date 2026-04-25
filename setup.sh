#!/bin/bash
# =============================================================================
# Intelliceed AI Meta — setup.sh
# Initializes .claude/ scaffold for any project.
# Run from your project root:
#
#   curl -fsSL "https://github.com/intelliceed/ai-meta/archive/refs/heads/main.tar.gz" | tar -xzf - -C /tmp/ && bash /tmp/ai-meta-main/setup.sh
#
# Flags: --skills  --agents  --hooks  --mcp  (default: run all)
# Compatible with macOS, Linux, and Windows (Git Bash / WSL).
# =============================================================================
set -euo pipefail

ARCHIVE_DIR="$(dirname "$0")"

# =============================================================================
# 1. Project root check
# =============================================================================
GIT_ROOT_RAW="$(git rev-parse --show-toplevel 2>/dev/null || true)"
GIT_ROOT=""
if [[ -n "$GIT_ROOT_RAW" ]]; then
  GIT_ROOT="$(cd "$GIT_ROOT_RAW" && pwd)"
fi

if [[ -z "$GIT_ROOT" ]]; then
  echo ""
  echo "Warning: not inside a git repository."
  echo "  Repo URL and project tree will not be auto-detected."
  read -rp "Continue anyway? [y/N]: " CONFIRM
  [[ "${CONFIRM:-N}" =~ ^[Yy] ]] || exit 1
  echo ""
elif [[ "$GIT_ROOT" != "$(pwd)" ]]; then
  echo ""
  echo "Warning: you are in a subdirectory, not the project root."
  echo "  Current:  $(pwd)"
  echo "  Root:     $GIT_ROOT"
  echo ""
  read -rp "Run from project root instead? [Y/n]: " CONFIRM
  if [[ ! "${CONFIRM:-Y}" =~ ^[Nn] ]]; then
    cd "$GIT_ROOT"
    echo "Switched to: $(pwd)"
  else
    exit 1
  fi
  echo ""
fi

# =============================================================================
# 2. Re-run detection
# =============================================================================
[[ -d ".claude" ]] && UPDATE_MODE=true || UPDATE_MODE=false

# =============================================================================
# 3. Parse flags
# =============================================================================
RUN_SKILLS=false
RUN_AGENTS=false
RUN_HOOKS=false
RUN_MCP=false
RUN_ALL=true

for arg in "$@"; do
  case "$arg" in
    --skills) RUN_SKILLS=true; RUN_ALL=false ;;
    --agents) RUN_AGENTS=true; RUN_ALL=false ;;
    --hooks)  RUN_HOOKS=true;  RUN_ALL=false ;;
    --mcp)    RUN_MCP=true;    RUN_ALL=false ;;
  esac
done

# =============================================================================
# 4. Banner
# =============================================================================
echo ""
echo "=========================================="
[[ "$UPDATE_MODE" == true ]] && echo "  Intelliceed AI Meta — update" || echo "  Intelliceed AI Meta — project setup"
echo "=========================================="
echo ""

# =============================================================================
# 5. Run modules
# =============================================================================
[[ "$UPDATE_MODE" == false ]] && source "$ARCHIVE_DIR/output.sh"

[[ "$RUN_ALL" == true || "$RUN_SKILLS" == true ]] && source "$ARCHIVE_DIR/skills/setup.sh"
[[ "$RUN_ALL" == true || "$RUN_AGENTS" == true ]] && source "$ARCHIVE_DIR/agents/setup.sh"
[[ "$RUN_ALL" == true || "$RUN_HOOKS" == true ]]  && source "$ARCHIVE_DIR/hooks/setup.sh"
[[ "$RUN_ALL" == true || "$RUN_MCP" == true ]]    && source "$ARCHIVE_DIR/mcp/setup.sh"

# =============================================================================
# 6. Summary
# =============================================================================
echo ""
echo "=========================================="
[[ "$UPDATE_MODE" == true ]] && echo "  Update complete!" || echo "  Setup complete!"
echo "=========================================="
echo ""
[[ "$UPDATE_MODE" == false ]] && echo "Next step: bash .claude/start-claude.sh" || echo "Run: bash .claude/start-claude.sh"
echo ""

# =============================================================================
# 7. Cleanup
# =============================================================================
# Only cleanup when running from /tmp/ (canonical install path).
# On macOS, /tmp is a symlink to /private/tmp — check both.
# Skipped for local runs regardless of how the script is invoked.
ARCHIVE_DIR_ABS="$(cd "$ARCHIVE_DIR" && pwd)"
if [[ "$ARCHIVE_DIR_ABS" == /tmp/* || "$ARCHIVE_DIR_ABS" == /private/tmp/* ]]; then
  rm -rf "$ARCHIVE_DIR_ABS"
fi