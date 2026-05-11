# Arch Rules Skills

Portable agent skills for applying an architecture-rules baseline to planning, implementation, and review.

This repository contains:

- `arch-rules-context` - builds a compact Architecture Context Map from project docs and an architecture-rules baseline.
- `arch-rules-slice-planning` - turns architecture intent into boundary-preserving implementation slices.
- `arch-rules-implementation-review` - reviews implementation against architecture gates, not just tests.

## What This Is

These skills are a small methodology pack. They do not define the architecture rules themselves. They tell an agent how to find a project-provided baseline, select the applicable rules, and use those rules to constrain planning and review.

## Dependencies

This pack depends on Superpowers or equivalent planning/TDD/verification skills.

Canonical links:

- Superpowers source project: https://github.com/obra/superpowers
- Claude plugin page: https://claude.com/plugins/superpowers
- Codex installation guide: https://github.com/obra/superpowers/blob/main/docs/README.codex.md

Required Superpowers skill surface:

- `superpowers:brainstorming`
- `superpowers:writing-plans`
- `superpowers:test-driven-development`
- `superpowers:verification-before-completion`

Project input dependency:

- A project-pinned architecture-rules baseline, or a public upstream baseline named by project policy.
- If no baseline is named, the agent should stop and ask for the source instead of inventing rules.

## Install In Codex

Install Superpowers first, or confirm that equivalent Superpowers skills are already available.

Recommended agent instruction:

```text
Install all skills from https://github.com/VanDalkvist/arch-rules-skills/tree/main/skills into Codex.
Use the Codex skill-installer flow if available. Install every arch-rules-* skill.
After installation, restart Codex so the skills are discovered.
```

Manual fallback:

```sh
git clone https://github.com/VanDalkvist/arch-rules-skills.git
cd arch-rules-skills
mkdir -p "${CODEX_HOME:-$HOME/.codex}/skills"
cp -R skills/arch-rules-* "${CODEX_HOME:-$HOME/.codex}/skills/"
```

## Install In Claude Code

Install the Superpowers plugin first, or confirm equivalent Superpowers skills are already installed: https://claude.com/plugins/superpowers

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

Claude Code skills documentation: https://code.claude.com/docs/en/skills

## Verify

```sh
find skills -name SKILL.md -maxdepth 3 -print
grep -R "<project-specific-name>\|<absolute-home-path>\|<private-user-name>" -n skills docs README.md AGENTS.md scripts || true
```

For Codex skill schema validation, use the local Codex validator when available:

```sh
for skill in skills/arch-rules-*; do
  uv run --with pyyaml python "$HOME/.codex/skills/.system/skill-creator/scripts/quick_validate.py" "$skill"
done
```

## Relationship To Arch Improvement Skills

`arch-improvement-skills` depends on this pack. Install order:

1. Superpowers
2. `arch-rules-skills`
3. `arch-improvement-skills`

## License

MIT.
