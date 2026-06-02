# Hooks component — sourced by setup.sh
# Globals required: ARCHIVE_DIR, UPDATE_MODE

HOOKS=()
ALL_HOOKS=()
while IFS= read -r bundle_dir; do
  ALL_HOOKS+=("$(basename "$bundle_dir")")
  HOOKS+=("$(basename "$bundle_dir")")
done < <(find "$ARCHIVE_DIR/hooks/bundles" -mindepth 1 -maxdepth 1 -type d | sort)

printf "Hooks:\n"
printf "  1) skip  <- default\n"
printf "  2) all\n"
printf "  3) pick\n"
read -rp "Choice [1]: " HOOKS_CHOICE_NUM
echo ""
case "${HOOKS_CHOICE_NUM:-1}" in
  1) HOOKS_TOP="skip" ;;
  2) HOOKS_TOP="all"  ;;
  3) HOOKS_TOP="pick" ;;
  *) echo "  Warning: unknown option — defaulting to skip"; HOOKS_TOP="skip" ;;
esac

if [[ "$HOOKS_TOP" == "skip" ]]; then
  echo "  hooks:  skipped"
  HOOKS=()
else
  if [[ "$HOOKS_TOP" == "pick" ]]; then
    for i in "${!ALL_HOOKS[@]}"; do
      bundle="${ALL_HOOKS[$i]}"
      desc=$(cat "$ARCHIVE_DIR/hooks/bundles/$bundle/description" 2>/dev/null || echo "no description")
      printf "  %d) %-22s — %s\n" "$((i+1))" "$bundle" "$desc"
    done
    read -rp "Select (comma-separated numbers): " HOOKS_CHOICE
    echo ""

    if [[ -n "${HOOKS_CHOICE:-}" ]]; then
      SELECTED_HOOKS=()
      IFS=',' read -ra INDICES <<< "$HOOKS_CHOICE"
      for idx in "${INDICES[@]}"; do
        idx="$(echo "$idx" | xargs)"
        if [[ "$idx" =~ ^[0-9]+$ ]] && (( idx >= 1 && idx <= ${#ALL_HOOKS[@]} )); then
          SELECTED_HOOKS+=("${ALL_HOOKS[$((idx-1))]}")
        fi
      done
      [[ ${#SELECTED_HOOKS[@]} -gt 0 ]] && HOOKS=("${SELECTED_HOOKS[@]}")
    fi
  elif [[ "$HOOKS_TOP" != "all" ]]; then
    echo "  Warning: unknown option '${HOOKS_TOP}' — defaulting to skip"
    echo "  hooks:  skipped"
    HOOKS=()
  fi

  # Only install/cleanup when a valid selection was made (not invalid input defaulting to skip)
  HOOKS_EXPLICIT=true
  [[ ${#HOOKS[@]} -eq 0 && "$HOOKS_TOP" != "all" && "$HOOKS_TOP" != "pick" ]] && HOOKS_EXPLICIT=false

  if [[ "$HOOKS_EXPLICIT" == true && ${#HOOKS[@]} -gt 0 ]]; then
    mkdir -p .claude/hooks

    # Collect scripts across selected bundles (dedup, preserve order)
    SCRIPTS_TO_COPY=()
    for bundle in "${HOOKS[@]}"; do
      while IFS= read -r script; do
        [[ -z "$script" ]] && continue
        if [[ ! " ${SCRIPTS_TO_COPY[*]:-} " =~ " ${script} " ]]; then
          SCRIPTS_TO_COPY+=("$script")
        fi
      done < "$ARCHIVE_DIR/hooks/bundles/$bundle/scripts.txt"
    done

    # Install settings.json — last selected bundle wins (comprehensive > basic-security)
    for bundle in "${HOOKS[@]}"; do
      printf "  hooks:  %-30s" "$bundle"
      cp "$ARCHIVE_DIR/hooks/bundles/$bundle/settings.json" ".claude/settings.json" && echo "done"
    done

    # Copy scripts
    for script in "${SCRIPTS_TO_COPY[@]}"; do
      cp "$ARCHIVE_DIR/hooks/scripts/$script" ".claude/hooks/$script"
      chmod +x ".claude/hooks/$script"
      echo "  copied: $script"
    done
  fi

  if [[ "$HOOKS_EXPLICIT" == true && "$UPDATE_MODE" == true ]]; then
    for bundle in "${ALL_HOOKS[@]}"; do
      if [[ ! " ${HOOKS[*]} " =~ " ${bundle} " ]]; then
        while IFS= read -r script; do
          [[ -z "$script" ]] && continue
          still_needed=false
          for selected in "${HOOKS[@]}"; do
            if grep -qF "$script" "$ARCHIVE_DIR/hooks/bundles/$selected/scripts.txt" 2>/dev/null; then
              still_needed=true
              break
            fi
          done
          if [[ "$still_needed" == false ]]; then
            rm -f ".claude/hooks/$script"
            echo "  removed: $script"
          fi
        done < "$ARCHIVE_DIR/hooks/bundles/$bundle/scripts.txt"
      fi
    done
  fi
fi
