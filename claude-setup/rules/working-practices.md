# Working Practices

## Implementing a handed plan

- When given a written plan to implement, the bar is immediate cold execution by a
  fresh agent.
- If implementing forces discovery (locating files, verifying counts), reconciliation
  (the plan contradicts current HEAD or committed code), or a blocking clarification,
  fold the resolution back into the plan file. Do the verification, then edit the plan
  to bake in what you learned.
- Add a "Pre-flight (confirmed <date>)" section just before the execution steps:
  confirmed file locations plus branch/HEAD, verified counts so the next agent does not
  re-run the analysis, any resolved contradiction quoted verbatim with its source
  commit, and the concrete fixes the work will require. Also correct stale inline
  instructions and any verification commands that no longer hold.
- Having to stop and re-investigate means the plan was not ready. Harden it once so it
  never blocks again. If a blocking question must go to the user, still record the
  resolution in the plan afterward.

## Deleting development docs

- Before deleting any development artifact (devlog, plan, investigation notes), audit
  what operational knowledge it holds: bug investigation narratives, edge-case
  discoveries, fix rationale.
- The fixes live in the code, but the context (why it was a bug, how it manifested,
  what was tried) is hard to reconstruct from code alone. The user considers this
  knowledge precious because it prevents re-encountering the same issues.
- Default to preserving it: offer to keep the file (renamed or cleaned) or migrate the
  useful parts into a README or other permanent doc. Prefer preservation over tidiness.
