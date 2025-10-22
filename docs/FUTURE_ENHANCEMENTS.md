# Future Enhancements

Optional improvements to consider implementing later.

---

## #10: 1Password CLI Integration with direnv

**Status:** Nice to have

**What it does:** Integrate 1Password CLI to load secrets from vaults into environment variables automatically.

**Benefits:**
- Keep secrets out of `.envrc` files
- Centralized secret management
- Works with existing 1Password setup

**Implementation approach:**
```bash
# In .envrc
export DATABASE_URL="op://vault/item/field"
eval $(op signin)
```

**Prerequisites:**
- 1Password CLI already installed
- Need to set up vaults and items
- Need to configure per-project .envrc files

**When to implement:**
- When managing multiple projects with different credentials
- When API keys/secrets start accumulating in multiple places
- When team needs consistent secret management

---

## #11: Git Configuration Enhancements

**Status:** Nice to have

**What it does:** Add more advanced git settings to `~/.gitconfig`

**Proposed additions:**
- **Rebase by default**: `pull.rebase = true`
- **Auto-stash**: `rebase.autoStash = true`
- **Better merge conflict style**: `merge.conflictStyle = diff3`
- **Prune on fetch**: `fetch.prune = true`
- **Default branch**: `init.defaultBranch = main`
- **Signing commits**: GPG/SSH commit signing (optional)

**Benefits:**
- Cleaner history (rebase by default)
- Fewer "forgot to stash" moments
- Better merge conflict resolution view
- Automatic remote branch cleanup
- Modern default branch naming

**When to implement:**
- When comfortable with current git workflow
- When ready to standardize on rebase workflow
- When commit signing becomes a requirement

**Implementation:**
Add to `~/.gitconfig` or `private_dot_gitconfig.tmpl` in chezmoi

---

## #12: macOS Defaults Script

**Status:** Nice to have

**What it does:** Automate macOS system preferences configuration.

**Examples:**
- Faster key repeat rate
- Disable press-and-hold for accents (enables key repeat in all apps)
- Show hidden files in Finder
- Disable auto-correct
- Dock settings (size, autohide, position)
- Trackpad/mouse settings
- Screenshot format and location
- Menu bar configuration
- Energy saving preferences

**Benefits:**
- Consistent setup across machines
- Quick onboarding for new Macs
- Document your preferred settings
- Undo Apple's "helpful" defaults

**Implementation approach:**
Create `run_once_after_20-macos-defaults.sh.tmpl` with:

```bash
#!/bin/bash

# Key repeat
defaults write -g InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 2

# Finder
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowPathbar -bool true

# Dock
defaults write com.apple.dock tilesize -int 36
defaults write com.apple.dock autohide -bool true

# Screenshots
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Restart affected applications
killall Finder Dock
```

**When to implement:**
- Before setting up a new Mac
- When documenting current preferences
- When specific macOS defaults become annoying
- When you want reproducible system configuration

**Caution:**
- Some settings require logout/restart
- Test changes before committing
- macOS updates may reset some preferences
- Document what each setting does

---

## #13: Backup/Restore Strategy

**Status:** Documentation task

**What it does:** Document and optionally automate backup of important data not in dotfiles.

**What to backup:**

**Secrets (encrypted):**
- SSH keys (`~/.ssh/`)
- GPG keys (if used)
- AWS credentials (though 1Password integration is better)
- Application-specific tokens

**Application data:**
- VS Code/Cursor workspaces
- JetBrains IDE settings (though sync handles this)
- Database exports (dev databases)
- Browser profiles (if not using sync)

**Project metadata:**
- List of active projects
- Custom scripts not in repos
- Documentation/notes

**What NOT to backup:**
- Anything in 1Password (already backed up)
- Git repositories (should be on remote)
- Homebrew packages (documented in Brewfile)
- Application binaries

**Implementation approach:**

**Option 1: Documentation only**
Create `docs/BACKUP_STRATEGY.md` explaining:
- What needs manual backup
- Where to store backups (encrypted drive, cloud)
- Recovery procedure

**Option 2: Backup script**
Create script that:
- Tars up SSH keys (encrypted)
- Exports database schemas
- Creates project list
- Uploads to secure location

**When to implement:**
- Before major system changes
- Before wiping a machine
- When setting up backup routines
- When disaster recovery becomes a concern

**Reality check:**
Most important data is already backed up:
- Dotfiles → chezmoi (git repo)
- Secrets → 1Password
- Code → Git remotes
- IDE settings → JetBrains Account

Main gaps:
- SSH keys (easy to regenerate)
- Local databases (dev data, can recreate)
- Un-committed work (commit more often!)

**Recommendation:** Start with documentation, add automation only if actually needed.

---

## Priority Assessment

**High value, low effort:**
- #11: Git configuration enhancements (5 minutes to implement)

**High value, medium effort:**
- #12: macOS defaults script (1-2 hours to document current settings)

**Medium value, variable effort:**
- #10: 1Password CLI integration (depends on how many secrets to migrate)
- #13: Backup strategy (mostly documentation)

---

## Next Steps

When ready to implement any of these:

1. Review the recommendation
2. Test changes in isolation first
3. Update chezmoi templates
4. Document in appropriate cheatsheet
5. Apply and verify

No rush - current setup is already comprehensive and functional!

---

**Last updated:** 2025-10-22
