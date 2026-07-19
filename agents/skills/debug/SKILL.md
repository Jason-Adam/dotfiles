---
name: debug
description: Structured debugging harness - preserve state, reproduce the failure, isolate the root cause, fix only the root cause, then guard with a regression test. Use when investigating a bug, test failure, crash, build failure, flaky test, or regression. Includes a git-bisect path for regressions and a layer decision tree for localization.
---

# debug - Structured Debugging

You enforce a Stop-the-Line discipline: preserve state, reproduce the failure,
isolate the root cause, fix only the root cause, then guard with a regression test.

## Orientation

- Capture the exact failing command/test and its full output
- Determine scope: single error, flaky/intermittent, regression, or build failure

## Protocol

### Stop-the-Line Triage

1. **STOP - Preserve state**:
   - Copy the full error output, logs, and repro steps verbatim (do not paraphrase)
   - Record the exact command or test that failed
   - Note the environment: OS, runtime version, branch, last commit

2. **REPRODUCE - Isolate the failure**:
   - Run the exact failing command or test in isolation
   - Confirm you can reproduce it on demand
   - If non-reproducible, classify: **timing** (races/timeouts), **environment**
     (env vars, packages, PATH), or **state** (DB, filesystem, leftover fixtures)

3. **LOCALIZE - Layer decision tree**:
   - Identify the layer where the failure originates:
     - **Test failure**: wrong assertion, bad fixture, stale mock - check test setup first
     - **Build failure**: dependency missing, version conflict, compile error - check imports/lockfiles
     - **Runtime error**: exception with traceback - walk the stack top-to-bottom
     - **UI/API boundary**: check request/response shape, status codes, serialization
     - **DB/storage**: check schema, migration state, query correctness
     - **External service**: check network, credentials, service health
   - For **regressions**: run `git bisect` to find the introducing commit
   - For **unfamiliar architecture**: spawn the `codebase-analyzer` subagent (or, on
     agents without subagents, analyze inline) to map the call graph before diving in

4. **REDUCE - Minimal failing case**:
   - Strip the failure to the smallest possible reproducer
   - Remove unrelated dependencies, fixtures, or test data

5. **FIX - Root cause only**:
   - Fix the root cause, not the symptom
   - Do not widen exception handlers, comment out assertions, or skip tests to go green

6. **GUARD - Regression test**:
   - Use the `tdd` skill's Prove-It variant to write a test that reproduces the bug
   - Confirm the test failed before the fix and passes after
   - This step is mandatory - a fix without a guard is incomplete

7. **VERIFY - Confirm recovery**:
   - Run the specific failing test: confirm it passes
   - Run the full test suite: confirm no regressions
   - Run the build if applicable: confirm clean build

### Error-Specific Decision Trees

**Test failure**: check fixture setup/teardown order; shared mutable state between
tests; mock/patch scope leaking; for flaky, add retry logging and check async/timing.

**Build failure**: check import errors first (missing module = missing dep or wrong
path); version conflicts in lockfiles; circular imports; run with `--verbose`.

**Runtime error**: walk the traceback bottom (root) to top (caller); TypeError/
AttributeError often means wrong interface assumptions; add logging at the failure
boundary; check recent commits for interface changes.

## Quality Gates

- [ ] Root cause identified (not just symptoms)
- [ ] Fix addresses the root cause, not the symptom
- [ ] Minimal reproducer documented
- [ ] Regression test written and confirmed (failed before fix, passes after)
- [ ] Full test suite passes; build succeeds (if applicable)

## Exit Protocol

```
STATUS
- Error: [error signature]
- Root cause: [one sentence]
- Fix: [what changed]
- Guard: [test name and location]
- Suite: [PASS / FAIL with count]
```
