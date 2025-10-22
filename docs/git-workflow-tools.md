# Git Workflow Tools Guide

**What's included:** Modern tools to enhance git workflows beyond basic CLI.

**Tools:**
- **lazygit** - Terminal UI for git operations
- **git-absorb** - Automatic fixup commits
- **difftastic** - Syntax-aware diffs

---

## lazygit - Terminal UI for Git

**What it is:** Fast, keyboard-driven terminal interface for git operations.

**Why use it:** Faster than GUI (Tower), richer than CLI. Visual staging, branch management, and interactive rebase made simple.

### Launch

```bash
lazygit                     # In current repo
lazygit -p /path/to/repo   # Specific repo
```

### Interface Layout

```
┌─────────────────────────────────────────────────────────┐
│ Status Panel                    │ Files Panel           │
│ Branch: main ↑1 ↓0             │ ✓ staged.js          │
│ No conflicts                    │ M modified.js        │
│                                 │ ?? untracked.js      │
├─────────────────────────────────┼──────────────────────┤
│ Branches Panel                  │ Main Panel           │
│ * main                          │ +added line          │
│   feature/auth                  │ -removed line        │
│   hotfix/bug                    │                      │
└─────────────────────────────────┴──────────────────────┘
Status: press ? for help
```

### Navigation

**Switch panels:**
```
1 - Status
2 - Files
3 - Branches
4 - Commits
5 - Stash
```

**Within panels:**
```
j/k or ↓/↑  - Move up/down
h/l or ←/→  - Collapse/expand
enter       - View details
esc         - Go back
q           - Quit
?           - Help
```

### Common Operations

**Staging:**
```bash
# In Files panel (press 2)
space       # Stage/unstage file
a           # Stage all
d           # Discard changes
enter       # View file diff

# Stage individual hunks
enter       # Open file
space       # Stage/unstage hunk
esc         # Back to files
```

**Committing:**
```bash
# In Files panel
c           # Commit
# Type message, save and close

# Amend last commit
A           # Amend (uppercase A)
```

**Branches:**
```bash
# In Branches panel (press 2)
enter       # Checkout branch
n           # New branch
d           # Delete branch
r           # Rebase branch
m           # Merge into current branch
space       # Checkout branch
```

**Pushing/Pulling:**
```bash
p           # Pull
P           # Push (uppercase P)
shift+P     # Force push (dangerous!)
```

**Stashing:**
```bash
# In Files panel
s           # Stash all changes

# In Stash panel (press 5)
enter       # View stash contents
space       # Apply stash
d           # Drop stash
g           # Pop stash
```

**Interactive Rebase:**
```bash
# In Commits panel (press 4)
e           # Edit commit
d           # Drop commit
p           # Pick commit
s           # Squash with previous
r           # Rename commit
m           # Move commit up/down

# Or press 'i' to enter interactive rebase mode
# Then: pick/squash/edit commits
```

### Workflows

**Quick staging and commit:**
```bash
1. Launch: lazygit
2. Press 2 (Files panel)
3. Navigate with j/k
4. Press space to stage files
5. Press c to commit
6. Type message, save
7. Press P to push
```

**Interactive staging (hunks):**
```bash
1. Press 2 (Files panel)
2. Press enter on modified file
3. Navigate hunks with j/k
4. Press space to stage/unstage each hunk
5. Press esc to go back
6. Press c to commit staged changes
```

**Branch switching:**
```bash
1. Press 3 (Branches panel)
2. Navigate with j/k
3. Press enter or space to checkout
```

**Clean up old branches:**
```bash
1. Press 3 (Branches panel)
2. Navigate to merged branch
3. Press d to delete
4. Confirm with enter
```

**Resolve merge conflicts:**
```bash
1. lazygit shows conflicted files
2. Press 2 (Files panel)
3. Conflicted files marked in red
4. Press enter on conflicted file
5. Edit file in editor
6. Save file
7. Back in lazygit, press space to stage resolution
8. Press c to commit merge
```

**Rebase current branch:**
```bash
1. Press 3 (Branches panel)
2. Navigate to base branch (e.g., main)
3. Press r (rebase current onto selected)
4. Confirm
```

### Tips

1. **Custom commands:** Press `x` to run custom git commands
2. **Search:** Press `/` to search in current panel
3. **Filter:** Press `f` to filter commits
4. **Cherry-pick:** In Commits panel, press `c` on a commit
5. **View all keybindings:** Press `?` for complete help

### Configuration

Create `~/.config/lazygit/config.yml` for customization:

```yaml
gui:
  theme:
    activeBorderColor:
      - blue
      - bold

git:
  paging:
    useConfig: true

os:
  editCommand: 'nvim'  # or 'vim', 'code', etc.
```

---

## git-absorb - Automatic Fixup Commits

**What it is:** Automatically creates `git commit --fixup` for changes that should belong to previous commits.

**Why use it:** Save time when fixing bugs in feature branches - automatically associate fixes with the right commits.

### How It Works

```bash
# Your commit history:
abc123 Add user authentication
def456 Add user tests
ghi789 Add documentation

# You fix a typo in the authentication code
vim src/auth.js         # Fix typo

# Instead of:
git add src/auth.js
git commit --fixup abc123
git rebase -i --autosquash HEAD~3

# Just do:
git add src/auth.js
git absorb
# Automatically creates fixup! commit for abc123
git rebase -i --autosquash HEAD~3
```

### Usage

**Basic workflow:**
```bash
# Make changes to existing code
vim file.js

# Stage changes
git add file.js

# Run absorb
git absorb

# It creates fixup commits automatically
# View what it did:
git log --oneline

# Apply fixups:
git rebase -i --autosquash HEAD~5
```

