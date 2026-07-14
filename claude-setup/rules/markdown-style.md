# Markdown Authoring

- When writing or editing markdown prose, put each sentence on its own line (semantic line breaks).
  Do not hard-wrap at a fixed column width.
  This overrides matching the surrounding file's wrap width.
- Each sentence ends with a newline; paragraphs are separated by blank lines.
- Inside list items, the marker prefixes the first sentence and continuation sentences are indented to align with the item text.
- Leading bold labels (e.g. `**Speed.**`) stay attached to the sentence they introduce.
- Keep code fences, tables, and headings verbatim.

Why: one sentence per line gives clean git diffs; a changed sentence is a one-line change.
