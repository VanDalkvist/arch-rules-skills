# Arch Rules Skills

Portable agent skills for applying an architecture-rules baseline to planning, implementation, and review.

This repository contains:

- `arch-rules-context` - builds a compact Architecture Context Map from project docs and an architecture-rules baseline.
- `arch-rules-slice-planning` - turns architecture intent into boundary-preserving implementation slices.
- `arch-rules-implementation-review` - reviews implementation against architecture gates, not just tests.

## What This Is

These skills are a small methodology pack. They do not define the architecture rules themselves. They tell an agent how to find a project-provided baseline, select the applicable rules, and use those rules to constrain planning and review.

## Agent Bootstrap

If an agent is given only this repository link, it should follow this order:

1. Install or confirm Superpowers.
2. Install all `arch-rules-*` skills from this repository.
3. In the target project, locate the architecture-rules baseline.
4. Run `arch-rules-context` to create an Architecture Context Map.
5. Only then use `arch-rules-slice-planning` or `arch-rules-implementation-review`.

Fail fast before planning or implementation if any required dependency is missing.

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

- Preferred: a project-pinned architecture-rules baseline in the target repository.
- Default public baseline: https://github.com/ai-meatbags/arch-rules
- Project override: a project policy file may name a different public or private baseline.

Baseline resolution order:

1. Project-local policy or docs, such as `AGENTS.md`, `docs/project-arch-rules.md`, `docs/arch-rules.md`, `docs/architecture.md`, or `.agents/`.
2. A baseline URL or repository explicitly named by the user.
3. The default public baseline: https://github.com/ai-meatbags/arch-rules

If the selected baseline cannot be read, the agent must stop with a clear error. It must not invent architecture rules or continue with generic best practices.

Fail-fast message shape:

```text
Cannot start arch-rules workflow.
Missing: <Superpowers skill | arch-rules skill | readable architecture-rules baseline>
Tried: <paths and URLs checked>
Next action: <install dependency or provide baseline URL/path>
```

## Install In Codex

Install Superpowers first, or confirm that equivalent Superpowers skills are already available.

Recommended agent instruction:

```text
Install or confirm Superpowers first.
Install all skills from https://github.com/VanDalkvist/arch-rules-skills/tree/main/skills into Codex.
Use the Codex skill-installer flow if available. Install every arch-rules-* skill.
Before using the skills, locate a project-pinned architecture-rules baseline or use the default public baseline at https://github.com/ai-meatbags/arch-rules.
Fail fast if Superpowers, any arch-rules-* skill, or a readable baseline is missing.
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
