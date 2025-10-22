# Starship Prompt Configuration Guide

**What it does:** Customizes your shell prompt with useful information and beautiful formatting.

**Configured in:** `~/.config/starship.toml`

---

## Overview

Your starship prompt shows:

**Left side (main prompt):**
- Username (if not default)
- Hostname (if SSH)
- Current directory (truncated)
- Git branch and status
- Success/error indicator

**Right side (context):**
- Command duration (if > 500ms)
- Kubernetes context
- AWS profile
- Terraform workspace
- Docker context

---

## Prompt Formats

### Normal state (no git)
```
┌─~/projects/myapp
└─> ➜
```

### With git branch
```
┌─~/projects/myapp on  main
└─> ➜
```

### With uncommitted changes
```
┌─~/projects/myapp on  main [!2 ?1]
└─> ➜
```
- `!2` = 2 modified files
- `?1` = 1 untracked file

### After error
```
┌─~/projects/myapp on  main
└─> ✗
```

### With context (pro machine)
```
┌─~/terraform/infra on  main [+3]          ☁️  production 💠 staging
└─> ➜
```
- `[+3]` = 3 staged files
- `☁️  production` = AWS profile
- `💠 staging` = Terraform workspace

### Slow command
```
┌─~/projects/myapp on  main                          took 2.3s
└─> ➜
```

### SSH session
```
┌─jeff on remote-server in ~/projects
└─> ➜
```

---

## Git Status Symbols

| Symbol | Meaning |
|--------|---------|
| `!n` | n modified files |
| `+n` | n staged files |
| `?n` | n untracked files |
| `✘n` | n deleted files |
| `📦n` | n stashed changes |
| `=n` | n conflicted files |
| `⇡n` | n commits ahead of remote |
| `⇣n` | n commits behind remote |
| `⇕⇡n⇣m` | Diverged: n ahead, m behind |

### Examples

```
[!3 +2 ?1]     # 3 modified, 2 staged, 1 untracked
[+5]           # 5 staged (ready to commit)
[!1 ⇡2]        # 1 modified, 2 commits ahead
[⇣3]           # 3 commits behind (need to pull)
[=2]           # 2 conflicted files (merge conflict)
```

---

## Context Indicators

### Kubernetes
```
☸ my-cluster(default)
```
Shows current kubectl context and namespace.

**Useful for:** Avoiding commands on wrong cluster

### AWS
```
☁️  production(us-east-1)
```
Shows AWS profile and region.

**Useful for:** Knowing which AWS account you're targeting

### Terraform
```
💠 staging
```
Shows current terraform workspace.

**Useful for:** Avoiding applying to wrong environment

### Docker
```
🐳 my-context
```
Shows Docker context.

**Useful for:** When using multiple Docker hosts

### Language Versions

Shown when in project directory:

```
⬢ 20.10.0          # Node.js
🐍 3.11.0          # Python
🐹 1.21.0          # Go
```

---

## Customization

### Change Prompt Format

**Single-line prompt:**
```toml
format = "$directory$git_branch$git_status$character"
```

Result:
```
~/projects/myapp on  main [!1] ➜
```

**Simpler two-line:**
```toml
format = """
$directory$git_branch$git_status
$character"""
```

Result:
```
~/projects/myapp on  main [!1]
➜
```

### Disable Features

**Don't show Kubernetes:**
```toml
[kubernetes]
disabled = true
```

**Don't show command duration:**
```toml
[cmd_duration]
disabled = true
```

**Don't show language versions:**
```toml
[nodejs]
disabled = true

[python]
disabled = true

[golang]
disabled = true
```

### Change Symbols

**Different git branch symbol:**
```toml
[git_branch]
symbol = "🌱 "    # or "🔱 " or " " or ""
```

**Different prompt symbol:**
```toml
[character]
success_symbol = "[❯](bold green)"
error_symbol = "[❯](bold red)"
```

**Simple text instead of emoji:**
```toml
[aws]
format = '[aws:$profile]($style) '

[kubernetes]
format = '[k8s:$context]($style) '
```

### Adjust Directory Truncation

**Show more directories:**
```toml
[directory]
truncation_length = 5  # Default: 3
```

**Don't truncate:**
```toml
[directory]
truncation_length = 0
```

