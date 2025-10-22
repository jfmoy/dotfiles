# asdf - Version Manager Cheatsheet

**What it does:** Unified version manager for Node.js, Python, Ruby, Terraform, Kubectl, and 500+ more tools.

**Why use it:** Replaces N (node), pyenv, rbenv, tfenv with a single tool. Per-project version management.

---

## Initial Setup

```bash
# Already installed via Brewfile
# Already initialized in .zshrc

# Install plugins for languages you need
asdf plugin add nodejs
asdf plugin add python
asdf plugin add terraform
asdf plugin add kubectl
```

---

## Common Commands

### List Plugins

```bash
asdf plugin list                    # List installed plugins
asdf plugin list all               # List all available plugins
asdf plugin add nodejs             # Add a plugin
```

### Install Versions

```bash
asdf list all nodejs               # List all available Node.js versions
asdf install nodejs latest         # Install latest Node.js
asdf install nodejs 20.10.0        # Install specific version
asdf install nodejs lts            # Install latest LTS

asdf install terraform 1.6.0       # Install Terraform 1.6.0
asdf install python 3.11.0         # Install Python 3.11.0
```

### Set Versions

```bash
# Global (default for all directories)
asdf global nodejs 20.10.0
asdf global terraform 1.6.0

# Local (current directory and subdirectories)
asdf local nodejs 18.0.0
asdf local terraform 1.5.0

# Shell (current shell session only)
asdf shell nodejs 16.0.0
```

### List Versions

```bash
asdf list nodejs                   # List installed Node.js versions
asdf current                       # Show current versions for all tools
asdf current nodejs                # Show current Node.js version
asdf where nodejs                  # Show install path for current version
```

### Uninstall

```bash
asdf uninstall nodejs 18.0.0       # Remove specific version
asdf plugin remove nodejs          # Remove plugin entirely
```

---

## Per-Project Versions

Create `.tool-versions` file in project root:

```bash
# .tool-versions example
nodejs 18.16.0
terraform 1.5.0
kubectl 1.28.0
python 3.11.0
```

When you `cd` into the directory, asdf automatically switches to those versions.

```bash
# Quick way to add current versions to .tool-versions
asdf local nodejs 18.16.0
asdf local terraform 1.5.0
```

---

## Migrating from N (Node Version Manager)

```bash
# 1. Check current Node version
node -v  # e.g., 20.10.0

# 2. Install same version with asdf
asdf plugin add nodejs
asdf install nodejs 20.10.0
asdf global nodejs 20.10.0

# 3. Verify it works
node -v
npm -v

# 4. Remove N
rm -rf ~/.n
# Remove N from PATH in .zshrc (we'll do this later if needed)
```

---

## Common Workflows

### New Project Setup

```bash
cd my-project

# Set versions for this project
asdf local nodejs 18.16.0
asdf local terraform 1.5.0

# .tool-versions file is created
git add .tool-versions
git commit -m "Add tool versions"

# Team members with asdf will use same versions
```

### Upgrade Tool

```bash
# List available versions
asdf list all nodejs

# Install new version
asdf install nodejs 20.11.0

# Test it in current shell
asdf shell nodejs 20.11.0
node -v

# If good, set as global
asdf global nodejs 20.11.0
```

### Update Plugin

```bash
asdf plugin update nodejs          # Update single plugin
asdf plugin update --all          # Update all plugins
```

---

## Useful Plugins for Your Work

```bash
# Infrastructure/Cloud
asdf plugin add terraform
asdf plugin add kubectl
asdf plugin add helm
asdf plugin add awscli

# Languages
asdf plugin add nodejs
asdf plugin add python
asdf plugin add golang

# Database tools
asdf plugin add postgres
```

---

## Tips

1. **Reshim after global package install:**
   ```bash
   npm install -g some-package
   asdf reshim nodejs
   ```

2. **Check what's using a version:**
   ```bash
   asdf current
   ```

3. **Legacy version files:**
   asdf can read `.nvmrc`, `.node-version`, `.terraform-version` files

4. **Performance:**
   Much faster than switching with N/nvm because no symlink changes

---

## Troubleshooting

**Command not found after install:**
```bash
asdf reshim nodejs
```

**Version not switching:**
```bash
# Check what's setting the version
asdf current nodejs

# Check .tool-versions in current and parent directories
cat .tool-versions
```

**Remove old version:**
```bash
asdf list nodejs
asdf uninstall nodejs 16.0.0
```

---

**Docs:** https://asdf-vm.com
