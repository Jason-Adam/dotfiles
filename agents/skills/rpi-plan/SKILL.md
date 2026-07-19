---
name: rpi-plan
description: Create a detailed, phased implementation plan through an interactive, skeptical process, writing it to thoughts/plans/ with separated automated and manual success criteria. Use when the user wants to plan a feature, change, refactor, or ticket before implementing - especially when they reference a ticket, spec, or research document to turn into an actionable plan. Plans the work; does not implement it.
---

# RPI: Create Plan

Create detailed implementation plans through an interactive, iterative process. Be
skeptical, thorough, and collaborative to produce high-quality technical specs.

## Your job is to PLAN the implementation. DO NOT implement it.

## Process

### Step 1: Context gathering & initial analysis
1. **Read all mentioned files immediately and FULLY** (tickets, research docs,
   related plans). Never read partially. Do this before spawning any subagents.
2. **Spawn initial research** via subagents (see runtime note below):
   - **codebase-locator** - find all files related to the task
   - **codebase-analyzer** - understand the current implementation
   - **pattern-finder** - find similar features to model after
3. **Read all files** the research surfaces, FULLY, into main context.
4. **Analyze and verify understanding**: cross-reference requirements with actual
   code, identify discrepancies, note assumptions, determine true scope.
5. **Present informed understanding and focused questions**. Only ask what you
   genuinely cannot answer through code investigation.

> Runtime note: on agents that support isolated subagents (Goose, Claude Code),
> spawn `codebase-locator`, `codebase-analyzer`, and `pattern-finder` as parallel
> subagents. On agents without a subagent mechanism (e.g. Pi), perform each role
> yourself inline in the main context.

### Step 2: Research & discovery
- If the user corrects a misunderstanding, DO NOT just accept it - spawn new
  research to verify, read the files they mention, proceed only once verified.
- Spawn parallel subagents for deeper research as needed. Wait for ALL to finish.
- Present findings and design options (with pros/cons) and open questions.

### Step 3: Plan structure
Propose a phase outline (Overview + numbered phases) and get feedback on the
structure BEFORE writing details.

### Step 4: Write the plan
After structure approval, write to `thoughts/plans/YYYY-MM-DD-HHmm-description.md`
(e.g. `2025-01-15-1430-add-auth.md`):

```markdown
# [Feature/Task Name] Implementation Plan

## Overview
[What we're implementing and why]

## Current State Analysis
[What exists now, what's missing, key constraints discovered]

## Desired End State
[Specification of the end state and how to verify it]

### Key Discoveries
- [Important finding with `file:line` reference]
- [Pattern to follow]

## What We're NOT Doing
[Explicitly out-of-scope items, to prevent scope creep]

## Implementation Approach
[High-level strategy and reasoning]

## Phase 1: [Descriptive Name]

### Overview
[What this phase accomplishes]

### Changes Required
#### 1. [Component/File Group]
**File**: `path/to/file.ext`
**Changes**: [Summary]

```[language]
// Specific code to add/modify
```

### Success Criteria
#### Automated Verification
- [ ] Tests pass: `make test`
- [ ] Linting passes: `make lint`
- [ ] Type checking passes

#### Manual Verification
- [ ] Feature works as expected
- [ ] No regressions in related features

**Implementation Note**: After this phase and its automated verification passes,
pause for manual confirmation before proceeding.

---

## Phase 2: [Descriptive Name]
[Similar structure...]

---

## Testing Strategy
### Unit Tests
- [What to test, key edge cases]
### Integration Tests
- [End-to-end scenarios]
```

## Success criteria guidelines
Always split into:
1. **Automated Verification** (scriptable): commands like `make test`, `npm run
   lint`; files that should exist; compilation/type checks.
2. **Manual Verification** (human): UI/UX, performance under real conditions,
   hard-to-automate edge cases.

## Common patterns
- **Database changes**: schema/migration -> store methods -> business logic -> API -> clients
- **New features**: research existing patterns -> data model -> backend -> API -> UI last
- **Refactoring**: document current behavior -> incremental changes -> keep backwards
  compatibility -> include migration strategy

## Be interactive
Confirm understanding before writing. Show structure before details. Only ask
questions code investigation cannot answer. A finished plan has no open questions.
