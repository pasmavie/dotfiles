---
name: clean-settings
description: Audit Claude Code settings files for duplicate permissions, misplaced entries, and accumulated one-off approvals. Proposes a cleanup and applies it on confirmation.
---

# Skill: clean-settings

Audit and clean up Claude Code permission settings across all applicable files.

## Trigger

Activate when the user wants to:
- Clean up or audit their Claude Code settings/permissions
- Remove duplicate or redundant permission entries
- Tidy accumulated one-off approvals in `.local.json` files

## Settings File Hierarchy

Claude Code merges permissions **additively** from multiple files. Entries in a
more-specific file do NOT override global ones — they stack. This means duplicating
a global permission in a project file is pure redundancy.

**Load order (most general → most specific):**

| Priority | File | Scope |
|----------|------|-------|
| 1 | `~/.claude/settings.json` | Global — all projects |
| 2 | `~/.claude/settings.local.json` | Global local — personal, not shared |
| 3 | `<project>/.claude/settings.json` | Project — checked into git |
| 4 | `<project>/.claude/settings.local.json` | Project local — gitignored |

## Procedure

### Step 1 — Read all settings files

Read all four files (some may not exist — that's fine, skip missing ones):
- `~/.claude/settings.json`
- `~/.claude/settings.local.json`
- `<project-root>/.claude/settings.json` (use the current working directory)
- `<project-root>/.claude/settings.local.json`

### Step 2 — Analyse

For each `permissions.allow` entry across all files, classify it:

1. **Duplicates**: Permissions present in a project file that already exist in a
   global file. These are redundant — the global entry already grants them everywhere.

2. **Misplaced items**:
   - *Project-specific in global*: entries in `~/.claude/settings.json` that reference
     project-specific tools (specific build systems, project paths, project-only CLIs).
     These should move to the project settings.
   - *Global-worthy in project*: entries in project settings that are general-purpose
     (e.g., `kill`, `aws`, `Read(//tmp/**)`, IDE tools). These could move to global.

3. **Accumulated junk**: Entries in any `.local.json` file that look like one-off
   auto-approved commands rather than intentionally curated permissions. Indicators:
   - Very long/specific command strings (not glob patterns)
   - Escaped characters, heredocs, or inline scripts
   - Commands that are clearly single-use (compilation commands, config file edits)

4. **Non-permission settings**: Also review non-permission keys (`hooks`, `outputStyle`,
   `enabledPlugins`, etc.) for anything that looks misplaced between global and project.

### Step 3 — Report

Present findings in a clear summary:
- Table of duplicates (with which files they appear in)
- List of misplaced items with recommended destination
- List of accumulated junk with recommendation to remove
- Any other observations

### Step 4 — Propose

Draft the cleaned versions of all affected files. Show what changes:
- Which entries move where
- Which entries get removed
- Which files stay unchanged

### Step 5 — Apply

**Ask the user for confirmation before writing any files.**

On confirmation, write all changed files. Report a before/after summary
(entry counts per file).
