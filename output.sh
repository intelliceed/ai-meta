# Output component — sourced by setup.sh on first run only
# Globals required: ARCHIVE_DIR

# =============================================================================
# Auto-detect project commands
# =============================================================================
REPO_URL="$(git remote get-url origin 2>/dev/null || echo 'TODO')"
INSTALL_CMD="TODO"
RUN_CMD="TODO"
TEST_CMD="TODO"
BUILD_CMD="TODO"

PKG_MANAGER="npm"
if [[ -f "pnpm-lock.yaml" ]]; then
  PKG_MANAGER="pnpm"
elif [[ -f "yarn.lock" ]]; then
  PKG_MANAGER="yarn"
fi

PKG_JSON=""
for dir in . app src frontend backend client server web; do
  if [[ -f "${dir}/package.json" ]]; then
    PKG_JSON="${dir}/package.json"
    break
  fi
done

if [[ -n "$PKG_JSON" ]] && command -v node &>/dev/null; then
  INSTALL_CMD="${PKG_MANAGER} install"
  RUN_CMD="$(node -e "
    const s = require('./${PKG_JSON}').scripts || {};
    console.log(s.dev ? '${PKG_MANAGER} run dev' : s.start ? '${PKG_MANAGER} start' : 'TODO');
  " 2>/dev/null || echo 'TODO')"
  TEST_CMD="$(node -e "
    const s = require('./${PKG_JSON}').scripts || {};
    console.log(s.test ? '${PKG_MANAGER} test' : 'TODO');
  " 2>/dev/null || echo 'TODO')"
  BUILD_CMD="$(node -e "
    const s = require('./${PKG_JSON}').scripts || {};
    console.log(s.build ? '${PKG_MANAGER} run build' : 'TODO');
  " 2>/dev/null || echo 'TODO')"
elif [[ -f "pyproject.toml" ]] || [[ -f "requirements.txt" ]]; then
  INSTALL_CMD="pip install -r requirements.txt"
  RUN_CMD="python app/main.py"
  TEST_CMD="pytest tests/"
  BUILD_CMD="TODO"
elif [[ -f "go.mod" ]]; then
  INSTALL_CMD="go mod download"
  RUN_CMD="go run ."
  TEST_CMD="go test ./..."
  BUILD_CMD="go build -o bin/app ."
elif [[ -f "Gemfile" ]]; then
  INSTALL_CMD="bundle install"
  RUN_CMD="bundle exec rails server"
  TEST_CMD="bundle exec rspec"
  BUILD_CMD="TODO"
fi

# =============================================================================
# Scaffold directories
# =============================================================================
mkdir -p .claude/skills .claude/agents .claude/documents .claude/hooks

# =============================================================================
# Project name prompt
# =============================================================================
FOLDER_NAME="$(basename "$(pwd)")"
read -rp "Project name [${FOLDER_NAME}]: " PROJECT_NAME
PROJECT_NAME="${PROJECT_NAME:-$FOLDER_NAME}"
echo ""

# =============================================================================
# Generate files
# =============================================================================
generate_tree() {
  local excludes="node_modules|.git|.claude|.idea|__pycache__|venv|dist|build|.next|.nuxt|coverage|.cache|.DS_Store"

  if command -v tree &>/dev/null; then
    tree -L 3 -I "$excludes" --noreport 2>/dev/null | tail -n +2
  else
    find . -maxdepth 3 -mindepth 1 \
      ! -path "*/node_modules/*" ! -name "node_modules" \
      ! -path "*/.git/*"         ! -name ".git" \
      ! -path "*/.claude/*"      ! -name ".claude" \
      ! -path "*/.idea/*"        ! -name ".idea" \
      ! -path "*/__pycache__/*"  ! -name "__pycache__" \
      ! -path "*/venv/*"         ! -name "venv" \
      ! -path "*/dist/*"         ! -name "dist" \
      ! -path "*/build/*"        ! -name "build" \
      ! -path "*/.next/*"        ! -name ".next" \
      ! -path "*/coverage/*"     ! -name "coverage" \
      ! -name "*.lock" \
      ! -name "package-lock.json" \
      ! -name ".DS_Store" \
      ! -name ".env*" \
      2>/dev/null | sort | while IFS= read -r path; do
        git check-ignore -q "$path" 2>/dev/null && continue
        local depth
        depth=$(echo "$path" | tr -cd '/' | wc -c | tr -d ' ')
        local indent
        indent=$(printf '  %.0s' $(seq 1 "$depth"))
        echo "${indent}$(basename "$path")"
      done
  fi
}

