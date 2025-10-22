# direnv - Per-Directory Environment Variables

**What it does:** Automatically loads and unloads environment variables when you cd into/out of directories.

**Why use it:** Manage AWS profiles, API keys, database URLs, feature flags per-project without manual export/unset.

---

## How It Works

1. Create `.envrc` file in project directory
2. Add environment variables
3. Run `direnv allow`
4. Variables automatically load when entering directory
5. Variables automatically unload when leaving directory

---

## Basic Usage

### Simple Environment Variables

```bash
cd ~/projects/my-app

# Create .envrc
cat > .envrc << 'EOF'
export AWS_PROFILE=my-app-dev
export DATABASE_URL=postgresql://localhost/myapp
export DEBUG=true
EOF

# Allow direnv to load it (security feature)
direnv allow

# Variables are now set
echo $AWS_PROFILE  # my-app-dev

# Leave directory - variables are unset
cd ..
echo $AWS_PROFILE  # (empty)
```

---

## Common Patterns

### AWS Profiles

```bash
# .envrc
export AWS_PROFILE=production
export AWS_REGION=us-east-1
```

### Database URLs

```bash
# .envrc
export DATABASE_URL=postgresql://localhost:5432/myapp_dev
export REDIS_URL=redis://localhost:6379/0
```

### API Keys (DO NOT COMMIT)

```bash
# .envrc (add to .gitignore!)
export STRIPE_API_KEY=sk_test_xxxxx
export SENDGRID_API_KEY=SG.xxxxx

# Load from 1Password instead
export STRIPE_API_KEY=$(op read "op://Private/Stripe/api_key")
```

### Feature Flags

```bash
# .envrc
export ENABLE_BETA_FEATURES=true
export LOG_LEVEL=debug
```

### Node/Python Versions (with asdf)

```bash
# .envrc
use asdf

# This loads versions from .tool-versions file
```

### PATH Additions

```bash
# .envrc
# Add project bin to PATH
PATH_add bin
PATH_add ./node_modules/.bin

# Now you can run local scripts directly
# Instead of: ./bin/my-script
# Just run: my-script
```

### Load .env Files

```bash
# .envrc
# Load variables from .env file
dotenv

# Or specific file
dotenv .env.local
```

---

## Advanced Patterns

### Conditional Logic

```bash
# .envrc
if [ "$USER" = "jeff" ]; then
  export AWS_PROFILE=jeff-dev
else
  export AWS_PROFILE=team-dev
fi
```

### Terraform Workspaces

```bash
# .envrc
export TF_WORKSPACE=staging
export TF_VAR_environment=staging
export TF_VAR_region=us-east-1
```

### Docker Compose

```bash
# .envrc
export COMPOSE_FILE=docker-compose.yml:docker-compose.dev.yml
export COMPOSE_PROJECT_NAME=myapp
```

### Multiple Environments

```bash
# projects/myapp/dev/.envrc
export ENVIRONMENT=development
export AWS_PROFILE=myapp-dev
export DATABASE_URL=postgresql://localhost/myapp_dev

# projects/myapp/staging/.envrc
export ENVIRONMENT=staging
export AWS_PROFILE=myapp-staging
export DATABASE_URL=postgresql://staging-db.example.com/myapp
```

---

## Security Best Practices

### DO NOT commit secrets

```bash
# Always add .envrc to .gitignore
echo ".envrc" >> .gitignore
```

### Use 1Password Integration

```bash
# .envrc
export API_KEY=$(op read "op://Private/MyApp/api_key")
export DB_PASSWORD=$(op read "op://Private/Database/password")
```

### Create .envrc.example

```bash
# .envrc.example (committed to git)
export AWS_PROFILE=CHANGEME
export DATABASE_URL=postgresql://localhost/myapp
export API_KEY=get_from_1password

# Team members copy and fill in:
# cp .envrc.example .envrc
# direnv allow
```

---

## Commands

```bash
direnv allow                       # Allow .envrc in current directory
direnv deny                        # Deny .envrc (don't load)
direnv reload                      # Reload .envrc
direnv edit .                      # Edit .envrc with $EDITOR and auto-allow
direnv status                      # Show current status

# After editing .envrc:
direnv allow                       # Re-allow the modified file
```

---

## Inheritance

direnv loads .envrc files from current directory and all parent directories.

```
~/projects/
  .envrc                  # Loads for all projects
    myapp/
      .envrc              # Loads in addition to parent
        backend/
          .envrc          # Loads in addition to both parents
```

---

## Common Workflows

### Team Project Setup

```bash
# 1. Project maintainer creates .envrc.example
cat > .envrc.example << 'EOF'
export AWS_PROFILE=project-dev
export DATABASE_URL=postgresql://localhost/myapp
export API_KEY=<get-from-1password>
EOF

git add .envrc.example
echo ".envrc" >> .gitignore
git add .gitignore
git commit -m "Add direnv template"

# 2. Team members set up
cp .envrc.example .envrc
# Edit .envrc with actual values
direnv allow
```

### Switching AWS Profiles

```bash
# Old way:
export AWS_PROFILE=project-a
aws s3 ls
unset AWS_PROFILE
export AWS_PROFILE=project-b
aws s3 ls

# With direnv:
# projects/project-a/.envrc
export AWS_PROFILE=project-a

# projects/project-b/.envrc
export AWS_PROFILE=project-b

# Just cd between projects - profile switches automatically
cd ~/projects/project-a
aws s3 ls  # uses project-a profile
cd ~/projects/project-b
aws s3 ls  # uses project-b profile
```

---

## Troubleshooting

**Variables not loading:**
```bash
direnv status              # Check if direnv is working
direnv allow              # Re-allow .envrc
```

**Changes not picked up:**
```bash
direnv reload             # Force reload
```

**See what direnv is doing:**
```bash
# Add to .envrc for debugging
set -x
export MY_VAR=value
set +x
```

**Disable direnv temporarily:**
```bash
direnv deny               # For current directory
export DIRENV_DISABLE=1   # Disable globally for session
```

---

## Tips

1. **Use with asdf:** `use asdf` in .envrc loads tool versions
2. **PATH_add:** Add project bins to PATH easily
3. **Layout functions:** `layout python` creates virtualenv automatically
4. **Keep it fast:** Avoid slow commands in .envrc (shell startup delay)
5. **Document in README:** Tell team members about .envrc setup

---

**Docs:** https://direnv.net
