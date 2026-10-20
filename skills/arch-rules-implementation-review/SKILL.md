---
name: arch-rules-implementation-review
description: Use when reviewing, verifying, or finishing code that was planned against an arch-rules architecture baseline.
---

# Arch Rules Implementation Review

## Purpose

Review implementation against the architecture baseline, not just tests. Lead with real violations and distinguish defects from non-applicable rules.

## Use With Superpowers

- Use before `superpowers:verification-before-completion`.
- Use after each meaningful implementation slice when architecture boundaries were touched.
- Use in code-review stance when the user asks for review.

## Review Gates

Check applicable AP rules from the context map:

- Boundaries: Domain/Application do not import Infrastructure; concrete adapters are wired only in composition root.
- Entry points: handlers/CLI/MCP tools stay thin and do not call DB/API clients directly except as boundary infrastructure.
- Contracts: public DTOs and tool schemas are explicit; storage/provider shapes do not leak out by accident.
- Errors: invalid config/input/auth/access/provider failures map to typed errors; no silent fallback after invariant failures.
- Config/secrets: required env is validated at startup; secrets are not committed, logged, or returned.
- Async: every promise is awaited or explicitly handled; intentional fire-and-forget has diagnostics.
- Command/query: read paths do not mutate state; command paths are explicit and guarded.
- Tests: core logic is tested without I/O; adapters use mocked provider clients or contract tests; tests are deterministic.

## Output Shape

If reviewing code, report findings first:

```markdown
Findings
- [P1] <AP-ID>: <file:line> <problem and impact>

Open questions
- ...

Verification
- ...
```

If finishing implementation, give a short pass/fail summary:

```markdown
Architecture verification
- Passed: AP-...
- Not applicable: AP-...
- Residual risk: ...

VERDICT: PASS | FAIL
```

## Verdict Rules

- **VERDICT: FAIL** if:
  - Any unresolved P0, P1, or P2 architecture rule violations, boundary leaks, or line budget breaches (AP-019) exist.
  - Verification evidence is missing or non-deterministic.
- **VERDICT: PASS** only when:
  - All applicable AP rules pass without open P0, P1, or P2 findings.
  - Residual architecture risk is clearly documented and bounded.
  - Only P3 findings (optional maintainability observations) remain triaged.

## Common Mistakes

- Counting test pass as architecture pass.
- Reporting generic style preferences without AP impact.
- Marking a rule "not applicable" without saying why.
- Accepting a local shortcut that violates a `critical` AP rule.
