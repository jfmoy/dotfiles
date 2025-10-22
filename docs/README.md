# Dotfiles Documentation

Quick reference guides for tools installed via this dotfiles repository.

---

## Modern CLI Tools

General-purpose command-line improvements for faster, better workflows.

**[📖 Modern CLI Tools Cheatsheet](./modern-cli-tools.md)**

Tools covered:
- **eza** - Better ls with colors, icons, git status
- **ripgrep (rg)** - Fast text search (grep replacement)
- **fd** - Simple file finding (find replacement)
- **zoxide (z)** - Smart directory jumping (cd replacement)
- **dust** - Visual disk usage (du replacement)
- **duf** - Pretty disk free (df replacement)
- **procs** - Modern process viewer (ps replacement)
- **bottom (btm)** - System monitor (htop replacement)

---

## Professional Development Tools

Tools for managing environments, versions, and APIs (installed on pro machines only).

### asdf - Version Manager

**[📖 asdf Cheatsheet](./asdf.md)**

Unified version manager for Node.js, Python, Terraform, Kubectl, and 500+ tools.
- Replace N, pyenv, rbenv, tfenv with single tool
- Per-project version management via `.tool-versions`
- Team collaboration with consistent versions

**Quick start:**
```bash
asdf plugin add nodejs
asdf install nodejs latest
asdf global nodejs latest
```

### direnv - Per-Directory Environment Variables

**[📖 direnv Cheatsheet](./direnv.md)**

Automatically load/unload environment variables when entering/leaving directories.
- Manage AWS profiles per project
- Keep API keys out of shell history
- Project-specific configuration

**Quick start:**
```bash
cd ~/project
echo 'export AWS_PROFILE=my-project' > .envrc
direnv allow
```

### HTTPie - API Testing

**[📖 HTTPie Cheatsheet](./httpie.md)**

User-friendly HTTP client for testing REST APIs.
- Simpler syntax than curl
- Colored JSON output
- Session support

**Quick start:**
```bash
http https://api.github.com/users/octocat
http POST https://api.example.com/users name=John email=john@example.com
```

### just - Command Runner

**[📖 just Cheatsheet](./just.md)**

Modern command runner for project tasks.
- Better than make for non-build tasks
- List all commands: `just --list`
- Great for personal projects

**Quick start:**
```bash
# Create justfile
just --init

# List commands
just --list

# Run command
just test
```

### SSH Multiplexing - Connection Reuse

**[📖 SSH Multiplexing Guide](./ssh-multiplexing.md)**

Reuse SSH connections for instant subsequent access.
- 10x faster SSH/SCP/rsync connections
- No repeated authentication
- Works automatically

**Quick start:**
```bash
# First connection - creates master
ssh user@server.com

# Subsequent connections - instant!
ssh user@server.com
scp file.txt user@server.com:
```

### Zsh Power-User Configuration

**[📖 Zsh Configuration Guide](./zsh-configuration.md)**

Enhanced shell with better history, navigation, and completions.
- 50,000 command history with smart deduplication
- Type directory names to cd (no need for `cd`)
- Advanced globbing: `**/*.txt`, `^*.log`
- Shared history across all terminals

**Quick examples:**
```bash
# Navigate by typing directory
~/projects/myapp

# Recursive file operations
rm **/*.log

# Hide sensitive commands (prefix with space)
 export SECRET=xyz

# Execute last docker command
!docker
```

### Tmux Configuration

**[📖 Tmux Configuration Guide](./tmux-configuration.md)**

Enhanced terminal multiplexer with modern features.
- Mouse support (click, drag, scroll)
- Vi-style navigation and copy mode
- Better split commands: `|` and `-`
- 50,000 line scrollback
- Status bar with time and session info

**Quick examples:**
```bash
# Better splits
prefix |              # Vertical split
prefix -              # Horizontal split

# Vi-style navigation
prefix h/j/k/l        # Move between panes

# Copy mode (vi-style)
prefix [              # Enter copy mode
v                     # Select
y                     # Copy to clipboard

# Sync panes
Ctrl-x                # Type in all panes at once
```

### Git Aliases

**[📖 Git Aliases Cheatsheet](./git-aliases.md)**

Comprehensive git workflow shortcuts for faster daily operations.
- 50+ aliases covering all common operations
- Organized by category (status, branch, commit, etc.)
- Beautiful log visualization
- Interactive staging shortcuts

**Quick examples:**
```bash
# Status and diff
gst                   # Short status
gd                    # Show changes

# Interactive staging
gap                   # Stage changes interactively

# Create feature branch
gcb feature/new       # Create and checkout

# Beautiful log
glog                  # Pretty commit graph

# Push with upstream
gpu                   # Push and set tracking

# Clean merged branches
gbclean               # Delete local merged branches
```

