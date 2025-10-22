# Tmux Configuration Guide

**What it does:** Comprehensive tmux setup with vi-style navigation, mouse support, and better defaults.

**Configured in:** `~/.tmux.conf`

---

## Quick Reference

**Default prefix key:** `Ctrl-b` (shown as `prefix` below)

### Essential Keybindings

```bash
# Sessions
prefix d              # Detach from session
tmux attach           # Reattach to session
tmux ls               # List sessions

# Windows (tabs)
prefix c              # Create new window
prefix ,              # Rename window
prefix n              # Next window
prefix p              # Previous window
prefix 0-9            # Switch to window by number
prefix &              # Kill window

# Panes (splits)
prefix |              # Split vertically
prefix -              # Split horizontally
prefix h/j/k/l        # Navigate panes (vi-style)
prefix H/J/K/L        # Resize panes (hold and repeat)
prefix x              # Kill pane
prefix z              # Toggle pane zoom (fullscreen)
Ctrl-x                # Toggle pane synchronization

# Other
prefix r              # Reload config
prefix [              # Enter copy mode
prefix ]              # Paste buffer
```

---

## Configuration Details

### Terminal & Colors

```tmux
set -g default-terminal "screen-256color"
set -ga terminal-overrides ",*256col*:Tc"
```

**What it does:**
- 256 color support
- True color (24-bit) support
- Better compatibility with modern terminals

### Window & Pane Numbering

```tmux
set -g base-index 1
setw -g pane-base-index 1
set -g renumber-windows on
```

**What it does:**
- Windows start at 1 (not 0) - easier to reach on keyboard
- Panes start at 1
- Windows renumber automatically when one closes

### Mouse Support

```tmux
set -g mouse on
```

**What you can do:**
- Click to select panes
- Drag pane borders to resize
- Scroll with mouse wheel
- Click window names in status bar
- Right-click for context menu

**Usage:**
```bash
# Click on a pane to switch to it
# Drag a border between panes to resize
# Scroll up/down to view history
# Click on window name in status bar to switch
```

### Vi Mode

```tmux
setw -g mode-keys vi
```

**What it enables:**
- Vi-style navigation in copy mode
- Vi-style selection and yanking
- Natural for vim/neovim users

### History

```tmux
set -g history-limit 50000
```

**What it does:**
- 50,000 lines of scrollback (vs default 2,000)
- Never lose command output

---

## Common Workflows

### Creating Splits

```bash
# Old way (hard to remember):
prefix "              # Horizontal split
prefix %              # Vertical split

# New way (intuitive):
prefix |              # Vertical split (looks like |)
prefix -              # Horizontal split (looks like -)
```

**All splits open in the current directory.**

### Navigating Panes

```bash
# Vi-style (if you know vim):
prefix h              # Go left
prefix j              # Go down
prefix k              # Go up
prefix l              # Go right

# Arrow keys still work:
prefix ←/↓/↑/→        # Navigate with arrows
```

### Resizing Panes

```bash
# Vi-style (hold prefix, then press multiple times):
prefix H              # Resize left (5 columns)
prefix J              # Resize down (5 rows)
prefix K              # Resize up (5 rows)
prefix L              # Resize right (5 columns)

# Or use mouse - drag the border
```

### Copy Mode (Scrollback)

```bash
# Enter copy mode
prefix [

# Navigation (vi-style):
h/j/k/l               # Move cursor
Ctrl-b / Ctrl-f       # Page up/down
g / G                 # Top/bottom
/ or ?                # Search forward/backward

# Selection (vi-style):
v                     # Start selection
V                     # Line selection
r                     # Rectangle selection

# Copy:
y                     # Yank selection to clipboard (macOS)
Enter                 # Yank and exit

# Exit:
q or Esc              # Quit copy mode

# Paste:
prefix ]              # Paste from tmux buffer
Cmd-V                 # Paste from system clipboard
```

**Example - copying from scrollback:**
```bash
1. prefix [           # Enter copy mode
2. /error             # Search for "error"
3. n                  # Next match
4. v                  # Start selection
5. $ (or End)         # Select to end of line
6. y                  # Copy to clipboard
7. prefix ]           # Paste in tmux
   # or Cmd-V in other apps
```

### Session Management

```bash
# Create named session
tmux new -s work

# List sessions
tmux ls

# Attach to session
tmux attach -t work

# Detach from session
prefix d

# Switch between sessions (inside tmux)
prefix s              # Show session list
prefix (              # Previous session
prefix )              # Next session

# Rename session
prefix $
```

### Window Management

```bash
# Create window
prefix c

# Rename window
prefix ,

# Close window
prefix &              # Asks for confirmation
# or just: exit       # In the shell

# Navigate windows
prefix 0-9            # Go to window by number
prefix n              # Next window
prefix p              # Previous window
prefix l              # Last window

# Reorder windows
prefix .              # Move window to new index
```

---

## Advanced Features

### Synchronize Panes

**Keybinding:** `Ctrl-x` (no prefix needed)

