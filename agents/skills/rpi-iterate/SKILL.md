---
name: rpi-iterate
description: Update an existing implementation plan in thoughts/plans/ based on feedback, using surgical edits grounded in codebase reality and optional targeted research. Use when revising, refining, expanding, or re-scoping a plan that already exists - adding a phase, updating success criteria, splitting phases, or adjusting scope.
---

# RPI: Iterate Plan

Update existing implementation plans based on user feedback. Be skeptical,
thorough, and ensure changes are grounded in actual codebase reality.

## Process

### Step 1: Read and understand the current plan
1. Read the existing plan file COMPLETELY (no limit/offset). Understand its
   structure, phases, scope, success criteria, and approach.
2. Understand the requested changes: what to add/modify/remove, whether they need
   codebase research, and the scope of the update.

### Step 2: Research if needed
Only spawn research if the changes require new technical understanding. If they do:
- Spawn subagents in parallel: **codebase-locator**, **codebase-analyzer**,
  **pattern-finder** (see runtime note below).
- Read any new files they surface FULLY into main context.
- Wait for ALL subagents to complete before proceeding.

> Runtime note: on agents that support isolated subagents (Goose, Claude Code),
> spawn these as parallel subagents. On agents without a subagent mechanism
> (e.g. Pi), perform each role yourself inline in the main context.

### Step 3: Present understanding and approach
Before editing, confirm:
```
Based on your feedback, I understand you want to:
- [Change 1 with specific detail]

My research found:
- [Relevant code pattern or constraint]

I plan to update the plan by:
1. [Specific modification]

Does this align with your intent?
```
Get confirmation before proceeding.

### Step 4: Update the plan
- Make **surgical** edits, not wholesale rewrites. Preserve good content.
- Keep `file:line` references accurate. Update success criteria if needed.
- Maintain consistency: new phases follow the existing pattern; scope changes
  update "What We're NOT Doing"; approach changes update "Implementation Approach".
- Preserve the automated vs manual success-criteria split.

### Step 5: Present changes
```
I've updated the plan at `thoughts/plans/[filename].md`

Changes made:
- [Specific change 1]

The updated plan now:
- [Key improvement]

Would you like any further adjustments?
```

## Guidelines
- **Be skeptical**: question vague or problematic requests; verify feasibility with
  code research; point out conflicts with existing phases.
- **Be surgical**: precise edits only; research only what the change requires.
- **Be thorough**: read the entire plan first; keep success criteria measurable.
- **Be interactive**: confirm before editing; allow course corrections.
- **No open questions**: if a change raises a question, ASK and resolve it before
  updating. Every change must be complete and actionable.