### Git Workflow Tools

**[📖 Git Workflow Tools Guide](./git-workflow-tools.md)**

Modern tools for enhanced git workflows.
- **lazygit** - Terminal UI for git (visual staging, branching, rebasing)
- **git-absorb** - Automatic fixup commits
- **difftastic** - Syntax-aware diffs for code review

**Quick examples:**
```bash
# Launch visual git interface
lazygit
# j/k to navigate, space to stage, c to commit, P to push

# Auto-fixup recent commits
git absorb

# Structural diff (better for refactoring)
GIT_EXTERNAL_DIFF=difft git diff
```

---

## Tool Categories

### Speed & Efficiency
- **zoxide** - Jump to directories instantly
- **ripgrep** - 10-100x faster than grep
- **fd** - Faster, simpler file finding
- **eza** - Better ls with more info

### Visibility & Monitoring
- **bottom** - Modern system monitor
- **procs** - Better process listing
- **dust** - Visual disk usage
- **duf** - Colored disk free info

### Development
- **asdf** - Multi-language version management
- **direnv** - Environment variable automation
- **HTTPie** - API testing and debugging
- **just** - Task automation
- **Git Workflow Tools** - lazygit, git-absorb, difftastic

### Infrastructure & Networking
- **SSH Multiplexing** - Connection reuse for 10x faster SSH/SCP/rsync

### Shell Configuration
- **Zsh Power-User Settings** - Better history, navigation, globbing, completions
- **Tmux Configuration** - Vi-mode, mouse support, better keybindings
- **Git Aliases** - Comprehensive workflow shortcuts

---

## Integration with Existing Tools

These tools complement what you already have:

- **asdf** can eventually replace **N** (node version manager)
- **bottom** is an alternative to **htop** (can use both)
- **eza** replaces **ls** (aliased in .zshrc)
- **zoxide** enhances **cd** (not a replacement)
- **ripgrep** is used by many editors/tools you may already have
- **direnv** works perfectly with **1Password CLI** for secrets

---

## Learning Path

**Start here (5 minutes):**
1. `ls` / `ll` / `la` - See the better file listings (eza)
2. `z <dir>` - Start building your directory jump database (zoxide)
3. `rg "pattern"` - Try fast searching (ripgrep)

**Next (15 minutes):**
1. Set up direnv for one project with AWS profile
2. Try httpie to test an API endpoint
3. Create a simple justfile for a personal project

**Deep dive (when needed):**
1. Migrate from N to asdf for version management
2. Set up direnv + 1Password integration for secrets
3. Create comprehensive justfiles for workflow automation

---

## Getting Help

- Each tool has a detailed cheatsheet in this directory
- Run `<tool> --help` for built-in help
- Visit official documentation (linked in each cheatsheet)
- For dotfiles issues: check main README or ~/.local/share/chezmoi/

---

## Quick Command Reference

| Task | Command | Cheatsheet |
|------|---------|------------|
| List files with icons | `ll` | [modern-cli-tools](./modern-cli-tools.md) |
| Search code | `rg "pattern"` | [modern-cli-tools](./modern-cli-tools.md) |
| Find files | `fd filename` | [modern-cli-tools](./modern-cli-tools.md) |
| Jump to directory | `z project` | [modern-cli-tools](./modern-cli-tools.md) |
| System monitor | `btm` | [modern-cli-tools](./modern-cli-tools.md) |
| Install node version | `asdf install nodejs 20.0.0` | [asdf](./asdf.md) |
| Auto-load env vars | `direnv allow` | [direnv](./direnv.md) |
| Test API | `http GET api.example.com/users` | [httpie](./httpie.md) |
| Run project task | `just test` | [just](./just.md) |
| Fast SSH connection | `ssh server` (reuses existing) | [ssh-multiplexing](./ssh-multiplexing.md) |
| Navigate to directory | `~/projects` (no cd needed) | [zsh-configuration](./zsh-configuration.md) |
| Recursive file search | `ls **/*.txt` | [zsh-configuration](./zsh-configuration.md) |
| Split tmux vertically | `prefix \|` | [tmux-configuration](./tmux-configuration.md) |
| Copy in tmux | `prefix [ → v → y` | [tmux-configuration](./tmux-configuration.md) |
| Git status (short) | `gst` | [git-aliases](./git-aliases.md) |
| Interactive staging | `gap` | [git-aliases](./git-aliases.md) |
| Beautiful git log | `glog` | [git-aliases](./git-aliases.md) |
| Visual git interface | `lazygit` | [git-workflow-tools](./git-workflow-tools.md) |
| Auto-fixup commits | `git absorb` | [git-workflow-tools](./git-workflow-tools.md) |

---

**Last updated:** 2025-10-21
