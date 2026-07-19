---
name: rpi-research
description: Research and document how a codebase implements a topic using parallel subagents, then write a structured research document to thoughts/research/. Use when you need to map or understand existing code before planning a change, or when the user asks to research, investigate, trace, or explain how something works in the codebase. Documents what EXISTS - it does not critique or suggest changes.
---

# RPI: Research Codebase

Produce a comprehensive, evidence-backed research document for a topic by spawning
parallel subagents and synthesizing their findings.

## Your only job: document the codebase as it exists today

- DO NOT suggest improvements or changes
- DO NOT critique the implementation
- ONLY describe what exists, where it exists, and how it works
- You are creating a technical map, not a code review

## Workflow (execute in order)

### 1. Read mentioned files first
If the user names specific files, read them FULLY (no limit/offset) before anything else.

### 2. Decompose the question, and check prior thoughts
Break the query into 3-5 specific research areas.

Then check what prior context already exists: spawn `thoughts-locator` to find
related documents in `~/thoughts/` (past research, plans, handoffs). For any relevant
hit, spawn `thoughts-analyzer` to extract its still-applicable decisions and
constraints. Fold that context in so you don't re-derive what's already known.

### 3. Spawn parallel subagents
Dispatch these roles, in parallel, one focused question each:

- **codebase-locator** - find WHERE files and components live
- **codebase-analyzer** - understand HOW specific code works
- **pattern-finder** - find existing examples of a pattern to model after
- **web-search-researcher** - external/current info (docs, releases, best practices)
  when the topic needs knowledge beyond this codebase

> Runtime note: on agents that support isolated subagents (Goose, Claude Code),
> spawn these (and `thoughts-locator`/`thoughts-analyzer` above) as parallel
> subagents. On agents without a subagent mechanism (e.g. Pi), perform each role
> yourself inline in the main context, keeping the same separation of concerns.

Give each agent ONE focused question. Tell it what you're looking for, not how to
search. Request `file:line` references.

### 4. Wait for all results, then synthesize
Wait for ALL subagent tasks to finish. Compile and connect findings across
components. Resolve contradictions. Note gaps.

### 5. Create and write the research document
Create the file with the helper CLI:

```bash
thoughts new research "<topic>"
```

This writes `~/thoughts/<repo>/research/YYYY-MM-DD-HHmm-<slug>.md` with the metadata
frontmatter (date, git_commit, branch, repository) already stamped, and prints the
path. Write the findings into that file under these sections, then set
`status: complete` in the frontmatter:

```markdown
## Research Question
[Original query]

## Summary
[High-level findings answering the question]

## Detailed Findings

### [Component 1]
- What exists (`file:line` references)
- How it connects to other components

## Code References
- `path/to/file.py:123` - Description

## Open Questions
[Areas needing further investigation]
```

### 6. Present summary
Show the user a concise summary with key file references. Ask if they have
follow-up questions; for follow-ups, spawn new subagents and append a
`## Follow-up: [topic] (YYYY-MM-DD)` section, then re-save.

## Remember
- Use subagents for research, not just your own tools
- Document what IS, not what SHOULD BE
- Include specific `file:line` references
- Write the doc to `~/thoughts/<repo>/research/`
