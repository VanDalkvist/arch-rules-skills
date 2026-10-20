---
name: arch-rules-implementation-review
description: Use when reviewing, verifying, or finishing code that was planned against an arch-rules architecture baseline.
---

# Arch Rules Implementation Review

## Purpose

Review implementation against the architecture baseline, not just tests. Lead with real violations and distinguish defects from non-applicable rules.

## The Iron Laws of Architecture Review

```
1. NO TOOL EXECUTION = INVALID REVIEW (REJECTED AS HALLUCINATION)
2. SIDE-EFFECT SINGLE OWNERSHIP (NO SPLIT INITIATORS)
3. COMMAND RECEIPTS IN THIS TURN ARE MANDATORY
```

- Any review that completes with zero tool executions (`bash`, `read`, `wc -l`) or lacks raw terminal execution receipts is **automatically disqualified and rejected**.
- Reviewers must verify side-effect ownership: for any lifecycle action (submitting to conversations, creating background tasks, writing to disk, acquiring locks), exactly ONE component must own it. Having both a tool body and a task extension initiate the same operation is a P1 Race Condition.

## Use With Superpowers

- Use before `superpowers:verification-before-completion`.
- Use in state S9 of `arch-improvement-loop` as part of the parallel dual-circuit verification gate.
- Use after each meaningful implementation slice when architecture boundaries were touched.

## Review Gates

Check applicable AP rules from the context map:

1. **AP-010 (Thin Bridge / Clean Boundaries):**
   - Domain/Application do not import Infrastructure; concrete adapters are wired only in composition root.
   - Handlers/CLI/MCP tools stay thin and do not mix orchestration with domain tasks.
2. **AP-011 (Lifecycle Cleanup):**
   - All timers, subscriptions, event listeners, streams, and SQLite database handles have guaranteed `finally` cleanup, `unsubscribe()`, or `close()` calls.
3. **AP-012 (Fail-Fast & Explicit Errors):**
   - Typed error envelopes; no silent fallbacks, no masked errors, no empty catch blocks.
4. **AP-013 / AP-034 (Deterministic Event Pipeline & Side-Effect Single Ownership):**
   - Exactly one component owns any given side-effect.
   - Event ordering is deterministic, snapshots deduplicated, deliveries idempotent.
5. **AP-019 (File Size Budgets):**
   - Strictly enforced line count limits (e.g. < 200 lines for runner, < 250 lines for host). Run `wc -l` to verify.
6. **AP-026 (DTO Boundaries & ACID Persistence):**
   - Public wire contracts are strictly defined and validated.
   - State documents (`defineDoc`) are mutated only inside ACID transactions.
7. **AP-028 (Deterministic TDD Testing):**
   - Zero flaky tests. Virtual timers (`mock.timers`) for debounces. Environment cleanup in tests.
8. **AP-029 (TypeScript Strictness):**
   - Zero `any`, zero `as unknown as`, zero unvalidated casts. `npx tsc --noEmit` must pass with 0 errors.

## Canonical Output Format

Every architecture review must strictly format its receipts, findings, and verification block:

```markdown
# Архитектурное ревью [S9a: Architecture Verify Gate]

## 1. Terminal Execution Receipts
```bash
# Paste raw terminal command(s) and their actual output tail here:
$ wc -l <touched-files>
...
$ npx tsc --noEmit
...
$ npm test
...
```

## 2. Findings
- [P1/P2/P3] AP-XXX: <file:line>
  - Evidence: <конкретная строка кода и вызов>
  - Impact: <архитектурное последствие, риск гонки, утечка или нарушение границ>
  - Rule: AP-XXX
  - Fix decision: fix-now | log-only | blocked

(If no defects are found, state: "Findings: - None")

## 3. Architecture verification
- Passed: AP-...
- Not applicable: AP-...
- Residual risk: ...

## Итоговый вердикт
VERDICT: PASS | FAIL
```

## Verdict Rules

- **VERDICT: FAIL** if:
  - Any unresolved P0, P1, or P2 architecture rule violations, boundary leaks, dual-ownership race conditions, or line budget breaches (AP-019) exist.
  - Terminal Execution Receipts are missing or show zero tool calls.
  - Verification evidence is missing or non-deterministic.
- **VERDICT: PASS** only when:
  - Terminal Execution Receipts confirm real commands (`wc -l`, `tsc`, `npm test`) were executed.
  - All applicable AP rules pass without open P0, P1, or P2 findings.
  - Residual architecture risk is clearly documented and bounded.
  - Only P3 findings (optional maintainability observations) remain triaged.

## Common Mistakes

- Submitting an essay without running commands (automatic disqualification).
- Counting test pass as architecture pass.
- Ignoring duplicate side-effect initiators (split ownership).
- Marking a rule "not applicable" without saying why.
