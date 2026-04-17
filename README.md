# Dotfiles

Personal macOS configuration managed with [chezmoi](https://www.chezmoi.io/).

## What's Configured

### Shell & Terminal
- **kitty** - GPU-accelerated terminal
- **zsh** - Enhanced shell with better history, navigation, and completions
- **starship** - Beautiful prompt with git awareness
- **tmux** - Terminal multiplexer with vi-mode and mouse support

### Window Management
- **AeroSpace** - i3-like tiling window manager

### Editors
- **helix** - Default terminal editor (`$EDITOR`, git)
- **neovim** with LazyVim - Full IDE experience in terminal
- **Visual Studio Code** - GUI editor
- **PyCharm** (pro machines) - Python IDE

### Git Workflow
- Comprehensive aliases and configuration
- **lazygit** - Terminal UI for git operations
- **git-absorb** - Automatic fixup commits
- **difftastic** - Syntax-aware diffs
- **git-delta** - Better diff viewer

### Modern CLI Tools
- **ripgrep (rg)** - Fast text search
- **fd** - Simple file finding
- **eza** - Better ls with colors and icons
- **zoxide (z)** - Smart directory jumping
- **bat** - Cat with syntax highlighting
- **fzf** - Fuzzy finder
- **bottom (btm)** - System monitor
- **dust** - Visual disk usage
- **duf** - Pretty disk free

### Development Tools (Pro Machines)
- **asdf** - Multi-language version manager
- **direnv** - Per-directory environment variables
- **docker** - Containerization
- **kubectl** & **helm** - Kubernetes tools
- **terraform** - Infrastructure as code
- **httpie** - API testing
- **just** - Command runner
- **gh** - GitHub CLI
- **awscli** - AWS command-line interface

## Prerequisites

- macOS
- [Homebrew](https://brew.sh/)
- [1Password](https://1password.com/) for secrets management

## Installation

### Fresh Setup

```bash
# Install chezmoi and apply dotfiles
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply jfmoy
```

You will be asked to provide your information, including first name, last name, email address and whether the machine is a professional machine.

The latter triggers the installation of all development tools and scripts.

### Update Existing

```bash
# Pull and apply latest changes
chezmoi update
```

## Post-Installation

### Configure Machine Type

Edit `~/.config/chezmoi/chezmoi.toml`:

```toml
[data]
    proMachine = "true"  # or "false" for personal machines
```

Pro machines get additional development tools and applications.

## Documentation

Comprehensive guides and cheatsheets are available in [docs/README.md](docs/README.md).

Topics covered:
- Modern CLI tools quick reference
- Development tools setup (asdf, direnv, httpie, just)
- Git workflow and aliases
- Neovim/LazyVim navigation
- Zsh, tmux, and SSH configuration
- Maintenance and cleanup functions

## Repository Structure

```
.
├── README.md                    # This file
├── docs/                        # Detailed guides and cheatsheets
├── private_dot_config/          # ~/.config/* files
│   ├── darwin/Brewfile.tmpl     # Homebrew packages
│   ├── kitty/                   # Terminal configuration
│   ├── helix/                   # Helix configuration
│   ├── nvim/                    # Neovim configuration
│   └── aerospace/               # Tiling window manager
├── scripts/                     # Utility scripts
├── dot_gitconfig.tmpl           # Git configuration
├── dot_zshrc.tmpl              # Zsh configuration
├── dot_tmux.conf               # Tmux configuration
└── run_once_*                  # Setup scripts
```

## Maintenance

```bash
# Update all tools
update-all

# Clean up system (Homebrew, Docker, caches)
cleanup

# Update Brewfile from currently installed packages
~/.local/share/chezmoi/update_brewfile.sh
```

## License

Personal configuration - use at your own risk.
