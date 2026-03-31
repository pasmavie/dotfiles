#!/bin/bash
# Claude Code notification hook
# Args: <title> <message>
# Requires: ClaudeNotify.app installed at ~/.claude/ClaudeNotify.app
#   (compiled macOS app, not tracked in git — install manually)
open "$HOME/.claude/ClaudeNotify.app" --args "${1:-Claude Code}" "${2:-Notification}"
