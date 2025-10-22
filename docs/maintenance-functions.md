# Maintenance Functions

**What's included:** Shell functions for automated cleanup and maintenance tasks.

**Configured in:** `~/.zshrc`

---

## Overview

Three main maintenance functions are available:

1. **cleanup** - Clean up system resources and caches
2. **update-all** - Update all installed tools
3. **git-maintenance** - Maintain current git repository

---

## cleanup

**What it does:** Cleans up system resources, caches, and unused files.

### Usage

```bash
cleanup
```

### What it cleans

**Homebrew:**
- Removes old versions of installed packages
- Deletes cached downloads
- Removes unused dependencies

**Docker:**
- Removes unused containers
- Removes dangling images
- Removes unused volumes
- Removes unused networks

**Git worktrees:**
- Prunes stale worktree references (current repo only)

**Zsh completions:**
- Clears completion cache
- Rebuilds completions

### When to use

- Monthly maintenance
- Before major updates
- When disk space is low
- After uninstalling applications

### Example

```bash
$ cleanup
🧹 Starting system cleanup...

📦 Cleaning Homebrew...
Removing: /Users/you/Library/Caches/Homebrew/downloads/...
Pruning: 2.5GB freed
✓ Homebrew cleaned

🐳 Cleaning Docker...
Deleted Containers: 5
Deleted Images: 12
Total reclaimed space: 3.2GB

🌳 Pruning git worktrees...
✓ Git worktrees pruned

🔄 Clearing zsh completion cache...
✓ Completion cache cleared

✨ Cleanup complete!
```

---

## update-all

**What it does:** Updates all installed tools in one command.

### Usage

```bash
update-all
```

### What it updates

**Homebrew packages:**
- Updates Homebrew itself
- Upgrades all installed formulae
- Upgrades all installed casks
- Runs cleanup afterward

**Chezmoi:**
- Updates chezmoi to latest version
- Pulls latest dotfiles changes

**asdf plugins (pro machine only):**
- Updates all asdf plugin repositories
- Does NOT update installed tool versions

**Starship:**
- Shows current version
- Reminds you to upgrade via brew

### When to use

- Weekly or bi-weekly
- Before starting major projects
- After seeing "update available" messages

### Example

```bash
$ update-all
🚀 Updating all tools...

📦 Updating Homebrew packages...
==> Updating Homebrew...
==> Upgrading 5 outdated packages:
neovim 0.9.0 -> 0.9.1
ripgrep 13.0.0 -> 14.0.0
...
✓ Homebrew updated

🏠 Updating chezmoi...
✓ Chezmoi updated

🔧 Updating asdf plugins...
nodejs: Already at latest version
python: Already at latest version
✓ asdf plugins updated

✨ Checking starship updates...
starship 1.16.0
   (run 'brew upgrade starship' if outdated)

✅ All updates complete!
```

### What it doesn't update

- **Language versions** (use `asdf install <tool> latest`)
- **Global npm packages** (use `npm update -g`)
- **Python packages** (use `pipx upgrade-all`)
- **macOS system updates** (use System Settings)

---

## git-maintenance

**What it does:** Performs maintenance on the current git repository.

### Usage

```bash
# Run from any directory in a git repo
git-maintenance
```

### What it does

**Fetch and prune:**
- Fetches from all remotes
- Removes references to deleted remote branches

**Clean merged branches:**
- Identifies locally merged branches
- Deletes them automatically
- Preserves main, master, and develop branches

**Prune worktrees:**
- Removes stale worktree references

**Garbage collection:**
- Runs `git gc --auto`
- Optimizes repository storage

### When to use

- After merging PRs
- Before starting new features
- When you have many old branches
- Monthly repository maintenance

### Example

```bash
$ cd ~/projects/myapp
$ git-maintenance
🔧 Running git maintenance...

📥 Fetching and pruning...
From github.com:user/repo
 - [deleted]         (none)     -> origin/feature/old-branch

🌿 Cleaning merged branches...
Deleted branch feature/completed-work (was abc1234)
Deleted branch fix/minor-bug (was def5678)

🌳 Pruning worktrees...

🗑️  Running garbage collection...
Auto packing the repository in background for optimum performance.

✅ Git maintenance complete!
```

### Safety notes

- Only deletes branches that are fully merged
- Never deletes main/master/develop branches
- Never deletes the current branch
- Safe to run anytime

---

