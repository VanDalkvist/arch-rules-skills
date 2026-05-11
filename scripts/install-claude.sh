#!/usr/bin/env sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
dest="${1:-$HOME/.claude/skills}"

mkdir -p "$dest"
cp -R "$repo_dir"/skills/arch-rules-* "$dest"/

printf 'Installed arch-rules skills into %s\n' "$dest"
printf 'Restart Claude Code if the top-level skills directory did not exist before installation.\n'
