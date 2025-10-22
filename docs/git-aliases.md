# Git Aliases Cheatsheet

**What it does:** Comprehensive git workflow aliases for faster daily operations.

**Configured in:** `~/.zshrc`

---

## Quick Reference by Category

### Status & Diff

| Alias | Command | Description |
|-------|---------|-------------|
| `gst` | `git status --short` | Compact status |
| `gss` | `git status` | Full status |
| `gd` | `git diff` | Show unstaged changes |
| `gdc` | `git diff --cached` | Show staged changes |
| `gdw` | `git diff --word-diff` | Word-level diff |

### Add & Stage

| Alias | Command | Description |
|-------|---------|-------------|
| `ga` | `git add` | Add files |
| `gaa` | `git add --all` | Stage all changes |
| `gap` | `git add -p` | Interactive staging |

### Commit

| Alias | Command | Description |
|-------|---------|-------------|
| `gc` | `git commit -v` | Commit with diff preview |
| `gcm` | `git commit -m` | Quick commit with message |
| `gca` | `git commit -v --amend` | Amend last commit |
| `gcan` | `git commit -v --amend --no-edit` | Amend without editing message |
| `gcn` | `git commit --no-verify` | Commit, skip hooks |

### Branch

| Alias | Command | Description |
|-------|---------|-------------|
| `gb` | `git branch` | List branches |
| `gba` | `git branch -a` | List all branches (local + remote) |
| `gbd` | `git branch -d` | Delete branch (safe) |
| `gbD` | `git branch -D` | Force delete branch |
| `gco` | `git checkout` | Checkout branch |
| `gcb` | `git checkout -b` | Create and checkout new branch |
| `gbclean` | Clean merged branches | Delete local merged branches |

### Log

| Alias | Command | Description |
|-------|---------|-------------|
| `glog` | Pretty log graph | Beautiful commit history |
| `gloga` | Pretty log graph (all) | All branches history |
| `glo` | `git log --oneline --decorate` | One line per commit |

### Remote Operations

| Alias | Command | Description |
|-------|---------|-------------|
| `gf` | `git fetch` | Fetch from remote |
| `gfa` | `git fetch --all` | Fetch all remotes |
| `gfp` | `git fetch --prune` | Fetch and prune deleted branches |
| `gpl` | `git pull` | Pull from remote |
| `gpr` | `git pull --rebase` | Pull with rebase |
| `gp` | `git push` | Push to remote |
| `gpu` | `git push -u origin HEAD` | Push and set upstream |
| `gpn` | `git push origin --no-verify` | Push, skip hooks |
| `gpnf` | `git push origin --no-verify --force` | Force push, skip hooks |

### Stash

| Alias | Command | Description |
|-------|---------|-------------|
| `gsta` | `git stash` | Stash changes |
| `gstaa` | `git stash apply` | Apply stash |
| `gstl` | `git stash list` | List stashes |
| `gstp` | `git stash pop` | Pop stash |
| `gstd` | `git stash drop` | Drop stash |
| `gstc` | `git stash clear` | Clear all stashes |

### Undo Operations

| Alias | Command | Description |
|-------|---------|-------------|
| `gundo` | `git reset --soft HEAD~1` | Undo last commit, keep changes |
| `gunstage` | `git restore --staged` | Unstage files |
| `gdiscard` | `git restore` | Discard working changes |

### Show & Inspect

| Alias | Command | Description |
|-------|---------|-------------|
| `gsh` | `git show` | Show commit |
| `gshow` | `git show --pretty=fuller` | Show commit (detailed) |
| `gwhat` | `git show --stat` | Show what changed (files only) |
| `gwho` | `git shortlog -sn` | Contributors by commit count |

### Worktree

| Alias | Command | Description |
|-------|---------|-------------|
| `gwt` | `git worktree` | Worktree command |
| `gwta` | `git worktree add` | Add worktree |
| `gwtl` | `git worktree list` | List worktrees |
| `gwtp` | `git worktree prune` | Prune worktrees |
| `gwtr` | `git worktree remove` | Remove worktree |

### Convenience Shortcuts

| Alias | Description |
|-------|-------------|
| `gfpp` | Checkout develop, fetch, prune, pull |
| `gfpm` | Checkout main/master, fetch, prune, pull |

---

## Common Workflows

### Starting New Feature

```bash
# Update main branch
gfpm                    # Fetch and pull main/master

# Create feature branch
gcb feature/new-thing   # Create and checkout

# Work on feature...
gst                     # Check status
gap                     # Stage changes interactively
gc                      # Commit with diff preview

# Push and set upstream
gpu                     # Push to origin, set tracking
```

### Interactive Staging

```bash
# See what changed
gst

# Stage changes interactively
gap
# For each change:
# y - stage this hunk
# n - don't stage
# s - split into smaller hunks
# q - quit

# Review staged changes
gdc

# Commit
gc
```

### Reviewing Changes

```bash
# Short status
gst

# See unstaged changes
gd

# See staged changes
gdc

# Word-level diff (better for prose)
gdw
```

### Amending Commits

```bash
# Made a typo in last commit message
gca                     # Amend with new message

# Forgot to add a file
ga forgotten-file.txt
gcan                    # Amend without changing message
```

### Branch Management

```bash
# List local branches
gb

# List all branches (including remote)
gba

# Create new branch
gcb feature/awesome

# Switch branches
gco main

# Delete branch (safe - only if merged)
gbd feature/old

# Force delete unmerged branch
gbD feature/abandoned

# Clean up all merged branches
gbclean
```

### Beautiful Log

