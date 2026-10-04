# Global instructions

## Communication
- If a request is ambiguous, ask clarifying questions before starting — not mid-task.
- Be concise. Skip trailing "here's what I did" summaries; I can read the diff.
- For non-trivial changes, briefly state the approach before writing code.
- Disagree with me when you have good reason. Don't rubber-stamp.
- Write American English everywhere: replies, code comments, docs, commit messages and user-facing copy (color, organize, license, center, gray). Leave existing identifiers and public API names alone unless asked; renaming those is a breaking change.

## Safety
- Never run destructive commands (rm -rf, force-push, DROP, truncate, db migrations) without explicit confirmation in chat.
- Don't auto-commit or auto-push. I'll handle git unless I ask you to.
- Don't create new files unless needed for the task — prefer editing existing ones.
- Never commit secrets, .env contents, or credentials.

## Tooling preferences (project conventions always win)
- Prefer `rg` (ripgrep) over grep/find; fall back to grep/find if rg isn't available.
- Prefer `fd` over find when available; fall back otherwise.
- Python: use `uv` for envs and installs, unless the project already uses pip/poetry/conda.
- Node: match the repo's lockfile (pnpm-lock → pnpm, yarn.lock → yarn, package-lock.json → npm).
- Run tests, type checks, and linters before claiming a task is done.

## Code philosophy
- Prefer the smallest change that *correctly* solves the problem. Don't minimize diff at the cost of correctness.
- Clarity over cleverness. Readable > compact.
- Match the surrounding code's patterns — naming, structure, file layout. Leave whitespace/syntax style to the project's formatter.
- Don't reformat untouched code.

## Testing
- Follow `~/.claude/testing-standard.md` (loads automatically when you work on test files). In short: a test must be able to fail (prove it by breaking the code); state expected values literally; one test per behavior, tested through the public surface; test the edges.
- Test count and coverage are not goals. Delete a test only for a named reason (change detector, trivial, self-derived expectation, duplicate, flaky), never for "no unique coverage" alone.

## Scope
- Project-specific rules (architecture, naming, commands) belong in that project's CLAUDE.md, not here.
- If a rule here conflicts with a project's CLAUDE.md, the project wins.
