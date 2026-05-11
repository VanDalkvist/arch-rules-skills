# Agent Installation Guide

Install every directory under `skills/`:

- `arch-rules-context`
- `arch-rules-slice-planning`
- `arch-rules-implementation-review`

## Required Dependencies

Install or confirm Superpowers first:

- Superpowers source project: https://github.com/obra/superpowers
- Claude plugin page: https://claude.com/plugins/superpowers
- Codex installation guide: https://github.com/obra/superpowers/blob/main/docs/README.codex.md

Required Superpowers skill surface:

- `superpowers:brainstorming`
- `superpowers:writing-plans`
- `superpowers:test-driven-development`
- `superpowers:verification-before-completion`

The target project must also provide or point to an architecture-rules baseline.

## Codex

Preferred:

1. Confirm Superpowers is available in Codex.
2. Use Codex's `skill-installer` flow for this GitHub repository if available.
3. Install all three `skills/arch-rules-*` paths.
4. Tell the user to restart Codex after installation.

Manual fallback:

```sh
git clone https://github.com/VanDalkvist/arch-rules-skills.git
cd arch-rules-skills
mkdir -p "${CODEX_HOME:-$HOME/.codex}/skills"
cp -R skills/arch-rules-* "${CODEX_HOME:-$HOME/.codex}/skills/"
```

## Claude Code

Install the Superpowers Claude plugin first, or confirm equivalent Superpowers skills are already installed: https://claude.com/plugins/superpowers

Personal install:

```sh
git clone https://github.com/VanDalkvist/arch-rules-skills.git
cd arch-rules-skills
mkdir -p "$HOME/.claude/skills"
cp -R skills/arch-rules-* "$HOME/.claude/skills/"
```

Project install:

```sh
git clone https://github.com/VanDalkvist/arch-rules-skills.git
cd your-project
mkdir -p .claude/skills
cp -R ../arch-rules-skills/skills/arch-rules-* .claude/skills/
```
