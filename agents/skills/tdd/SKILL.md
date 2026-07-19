---
name: tdd
description: Test-driven development harness enforcing the RED/GREEN/REFACTOR cycle - write a failing test first, write the minimum code to pass, then refactor while green. Includes a Prove-It variant for bug fixes (write a failing repro test before the fix). Use when building a feature test-first or fixing a bug with a regression guard.
---

# tdd - Test-Driven Development

You enforce the RED/GREEN/REFACTOR cycle: write tests before code, drive the
implementation to passing, and refactor while the suite stays green.

## Orientation

- Detect the test framework from project files:
  - `pytest.ini`, `pyproject.toml` (`[tool.pytest]`), or `tests/` -> pytest
  - `package.json` (jest/vitest config) -> jest/vitest
  - `go.mod` -> go test
- Determine scope: user-specified behavior, file, or function
- If scope is broad (multiple files/functions), get a coverage-gap analysis from the
  `test-engineer` subagent (or analyze inline on agents without subagents) first

## Protocol

### Standard TDD Cycle

1. **RED - Write the failing test**:
   - Write a test that describes the desired behavior
   - Run the suite; confirm the new test is the only (expected) failure

2. **GREEN - Minimum code to pass**:
   - Write the simplest code that makes the test pass; no gold-plating
   - Run the suite; confirm the target test now passes

3. **VERIFY - Confirm suite integrity**:
   - Run the full suite; confirm no regressions
   - Fix any new failures before proceeding

4. **REFACTOR - Clean up with tests green**:
   - Improve structure, naming, and clarity; no behavior changes
   - Run tests after each refactor step

### Prove-It Variant (Bug Fixes)

1. **REPRO** - Write a test that reproduces the bug. Run it, confirm it fails.
2. **FIX** - Implement the fix.
3. **VERIFY** - Run the repro test, confirm it passes. Run full suite, confirm no regressions.

### Coverage Analysis (Broad Scope)

- Spawn the `test-engineer` subagent with the target file list
- Wait for coverage gap analysis (current gaps, recommended tests, priority tiers)
- Write tests starting from the highest-priority gaps, each via RED/GREEN/REFACTOR

## Quality Gates

- [ ] Every new behavior has at least one test
- [ ] Bug fixes have a repro test confirmed failing before the fix
- [ ] No tests are skipped (`@pytest.mark.skip`, `xit(`, `t.Skip()`)
- [ ] Coverage has not decreased from the pre-session baseline
- [ ] Full test suite passes at the end of the session

## Exit Protocol

```
HANDOFF
- Done: [N] tests written, [M] behaviors covered, [K] bugs fixed
- Coverage delta: [increased/maintained, note gaps left intentionally]
- Next: Commit changes, or continue with next behavior
```
