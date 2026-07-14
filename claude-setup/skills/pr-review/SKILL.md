---
name: pr-review
description: Deep, verification-first review of any GitHub PR in two gated phases. Phase 1 judges thoughtfulness and soundness (did the author reason about the problem, document it, follow the repo's guidelines); only if that passes does phase 2 run the sized bug hunt via the /code-review workflow, with independent verification of every finding. Use when the user asks for a deep or thorough review of a PR, or says "review PR #N". Drafts kind PR comments posted only on approval.
---

# PR Review

Review a GitHub PR in an isolated worktree, in two gated phases:

1. **Thoughtfulness and soundness** (cheap, manual): did the author reason about what they
   are fixing, is it documented properly, does it follow the repo and team guidelines.
2. **Bug hunt** (expensive, sized): only if phase 1 ticks. Fan out to the `/code-review`
   workflow at a tier chosen from the diff size, then independently verify and correct
   what it returns, and add the angles it under-weights.

Verification-first throughout. Post NOTHING until the user approves each comment one at a
time.

The target PR number is in the skill args. If absent, ask for it (and the repo/branch if
ambiguous) before starting.

## Setup

- `gh pr view <N> --json number,title,headRefName,baseRefName,author,additions,deletions,changedFiles,body`
- From the repo root, fetch the head ref and create a worktree:
  `git fetch origin <headRefName> && git worktree add .claude/worktrees/review-pr-<N> <headRefName>`.
- Diff against the PR's ACTUAL base (`origin/<baseRefName>...HEAD`, not assumed master) and
  read EVERY changed file in full, not just the hunks.
- Check branch position: `git rev-list --left-right --count origin/<baseRefName>...HEAD`
  (is it behind its base?).

## Phase 1: thoughtfulness and soundness

This phase is a manual pass, no fan-out. It answers one question: is this PR a considered
piece of work, or code thrown at a symptom? Work through:

- **Reconstruct the intent.** From the PR title/body, linked ticket or issue, and commit
  messages, state in one or two sentences what problem this solves and why this approach.
  If you cannot, the PR body is inadequate: that is itself a finding, usually a blocker for
  anything non-trivial.
- **Root cause vs symptom.** For a fix: does the change address the cause, or paper over
  the manifestation? Is there evidence the author understood the bug (a repro, an analysis
  in the ticket or body, a regression test that fails without the fix)? For a feature: is
  the design reasoned (alternatives weighed, placement justified) or the first thing that
  compiled?
- **Diff matches stated intent.** Every hunk should serve the stated purpose. Flag drive-by
  refactors, unrelated changes smuggled in, debug leftovers, commented-out code, dead code.
- **Documentation.** PR-body claims must match the committed files (a PR description can
  disagree with the code; when it does, flag the gap, never paper over it). Behaviour
  changes must update their docs/docstrings in the SAME PR. New config, flags, or endpoints
  must be documented. Update the changelog if the repo keeps one. Numbers or results quoted
  in the PR body must be traceable to a source (file, command, run).
- **Repo and team guidelines.** Find what actually governs this repo and judge against
  that, not generic taste: `CONTRIBUTING.md`, root and directory-level `CLAUDE.md`,
  `.github/PULL_REQUEST_TEMPLATE.md`, a project spec (`PROJECT_SPEC.md`, ADRs, design
  docs), lint/format configs, commit-message conventions. When explicit guidelines are
  thin, infer the norm from adjacent code and a few recently merged PRs
  (`gh pr list --state merged --limit 10`).
- **Spec agreement**, when the repo has an authoritative spec: for every change, "do the
  code and the spec agree, yes or no?" A behaviour change must update its matching spec
  section in the same PR; anything the spec marks as planned that this PR builds must lose
  the planned label.
- **Tests.** Does the change carry tests per the repo norm? A bug fix should carry a
  regression test; new pure logic should be covered.

**The gate:** if this phase surfaces fundamental problems (approach not reasoned, diff
contradicts the stated intent, required docs or tests absent, guidelines ignored), STOP.
Deliver the phase-1 findings, draft the comments, and ask whether to run the bug hunt
anyway; do not spend on a fan-out for a PR that needs rework first. Minor nits (a typo,
soft wording) do not block phase 2; carry them into the final output.

## Phase 2: size the PR and pick the effort tier (do this before any fan-out)

The finding stage is the expensive part and it does NOT auto-scale to PR size: xhigh always
spawns ~10 finders plus one verifier per distinct finding location, and every agent reads
the full diff and the files it touches. So choose the tier from the diff size first.

- Size it: `gh pr view <N> --json additions,deletions,changedFiles`; note how many of the
  changed files are real source vs generated/lockfiles/fixtures.

| PR size (rough) | Finding approach |
| --- | --- |
| Docs only, or < ~50 changed lines | One manual pass (no workflow); spot-verify by hand. |
| Small to moderate (≲ 10 source files, ≲ ~600 lines) | `/code-review` at **high** (or `/review` medium). |
| Large (many files / thousands of lines) | xhigh, but scope it: review the source files only (skip generated/lockfiles and say so), and consider chunking by area across several runs. |

- Cost calibration (re-verify the current model price with the `claude-api` skill; do not
  trust a baked-in number): on Opus 4.8 at roughly $5 / 1M input and $25 / 1M output, a
  **tiny ~500-line PR at xhigh ran ~47 agents, ~15 min, and on the order of $15-40**. Cost
  scales with both diff size and finding count, so a large PR at xhigh can be far more.
- **Estimate and confirm before a large fan-out.** If the chosen approach would spawn many
  agents (large PR at high/xhigh), tell the user the rough agent count and cost band and
  ask before launching. Do not silently spend.
- **Log any cap** (e.g. "reviewed the 8 changed `.py` files, skipped the lockfile and
  generated stubs") so coverage limits are explicit, never implied as full coverage.

## Phase 2: delegate the bug hunt to the code-review workflow

Do NOT hand-scan for bugs as a single pass unless the PR is doc-only or tiny (see the size
tiers above). A lone reviewer has good verification but narrow coverage. For anything
larger, delegate finding to the workflow-backed `/code-review`, which fans out ~10 finder
angles plus a per-location verifier. Use the tier chosen in the sizing step (`high` for
small-to-moderate PRs, `xhigh` only for large PRs and only after the confirm step):

- Call `Workflow({ name: "code-review", args: "<tier> <target + context>" })` where
  `<tier>` is the first token; everything after is the target. Pass, verbatim: the PR
  number, the instruction to gather the diff with `gh pr diff <N>` (NOT a local git diff,
  the main checkout may be on another branch), the worktree path, the project's
  verification toolchain (interpreter path, how to run the code), the location of any
  governing spec or guideline docs, and any library/SDK facts already verified during
  phase 1 so finders do not re-derive (or re-break) them.
- Optionally also run `/review` (medium) as a second angle. In practice it catches things
  the workflow misses: deleted doc lines and cross-project duplication. It also emits more
  noise, so lean on the correction step below.
- The workflow runs in the background and returns its verified findings as a task
  notification.

## Phase 2: verify and correct the findings (the skill's core value)

The workflow's findings are candidates, not gospel. Re-verify each yourself before
surfacing it, because the same false claim recurs across passes and only independent
checking kills it. Passes err in BOTH directions: they confirm phantom bugs AND over-refute
real ones, so verify each way rather than only hunting for false positives.

- For any library / SDK / CLI / runtime claim, verify against the ACTUALLY INSTALLED
  version, not memory or the finding text. Find the pin in the repo's lockfile
  (`package-lock.json`, `poetry.lock`, `uv.lock`, `Cargo.lock`, `go.sum`, a monorepo
  lockfile), then introspect the real package with the project's own interpreter or
  toolchain (signatures, docstrings, behaviour). Run the new pure functions on the real
  data the repo ships where it exists. Show the evidence.
- Track claims already settled during this review. The same false claim tends to recur
  across passes: once refuted with evidence, keep it refuted; once confirmed with
  evidence, do not let a later refute pass kill it.
- Style/pattern noise (`print()` vs logging, naming taste) is not a bug unless it violates
  the repo's actual norm; judge against the guidelines found in phase 1.
- Line-by-line crash claims ("TypeError on string input", "field can be None") must be
  reproduced against the real inputs before believing them; such claims usually do not
  fire on the data the code actually sees.
- Confirm every module/file/path a docstring or comment references actually exists, on the
  branch AND on the base. Map forward references to the ticket that introduces them.
- For each finding return CONFIRMED / REFUTED / NEEDS-FIX (claim real but its detail, line,
  or severity is wrong; give the correction). Merge duplicates that share one root cause.

## Phase 2: add what the workflow under-weights

The workflow is strong on code bugs but thin on these. Add them yourself:

- Spec/guideline agreement, carried over from phase 1 but now checked against the final
  understanding of the code.
- Explainability: are docstrings/comments ACCURATE (not overstating present reality), do
  they define their terms, can a junior dev reconstruct intent from them.
- Doc/provenance hygiene: docstring schemas matching what the code writes, `--help`
  matching the real inputs, PR-body claims matching the committed files.
- Test coverage against the project norm.

## Output and process

- Lead with the phase-1 verdict: was the change reasoned, documented, and in line with the
  repo's guidelines. Then what was verified as CORRECT, so the green parts are trustworthy.
- Group findings by severity: merge-blocker / medium / low / informational. Each carries an
  exact `file:line` and the evidence it was verified against.
- Then go through issues one at a time. For each, draft a PR comment in a kind, humble tone
  (this is a colleague's work), in plain simple English. Post only after approval, via
  `gh pr comment <N> --body-file`. Never claim the user ran or tested something they did
  not.
- If an issue warrants a follow-up, propose a ticket in the team's tracker and create it
  only on the user's go-ahead, then reference it in the comment with a TODO.

## Style

- Direct, no fluff, no wrap-ups. Never use em dashes; restructure the sentence or use "->".
- Verify tool/library behaviour by running commands, not from memory.
