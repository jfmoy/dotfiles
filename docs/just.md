# just - Command Runner Cheatsheet

**What it does:** Modern command runner for project-specific tasks. Better than Makefiles for task running.

**Why use it:** Simpler syntax, better error messages, any shell (bash, python, node), lists commands.

**Note:** Use for personal projects. For team projects, stick with Makefiles for ubiquity.

---

## Basic Usage

### Create Justfile

```bash
cd ~/my-project
touch justfile
```

### List Available Commands

```bash
just --list
# or simply:
just
```

### Run a Command

```bash
just test
just deploy
just build
```

---

## Basic Justfile Syntax

```just
# This is a comment

# Simple command
hello:
    echo "Hello, World!"

# Command with dependencies
build:
    cargo build --release

deploy: build test
    ./scripts/deploy.sh

# Command with parameters
greet name:
    echo "Hello, {{name}}!"

# Run: just greet John
```

---

## Common Patterns

### Default Recipe

```just
# Runs when you type 'just' with no arguments
default:
    @just --list
```

### Development Tasks

```just
# Install dependencies
install:
    npm install
    pip install -r requirements.txt

# Run development server
dev:
    npm run dev

# Run tests
test:
    npm test
    pytest

# Build for production
build:
    npm run build

# Clean build artifacts
clean:
    rm -rf dist/
    rm -rf node_modules/
```

### Docker Workflows

```just
# Start services
up:
    docker-compose up -d

# Stop services
down:
    docker-compose down

# View logs
logs:
    docker-compose logs -f

# Rebuild and restart
rebuild:
    docker-compose down
    docker-compose build
    docker-compose up -d

# Run tests in container
test:
    docker-compose exec app pytest
```

### Database Tasks

```just
# Create database
db-create:
    createdb myapp_dev

# Run migrations
db-migrate:
    alembic upgrade head

# Seed database
db-seed:
    python scripts/seed.py

# Reset database
db-reset:
    dropdb myapp_dev || true
    createdb myapp_dev
    alembic upgrade head
    python scripts/seed.py
```

---

## Advanced Features

### Variables

```just
app_name := "myapp"
docker_image := "mycompany/" + app_name

build:
    docker build -t {{docker_image}} .

run:
    docker run {{docker_image}}
```

### Parameters with Defaults

```just
# Optional parameter with default
deploy env="staging":
    echo "Deploying to {{env}}"
    ./scripts/deploy.sh {{env}}

# Multiple parameters
create-user name email role="user":
    echo "Creating {{name}} ({{email}}) with role {{role}}"
```

### Conditional Logic

```just
test *FLAGS:
    #!/usr/bin/env bash
    if [ -z "{{FLAGS}}" ]; then
        pytest tests/
    else
        pytest {{FLAGS}}
    fi
```

### Multi-line Commands (Shebang)

```just
# Python script
analyze:
    #!/usr/bin/env python3
    import json
    data = {"status": "ok"}
    print(json.dumps(data, indent=2))

# Bash script
deploy:
    #!/usr/bin/env bash
    set -euo pipefail
    echo "Building..."
    npm run build
    echo "Deploying..."
    rsync -avz dist/ server:/var/www/
```

### Environment Variables

```just
# Set environment variables
export DATABASE_URL := "postgresql://localhost/myapp"

migrate:
    # DATABASE_URL is available here
    alembic upgrade head

# Or load from .env file
set dotenv-load := true

test:
    # Variables from .env are loaded automatically
    pytest
```

---

## Useful Flags

```bash
just --list                 # List all commands
just --show build          # Show the recipe for 'build'
just --dry-run deploy      # Show what would be executed
just --verbose test        # Show commands before executing
just --working-directory ~/project build  # Run in specific directory
```

---

## Recipe Dependencies

```just
# 'deploy' runs 'test' and 'build' first
deploy: test build
    ./scripts/deploy.sh

# Dependencies run in order
all: clean install build test
    echo "All done!"
```

---

## Common Recipes Collection

### Web Development

```just
# Development
dev:
    npm run dev

# Production build
build:
    npm run build

# Type checking
typecheck:
    tsc --noEmit

# Linting
lint:
    eslint src/
    prettier --check src/

# Format code
format:
    prettier --write src/

# Run all checks
check: typecheck lint test
    echo "All checks passed!"
```

### Infrastructure/Terraform

```just
# Initialize Terraform
tf-init:
    terraform init

# Plan changes
tf-plan env="dev":
    terraform plan -var-file={{env}}.tfvars

# Apply changes
tf-apply env="dev": (tf-plan env)
    terraform apply -var-file={{env}}.tfvars

# Destroy infrastructure
tf-destroy env="dev":
    terraform destroy -var-file={{env}}.tfvars
```

### Personal Scripts

```just
# Backup important files
backup:
    #!/usr/bin/env bash
    BACKUP_DIR=~/backups/$(date +%Y%m%d)
    mkdir -p $BACKUP_DIR
    cp -r ~/Documents $BACKUP_DIR/
    cp -r ~/Projects $BACKUP_DIR/
    echo "Backup created: $BACKUP_DIR"

# Update all tools
update:
    brew update
    brew upgrade
    brew cleanup
    chezmoi update
    asdf plugin update --all

# Clean temporary files
clean-temp:
    rm -rf ~/Downloads/*.tmp
    rm -rf ~/.cache/*
    echo "Temp files cleaned"
```

---

## Tips

1. **Name commands with dashes:** `db-migrate` instead of `db_migrate`

2. **Use @ to suppress command echo:**
   ```just
   greet:
       @echo "Hello"  # Only shows "Hello", not the echo command
   ```

3. **Document your recipes:**
   ```just
   # Run tests with coverage
   test:
       pytest --cov
   ```

4. **Create recipe aliases:**
   ```just
   alias t := test
   alias b := build
   ```

5. **Use recipe dependencies for workflows:**
   ```just
   deploy: test build
       ./deploy.sh
   ```

6. **Keep it simple:** For complex logic, call external scripts
   ```just
   complex-task:
       ./scripts/complex-task.sh
   ```

---

## Justfile Example

```just
# Default recipe (runs when you type 'just')
default:
    @just --list

# Install dependencies
install:
    npm install

# Run development server
dev:
    npm run dev

# Run tests
test:
    npm test

# Build for production
build:
    npm run build

# Lint code
lint:
    eslint src/

# Format code
format:
    prettier --write src/

# Run all checks
check: lint test
    @echo "All checks passed!"

# Deploy to staging
deploy-staging: check build
    ./scripts/deploy.sh staging

# Deploy to production
deploy-prod: check build
    ./scripts/deploy.sh production
```

---

**Docs:** https://just.systems
