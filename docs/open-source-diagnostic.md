# Open Source Diagnostic

Date: 2026-05-11

## Scope

Reviewed skills:

- `arch-rules-context`
- `arch-rules-slice-planning`
- `arch-rules-implementation-review`

## Architecture Fit

Pass. The pack has a coherent boundary: it teaches an agent how to apply an external architecture-rules baseline during context mapping, planning, and implementation review.

The skills do not own the improvement loop. That remains in `arch-improvement-skills`. This separation keeps the architecture-rule methodology reusable for other workflows.

## Open Source Fit

Pass with one adjustment applied.

The original `arch-rules-context` skill named a specific upstream baseline URL. For open source portability, the skill now requires a project-pinned baseline or a public upstream named by project policy. If no baseline is named, the agent must stop and ask instead of inventing rules.

## Dependency Fit

Pass.

The skills depend on Superpowers concepts:

- `superpowers:brainstorming`
- `superpowers:writing-plans`
- `superpowers:test-driven-development`
- `superpowers:verification-before-completion`

The dependency is now explicit in `README.md`.

## Risk Register

- Risk: users install these skills without an architecture-rules baseline.
  - Mitigation: README and `arch-rules-context` define baseline resolution order and a default public baseline.
- Risk: users treat `arch-rules` as a paste-in checklist.
  - Mitigation: `arch-rules-context` instructs the agent to select applicable rules and mark non-applicable rules explicitly.
- Risk: the pack is confused with `arch-improvement-skills`.
  - Mitigation: README documents that `arch-improvement-skills` depends on this pack, not the other way around.

## Verification

Required checks before publish:

```sh
for skill in skills/arch-rules-*; do
  uv run --with pyyaml python "$HOME/.codex/skills/.system/skill-creator/scripts/quick_validate.py" "$skill"
done

grep -R "<absolute-home-path>\|<private-user-name>\|<project-specific-name>\|<private-provider>\|<old-package-name>" -n skills README.md docs AGENTS.md scripts || true
```