TODAY="$(date +%Y-%m-%d)"
PROJECT_FOLDER="$(basename "$(pwd)")"
PROJECT_TREE="$(generate_tree)"

{
  cat << EOF
# ${PROJECT_NAME}

> **Last Updated**: ${TODAY}
> **Status**: active
> **Owner**: Intelliceed Team
> **Repo**: ${REPO_URL}

## Engineer Role

TODO

## Stack

TODO

## Commands

\`\`\`bash
# Install
${INSTALL_CMD}

# Run
${RUN_CMD}

# Test
${TEST_CMD}

# Build
${BUILD_CMD}
\`\`\`

## Project Structure

\`\`\`
${PROJECT_FOLDER}/
${PROJECT_TREE}
\`\`\`

## Architecture

TODO

## Key Files

TODO

## Coding Conventions

TODO

## Business Domain

TODO

## Known Gotchas

TODO

## Links

- **Jira**: TODO
- **Confluence**: TODO
- **Staging**: TODO
- **Dashboards**: TODO

EOF
  cat << 'EOF'
## TODO Protocol

1. At every session start, read `.claude/TODO.md` and remind the user of all Pending items before starting work.
2. When a task is completed, move it from Pending to Done.
3. Add newly discovered tasks to Pending. Write tasks so they're understandable without prior conversation context.

## Strict Planning Protocol

1. For any task involving file changes, you MUST present a numbered Plan first.
2. You are FORBIDDEN from writing code until the user explicitly says "Proceed" or "Approved."
3. If the user provides a "Pivot" or "Correction," discard the old plan and present a versioned update (e.g., "Plan v2").
4. Before committing, you MUST present the proposed commit message for discussion and wait for explicit approval.

## Document Creation Protocol (Claude)

1. All generated documents MUST be created in `.claude/documents`.
2. This folder is gitignored — files there are NOT part of the repository.
3. You are FORBIDDEN from placing documents outside this folder unless explicitly instructed.
4. If the user wants a document tracked in the repo, they MUST move it or clearly request a different location.
5. Do NOT auto-promote or duplicate files into tracked directories.
EOF
} > .claude/CLAUDE.md
echo "Generated   .claude/CLAUDE.md"

cp "$ARCHIVE_DIR/settings.json" .claude/settings.json
echo "Generated   .claude/settings.json"

cat > .claude/TODO.md << 'EOF'
# TODO

## Pending

- Confirm or update **Status** in CLAUDE.md (active / maintenance / deprecated)
- Confirm or update **Owner** in CLAUDE.md (team or person)
- Fill in **Engineer Role** — what role are you in this project?
- Fill in **Stack** — what technologies does this project use?
- Fill in **Architecture** section in CLAUDE.md
- Fill in **Key Files** section in CLAUDE.md
- Fill in **Coding Conventions** section in CLAUDE.md
- Fill in **Business Domain** section in CLAUDE.md
- Fill in **Known Gotchas** section in CLAUDE.md
- Fill in **Links** section in CLAUDE.md (Jira, Confluence, Staging, Dashboards)

## Done
EOF
echo "Generated   .claude/TODO.md"

cat > .claude/.gitignore << 'EOF'
documents/*
!documents/.gitkeep
TODO.md
EOF

touch .claude/documents/.gitkeep
touch .claude/skills/.gitkeep
touch .claude/agents/.gitkeep
touch .claude/hooks/.gitkeep

cat > .claude/start-claude.sh << EOF
#!/bin/bash
cd "\$(dirname "\$0")/.."

echo "=========================================="
echo "  Starting Claude Code"
echo "  Project: ${PROJECT_NAME}"
echo "  Working directory: \$(pwd)"
echo "=========================================="
echo ""
echo "Conventions:"
echo "  - Documents go in .claude/documents/ (gitignored)"
echo "  - Present a Plan before making file changes"
echo "  - Get explicit approval before committing"
echo ""

if [[ ! -f ".claude/TODO.md" ]]; then
  cat > .claude/TODO.md << 'TODOEOF'
# TODO

## Pending

## Done
TODOEOF
fi

claude "Read .claude/TODO.md and remind me of all pending items before we start."

if [ \$? -ne 0 ]; then
  echo ""
  echo "Error starting Claude Code. Press any key to close..."
  read -n 1
fi
EOF
chmod +x .claude/start-claude.sh
echo "Created     .claude/start-claude.sh"