**Show full path:**
```toml
[directory]
truncate_to_repo = false
```

### Change Command Duration Threshold

**Show for commands over 1 second:**
```toml
[cmd_duration]
min_time = 1000
```

**Always show:**
```toml
[cmd_duration]
min_time = 0
```

### Add Timestamp

**Enable time:**
```toml
[time]
disabled = false
```

**Custom format:**
```toml
[time]
disabled = false
time_format = "%H:%M:%S"
format = "at [$time]($style) "
```

Result:
```
┌─~/projects on  main                          at 14:23:45
└─> ➜
```

---

## Presets

Starship has built-in presets you can use instead:

**View presets:**
```bash
starship preset --help
```

**Use a preset:**
```bash
# Nerd Font Symbols
starship preset nerd-font-symbols -o ~/.config/starship.toml

# Pure prompt
starship preset pure-preset -o ~/.config/starship.toml

# Pastel Powerline
starship preset pastel-powerline -o ~/.config/starship.toml
```

**Try before saving:**
```bash
starship preset nerd-font-symbols | less
```

---

## Tips

### 1. Test Changes

After editing `~/.config/starship.toml`:
```bash
# Apply changes (opens new prompt)
exec zsh

# Or just start new terminal
```

### 2. Debug Prompt

**See what starship is detecting:**
```bash
starship explain
```

**Check config:**
```bash
starship config
```

**Validate config:**
```bash
starship print-config
```

### 3. Git Status Performance

If git status is slow in large repos:
```toml
[git_status]
disabled = true  # In specific repos
```

Or create `.git/config` override:
```bash
git config --local starship.git_status.disabled true
```

### 4. SSH Sessions

Username/hostname automatically show when SSH'd:
```
┌─jeff on production-server in ~/app
└─> ➜
```

### 5. Context-Specific Config

**Different config per project:**
```bash
cd project
export STARSHIP_CONFIG=~/project/.starship.toml
```

### 6. Transient Prompt

Make previous prompts shorter (fish-style):
```toml
[transient_prompt]
enabled = true
```

---

## Troubleshooting

### Symbols not showing

**Install Nerd Font:**
- Already have: JetBrains Mono Nerd Font
- Make sure terminal is using it

**Test unicode:**
```bash
echo "     ➜ ✗"
```

Should show icons. If not, font issue.

### Slow prompt

**Profile startup:**
```bash
time zsh -i -c exit
```

**Check which module is slow:**
```bash
starship timings
```

**Disable slow modules:**
```toml
[git_status]
disabled = true
```

### Context not showing

**Kubernetes:**
```bash
# Check kubectl config exists
ls ~/.kube/config

# Test kubectl
kubectl config current-context
```

**AWS:**
```bash
# Check AWS_PROFILE set
echo $AWS_PROFILE

# Or check credentials
ls ~/.aws/credentials
```

**Terraform:**
```bash
# Must be in terraform directory
cd /path/to/terraform
cat .terraform/environment
```

### Colors wrong

**Test colors:**
```bash
starship config get | grep style
```

**Override theme:**
```toml
[character]
success_symbol = "[>](green)"  # Force color
```

---

## Common Configurations

### Minimal

```toml
format = "$directory$git_branch$character"

[directory]
truncation_length = 1

[git_branch]
symbol = ""
```

Result:
```
~/myapp main ➜
```

### Detailed

```toml
format = """
$username$hostname$directory$git_branch$git_status
$nodejs$python$golang$docker_context
$character"""

right_format = "$cmd_duration$time"

[time]
disabled = false
```

Result:
```
~/myapp on main [!2] ⬢ 20.10.0
➜
```

### Power User

```toml
format = """
╭─$username$hostname$directory$git_branch$git_status
╰─❯ $character"""

right_format = "$all"  # Show everything

[git_status]
ahead = "⇡"
behind = "⇣"
diverged = "⇕"
modified = "!"
staged = "+"
untracked = "?"
```

---

## Quick Reference

| Config File | `~/.config/starship.toml` |
| Reload | `exec zsh` or new terminal |
| Test | `starship explain` |
| Docs | https://starship.rs/config/ |
| Presets | `starship preset --help` |

---

**Pro tip:** Your current config is comprehensive but not overwhelming. Try it for a few days before customizing. The defaults are well-chosen!
