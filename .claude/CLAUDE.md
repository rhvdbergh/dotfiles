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
- **The conversation is sealed off from the code. NOTHING from our discussion, the plan document, the ticket, or the PR thread may appear in a comment.** Specifically, never:
  - Address me, or any reader, in a comment. No second person ("you'll notice", "as you asked", "note that if you"), no first person ("I chose", "I've left this"), no questions, no hedging at a reader.
  - Answer a question I asked. If I asked something in chat or in a `%%` note, the answer belongs in your reply to me — never in the code.
  - Explain or justify a decision that was discussed. If we debated an approach and picked one, the code contains the approach; the debate goes nowhere. The *only* exception is when the losing option would otherwise look like an obvious improvement to a future reader with no context — then state the constraint impersonally ("the batched call is not usable here: the vendor endpoint caps at 50 ids"), never the discussion ("we went with the loop because you said batching was risky").
  - Reference the plan, the ticket, the review, or the request in any form — no "per the plan", "step 3", "as discussed", "requested change", ticket ids, or dates.
  - Flag something as new, changed, moved, or temporary relative to what existed before. The diff shows that; the comment outlives it.
- The test: if a comment would read as strange or meaningless to someone who finds this file in two years knowing nothing about you, me, or this task, it must not exist. A comment describes the code as it stands, to a stranger, forever.

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
- Every plan file MUST end with the following section, copied verbatim as its final section. This is the one exception to the "rationale + implementation only" rule above. Re-read this section immediately before writing any code from the plan, and treat it as binding during implementation:

  ```markdown
  ## Comment Policy (binding during implementation)

  - Comments explain *why*, never *what*. Code is self-explanatory via naming; a comment restating what a line does is a defect and must be deleted.
  - The ONLY valid comment is a non-obvious constraint, tradeoff, workaround, or gotcha that cannot be recovered from reading the code (e.g. "retrying here because the vendor API silently drops writes under load").
  - **This conversation, this plan, and this ticket are sealed off from the code. NONE of it may appear in a comment.** Never address the reader or use second person ("you'll notice", "as requested"). Never use first person ("I chose", "I've left"). Never answer in a comment a question that was asked in chat or in a `%%` note — that answer goes in the reply, not the code. Never justify a decision by referring to the discussion that produced it. Never cite the plan, a step number, a ticket id, a review, or a date. Never mark anything as new, changed, moved, or temporary.
  - Where a discussed constraint genuinely needs recording, state it impersonally as a fact about the system ("the vendor endpoint caps at 50 ids"), never as history ("we decided to loop instead").
  - Tempted to explain what code does? Rename the variable/function instead and write no comment.
  - Before finishing, re-read every comment added or touched. Delete any that fails these rules, and any that would read as strange or meaningless to a stranger finding this file in two years with no knowledge of this task.
  ```

@RTK.md