**Dry run (see what would happen):**
```bash
git absorb --dry-run
```

**Absorb and auto-rebase:**
```bash
git absorb --and-rebase
```

**Force absorb (bypass safety checks):**
```bash
git absorb --force
```

### When to Use

**Good use cases:**
- Fixing typos in recent commits
- Adding forgotten files to logical commits
- Cleaning up code style in feature branch
- Fixing bugs discovered during feature development

**Don't use when:**
- Working on main/master branch
- Commits already pushed and shared
- Unsure which commit the fix belongs to (review manually)

### Safety

- Only affects unpushed commits
- Won't create fixups for commits older than base branch
- Use `--dry-run` first if unsure
- Can always undo with `git reflog`

---

## difftastic - Syntax-Aware Diffs

**What it is:** Diff tool that understands code structure, not just lines.

**Why use it:** Better visualization of refactoring, function renames, and structural changes. Complements delta.

### Comparison

**Regular diff (line-based):**
```diff
-function getUserName(user) {
-  return user.name;
-}
+function getUserFullName(user) {
+  return user.firstName + ' ' + user.lastName;
+}
```

**difftastic (structure-based):**
```diff
function getUserName → getUserFullName(user) {
  return:
    - user.name
    + user.firstName + ' ' + user.lastName
```

### Usage

**One-time use:**
```bash
# View diff with difftastic
GIT_EXTERNAL_DIFF=difft git diff

# Staged changes
GIT_EXTERNAL_DIFF=difft git diff --cached

# Specific commit
GIT_EXTERNAL_DIFF=difft git show abc123
```

**Create alias:**
Add to `~/.zshrc`:
```bash
alias gdiff="GIT_EXTERNAL_DIFF=difft git diff"
alias gdiffc="GIT_EXTERNAL_DIFF=difft git diff --cached"
```

**Configure as default (optional):**
```bash
# Add to ~/.gitconfig
[diff]
  external = difft
  tool = difftastic

[difftool]
  prompt = false

[difftool "difftastic"]
  cmd = difft "$LOCAL" "$REMOTE"

# Then use:
git difftool
```

**Show specific file:**
```bash
GIT_EXTERNAL_DIFF=difft git diff -- src/file.js
```

### Language Support

Supports 30+ languages including:
- JavaScript/TypeScript
- Python
- Go
- Rust
- Java
- Ruby
- C/C++
- Shell scripts
- JSON/YAML
- And more...

### When to Use

**Use difftastic for:**
- Reviewing refactoring PRs
- Understanding function/class renames
- Structural code changes
- Large file reorganizations

**Use delta (default) for:**
- Line-by-line changes
- Quick diffs
- Text files
- Familiar git diff experience

### Tips

1. **Side-by-side view:**
   ```bash
   difft --display side-by-side file1.js file2.js
   ```

2. **Color output:**
   ```bash
   difft --color always file1.js file2.js
   ```

3. **Compare with delta:**
   ```bash
   git diff file.js              # delta (line-based)
   gdiff file.js                 # difftastic (structure-based)
   ```

---

## Alternative: git-branchless (Not Installed)

**What it is:** Advanced workflow tools for branch management.

**Why it's interesting:**
- `git undo` - Undo any operation (even complex rebases)
- `git smartlog` - Better commit visualization
- `git move` - Move commits between branches
- `git sync` - Keep branches synchronized

**Installation (if interested later):**
```bash
brew install git-branchless

# Initialize in repo
git branchless init
```

**Key features:**

**Undo any operation:**
```bash
git rebase -i HEAD~5           # Oops, messed up
git undo                       # Undoes the rebase
```

**Smart log:**
```bash
git smartlog
# Output:
# ◯ main
# │
# ◯ feature-a
# │
# ◯ feature-b (current)
```

**Move commits:**
```bash
git move -b target-branch abc123..def456
# Moves commits to different branch
```

**Why not installed by default:**
- Requires initialization per repo
- Learning curve for advanced features
- Can be overkill for standard workflows
- Git's built-in reflog already handles most undo cases

**Consider if:**
- You frequently do complex rebases
- You want visual branch relationships
- You move commits between branches often
- You need powerful undo capabilities

---

## Comparison: When to Use Each Tool

| Task | Tool | Why |
|------|------|-----|
| Quick status check | `gst` alias | Fastest |
| Stage files | `lazygit` | Visual, easy |
| Stage hunks | `lazygit` | Better than `git add -p` |
| Commit | `lazygit` or `gc` | Either works |
| Branch management | `lazygit` | Visual switching |
| Interactive rebase | `lazygit` | Much easier |
| Fixup old commits | `git-absorb` | Automatic |
| View refactoring | `difftastic` | Structural view |
| Line changes | `git diff` (delta) | Fast, familiar |
| Complex undo | `git reflog` | Built-in |

---

## Recommended Workflow

**Daily development:**
```bash
1. lazygit              # Visual git interface
2. Stage, commit, push visually
3. Use aliases for quick ops (gst, glog, etc.)
```

**When fixing bugs in feature branch:**
```bash
1. Fix bugs as you develop
2. git add .
3. git absorb           # Auto-fixup to right commits
4. git rebase -i --autosquash HEAD~10
```

**Reviewing changes:**
```bash
1. git diff             # Quick line-based (delta)
2. gdiff                # Structural view (difftastic) if refactoring
3. lazygit              # Visual review of all changes
```

---

**Quick start:** Just run `lazygit` in a git repo and press `?` for help. You'll learn it in 5 minutes!
