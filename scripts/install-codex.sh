#!/usr/bin/env sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
dest="${CODEX_HOME:-$HOME/.codex}/skills"

mkdir -p "$dest"
cp -R "$repo_dir"/skills/arch-rules-* "$dest"/

printf 'Installed arch-rules skills into %s\n' "$dest"
printf 'Restart Codex to pick up newly installed skills.\n'
