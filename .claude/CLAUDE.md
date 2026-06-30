Always address me as Mr. Plankton.

## Rules

- Always prefer a Clean Code style.
- Always prefer clear, unambiguous naming over leaving comments. The code should be understandable without having to resort to comments.
- Always prefer DRY code. If the same pattern repeats more than two times, extract the code into a reusable method, function, or component.
- For TypeScript, always place components in their own files.
- If a string is being used more than once (e.g., to match on), extract that string as a constant (when it's longer) or a type (if it's shorter).
- When working on a project, do NOT update ClickUp tickets automatically, even if permissions are set. If multiple task updates need to be done, you can ask once whether the updates need to happen (i.e., you don't have to ask for each task), but permission always needs to be given in a session before updating, creating, or in any way modifying ClickUp tasks.
- NEVER create Git commits, push to or pull from origin, or make pull requests. I will always do this myself. You can make branches, but ONLY if I ask you to. You are allowed to create worktrees (locally, of course).

## Questions

- When I start a message with `Q` (that is, Q followed by a space), I am only asking a question that you should answer. Do NOT make any code changes — this includes edits, file creation, and deletions. You may use read-only tools (Read, Bash for grep/git/build output) to investigate and inform your answer, but you must stop at reporting findings. Do not fix anything. This applies even in autonomous/auto mode.
- Whenever I say "own words" (any capitalization), stop immediately and restate my request back to me in your own words — what you understand me to be asking and nothing else. Do NOT read files, run tools, make code changes, suggest implementations, or reason toward a solution. Just confirm your understanding of the request.
- Whenever I end a question or statement with "examples" or "give examples", answer the question in really easy to understand terms and use examples to clarify.

## Investigation

- Before making code edits based on assumptions or prior context, verify the current state of the relevant files and behavior. Do not act on theoretical analysis without empirical investigation.

## Testing

- After modifying code, run the relevant tests and a build/type check before declaring the task complete. For .NET projects, verify the build; for TS, run tsc on modified files.
- When adding tests, follow existing sibling test patterns in the codebase (e.g., BankingGroupProjectionTests, screeningResults action tests) — search for similar tests before writing new ones.

## Git Worktrees

- After creating a Git worktree, look for a .worktreeinclude file; if it exists, copy over the necessary files.
- Always place the git worktree directory as a sibling to the directory from which we are branching from.

## Planning

- When planning, I will edit the `.md` file that is created as a plan inline. I will add comments prefaced with `%%` to the document - these should alter the plan when you act on them. Explicitly state when you start implementing the plan that my notes are being respected.
- When I simply enter %% into the prompt, it means that I want you to read my comments in the file and address them. When you encounter a %% marker, don't just update this in situ in the plan document, but repeat my statements (they may be summarized) in our conversation (at the very end) and address them there. You can also work this into the plan document in situ, but I want them grouped at the end so I can easily see what I asked and what the answers were.
- When in plan mode, if I ask to save a file to memory, prepend the file with `mem-` - note that I will refer to these files as mem- files, if I need you to look them up
- When saving the plan (post plan-mode), rename it inside `~/.claude/plans/` using the format `<repo>_<YYYY-MM-DD>_<descriptive-slug>.md`. Derive `<repo>` from `git rev-parse --show-toplevel` (basename), falling back to `no-repo` when not in a git repo. Use today's date. Always tell me the final filename.
- The `mem-` prefix convention layers on top of the filename format: `mem-<repo>_<YYYY-MM-DD>_<slug>.md`.

@RTK.md
