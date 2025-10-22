# SSH Multiplexing - Connection Reuse

**What it does:** Reuses a single SSH connection for multiple sessions, making subsequent connections instant.

**Configured in:** `~/.ssh/config`

---

## How It Works

1. First connection to a server creates a "master" connection
2. Master connection saves a socket file in `~/.ssh/sockets/`
3. Subsequent connections reuse the master socket (instant connection)
4. Socket persists for 10 minutes (600 seconds) after last use
5. All SSH-based tools (ssh, scp, rsync, git) use the same socket

---

## Benefits

- **Speed:** 10x faster subsequent connections (no re-authentication)
- **Convenience:** No repeated password/key prompts
- **Efficiency:** Reduced authentication overhead
- **Reliability:** Auto-reconnect on network hiccups
- **Works with:** ssh, scp, rsync, git (except github.com)

---

## Configuration

Already configured in your `~/.ssh/config`:

```ssh-config
Host *
  # SSH multiplexing
  ControlMaster auto
  ControlPath ~/.ssh/sockets/%r@%h-%p
  ControlPersist 600

  # Keep connections alive
  ServerAliveInterval 60
  ServerAliveCountMax 3

  # Compression
  Compression yes

# Exception: Don't multiplex GitHub (can cause issues with git)
Host github.com
  ControlMaster no
```

**Settings explained:**
- `ControlMaster auto` - Automatically create/reuse connections
- `ControlPath ~/.ssh/sockets/%r@%h-%p` - Socket file location
- `ControlPersist 600` - Keep socket alive for 10 minutes after last use
- `ServerAliveInterval 60` - Send keepalive every 60 seconds
- `ServerAliveCountMax 3` - Disconnect after 3 failed keepalives
- `Compression yes` - Compress data (faster on slow networks)

---

## Usage Examples

### Basic Usage (Automatic)

```bash
# First connection - creates master socket
ssh user@server.com
# Takes normal time (authentication required)

# In another terminal - reuses socket
ssh user@server.com
# Instant! No password/key needed

# SCP also uses the socket
scp file.txt user@server.com:/path/
# Instant connection

# Rsync too
rsync -avz ./dir/ user@server.com:/path/
# Instant connection
```

### Check Active Connections

```bash
# List socket files (active connections)
ls -l ~/.ssh/sockets/

# Example output:
# user@server.com-22
# admin@prod.example.com-22
```

### Manual Control

```bash
# Check if master connection exists
ssh -O check user@server.com

# Close master connection
ssh -O exit user@server.com

# Force new master connection
ssh -O forward user@server.com
```

---

## Common Workflows

### Multiple Terminals to Same Server

```bash
# Terminal 1
ssh user@server.com
# Authenticates, creates master

# Terminal 2
ssh user@server.com
# Instant! Uses master from Terminal 1

# Terminal 3
scp file.txt user@server.com:/tmp/
# Instant! Uses same master

# Close Terminal 1 - master persists for 10 minutes
# Terminals 2 and 3 still work
```

### Large File Transfers

```bash
# Start SSH session (creates master)
ssh user@server.com

# In another terminal, use rsync (reuses connection)
rsync -avz --progress large-dir/ user@server.com:/backup/
# No authentication delay, starts transferring immediately
```

### Running Multiple Commands

```bash
# No multiplexing (slow):
ssh server "command1"  # Authenticates
ssh server "command2"  # Authenticates again
ssh server "command3"  # Authenticates again

# With multiplexing (fast):
ssh server "command1"  # Authenticates, creates master
ssh server "command2"  # Instant
ssh server "command3"  # Instant
```

---

## Troubleshooting

### Stale Socket Files

If connection fails with socket error:

```bash
# Remove stale socket
rm ~/.ssh/sockets/user@server.com-22

# Or remove all sockets
rm ~/.ssh/sockets/*

# Try connecting again
ssh user@server.com
```

### Check Socket Status

```bash
# Check if socket is working
ssh -O check user@server.com

# Possible responses:
# "Master running (pid=12345)" - Socket is active
# "No ControlPath specified" - Multiplexing not configured for this host
# "Control socket connect(...): Connection refused" - Stale socket, remove it
```

### Disable for Specific Host

Add to `~/.ssh/config`:

```ssh-config
Host problematic-server.com
  ControlMaster no
```

### View Active Connections

```bash
# List sockets with age
ls -lh ~/.ssh/sockets/

# See what's using a socket (macOS)
lsof ~/.ssh/sockets/user@server.com-22

# Kill master connection
ssh -O exit user@server.com
```

---

## Performance Example

**Without multiplexing:**
```bash
$ time ssh server.com "echo test"
test
real    0m2.341s  # 2.3 seconds (authentication)
```

**With multiplexing (subsequent connections):**
```bash
$ time ssh server.com "echo test"
test
real    0m0.123s  # 0.1 seconds (10x faster!)
```

---

## Advanced Usage

### Custom Persist Time

Per-host customization in `~/.ssh/config`:

```ssh-config
# Production server - keep alive longer
Host prod.example.com
  ControlPersist 3600  # 1 hour

# Development server - shorter timeout
Host dev.example.com
  ControlPersist 300   # 5 minutes
```

### Disable for Specific Command

```bash
# Skip multiplexing for one command
ssh -o ControlMaster=no user@server.com
```

### Background Master Connection

```bash
# Start master in background (no shell)
ssh -fN user@server.com

# Now other commands use it
ssh user@server.com "uptime"  # Instant
scp file.txt user@server.com:  # Instant

# Close master when done
ssh -O exit user@server.com
```

---

## Security Considerations

1. **Socket permissions:** Sockets are in `~/.ssh/sockets/` with 0700 permissions (only you can access)

2. **Shared sessions:** All connections share authentication. If master is compromised, all are compromised.

3. **Timeout:** Sockets expire after 10 minutes of inactivity (configurable via `ControlPersist`)

4. **Not for GitHub:** Disabled for github.com to avoid issues with git operations

---

## Tips

1. **Monitor active connections:**
   ```bash
   watch -n 5 'ls -lh ~/.ssh/sockets/'
   ```

2. **Clean up old sockets periodically:**
   ```bash
   # Add to cron or just file
   find ~/.ssh/sockets/ -type s -mtime +1 -delete
   ```

3. **Combine with direnv for per-project servers:**
   ```bash
   # .envrc
   export SSH_HOST=staging.example.com

   # Then: ssh $SSH_HOST
   ```

4. **Use with ansible/terraform:**
   - SSH multiplexing dramatically speeds up ansible playbooks
   - Terraform SSH provisioners connect faster

---

## Related Configuration

Works well with:
- **1Password SSH agent** - Authentication via 1Password
- **Compression** - Enabled in config
- **ServerAlive** - Keeps connection from timing out
- **Known hosts** - HashKnownHosts disabled for easier management

---

**Docs:** `man ssh_config` (search for ControlMaster)