```bash
# Pretty graph of current branch
glog

# Pretty graph of all branches
gloga

# Compact one-line log
glo
```

**Example glog output:**
```
* a1b2c3d - (HEAD -> main) Add new feature (2 hours ago) <Your Name>
* e4f5g6h - Fix bug in parser (5 hours ago) <Your Name>
*   h7i8j9k - Merge branch 'feature/cool' (1 day ago) <Your Name>
|\
| * k0l1m2n - (feature/cool) Implement cool feature (2 days ago) <Your Name>
|/
* n3o4p5q - Initial commit (1 week ago) <Your Name>
```

### Stashing Work

```bash
# Need to switch branches but have uncommitted changes
gsta                    # Stash changes

# Do other work...
gco other-branch
# ... work ...
gco -                   # Back to previous branch

# Restore stashed changes
gstp                    # Pop stash (apply and remove)

# Or keep stash and just apply
gstaa                   # Apply stash
gstl                    # List remaining stashes
```

### Undoing Mistakes

```bash
# Oops, committed too early
gundo                   # Undo commit, keep changes staged

# Staged wrong files
gunstage file.txt       # Unstage specific file
gunstage .              # Unstage everything

# Made unwanted changes
gdiscard file.txt       # Discard changes in file
# WARNING: Cannot be undone!
```

### Worktree Workflow

```bash
# Working on feature but need to check main
gwtl                    # List worktrees

# Create worktree for hotfix
gwta ../myapp-hotfix main    # New worktree, checked out to main
cd ../myapp-hotfix
# ... fix bug ...
gp

# Back to feature work
cd -
# Feature worktree unchanged

# Clean up
gwtr ../myapp-hotfix    # Remove worktree
gwtp                    # Prune deleted worktrees
```

---

## Workflow Examples

### Feature Branch Workflow

```bash
# 1. Start from main
gfpm                              # Update main

# 2. Create feature branch
gcb feature/user-auth

# 3. Make changes
gap                               # Stage interactively
gc                                # Commit
# ... repeat ...

# 4. Push feature
gpu                               # Push and set upstream

# 5. More commits
gap
gc
gp                                # Just push (upstream already set)

# 6. After PR merged
gco main                          # Back to main
gfpm                              # Update main
gbd feature/user-auth             # Delete feature branch
```

### Hotfix Workflow

```bash
# 1. Start from main
gco main
gpl

# 2. Create hotfix branch
gcb hotfix/critical-bug

# 3. Fix and test
gap
gc

# 4. Push
gpu

# 5. After deploy
gco main
gpl
gbd hotfix/critical-bug
```

### Code Review Workflow

```bash
# Review changes before committing
gst                               # What changed?
gd                                # See actual changes
gap                               # Stage only what you want

# Review staged changes
gdc                               # Diff of staged files

# Commit with detailed message
gc                                # Opens editor with diff
```

### Cleaning Up History

```bash
# See recent commits
glog

# Oops, last commit was wrong
gundo                             # Undo last commit
# Make corrections
gap
gc                                # Commit again

# Fix typo in last commit message
gca                               # Amend with new message

# Add forgotten file to last commit
ga forgotten.txt
gcan                              # Amend without changing message
```

---

## Tips & Best Practices

### 1. Interactive Staging (gap)

**Use when:**
- You made multiple unrelated changes
- You want to commit in logical chunks
- You want to review before committing

**Workflow:**
```bash
gap
# Review each hunk, press:
# y = stage, n = skip, s = split, q = quit
```

### 2. Beautiful Logs (glog)

**Add to your workflow:**
```bash
# Before pulling
glog                    # See your commits

# After pulling
glog                    # See how your commits fit

# When reviewing branches
gloga                   # See all branches
```

### 3. Safe Deletions

**Always try safe delete first:**
```bash
gbd feature/done        # Safe delete (only if merged)
# If it complains:
gba                     # Check if really merged
gbD feature/done        # Force delete if sure
```

### 4. Stash Best Practices

**Name your stashes:**
```bash
git stash push -m "WIP: user authentication"
gstl                    # See all stashes with names
```

**Apply specific stash:**
```bash
git stash apply stash@{1}
```

### 5. Branch Cleanup

**Regular maintenance:**
```bash
# Every week or so
gfp                     # Prune remote tracking branches
gbclean                 # Delete local merged branches
```

### 6. Worktrees for Parallel Work

**When to use:**
- Need to check/fix main while working on feature
- Multiple features in parallel
- Don't want to stash/commit incomplete work

```bash
gwta ../project-main main       # Separate main worktree
cd ../project-main
# Work on hotfix
cd -                            # Back to feature work
```

---

## Comparison: Before vs After

**Before (verbose):**
```bash
git status
git add -p
git commit -v
git push -u origin HEAD
git log --graph --pretty=format:'...' --abbrev-commit
git branch -d old-branch
```

**After (with aliases):**
```bash
gss
gap
gc
gpu
glog
gbd old-branch
```

**Time saved per operation:** ~70% less typing

---

## Troubleshooting

### Alias not found

```bash
# Check if alias exists
alias | grep glog

# Reload zsh config
source ~/.zshrc
```

### Forgot what an alias does

```bash
# Show alias definition
alias glog

# Or check this cheatsheet
```

### Want to use full git command

Just use `git` instead of alias:
```bash
git status              # Instead of gst
git commit              # Instead of gc
```

Aliases don't replace git commands, just supplement them.

---

**Pro tip:** Print this cheatsheet or bookmark it. After a week of using these aliases, they'll become muscle memory!
