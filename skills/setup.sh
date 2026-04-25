# Skills component — sourced by setup.sh
# Globals required: ARCHIVE_DIR, UPDATE_MODE

SKILLS=()
ALL_SKILLS=()
while IFS= read -r skill_dir; do
  ALL_SKILLS+=("$(basename "$skill_dir")")
  SKILLS+=("$(basename "$skill_dir")")
done < <(find "$ARCHIVE_DIR/skills" -mindepth 1 -maxdepth 1 -type d | sort)

printf "Skills:\n"
printf "  1) all   <- default\n"
printf "  2) pick\n"
printf "  3) skip\n"
read -rp "Choice [1]: " SKILLS_CHOICE_NUM
echo ""
case "${SKILLS_CHOICE_NUM:-1}" in
  1) SKILLS_TOP="all"  ;;
  2) SKILLS_TOP="pick" ;;
  3) SKILLS_TOP="skip" ;;
  *) echo "  Warning: unknown option — defaulting to all"; SKILLS_TOP="all" ;;
esac

if [[ "$SKILLS_TOP" == "skip" ]]; then
  echo "  skills: skipped"
  SKILLS=()
else
  if [[ "$SKILLS_TOP" == "pick" ]]; then
    for i in "${!ALL_SKILLS[@]}"; do
      skill="${ALL_SKILLS[$i]}"
      desc=$(awk '/^## Purpose/{f=1;next} f&&/^[^[:space:]#]/{print;exit}' "$ARCHIVE_DIR/skills/$skill/SKILL.md" 2>/dev/null | cut -c1-60 || echo "no description")
      printf "  %d) %-22s — %s\n" "$((i+1))" "$skill" "$desc"
    done
    read -rp "Select (comma-separated numbers): " SKILLS_CHOICE
    echo ""

    if [[ -n "${SKILLS_CHOICE:-}" ]]; then
      SELECTED_SKILLS=()
      IFS=',' read -ra INDICES <<< "$SKILLS_CHOICE"
      for idx in "${INDICES[@]}"; do
        idx="$(echo "$idx" | xargs)"
        if [[ "$idx" =~ ^[0-9]+$ ]] && (( idx >= 1 && idx <= ${#ALL_SKILLS[@]} )); then
          SELECTED_SKILLS+=("${ALL_SKILLS[$((idx-1))]}")
        fi
      done
      [[ ${#SELECTED_SKILLS[@]} -gt 0 ]] && SKILLS=("${SELECTED_SKILLS[@]}")
    fi
  elif [[ "$SKILLS_TOP" != "all" ]]; then
    echo "  Warning: unknown option '${SKILLS_TOP}' — defaulting to all"
  fi

  for skill in "${SKILLS[@]}"; do
    mkdir -p ".claude/skills/${skill}"
    printf "  skill:  %-30s" "${skill}"
    cp -r "$ARCHIVE_DIR/skills/${skill}/." ".claude/skills/${skill}/" && echo "done"
  done

fi
