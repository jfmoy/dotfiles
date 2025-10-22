# Modern CLI Tools Cheatsheet

Quick reference for modern CLI replacements installed via Homebrew.

---

## eza - Modern ls replacement

**What it does:** Better file listing with colors, icons, and git status.

**Common commands:**
```bash
ls              # List files (aliased to eza)
ll              # Long format with details
la              # List all including hidden
lt              # Tree view

eza --tree      # Tree view (custom depth)
eza --tree -L 2 # Tree view, 2 levels deep
eza -l --git    # Show git status
```

**Features:**
- Colors by file type
- Icons for files and directories
- Git status integration
- Tree view built-in

**Docs:** https://eza.rocks

---

## ripgrep (rg) - Fast search

**What it does:** Recursively search for patterns, 10-100x faster than grep.

**Common commands:**
```bash
rg "pattern"                    # Search in current directory
rg "pattern" path/              # Search in specific path
rg -i "pattern"                 # Case insensitive
rg -w "word"                    # Match whole words only
rg -t js "pattern"              # Search only JavaScript files
rg -l "pattern"                 # List files with matches
rg --hidden "pattern"           # Include hidden files
rg --no-ignore "pattern"        # Don't respect .gitignore
```

**Features:**
- Respects .gitignore by default
- Colored output
- Supports regex
- Very fast parallel search

**Docs:** https://github.com/BurntSushi/ripgrep

---

## fd - Simple find alternative

**What it does:** Fast, user-friendly file finder.

**Common commands:**
```bash
fd pattern                      # Find files/directories matching pattern
fd -e txt                       # Find all .txt files
fd -e pdf -e docx              # Find PDFs and DOCX files
fd pattern path/               # Search in specific path
fd -H pattern                  # Include hidden files
fd -I pattern                  # Don't respect .gitignore
fd -t f pattern                # Only files
fd -t d pattern                # Only directories
fd -x rm                       # Execute command on results (delete)
```

**Features:**
- Simple, intuitive syntax
- Fast parallel execution
- Respects .gitignore
- Colored output

**Docs:** https://github.com/sharkdp/fd

---

## zoxide (z) - Smart cd

**What it does:** Jump to frequently used directories with partial matches.

**Common commands:**
```bash
z proj                          # Jump to most frequent match (e.g., ~/projects)
z doc work                      # Jump to match with multiple terms
zi proj                         # Interactive selection with fzf
zoxide query proj               # Show what directory z would jump to
zoxide query --list            # List all tracked directories
zoxide remove /path            # Remove directory from database
```

**How it works:**
- Tracks directories you visit
- Ranks by "frecency" (frequency + recency)
- Partial name matching
- After a few uses, just `z proj` instead of `cd ~/work/projects`

**Docs:** https://github.com/ajeetdsouza/zoxide

---

## dust - Visual disk usage

**What it does:** Shows disk usage in a visual tree format.

**Common commands:**
```bash
dust                            # Disk usage of current directory
dust /path                     # Disk usage of specific path
dust -d 1                      # Depth 1 only
dust -r                        # Reverse order (smallest first)
dust -n 20                     # Show top 20 entries
dust -s                        # No percent bars or graphs
```

**Features:**
- Visual tree with bars
- Percentage of total
- Colored output
- Fast

**Docs:** https://github.com/bootandy/dust

---

## duf - Pretty disk free

**What it does:** Shows filesystem usage in a pretty, organized format.

**Common commands:**
```bash
duf                             # Show all filesystems
duf /home                      # Show specific mount point
duf --only local               # Only local filesystems (no network)
duf --hide-fs tmpfs            # Hide specific filesystem types
```

**Features:**
- Colored, organized output
- Usage bars
- Groups by device type
- Shows inodes

**Docs:** https://github.com/muesli/duf

---

## procs - Modern ps

**What it does:** Better process listing with search and highlighting.

**Common commands:**
```bash
procs                           # List all processes
procs firefox                  # Search for firefox processes
procs --tree                   # Tree view of processes
procs --sortd cpu              # Sort by CPU (descending)
procs --sortd mem              # Sort by memory
procs --watch                  # Watch mode (updates)
```

**Features:**
- Colored output
- Search built-in
- Shows Docker container names
- Better defaults than ps

**Docs:** https://github.com/dalance/procs

---

## bottom (btm) - System monitor

**What it does:** Modern replacement for htop/top with better visuals.

**Common commands:**
```bash
btm                             # Launch bottom
btm -b                         # Basic mode (less features)
btm --battery                  # Show battery widget

# Inside bottom:
/       # Search processes
dd      # Kill selected process
e       # Toggle process grouping
t       # Toggle tree mode
m       # Sort by memory
c       # Sort by CPU
```

**Features:**
- CPU, memory, network, disk graphs
- Process management
- Battery monitoring
- Mouse support
- Customizable

**Docs:** https://github.com/ClementTsang/bottom

---

## Quick Comparison Table

| Task | Old Command | New Command |
|------|-------------|-------------|
| List files | `ls -la` | `la` (eza) |
| Search text | `grep -r "pattern"` | `rg "pattern"` |
| Find files | `find . -name "*.txt"` | `fd -e txt` |
| Jump to dir | `cd ~/long/path/to/projects` | `z proj` |
| Disk usage | `du -sh *` | `dust` |
| Disk free | `df -h` | `duf` |
| Process list | `ps aux | grep firefox` | `procs firefox` |
| System monitor | `htop` | `btm` |
