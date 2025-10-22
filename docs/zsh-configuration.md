# Zsh Configuration Guide

**What's configured:** Power-user settings for better history, navigation, globbing, and completions.

**Already active in:** `~/.zshrc`

---

## History Configuration

### Settings

```bash
HISTSIZE=50000                   # 50,000 commands in memory
SAVEHIST=50000                   # 50,000 commands saved to file
HISTFILE=~/.zsh_history          # History file location

setopt EXTENDED_HISTORY          # Save timestamp with commands
setopt INC_APPEND_HISTORY        # Add commands immediately
setopt SHARE_HISTORY             # Share between all sessions
setopt HIST_IGNORE_DUPS          # Don't record duplicates
setopt HIST_IGNORE_ALL_DUPS      # Remove older duplicates
setopt HIST_FIND_NO_DUPS         # Don't show duplicates in search
setopt HIST_REDUCE_BLANKS        # Remove extra blanks
setopt HIST_VERIFY               # Show command before executing
setopt HIST_IGNORE_SPACE         # Don't save commands starting with space
```

### Usage

**Search history:**
```bash
# Press Ctrl-R and type to search
^R pattern

# Or use history command
history | grep docker

# Show last 20 commands
history -20
```

**Execute from history:**
```bash
!!                              # Execute last command
!-2                             # Execute 2nd last command
!docker                         # Execute last command starting with "docker"
!?container                     # Execute last command containing "container"
```

**Verify before executing:**
```bash
# With HIST_VERIFY enabled:
!docker                         # Shows the command, press Enter again to execute
```

**Hide sensitive commands:**
```bash
# Prefix with space - won't save to history
 export SECRET_KEY=abc123
 aws configure set aws_secret_access_key xyz
```

**Shared history benefits:**
```bash
# Terminal 1:
git status

# Terminal 2:
# Press Up arrow - sees "git status" from Terminal 1 immediately
```

---

## Better Globbing (File Matching)

### Settings

```bash
setopt EXTENDED_GLOB             # Advanced pattern matching
setopt GLOB_DOTS                 # Include hidden files
setopt NO_CASE_GLOB              # Case insensitive
```

### Usage

**EXTENDED_GLOB patterns:**

```bash
# Recursive search
ls **/*.txt                      # All .txt files in subdirectories
rm **/*.log                      # Delete all .log files recursively

# Negation
ls ^*.txt                        # Everything except .txt files
rm **/^*.md                      # Delete all non-markdown files

# Numeric ranges
ls file<1-10>.txt               # file1.txt through file10.txt

# Alternatives
ls *.{jpg,png,gif}              # All image files

# Character classes
ls [[:upper:]]*.txt             # Files starting with uppercase
```

**GLOB_DOTS (includes hidden files):**

```bash
# Without GLOB_DOTS:
ls *                            # Shows: file1.txt file2.txt

# With GLOB_DOTS:
ls *                            # Shows: .hidden file1.txt file2.txt

# Explicitly exclude dot files:
ls ^.*                          # Only non-hidden files
```

**NO_CASE_GLOB (case insensitive):**

```bash
ls *.TXT                        # Matches: file.txt, FILE.TXT, File.Txt
cat readme.*                    # Matches: README.md, readme.MD, Readme.md
```

---

## Directory Navigation

### Settings

```bash
setopt AUTO_CD                   # cd by typing directory name
setopt AUTO_PUSHD                # Automatically push to dir stack
setopt PUSHD_IGNORE_DUPS         # No duplicates in stack
setopt PUSHD_SILENT              # Don't print stack
setopt PUSHD_TO_HOME             # pushd with no args → home
DIRSTACKSIZE=20                  # Remember 20 directories
```

### Usage

**AUTO_CD - Type directory name:**

```bash
# Instead of: cd ~/projects
~/projects

# Instead of: cd ..
..

# Instead of: cd ../..
../..

# Still works with cd:
cd /etc
```

**Directory Stack:**

```bash
# View directory stack
dirs -v
# Output:
# 0  ~/projects/myapp
# 1  ~/Documents
# 2  /etc
# 3  ~/Downloads

# Jump to directory by number
cd -2                           # Go to /etc
cd -                            # Toggle between current and previous

# Push directory to stack
pushd ~/new/location

# Pop directory from stack
popd
```

**Quick directory jumping:**

```bash
# Work in multiple directories
~/projects/app1
# ... do some work
~/projects/app2
# ... do some work
cd -                            # Back to app1
cd -                            # Back to app2
```

---

## Command Corrections

### Settings

```bash
setopt CORRECT                   # Suggest corrections for commands
```

### Usage

**Typo correction:**

```bash
$ pytohn script.py
zsh: correct 'pytohn' to 'python' [nyae]?

# Options:
# n - no, don't correct
# y - yes, correct
# a - abort, don't execute
# e - edit, open in editor
```

**Disable for one command:**