## Scheduling Maintenance

### Manual schedule

**Weekly:**
```bash
update-all
```

**Monthly:**
```bash
cleanup
```

**Per project (as needed):**
```bash
cd ~/project
git-maintenance
```

### Future: Automated scheduling

You could add cron jobs or use macOS launchd for automatic maintenance:

**Example launchd plist** (not implemented yet):
```xml
<!-- ~/Library/LaunchAgents/local.maintenance.plist -->
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
  "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>local.maintenance</string>
  <key>ProgramArguments</key>
  <array>
    <string>/bin/zsh</string>
    <string>-c</string>
    <string>source ~/.zshrc && cleanup</string>
  </array>
  <key>StartCalendarInterval</key>
  <dict>
    <key>Weekday</key>
    <integer>0</integer> <!-- Sunday -->
    <key>Hour</key>
    <integer>2</integer> <!-- 2 AM -->
  </dict>
</dict>
</plist>
```

---

## Tips

### 1. Dry run equivalent

**For cleanup:**
```bash
# See what Homebrew would clean
brew cleanup --dry-run

# See what Docker would remove
docker system df
```

**For updates:**
```bash
# Check for Homebrew updates without upgrading
brew outdated
```

### 2. Selective updates

Instead of `update-all`, you can update specific tools:

```bash
# Just Homebrew
brew update && brew upgrade

# Just one package
brew upgrade neovim

# Just asdf plugins
asdf plugin update --all
```

### 3. Disk space check

Before cleanup:
```bash
# Overall disk usage
df -h

# Homebrew cache size
du -sh ~/Library/Caches/Homebrew

# Docker disk usage
docker system df
```

After cleanup:
```bash
df -h  # Compare
```

### 4. Git maintenance for all repos

Run maintenance on multiple repos:

```bash
# Using find
for repo in ~/projects/*/; do
  cd "$repo"
  if [ -d .git ]; then
    echo "Maintaining $repo"
    git-maintenance
  fi
done
```

### 5. Combining commands

Run multiple maintenance tasks at once:

```bash
# Weekly routine
update-all && cleanup

# Full maintenance
update-all && cleanup && cd ~/projects/myapp && git-maintenance
```

---

## Troubleshooting

### "Docker not running"

**Issue:** Docker cleanup skipped with warning

**Solution:**
```bash
# Start Docker Desktop first
open -a Docker

# Wait for it to start, then run cleanup again
cleanup
```

### "Permission denied" during cleanup

**Issue:** Can't delete certain files

**Solution:**
```bash
# Homebrew permissions
sudo chown -R $(whoami) /opt/homebrew  # ARM Mac
sudo chown -R $(whoami) /usr/local     # Intel Mac

# Then try again
cleanup
```

### Git maintenance deletes wrong branch

**Issue:** Branch deleted that shouldn't have been

**Solution:**
```bash
# Find the branch in reflog
git reflog

# Restore it
git checkout -b branch-name <commit-hash>
```

### Update-all is slow

**Issue:** Takes too long to run

**Solution:**
```bash
# Update only critical tools
brew update && brew upgrade chezmoi starship

# Skip asdf plugin updates if not needed
# (edit function to comment out asdf section)
```

---

## Configuration

### Customize Docker cleanup

Edit the `cleanup()` function in `~/.zshrc`:

```bash
# Less aggressive (keep volumes)
docker system prune -af

# More aggressive (remove everything)
docker system prune -af --volumes --all
```

### Exclude branches from git-maintenance

Edit the `git-maintenance()` function:

```bash
# Add more branches to preserve
git branch --merged | grep -v '\*\|main\|master\|develop\|staging\|production'
```

### Add more update targets

Add to `update-all()` function:

```bash
# npm global packages
if command -v npm &> /dev/null; then
  echo "\n📦 Updating npm packages..."
  npm update -g
fi

# pipx packages
if command -v pipx &> /dev/null; then
  echo "\n🐍 Updating pipx packages..."
  pipx upgrade-all
fi
```

---

## Quick Reference

| Function | Purpose | Frequency |
|----------|---------|-----------|
| `cleanup` | Clean caches and unused files | Monthly |
| `update-all` | Update all tools | Weekly |
| `git-maintenance` | Clean up git repo | As needed |

---

**Pro tip:** Run `update-all` every Monday morning and `cleanup` on the first of each month. Add reminders to your calendar!
