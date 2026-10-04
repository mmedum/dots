---
paths:
  - "**/*_test.go"
  - "**/*.{test,spec}.{ts,tsx,js,jsx,mjs,cjs}"
  - "**/test_*.py"
  - "**/*_test.py"
  - "**/{test,tests,__tests__,testdata}/**"
---
# Testing standard

Applies to all code I work on. A project's own CLAUDE.md wins where it
says more. Evidence: `~/research/reports/Testing best practices.md`,
with every quote and URL in
`~/research/research_notes/Testing best practices/verification.md`.
Tiers: A = peer-reviewed and replicated or at scale, B = industrial
report or published style guide, C = named expert opinion.

## What a suite is for

A suite earns its keep by failing when behavior breaks and by staying
green when only structure changes. Its size and its coverage prove
neither. Covered code can be completely unchecked: studies found covered
methods whose bodies could be deleted without failing any test, in 1% to
46% of methods, across every project studied (A).

"Too many tests" is a claim to measure before acting on it. The first
repository measured (2026-10-01) had a 0.5 test/source ratio and 7 s of
runtime. Its real weakness was missing boundary and error-path
assertions, not excess volume.

## Rules

1. **A test must be able to fail.** Prove it once by breaking the code
   it watches, one change at a time, and check that the failure you see
   is the one you caused. For a package, run a mutation tester
   (`gremlins`, with `GOFLAGS=-count=1`) and read what LIVED. A lived
   mutant is a prompt, not a mandate. Don't write a test only to kill a
   mutant on a line nobody would get wrong. (A)

   A mutant can turn a test's fake into the real thing, by flipping an
   `if opener == nil` and launching a browser, for example. Run mutation
   with the side effects stubbed: a no-op `xdg-open` first on `PATH`, no
   live credentials in the environment, and a scratch copy of the repo.
2. **State the expected value literally.** Never compute it from the
   code under test or from logic that code shares. A golden file that
   was regenerated and not read counts as a computed expectation, so
   review a golden diff like code. Deriving *what to check over* from
   the code is fine: the tools, the settings, the files. Deriving the
   *answer* is not. (A/B)
3. **One test per behavior, not per function.** Name the behavior. Use
   table rows when they share one behavior and one checking rule. (B)
4. **Test through the public surface.** Check state, not call order.
   Prefer real implementations, or an in-memory fake behind a real
   transport, to mocks. Same-package tests of a helper with real logic
   are fine. Don't add test-only back doors. (B)
5. **Assert the contract, not the prose.** Match errors by type or
   class token, not by message text, unless the text is the contract.
   Substring checks on descriptions or instructions are change
   detectors. Keep them only where the wording is a safety property. (B)
6. **Test the edges.** Exact limits (`>` against `>=`, n and n+1),
   empty and maximal inputs, and every error path that changes what
   the caller sees. This is where mutants survive in practice. (A)
7. **Fuzz what parses outside bytes,** and keep a few example tests
   next to each fuzz target. Fuzzing supplements example tests; it does
   not replace them. (A/B)
8. **Add a test when a bug escapes.** It pins the mistake you actually
   made. (C)
9. **No flaky test stays.** Fix it or delete it the week it is seen.
   Run CI with `-race` and `-shuffle=on`. (A/B)
10. **Failure messages say what ran, with which input, what came back
    and what was wanted.** Use `t.Errorf`, compare with `cmp.Diff`, and
    no assertion library. (B)
11. **Coverage finds gaps; it is not a target.** Read the uncovered
    lines of a change in review. A floor is per package, below what the
    package reaches, and never raised as a goal. (A/B)

## Deleting tests

Delete a test only for a named reason, and put the reason in the commit:

- change detector: it fails when structure changes, not when behavior
  breaks
- tests trivial code
- its expectation is derived from the code under test
- duplicates the same check at another level
- flaky and unfixed

"No unique coverage" or "no unique mutant kill" starts a review. It is
not a reason on its own. Suites reduced to keep the same coverage or
mutant kills still missed 9.5–52.2% of later real build failures (A).
In the first repository measured, removing tests with no unique
coverage as a set cost 15 points of mutation score.

A test that never fails is not useless for that reason alone. (A)

## Checkers, gates and linters

A gate is a test, so these rules apply to it too.

- For each rule it enforces: one input it must accept, one minimally
  broken input it must reject with the named message, and a literal
  floor on how much it read. A checker that reads nothing passes
  everything. Keep the floor a stated number, never a count read back
  from the same scan.
- Assert both directions, the way Go's `analysistest` does. The gate
  fires where it should, and it stays silent everywhere else.
- Collapse tests that restate the gate's own allow-list or regex. Those
  are change detectors.
- Collapse near-identical reject cases into one table. Keep only rows
  that exercise a different path through the matching logic.
- Don't delete a reject case because another gate also catches the same
  input. The two gates can drift apart.
- A new rule earns a gate when it has been broken once, or when
  breaking it is severe and silent. Otherwise one test is enough.
