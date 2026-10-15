#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
skills_dir="${AGENT_SKILLS_DIR:-"$HOME/.agents/skills"}"

mkdir -p "$skills_dir"

for skill_file in "$repo_dir"/*/SKILL.md; do
  [[ -f "$skill_file" ]] || continue

  skill_dir="${skill_file%/SKILL.md}"
  destination="$skills_dir/${skill_dir##*/}"

  if [[ -L "$destination" && "$(readlink "$destination")" == "$skill_dir" ]]; then
    printf 'Already installed %s\n' "${skill_dir##*/}"
  elif [[ -e "$destination" || -L "$destination" ]]; then
    printf 'Refusing to replace %s\n' "$destination" >&2
    exit 1
  else
    ln -s "$skill_dir" "$destination"
    printf 'Installed %s\n' "${skill_dir##*/}"
  fi
done