```bash
# Type in multiple panes at once
Ctrl-x                # Toggle sync on/off

# Use case: Running same command on multiple servers
1. Split panes: prefix | prefix | prefix |
2. SSH to different servers in each pane
3. Ctrl-x to enable sync
4. Type command - appears in all panes
5. Ctrl-x to disable sync
```

### Zoom Pane (Fullscreen)

```bash
prefix z              # Toggle pane fullscreen
```

**Use case:** Temporarily maximize a pane, then restore layout.

### Break Pane to Window

```bash
prefix !              # Break pane into its own window
```

### Join Pane from Window

```bash
prefix :join-pane -s 2.1    # Join window 2, pane 1 to current window
```

### Swap Panes

```bash
prefix {              # Swap with previous pane
prefix }              # Swap with next pane
```

### Kill Everything

```bash
# Kill current pane
prefix x

# Kill current window
prefix &

# Kill session
prefix :kill-session

# Kill tmux server (all sessions)
tmux kill-server
```

---

## Status Bar

**Position:** Top of screen

**Left side:** Session name in green
```
work |
```

**Right side:** Date and time
```
2025-10-21 | 14:23:45
```

**Windows:** Current window highlighted in yellow
```
1:zsh  2:vim  3:logs
```

---

## Tips & Tricks

### 1. Reload Config Quickly

```bash
prefix r              # Reload ~/.tmux.conf
# Shows message: "Config reloaded!"
```

### 2. New Windows/Splits in Current Directory

All new windows and splits automatically open in the current directory.

```bash
# In ~/projects/myapp
prefix c              # New window opens in ~/projects/myapp
prefix |              # Split opens in ~/projects/myapp
```

### 3. Search in Scrollback

```bash
prefix [              # Enter copy mode
/error                # Search for "error"
n                     # Next match
N                     # Previous match
```

### 4. Copy Without Entering Copy Mode

Just use your mouse:
1. Select text with mouse
2. It's automatically in clipboard
3. Cmd-V to paste

### 5. Detach and Reattach

```bash
# On local machine
tmux new -s dev
# ... do work ...
prefix d              # Detach

# Close laptop, go home

# On local machine (later)
tmux attach -t dev    # Back to exactly where you left off
```

### 6. Nested Tmux (Tmux in SSH)

```bash
# Local prefix: Ctrl-b
prefix c              # Create local window

# Remote prefix: Ctrl-b Ctrl-b
prefix prefix c       # Create remote window
```

### 7. Custom Layouts

```bash
prefix Esc            # Enter layout mode
1-5                   # Select preset layout
Space                 # Cycle through layouts
```

---

## Common Setups

### Development Layout

```bash
# Terminal 1
tmux new -s dev

# Create 3-pane layout
prefix |              # Vertical split
prefix -              # Horizontal split (in right pane)

# Result:
# +----------+----------+
# |          |   top    |
# |   main   +----------+
# |          |  bottom  |
# +----------+----------+

# Use:
# - Left: Editor
# - Top-right: Server/logs
# - Bottom-right: Commands
```

### Multi-Server Administration

```bash
tmux new -s servers

# Create 4 panes
prefix |
prefix -
prefix l              # Go to left pane
prefix -

# Result:
# +------+------+
# | srv1 | srv2 |
# +------+------+
# | srv3 | srv4 |
# +------+------+

# SSH to each server
# Then: Ctrl-x to sync panes
# Run commands on all servers simultaneously
```

### Monitoring Dashboard

```bash
tmux new -s monitoring

prefix -              # Split horizontal
prefix -              # Split horizontal again

# In each pane:
# Pane 1: htop (or btm)
# Pane 2: tail -f /var/log/app.log
# Pane 3: watch docker ps
```

---

## Troubleshooting

### Colors look wrong

```bash
# Check TERM
echo $TERM            # Should be "screen-256color" inside tmux

# If not, add to ~/.zshrc:
export TERM=xterm-256color
```

### Copy to clipboard not working

```bash
# Make sure pbcopy is available
which pbcopy          # Should show /usr/bin/pbcopy

# Try copying manually:
prefix [
# Select text
y                     # Should copy to clipboard
```

### Mouse scroll doesn't work

```bash
# Check mouse is enabled
prefix :show-options -g mouse
# Should show: mouse on

# Re-enable if needed:
prefix :set -g mouse on
```

### Keybinding not working

```bash
# List all keybindings
prefix ?

# Check specific binding
prefix :list-keys -T prefix

# Reload config
prefix r
```

---

## Comparison: Old vs New

| Task | Old Way | New Way |
|------|---------|---------|
| Vertical split | `prefix %` | `prefix \|` |
| Horizontal split | `prefix "` | `prefix -` |
| Navigate panes | `prefix arrow` | `prefix hjkl` |
| Resize panes | `prefix Ctrl-arrow` | `prefix HJKL` |
| Copy mode | Complex | Vi-style `v` and `y` |
| Reload config | `:source ~/.tmux.conf` | `prefix r` |
| Select pane | `prefix o` | Click with mouse |
| Resize pane | Multiple commands | Drag with mouse |

---

**Official docs:** `man tmux`

**Cheat sheet:** `prefix ?` (inside tmux)
