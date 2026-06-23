# Status & Reference Doc Provenance

When maintaining a status, catch-up, or results document, every number must be traceable.

- For each metric or results table state three things: who produced it, where the
  result lives (exact file, PR, branch, plus the command that generated it), and the
  concrete definition of the metric, not just the acronym.
- Verify numbers against the actual source (data files, result files, PR file contents)
  before writing them. Never assert a number from memory or from a PR description alone.
- A PR description can disagree with the committed result files. When it does, inspect
  the underlying data and flag the gap rather than papering over it.
- Reconcile stale counts everywhere they appear, not just in the first place noticed.
- Vague metric labels hide real distinctions (doc-level versus section-level of the
  same metric are different numbers). Spell out which one each figure is.
- When the reader needs to reconstruct state, expand terse references into a log-level
  account: unpack each named artifact with a verbatim worked example pulled fresh from
  the source. Length is acceptable; vagueness is not.
