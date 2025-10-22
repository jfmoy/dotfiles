# HTTPie - User-Friendly HTTP Client

**What it does:** Human-friendly command-line HTTP client for testing APIs. Much easier than curl.

**Why use it:** Simple syntax, colored JSON output, session support, better debugging.

---

## Basic Syntax

```bash
http [METHOD] URL [ITEM...]

# ITEM can be:
#   key=value       → JSON field
#   key==value      → query parameter
#   header:value    → request header
#   @file           → upload file
```

---

## GET Requests

```bash
# Simple GET
http https://api.github.com/users/octocat

# GET with query parameters
http GET https://api.example.com/users page==2 limit==10
# Equivalent to: https://api.example.com/users?page=2&limit=10

# GET with headers
http https://api.example.com/data Authorization:"Bearer token123"

# Save response to file
http https://api.example.com/users > users.json

# Download file
http --download https://example.com/file.pdf
```

---

## POST Requests

```bash
# POST JSON data
http POST https://api.example.com/users name=John email=john@example.com

# Generated request:
# {
#   "name": "John",
#   "email": "john@example.com"
# }

# POST with nested JSON
http POST https://api.example.com/users \
  name=John \
  email=john@example.com \
  address[city]=NYC \
  address[zip]=10001

# POST raw JSON
http POST https://api.example.com/users < data.json

# POST form data (not JSON)
http --form POST https://api.example.com/upload file@~/photo.jpg
```

---

## Other Methods

```bash
# PUT (update)
http PUT https://api.example.com/users/123 name=Jane

# PATCH (partial update)
http PATCH https://api.example.com/users/123 email=newemail@example.com

# DELETE
http DELETE https://api.example.com/users/123

# HEAD (headers only)
http HEAD https://api.example.com/users
```

---

## Authentication

```bash
# Basic auth
http -a username:password https://api.example.com/private

# Bearer token
http https://api.example.com/data Authorization:"Bearer YOUR_TOKEN"

# Custom header
http https://api.example.com/data X-API-Key:your-api-key
```

---

## Sessions

Persist headers, cookies, and auth across requests.

```bash
# Create named session
http --session=dev https://api.example.com/login email=user@example.com password=secret

# Subsequent requests use stored cookies/headers
http --session=dev https://api.example.com/profile
http --session=dev https://api.example.com/data

# Sessions stored in ~/.config/httpie/sessions/
```

---

## Useful Flags

```bash
# Print options
http --print=h           # Headers only
http --print=b           # Body only
http --print=hb          # Headers and body (default)
http --verbose           # Show request and response

# Follow redirects
http --follow https://example.com

# Verify SSL
http --verify=no https://self-signed.example.com

# Timeout
http --timeout=5 https://slow-api.example.com

# Pretty print
http --pretty=all        # Default
http --pretty=none       # Raw output
http --pretty=colors     # Colors only
http --pretty=format     # Format only

# Output to file
http --output=response.json https://api.example.com/data
```

---

## Comparison with curl

### GET with Headers

```bash
# curl
curl -H "Authorization: Bearer token123" \
     -H "Content-Type: application/json" \
     https://api.example.com/users

# httpie
http https://api.example.com/users \
  Authorization:"Bearer token123" \
  Content-Type:application/json
```

### POST JSON

```bash
# curl
curl -X POST https://api.example.com/users \
  -H "Content-Type: application/json" \
  -d '{"name":"John","email":"john@example.com"}'

# httpie
http POST https://api.example.com/users \
  name=John \
  email=john@example.com
```

### POST Form Data

```bash
# curl
curl -X POST https://api.example.com/upload \
  -F "file=@photo.jpg" \
  -F "title=My Photo"

# httpie
http --form POST https://api.example.com/upload \
  file@photo.jpg \
  title="My Photo"
```

---

## Real-World Examples

### REST API Testing

```bash
# List users
http https://api.example.com/users

# Get specific user
http https://api.example.com/users/123

# Create user
http POST https://api.example.com/users \
  name="Jane Doe" \
  email="jane@example.com" \
  role="admin"

# Update user
http PUT https://api.example.com/users/123 \
  email="newemail@example.com"

# Delete user
http DELETE https://api.example.com/users/123
```

### GitHub API

```bash
# Get your repos (requires token)
http https://api.github.com/user/repos \
  Authorization:"token YOUR_GITHUB_TOKEN"

# Create issue
http POST https://api.github.com/repos/owner/repo/issues \
  Authorization:"token YOUR_TOKEN" \
  title="Bug report" \
  body="Description of the bug"
```

### AWS API (with session)

```bash
# Login and save session
http --session=aws POST https://api.example.com/auth \
  username=admin \
  password=secret

# Use session for subsequent requests
http --session=aws https://api.example.com/s3/buckets
http --session=aws POST https://api.example.com/s3/buckets name=my-bucket
```

### Testing with Different Environments

```bash
# Development
http https://dev-api.example.com/users Authorization:"Bearer $DEV_TOKEN"

# Staging
http https://staging-api.example.com/users Authorization:"Bearer $STAGING_TOKEN"

# Production
http https://api.example.com/users Authorization:"Bearer $PROD_TOKEN"
```

---

## Advanced Features

### Custom JSON

```bash
# Array
http POST https://api.example.com/batch items:='[1,2,3]'

# Nested object
http POST https://api.example.com/config settings:='{"theme":"dark","lang":"en"}'

# Raw JSON with :=
http POST https://api.example.com/data \
  count:=42 \
  enabled:=true \
  tags:='["tag1","tag2"]'
```

### File Upload

```bash
# Single file
http --form POST https://api.example.com/upload file@~/document.pdf

# Multiple files
http --form POST https://api.example.com/upload \
  file1@~/doc1.pdf \
  file2@~/doc2.pdf

# File with metadata
http --form POST https://api.example.com/upload \
  file@~/photo.jpg \
  title="Vacation Photo" \
  tags="summer,beach"
```

---

## Tips

1. **Aliases for common endpoints:**
   ```bash
   alias api-dev="http https://dev-api.example.com"
   api-dev/users
   ```

2. **Environment variables for tokens:**
   ```bash
   export API_TOKEN="your-token"
   http https://api.example.com/data Authorization:"Bearer $API_TOKEN"
   ```

3. **Use with jq for processing:**
   ```bash
   http https://api.github.com/users/octocat | jq '.name'
   ```

4. **Save common requests as scripts:**
   ```bash
   #!/bin/bash
   # create-user.sh
   http POST https://api.example.com/users \
     name="$1" \
     email="$2"
   ```

5. **Debugging API issues:**
   ```bash
   http --verbose POST https://api.example.com/endpoint data=value
   # Shows full request and response
   ```

---

**Docs:** https://httpie.io/docs/cli
