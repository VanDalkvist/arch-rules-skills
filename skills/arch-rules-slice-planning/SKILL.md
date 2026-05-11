---
name: arch-rules-slice-planning
description: Use when turning an architecture document and arch-rules context map into an implementation plan or task breakdown.
---

# Arch Rules Slice Planning

## Purpose

Convert architecture intent into implementation slices that preserve boundaries. Plan by behavior and architecture boundary, not by incidental file lists.

## Use With Superpowers

- Use after `arch-rules-context`.
- Use alongside `superpowers:writing-plans`.
- Each implementation slice should be executed with `superpowers:test-driven-development` unless the user explicitly excludes TDD.

## Planning Rules

1. Start from user-visible or contract-visible behavior.
2. For each slice, name the primary boundary it touches:
   - Domain/Application
   - Interface entry point
   - Infrastructure adapter
   - Config/session/auth boundary
   - DTO/schema/error mapping boundary
3. Attach AP gates to the slice. Prefer AP IDs over prose.
4. Keep entry points thin: parse/validate -> enforce limits/security -> call use-case/query path -> map output.
5. Separate query and command paths. If the project is read-only, any state-changing tool, side effect, watcher, daemon, or implicit mutation is out of scope unless the architecture is updated first.
6. Put runtime validation and typed error behavior in the same slice as the boundary that exposes it.
7. Treat open architecture choices as plan blockers when they affect public contracts or critical AP rules.

## Slice Template

```markdown
### Slice N: <behavior>
- Boundary: <layer/component>
- AP gates: AP-...
- Red test first: <expected failing behavior>
- Implementation: <smallest code path to satisfy the test>
- Verification: <targeted command/manual smoke>
- Stop condition: <critical AP or contract violation>
```

## Common Mistakes

- Planning one task per future file before the architecture boundary is clear.
- Hiding cross-layer coupling inside "service" or "helper" tasks.
- Deferring input validation, typed errors, or DTO mapping to a vague cleanup step.
- Treating adapters as owners of business rules instead of implementation details behind ports.
