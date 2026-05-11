---
name: arch-rules-context
description: Use when a project has an architecture/spec document and an arch-rules baseline should constrain planning, implementation, or review decisions.
---

# Arch Rules Context

## Purpose

Create a small architecture context map before planning or coding. Do not copy the whole baseline into the task; select the rules that actually govern the current project and feature.

## Use With Superpowers

- Use after `superpowers:brainstorming` has established the product/architecture intent.
- Use before `superpowers:writing-plans` or any implementation plan.
- Pair with `superpowers:test-driven-development` only after the applicable AP rules and boundaries are known.

## Workflow

1. Read the current project architecture/spec and any project-owned policy or AGENTS.md.
2. Locate the arch-rules baseline. Prefer the project-pinned copy; otherwise use the public upstream or baseline repository named by project policy. If no baseline is named, stop and ask for the baseline source instead of inventing rules.
3. Identify the project stage: `mvp`, `prod`, or `scale`. If unclear, infer conservatively and state the assumption.
4. Build an `Architecture Context Map`:
   - Applicable critical AP rules.
   - Applicable baseline AP rules.
   - Guidelines that materially affect the design.
   - Explicitly non-applicable stack rules, such as frontend or database rules for a CLI-only project.
   - Known deviations. A deviation from `baseline` must point to a project-owned policy entry; a feature spec alone is not enough.
   - Open implementation decisions that must be settled in the plan.
5. If a proposed direction violates a `critical` AP rule, stop and call out the architecture conflict before planning implementation.

## Output Shape

```markdown
Architecture Context Map
- Stage: mvp | prod | scale
- Source docs: ...
- Critical AP gates: AP-...
- Baseline AP gates: AP-...
- Not applicable: AP-... because ...
- Deviations: none | ...
- Plan decisions still open: ...
```

## Common Mistakes

- Treating `arch-rules` as a checklist to paste instead of a baseline to apply.
- Enforcing frontend, database, or server-production rules on a project that does not have that surface yet.
- Letting a feature spec override a critical AP rule.
- Starting implementation before resolving a boundary, contract, or security conflict.
