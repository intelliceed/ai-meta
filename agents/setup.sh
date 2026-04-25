# Agents component — sourced by setup.sh
# Globals required: ARCHIVE_DIR, UPDATE_MODE

AGENTS=()
ALL_AGENTS=()
while IFS= read -r agent_file; do
  ALL_AGENTS+=("$(basename "$agent_file" .md)")
  AGENTS+=("$(basename "$agent_file" .md)")
done < <(find "$ARCHIVE_DIR/agents" -maxdepth 1 -name "*.md" -not -name "README.md" | sort)

printf "Agents:\n"
printf "  1) all   <- default\n"
printf "  2) pick\n"
printf "  3) skip\n"
read -rp "Choice [1]: " AGENTS_CHOICE_NUM
echo ""
case "${AGENTS_CHOICE_NUM:-1}" in
  1) AGENTS_TOP="all"  ;;
  2) AGENTS_TOP="pick" ;;
  3) AGENTS_TOP="skip" ;;
  *) echo "  Warning: unknown option — defaulting to all"; AGENTS_TOP="all" ;;
esac

if [[ "$AGENTS_TOP" == "skip" ]]; then
  echo "  agents: skipped"
  AGENTS=()
else
  if [[ "$AGENTS_TOP" == "pick" ]]; then
    for i in "${!ALL_AGENTS[@]}"; do
      agent="${ALL_AGENTS[$i]}"
      desc=$(grep '^description:' "$ARCHIVE_DIR/agents/${agent}.md" 2>/dev/null | head -1 | sed 's/^description: *"*//;s/"[^"]*$//' | cut -c1-60 || echo "no description")
      printf "  %d) %-22s — %s\n" "$((i+1))" "$agent" "$desc"
    done
    read -rp "Select (comma-separated numbers): " AGENTS_CHOICE
    echo ""

    if [[ -n "${AGENTS_CHOICE:-}" ]]; then
      SELECTED_AGENTS=()
      IFS=',' read -ra INDICES <<< "$AGENTS_CHOICE"
      for idx in "${INDICES[@]}"; do
        idx="$(echo "$idx" | xargs)"
        if [[ "$idx" =~ ^[0-9]+$ ]] && (( idx >= 1 && idx <= ${#ALL_AGENTS[@]} )); then
          SELECTED_AGENTS+=("${ALL_AGENTS[$((idx-1))]}")
        fi
      done
      [[ ${#SELECTED_AGENTS[@]} -gt 0 ]] && AGENTS=("${SELECTED_AGENTS[@]}")
    fi
  elif [[ "$AGENTS_TOP" != "all" ]]; then
    echo "  Warning: unknown option '${AGENTS_TOP}' — defaulting to all"
  fi

  mkdir -p .claude/agents
  for agent in "${AGENTS[@]}"; do
    printf "  agent:  %-30s" "${agent}"
    cp "$ARCHIVE_DIR/agents/${agent}.md" ".claude/agents/${agent}.md" && echo "done"
  done

fi
