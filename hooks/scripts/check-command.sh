#!/bin/bash
# PreToolUse hook: block dangerous bash commands
# Receives tool input JSON on stdin. Exit 2 to block.

input=$(cat)
command=$(printf '%s' "$input" | jq -r '.command // ""' 2>/dev/null || echo "")

[[ -z "$command" ]] && exit 0

patterns=(
  'rm\s+-rf\s+/'      # rm -rf /
  'rm\s+-rf\s+\*'     # rm -rf *
  'DROP\s+TABLE'      # SQL DROP TABLE
  'DROP\s+DATABASE'   # SQL DROP DATABASE
  ':\(\)\{.*\}'       # fork bomb
  'mkfs\.'            # format filesystem
  'dd\s+if=.*of=/dev' # overwrite disk device
)

for pattern in "${patterns[@]}"; do
  if echo "$command" | grep -qiE "$pattern"; then
    echo "check-command: dangerous command blocked — review before running" >&2
    exit 2
  fi
done

exit 0