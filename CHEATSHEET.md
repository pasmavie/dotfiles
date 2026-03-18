# Dotfiles v2 Cheatsheet

## Window Management — AeroSpace (the new i3)

Everything uses `alt` as the modifier, just like your old chunkwm/i3 setup.

| Action | Keys | Notes |
|--------|------|-------|
| Focus window | `alt + h/j/k/l` | Left/Down/Up/Right |
| Move window | `shift+alt + h/j/k/l` | Swap position |
| Switch workspace | `alt + 1-9` | Like i3 workspaces |
| Send to workspace | `shift+alt + 1-9` | Move window there |
| Fullscreen | `alt + f` | Toggle |
| Float/tile toggle | `alt + shift + space` | |
| Rotate layout | `alt + r` | H ↔ V |
| Equalize sizes | `shift+alt + 0` | Balance all |
| Open terminal | `alt + enter` | Opens Ghostty |
| **Resize mode** | `shift+alt + r` | Then h/j/k/l to resize, `esc` to exit |

## Terminal — Ghostty

| Action | Keys |
|--------|------|
| Copy | `cmd + c` |
| Paste | `cmd + v` |
| Zoom in | `cmd + =` |
| Zoom out | `cmd + -` |
| Reset zoom | `cmd + 0` |

Config lives at `~/.config/ghostty/config`. Ghostty is fast and simple — most window management is handled by AeroSpace, most splits by tmux.

## Multiplexer — tmux (same as before)

Prefix is still `C-b`. Your muscle memory is preserved.

| Action | Keys |
|--------|------|
| New window | `C-b c` |
| Split horizontal | `C-b %` |
| Split vertical | `C-b "` |
| Navigate panes | `C-h/j/k/l` | No prefix needed (vim-tmux-navigator) |
| Resize pane | `C-b H/J/K/L` | Capital = resize by 10 |
| Next/prev window | `C-b n` / `C-b p` |
| Attach session | `t0` / `t1` (aliases) |
| Join pane | `C-b S` |

## Shell — Modern CLI Tools

These replace old coreutils. Just use them naturally:

| Old command | New command | What changed |
|-------------|-------------|--------------|
| `ls` | `eza` (aliased to `ls`) | Icons, colors, git status |
| `ls -la` | `ll` | Long listing with icons |
| `ls --tree` | `lt` | Tree view (2 levels) |
| `cat` | `bat` (aliased to `cat`) | Syntax highlighting, line numbers |
| `grep` | `rg` (aliased to `grep`) | Much faster, respects .gitignore |
| `find` | `fd` (aliased to `find`) | Simpler syntax: `fd "pattern"` |
| `cd` (to frequent dirs) | `z dirname` | Learns your habits (zoxide) |
| `ctrl+r` (history) | `ctrl+r` | Now powered by atuin — searchable, syncable |
| `ctrl+t` | `ctrl+t` | fzf file finder |

### fzf tricks
- `ctrl+r` — fuzzy search shell history (via atuin)
- `ctrl+t` — fuzzy find files, insert path
- `alt+c` — fuzzy cd into directories
- `vim **<tab>` — fzf completion for any command

### zoxide tricks
- `z foo` — cd to most-visited directory matching "foo"
- `zi foo` — interactive selection if multiple matches

## Prompt — Starship

The prompt shows: user, directory, git branch/status, language version, docker context.
No configuration needed day-to-day. Config is at `~/.config/starship.toml`.

## Editor — LazyVim (Neovim)

Leader key is `space`.

### Essential keybindings (your old ones are preserved)

| Action | Keys | Notes |
|--------|------|-------|
| Start of line | `B` | Was `^`, ported from your vimrc |
| End of line | `E` | Was `$` |
| Escape (insert mode) | `jj` | Same as before |
| Next buffer | `C-n` | Same as before |
| Previous buffer | `C-p` | Same as before |
| Delete (no yank) | `d` | Black-hole delete, same as before |
| Paste (no yank) | `<leader>p` | Same as before |
| System clipboard | `C-y` | Same as before |

### LazyVim built-in keybindings (learn these)

| Action | Keys |
|--------|------|
| File finder | `<leader>ff` |
| Live grep | `<leader>sg` |
| File explorer | `<leader>e` |
| Buffer list | `<leader>,` |
| Recent files | `<leader>fr` |
| LSP: Go to definition | `gd` |
| LSP: References | `gr` |
| LSP: Hover doc | `K` |
| LSP: Rename | `<leader>cr` |
| LSP: Code action | `<leader>ca` |
| Diagnostics | `<leader>xx` |
| Which-key (shows all) | `<leader>` (wait) |

Tip: press `<leader>` and wait — which-key will show you all available commands.

## Git — Improved

| Alias | Command | What it does |
|-------|---------|--------------|
| `git s` | `git status --short` | Compact status |
| `git l` | `git log --oneline -20` | Quick log |
| `git lg` | `git log --graph --oneline --decorate --all` | Visual graph |
| `git d` | `git diff` | Now rendered by delta (side-by-side!) |
| `git ds` | `git diff --staged` | Staged changes |
| `git co` | `git checkout` | |
| `git cb` | `git checkout -b` | New branch |
| `git undo` | `git reset --soft HEAD~1` | Undo last commit (keep changes) |
| `git wip` | `git add -A && commit -m 'wip'` | Quick save |

All diffs now use **delta** — side-by-side, syntax highlighted, line numbers.

## The Modifier Map (no conflicts)

```
alt + key        → AeroSpace (window management)
C-b + key        → tmux (terminal multiplexing)
C-h/j/k/l       → vim-tmux-navigator (cross-pane movement)
space + key      → LazyVim (editor commands)
super + key      → Ghostty / macOS (copy, paste, zoom)
```

## Quick Reference: Where's the config?

| Tool | Config location |
|------|----------------|
| AeroSpace | `~/.config/aerospace/aerospace.toml` |
| Ghostty | `~/.config/ghostty/config` |
| Starship | `~/.config/starship.toml` |
| Neovim | `~/.config/nvim/` |
| tmux | `~/.tmux.conf` |
| bat | `~/.config/bat/config` |
| atuin | `~/.config/atuin/config.toml` |
| git | `~/.config/git/config` |
| zsh | `~/.zshrc` |

All managed by **GNU Stow** from `~/dotfiles-v2/`. To update a config:
1. Edit the file in `~/dotfiles-v2/<package>/...`
2. It's already symlinked — changes take effect immediately
3. Commit to the dotfiles-v2 repo
