---
name: polish
description: Parallel code polish - run correctness, security, and simplification reviews concurrently, merge and deduplicate their findings into one severity-ranked report, then auto-fix. Use when the user wants to review and clean up changed code, "polish this", or run a multi-perspective review with fixes applied.
---

# polish - Code Polish

You coordinate three review perspectives in parallel (correctness, security,
simplification), merge their findings into a single deduplicated report, and
auto-fix the issues.

## Orientation

- Determine what to polish: changed files (git diff), user-specified files, or directories
- Three review agents run in parallel - each is read-only and produces a structured report
- After merging, you apply fixes directly (no user approval gate - this is auto-fix)

## Protocol

1. **Resolve scope**:
   - If the user specified files or paths, use those
   - Otherwise run `git diff --name-only` to find changed files on the current branch
   - Filter to relevant file types (.py, .js, .ts, .sh, .md, etc.)
   - If no changed files found, ask the user what to polish

2. **Fan out three review agents in parallel**:
   - `code-reviewer` - bugs, logic errors, quality issues
   - `security-reviewer` - vulnerabilities, injection vectors, secrets
   - `code-simplifier` - unnecessary complexity, dead code, duplication

   > Runtime note: on agents that support isolated subagents (Goose, Claude Code),
   > spawn these three in parallel. On agents without a subagent mechanism (e.g. Pi),
   > perform the three review passes yourself, one at a time, in the main context.

3. **Collate and deduplicate** with the bundled helper:
   - Collect each agent's findings into one JSON array of objects, one per finding:
     `{"file", "line", "severity" (critical|high|medium|low), "perspective", "description"}`
   - Pipe it to the bundled `merge-findings` script, which groups by `file:line`, keeps
     the highest severity, unions the perspectives, and severity-sorts the result:
     ```bash
     echo "$FINDINGS_JSON" | scripts/merge-findings
     ```
     The script is bundled beside this SKILL.md (`scripts/merge-findings`); the resolved
     path is `~/.agents/skills/polish/scripts/merge-findings`. It prints the merged
     findings body used in the report below.

4. **Present unified report** - wrap the script's merged findings with scope, score, and
   summary:
   ```
   ## Polish Report: [scope description]

   ### Score: [X]/100

   [merged findings from `merge-findings` - severity sections, each line:
    [perspectives] `file.py:42` - merged description]

   ### Summary
   [2-3 sentence overall assessment]
   ```

5. **Auto-fix all findings**:
   - Work from highest to lowest severity
   - Apply each fix; read surrounding context to verify correctness
   - Skip any finding that cannot be fixed without changing behavior (note it in the report)

6. **Scoring rubric** (for the report score):
   - Correctness (40 pts), Security (25 pts), Completeness (20 pts), Style (15 pts) = /100

## Quality Gates

- [ ] All three review passes completed and returned findings
- [ ] Findings are deduplicated - no duplicate file:line entries in the final report
- [ ] Report includes a numeric score /100
- [ ] All fixable issues have been auto-fixed; skipped ones are noted

## Exit Protocol

```
HANDOFF
- Done: Polished [N] files, found [X] issues ([Y] critical, [Z] high), auto-fixed [W]
- Decisions: [any findings skipped and why]
- Next: Run tests to verify fixes, or commit changes
```
