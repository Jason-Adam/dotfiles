---
name: resume-handoff
description: Resume work from a handoff document - read it fully, verify the repo's current state against it, reconcile any drift, and propose a concrete next-step plan before acting. Use when picking up a prior session, continuing from a handoff, or when the user points to a handoff file or asks to resume where they left off.
---

# resume-handoff - Resume From a Handoff

You resume work from a handoff document (written by the `handoff` skill). Handoffs
contain context, decisions, and next steps from a previous session that must be
understood and verified against the current repo state before continuing.

Handoffs live in the central thoughts directory:
`~/thoughts/<repo>/handoffs/YYYY-MM-DD.md`, where `<repo>` is
`basename $(git rev-parse --show-toplevel)`.

## Initial Response

- **If a handoff path was provided**: read it FULLY immediately, then read any
  research/plan documents it links to under `~/thoughts/<repo>/{research,plans}/`
  (read these critical files directly, not via a subagent).
- **If no path was provided**: run `~/.agents/scripts/thoughts latest handoff` to get the most recent
  handoff path (empty output means none exist - ask which handoff to resume).

## Process

### Step 1: Read and analyze the handoff

Read the handoff completely (no limit/offset) and extract: tasks and their statuses,
recent changes, decisions, open items, next steps, and referenced artifacts. Read
the referenced research/plan/artifact files fully.

### Step 2: Verify current state against the handoff

Never assume the handoff still matches reality. Verify:
- Do the "recent changes" it describes still exist in the code? (present / missing / modified)
- Are the documented learnings and `file:line` references still valid?
- Has the codebase diverged (new related code, refactors, regressions) since?

Use `git log`/`git diff` and targeted reads to confirm.

### Step 3: Present analysis and proposed plan

```
I've analyzed the handoff from [date]. Current situation:

**Original Tasks:**
- [Task]: [handoff status] -> [current verification]

**Learnings Validated:**
- [learning w/ file:line] - [still valid / changed]

**Recent Changes Status:**
- [change] - [present / missing / modified]

**Recommended Next Actions:**
1. [most logical next step]
2. [second priority]

**Potential Issues:**
- [conflicts, regressions, or missing dependencies found]

Shall I proceed with [action 1], or adjust the approach?
```

Get confirmation before proceeding.

### Step 4: Execute

Create a todo list from the confirmed action items, then start the first task,
applying the patterns and avoiding the pitfalls the handoff documented. Consider
writing a fresh handoff (via the `handoff` skill) when you stop.

## Common Scenarios

- **Clean continuation**: all changes present, no conflicts - proceed with next steps.
- **Diverged codebase**: some changes missing/modified - reconcile before continuing.
- **Incomplete work**: tasks were `in_progress` - finish those before new work.
- **Stale handoff**: significant time/refactoring since - re-evaluate the strategy.

## Guidelines

- Be thorough: read the whole handoff and verify every mentioned change
- Be interactive: present findings and get buy-in before starting
- Validate before acting: confirm file references and patterns still hold
