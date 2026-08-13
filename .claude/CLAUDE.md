@WISPLET.md

Always address me as Mr. Plankton.

## Rules

- Always prefer a Clean Code style.
- Always prefer DRY code. If the same pattern repeats more than two times, extract the code into a reusable method, function, or component.
- For TypeScript, always place components in their own files.
- If a string is being used more than once (e.g., to match on), extract that string as a constant (when it's longer) or a type (if it's shorter).
- When working on a project, do NOT update ClickUp tickets automatically, even if permissions are set. If multiple task updates need to be done, you can ask once whether the updates need to happen (i.e., you don't have to ask for each task), but permission always needs to be given in a session before updating, creating, or in any way modifying ClickUp tasks.
- NEVER create Git commits, push to or pull from origin, or make pull requests. I will always do this myself. You can make branches, but ONLY if I ask you to. You are allowed to create worktrees (locally, of course).
- Use US spelling rather than British spelling.

## Worktrees

- Before implementing any ticket, run `git rev-parse --show-toplevel` and `pwd` and confirm you are in the correct pre-created feature worktree. Never build or edit ticket code in the main repo checkout. If a worktree for the ticket exists, cd into it first and state which path you are working in.
- After creating a Git worktree, look for a .worktreeinclude file; if it exists, copy over the necessary files.
- Always place the git worktree directory as a sibling to the directory from which we are branching from.

## Remote vs Local Execution

- When I am working on a remote Windows server (SQL Server, SSIS, prod services, GitHub runner), do NOT execute Bash/git commands locally. Output copy-pasteable commands as a single block I can run on that machine. Ask "run here or paste to server?" if ambiguous.

## Comments

- Write comments to explain *why*, never *what*. Code should be self-explanatory via naming; a comment restating what a line does is a bug.
- The only valid reason to comment: a non-obvious constraint, tradeoff, workaround, or gotcha that isn't recoverable from reading the code itself (e.g. "retrying here because the vendor API silently drops writes under load").
- Never leave comments that narrate what was done in response to a prompt, task, or conversation (e.g. "added for X flow", "fixed per user request", "changed to address Y issue"). Comments must stand alone as if no conversation ever happened — they describe the code's own logic, not its history.
- If you're tempted to write a comment explaining what code does, rename the variable/function instead and delete the comment.

## Questions

- When I start a message with `Q` (that is, Q followed by a space), I am only asking a question that you should answer. Do NOT make any code changes — this includes edits, file creation, and deletions. You may use read-only tools (Read, Bash for grep/git/build output) to investigate and inform your answer, but you must stop at reporting findings. Do not fix anything. This applies even in autonomous/auto mode.
- Whenever I say "own words" (any capitalization), stop immediately and restate my request back to me in your own words — what you understand me to be asking and nothing else. Do NOT read files, run tools, make code changes, suggest implementations, or reason toward a solution. Just confirm your understanding of the request.
- Whenever I end a question or statement with "examples" or "give examples", answer the question in really easy to understand terms and use examples to clarify.

## Subagents

- Default to using subagents for implementation when the work splits cleanly by file (each subagent owns distinct files with no shared state or interfaces) AND the task is large enough that setup overhead is a small fraction of the total work.
  - Qualifies, e.g.: adding a loading state to 6 unrelated page components; writing tests for 8 independent modules; applying the same migration across many independent services.
  - Does not qualify, e.g.: renaming a shared interface and updating all call sites; a refactor that ripples through shared types/config; small tasks (a few tool-call rounds of work or less); anything needing one coherent mental model to get right (architecture decisions, subtle bug fixes).
- For small or tightly coupled tasks, implement directly instead of splitting for splitting's sake.
- Before starting a task near this boundary, state the file split and the decision (subagents vs. direct) before acting, so it can be corrected early rather than after tokens are spent.
- Always verify subagent outputs compose correctly (e.g., compiles, types align, no conflicting edits) before considering the task done.

## Investigation

- Before making code edits based on assumptions or prior context, verify the current state of the relevant files and behavior. Do not act on theoretical analysis without empirical investigation.

## Verifying Claims

- Never assert a codebase convention, capability, or "this is unverifiable" without first grepping/reading the actual source, the masterplan docs in `./docs`, or official vendor documentation. Cite the file:line or doc URL that supports each claim. If evidence is absent, say "no evidence found" rather than inferring.

## Testing

- After modifying code, run the relevant tests and a build/type check before declaring the task complete. For .NET projects, verify the build; for TS, run tsc on modified files.
- When adding tests, follow existing sibling test patterns in the codebase (e.g., BankingGroupProjectionTests, screeningResults action tests) — search for similar tests before writing new ones.
- After any insertion or multi-edit sequence, re-Read the file before the next Edit — do not target line numbers from a pre-edit view.
- Always compile/build and run the affected test suite before reporting a fix as done; report the pass count.

## Codegen

- When a project uses codegen to produce generated client files (e.g., nswag/openapi/Swagger generating `apiClientGenerated.ts`): never hand-write substitute code for what codegen would produce, in any situation — including when the generated file is missing or stale. If a task requires the generated output to exist or be up to date, finish any backend changes first, then stop and ask me to run codegen manually before continuing.

## Planning

- When planning, I will edit the `.md` file that is created as a plan inline. I will add comments prefaced with `%%` to the document - these should alter the plan when you act on them. Explicitly state when you start implementing the plan that my notes are being respected.
- When I simply enter %% into the prompt, it means that I want you to read my comments in the file and address them. When you encounter a %% marker, don't just update this in situ in the plan document, but repeat my statements (they may be summarized) in our conversation (at the very end) and address them there. You can also work this into the plan document in situ, but I want them grouped at the end so I can easily see what I asked and what the answers were.
- When in plan mode, if I ask to save a file to memory, prepend the file with `mem-` - note that I will refer to these files as mem- files, if I need you to look them up
- When saving the plan (post plan-mode), rename it inside `~/.claude/plans/` using the format `<repo>_<YYYY-MM-DD>_<descriptive-slug>.md`. Derive `<repo>` from `git rev-parse --show-toplevel` (basename), falling back to `no-repo` when not in a git repo. Use today's date. Always tell me the final filename.
- The `mem-` prefix convention layers on top of the filename format: `mem-<repo>_<YYYY-MM-DD>_<slug>.md`.
- Before resuming any saved plan, re-verify it against current code and the masterplan (plans go stale after other tickets land). State up front whether the plan is current, stale, or already implemented.
- When writing RFCs/plans, include rationale + implementation only — no "Open Questions" section unless I ask.

@RTK.md
