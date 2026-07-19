---
name: create-pr
description: Analyze the full branch diff, write a thorough PR description that honors the repo's existing PR template (or a slim default), and open the pull request via gh. Use when the user wants to create or open a pull request or "make a PR". Never pushes from or targets main/master.
---

# create-pr - Create Pull Request

You analyze the full branch diff, write a thorough PR description, and create the PR
via `gh`. You respect the repository's existing PR template if one exists. You never
push from or create PRs against main/master.

## Orientation

- Run `git branch --show-current` - if on main/master, abort immediately
- Run `git status` to check for uncommitted changes
- Check if a PR already exists for this branch with `gh pr view`
- Locate the repo's PR template (if any)

## Protocol

1. **Branch safety**:
   - Run `git branch --show-current`
   - If on `main` or `master`: STOP. Tell the user they need a feature branch. Abort.

2. **Handle uncommitted changes**:
   - Run `git status`
   - If there are uncommitted changes, commit them first using the `gc` skill, then continue

3. **Check for existing PR**:
   - Run `gh pr view --json url,number,title,state 2>/dev/null`
   - If a PR already exists, tell the user and ask if they want the description updated instead

4. **Push the branch**:
   - Verify once more with `git branch --show-current` that you are NOT on main/master
   - Push: `git push -u origin HEAD`
   - If you get an error about no default remote, instruct the user to run `gh repo set-default`

5. **Find PR template**:
   - Check these locations in order:
     - `.github/pull_request_template.md`
     - `.github/PULL_REQUEST_TEMPLATE.md`
     - `.github/PULL_REQUEST_TEMPLATE/` directory (if it exists, use the default)
     - `docs/pull_request_template.md`
   - If a template is found, read it and use its structure
   - If no template exists, use this slim default:
     ```
     ## Summary
     <!-- What does this PR do and why? -->

     ## Changes
     <!-- Key changes, organized by area -->

     ## Test Plan
     <!-- How to verify this works -->
     ```
   - Do NOT create a template file in the repo - just use the default inline

6. **Gather context**:
   - Detect the default branch: `git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@'` - fall back to `main`
   - Get the full diff: `git diff <default-branch>...HEAD`
   - Get commit history: `git log <default-branch>..HEAD --oneline`
   - Read through the diff carefully - understand every change

7. **Analyze changes**:
   - Understand the purpose and impact of each change
   - Identify user-facing changes vs internal implementation
   - Look for breaking changes or migration requirements
   - Read any referenced files not shown in the diff

8. **Write the PR description**:
   - Fill out each section from the template (repo template or default) thoroughly
   - Be specific about what changed and why; focus on the "why"
   - If touching multiple components, organize by area
   - Keep it thorough but scannable

9. **Create the PR**:
   - Write the description to a temp file
   - Create: `gh pr create --title "<concise title>" --body-file <temp-file> --assignee "@me"`
   - Clean up the temp file
   - Return the PR URL to the user

## Quality Gates

- [ ] Not on main or master
- [ ] All changes are committed and pushed
- [ ] PR description follows the repo's template (or slim default)
- [ ] Description covers what, why, and how to test
- [ ] PR is created and URL is returned

## Exit Protocol

Return the PR URL. If any issues came up (existing PR, uncommitted changes handled),
summarize what was done.