```bash
nocorrect git pushh             # Won't suggest correction
```

**Disable corrections temporarily:**

```bash
unsetopt CORRECT
# ... run commands without corrections
setopt CORRECT
```

---

## Better Completions

### Settings

```bash
setopt COMPLETE_IN_WORD          # Complete from cursor position
setopt ALWAYS_TO_END             # Move cursor after completion
setopt AUTO_MENU                 # Show menu on successive tab
setopt LIST_PACKED               # Compact column display
```

### Usage

**COMPLETE_IN_WORD:**

```bash
# Cursor in middle of word: file_|_test.txt
# Tab completes from cursor position
file_name_test.txt
```

**AUTO_MENU (successive tabs):**

```bash
$ git ch<TAB>
# First tab: completes common part
$ git che<TAB>
# Second tab: shows menu
checkout  cherry  cherry-pick
```

**Better file completion:**

```bash
$ vim doc<TAB>
# Shows:
Documents/  Dockerfile  docker-compose.yml

# Continue typing:
$ vim docu<TAB>
# Completes to Documents/

$ vim Documents/pr<TAB>
# Completes files in Documents/
```

---

## Practical Examples

### History Power Usage

```bash
# Find all docker commands you've run
history | grep docker

# Re-run last terraform command
!terraform

# Execute command but don't save (prefix with space)
 aws configure set aws_secret_access_key secret123

# Search and execute
^R docker ps                    # Finds last "docker ps"
```

### Globbing for Cleanup

```bash
# Delete all log files recursively
rm **/*.log

# Delete everything except markdown files
rm ^*.md

# Find large files
ls -lh **/*(.Lm+100)           # Files larger than 100MB

# Backup all config files
cp **/*.conf ~/backup/
```

### Fast Directory Navigation

```bash
# Jump between project directories
~/projects/frontend
# ... work on frontend
~/projects/backend
# ... work on backend
cd -                            # Back to frontend
cd -                            # Back to backend

# View recent directories
dirs -v
cd -3                           # Jump to 3rd directory
```

### Smart Completions

```bash
# Complete git branches
git checkout ma<TAB>            # Completes to main/master

# Complete ssh hosts (from ~/.ssh/config)
ssh prod<TAB>                   # Completes to production-server

# Complete file paths
vim ~/Doc<TAB>                  # Completes to ~/Documents/
vim ~/Documents/proj<TAB>       # Completes to ~/Documents/project/
```

---

## Tips & Tricks

### 1. History Search with fzf

If you have fzf installed:
```bash
# Ctrl-R for fuzzy history search (better than default)
^R
```

### 2. Prevent Specific Commands from History

```bash
# Add space before command
 export AWS_SECRET=xyz
 rm sensitive-file.txt

# Or set pattern
HISTORY_IGNORE="(ls|cd|pwd|exit)"
```

### 3. Shared History Best Practices

```bash
# Reload history in current shell
fc -R

# Force save current session history
fc -W
```

### 4. Custom Directory Shortcuts

Add to `.zshrc`:
```bash
hash -d proj=~/projects
hash -d docs=~/Documents

# Usage:
cd ~proj                        # Goes to ~/projects
vim ~docs/file.txt             # Opens ~/Documents/file.txt
```

### 5. Glob Qualifiers (Advanced)

```bash
# Only directories
ls -d **/*(/)

# Only regular files
ls **/*(.)

# Files modified in last 24 hours
ls **/*(.m-1)

# Executable files
ls **/*(.x)

# Files owned by you
ls **/*(.u$UID)
```

---

## Quick Reference

| Feature | Command | Result |
|---------|---------|--------|
| Execute last command | `!!` | Runs previous command |
| Execute by pattern | `!docker` | Runs last docker command |
| Search history | `^R` | Interactive search |
| Hide from history | ` command` | Space prefix = not saved |
| Recursive glob | `**/*.txt` | All .txt in subdirs |
| Negate pattern | `^*.log` | Everything except .log |
| Type to cd | `~/projects` | Changes to directory |
| Dir stack | `dirs -v` | Show recent directories |
| Jump to dir | `cd -2` | Go to 2nd dir in stack |
| Toggle dirs | `cd -` | Switch between 2 dirs |
| Correct typos | Auto-suggested | Fix command typos |

---

## Troubleshooting

**History not saving:**
```bash
# Check HISTFILE location
echo $HISTFILE

# Check permissions
ls -la ~/.zsh_history

# Force save
fc -W
```

**Glob not working:**
```bash
# Check if option is set
setopt | grep EXTENDED_GLOB

# Re-enable if needed
setopt EXTENDED_GLOB
```

**Too many corrections:**
```bash
# Disable temporarily
unsetopt CORRECT

# Or permanently remove from .zshrc
```

**Directory stack too large:**
```bash
# Reduce size in .zshrc
DIRSTACKSIZE=10
```

---

**Docs:** `man zshoptions` and `man zshexpn` (globbing)
