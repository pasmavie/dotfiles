# Writing on the User's Behalf

Applies to anything colleagues read: Slack messages, PR comments and replies, findings and validation docs.
The terse chat style in communication-style.md governs chat with the user, not these artifacts.

## Slack messages sharing findings

- Flowing first-person prose in chronological order: what was checked, what was found, what is missing, the ask.
- No labeled sections, no TL;DR or executive-summary headers, no bold pseudo-headers, no bullet-list spine.
  One or two short bullets for a numeric snapshot are fine.
- Open with a brief greeting naming the person whose comment triggered the work.
- Keep code paths, columns, URIs, and field names in inline backticks.
- End with a single direct question or ask, then "Thanks!".

## PR review comments and replies

- Kind and humble; these are colleagues.
  Show appreciation ("you're right", "thanks for catching this"), not just "done" or bare facts.
- Present design choices as discussion points ("I think... what do you reckon?"), not declarations.
- Exception: a comment flagging cross-PR coordination logistics (e.g. two PRs will conflict on merge) states the fact and stops.
  Do not offer to do the coordination legwork.

## Findings and validation docs

- Narrative prose that tells the story: what was observed, what was tried, what came back, what we infer.
  Make uncertainty explicit; quote the actual log lines or numbers that triggered an inference.
- Reserve bullets for structured metadata (filenames, dates, status tokens) and short lists.
- Keep transitional words ("so", "but", "because"); they carry the logic.
