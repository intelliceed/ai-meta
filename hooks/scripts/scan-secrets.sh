#!/bin/bash
# PreToolUse hook: scan for hardcoded secrets before Edit/Write
# Receives tool input JSON on stdin. Exit 2 to block.

input=$(cat)
content=$(printf '%s' "$input" | jq -r '(.new_string // .content) // ""' 2>/dev/null || echo "")

[[ -z "$content" ]] && exit 0

patterns=(
  'AKIA[0-9A-Z]{16}'                                              # AWS access key ID
  'sk-[a-zA-Z0-9]{32,}'                                          # OpenAI / Anthropic API key
  'ghp_[a-zA-Z0-9]{36}'                                          # GitHub personal token
  'glpat-[a-zA-Z0-9_-]{20}'                                      # GitLab personal token
  '(password|passwd|pwd)\s*=\s*["'"'"'][^"'"'"']{4,}["'"'"']'   # hardcoded password
  '(secret|api_?key|token)\s*=\s*["'"'"'][^"'"'"']{8,}["'"'"']' # hardcoded secret/token
)

for pattern in "${patterns[@]}"; do
  if echo "$content" | grep -qiE "$pattern"; then
    echo "scan-secrets: possible hardcoded secret detected — review before writing" >&2
    exit 2
  fi
done

exit 0