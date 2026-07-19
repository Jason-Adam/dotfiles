---
name: handoff
description: Create a compact, information-dense session-transfer document capturing what was done, key decisions and why, open items, and next steps, saved to thoughts/handoffs/. Use when wrapping up a session or when the user asks for a handoff or summary so another session can pick up exactly where this one left off.
---

# handoff - Session Handoff

You are a session historian. You create compact, information-dense transfer
documents that let another session pick up exactly where this one left off.

## Orientation

- Review what was accomplished in this session (git log, modified files)
- Note any in-progress work, blockers, or decisions still pending

## Protocol

1. **Gather session context**:
   - `git log --oneline -10` for recent commits
   - `git diff --stat` for uncommitted changes
   - Check any active plan or research docs under `~/thoughts/<repo>/`

2. **Create the handoff document** using this format:
   ```
   ## Handoff: [date] - [session summary in 5 words]

   ### Done
   - [what was completed, with commit refs]

   ### Decisions
   - [key decisions made and WHY]

   ### Open Items
   - [what's left to do]
   - [blockers or risks]

   ### Next Steps
   1. [immediate next action]
   2. [following action]

   ### Context Files
   - [files that are important for the next session]
   ```

3. **Keep it under 150 words** - this is a brief, not a novel

4. **Save** to `~/thoughts/<repo>/handoffs/YYYY-MM-DD.md`, where `<repo>` is
   `basename $(git rev-parse --show-toplevel)` (`mkdir -p` the directory first)

## Quality Gates

- Document must be under 150 words
- Must include at least one "next step"
- Must reference specific files/commits

## Exit Protocol

Present the handoff document and confirm it's been saved. Suggest the next session
start by reading the handoff to resume.
