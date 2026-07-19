---
name: rpi-implement
description: Implement an approved technical plan from thoughts/plans/ phase by phase, checking off progress in the plan file and pausing for verification between phases. Use when executing an existing implementation plan, resuming partially-completed work, or when the user points to a plan file and asks to build it.
---

# RPI: Implement Plan

Implement an approved plan from `thoughts/plans/`. Plans contain phases with
specific changes and success criteria.

## Getting started
Given a plan path:
- Read the plan COMPLETELY and check for existing checkmarks (`- [x]`)
- Read the original ticket and all files the plan mentions
- **Read files fully** - never use limit/offset; you need complete context
- Think about how the pieces fit together
- Create a todo list to track progress
- Start implementing once you understand what's needed

If no plan path is provided, ask for one.

## Implementation philosophy
Plans are carefully designed, but reality can be messy. Your job:
- Follow the plan's intent while adapting to what you find
- Implement each phase fully before moving to the next
- Verify your work makes sense in the broader codebase context
- Update checkboxes in the plan file as you complete sections

**Trust the plan - don't re-search documented items.** If the plan gives exact
paths, code blocks, or changes, use them directly. Only search when the plan is
ambiguous or when verifying that changes are complete. Use subagents sparingly -
mainly for targeted debugging or exploring unfamiliar territory.

## Handling mismatches
If reality doesn't match the plan, STOP and think about why, then present it:
```
Issue in Phase [N]:
Expected: [what the plan says]
Found: [actual situation]
Why this matters: [explanation]

How should I proceed?
```

## Verification after each phase
1. **Run automated checks** from the plan's success criteria. Fix issues before
   proceeding. Update progress in both your todos and the plan file - check off
   completed automated items in the plan itself.
2. **Pause for human verification**:
   ```
   Phase [N] Complete - Ready for Manual Verification

   Automated verification passed:
   - [checks that passed]

   Please perform the manual verification steps from the plan:
   - [manual items]

   Let me know when manual testing is complete so I can proceed to Phase [N+1].
   ```
3. **Do NOT check off manual items** until the user confirms.

If told to run multiple phases consecutively, skip the pause until the last phase.
Otherwise assume one phase at a time.

## Resuming work
If the plan has existing checkmarks: trust completed work, pick up from the first
unchecked item, and verify prior work only if something seems off.

Remember: you're implementing a solution, not just checking boxes. Keep the end
goal in mind and maintain forward momentum.
