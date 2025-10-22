# Neovim with LazyVim - IDE Navigation Cheatsheet

**What it is:** Complete IDE experience in the terminal using Neovim with LazyVim preconfigured setup.

**Configured in:** `~/.config/nvim/`

**Note:** `<leader>` is `<Space>` by default in LazyVim.

---

## 🎯 Essential Shortcuts (Learn These First!)

These 6 shortcuts will get you 80% of the way to IDE productivity:

```
<leader>ff   - Find files (Ctrl+P in VSCode)
<leader>fg   - Find in files (grep across project)
<leader>bb   - Switch between open files (buffers)
<leader>e    - Toggle file explorer
gd           - Go to definition
<C-o>        - Jump back to previous location
```

**Pro tip:** Press `<Space>` and pause - WhichKey will show you available commands!

---

## 🔍 File Navigation (Telescope)

**Find files:**
```
<leader>ff   - Find files in project
<leader>fr   - Recent files
<leader>fg   - Grep/search text in all files
<leader>fw   - Grep word under cursor
<leader>/    - Search in current buffer
<leader>fb   - Find in open buffers
<leader>fo   - Find in old files
```

**Search everything:**
```
<leader>sk   - Search keymaps (when you forget a shortcut!)
<leader>sh   - Search help
<leader>sc   - Search commands
<leader>ss   - Search symbols (functions/classes in file)
<leader>sS   - Search symbols in workspace
```

---

## 📂 File Explorer (Neo-tree)

**Open/close:**
```
<leader>e    - Toggle Neo-tree
<leader>fe   - Open Neo-tree at current file
```

**Navigation in Neo-tree:**
```
j/k          - Move down/up
h/l          - Collapse/expand folder
<Enter>      - Open file
<Tab>        - Open file but keep focus on tree
```

**File operations:**
```
a            - Add file/directory (end with / for directory)
d            - Delete
r            - Rename
c            - Copy
x            - Cut
p            - Paste
y            - Copy filename
Y            - Copy relative path
gy           - Copy absolute path
```

**Neo-tree settings:**
```
?            - Show help
H            - Toggle hidden files
R            - Refresh
```

---

## 🗂️ Buffer Management (Open Files)

**Switch buffers:**
```
<leader>bb   - List all buffers (pick one)
[b           - Previous buffer
]b           - Next buffer
<S-h>        - Previous buffer (Shift+h)
<S-l>        - Next buffer (Shift+l)
```

**Close buffers:**
```
<leader>bd   - Delete/close current buffer
<leader>bo   - Close all other buffers
<leader>bD   - Delete buffer and window
```

**Buffer actions:**
```
<leader>bp   - Pin/unpin buffer (keeps it open)
<leader>bP   - Delete all non-pinned buffers
```

---

## 🧭 Code Navigation (LSP)

**Jump to definitions:**
```
gd           - Go to definition
gD           - Go to declaration
gr           - Find references (where is this used?)
gI           - Go to implementation
gy           - Go to type definition
```

**Understand code:**
```
K            - Hover documentation (what is this?)
<leader>K    - Signature help (function parameters)
```

**Code actions:**
```
<leader>ca   - Code actions (fix/refactor/import)
<leader>cr   - Rename symbol across project
<leader>cf   - Format document/selection
```

---

## 🐛 Diagnostics (Errors & Warnings)

**Navigate diagnostics:**
```
]d           - Next diagnostic
[d           - Previous diagnostic
]e           - Next error
[e           - Previous error
```

**View diagnostics:**
```
<leader>cd   - Show line diagnostics (float)
<leader>xx   - Open diagnostic list (Trouble)
<leader>xX   - Open workspace diagnostics
<leader>xL   - Open location list
<leader>xQ   - Open quickfix list
```

---

## 🪟 Window & Split Management

**Create splits:**
```
<leader>-    - Split horizontal
<leader>|    - Split vertical
<C-w>s       - Split horizontal (alternative)
<C-w>v       - Split vertical (alternative)
```

**Navigate between windows:**
```
<C-h>        - Move to left window
<C-j>        - Move to window below
<C-k>        - Move to window above
<C-l>        - Move to right window
```

**Resize windows:**
```
<C-Up>       - Increase height
<C-Down>     - Decrease height
<C-Left>     - Decrease width
<C-Right>    - Increase width
<C-w>=       - Make windows equal size
```

**Close windows:**
```
<C-w>q       - Close current window
<C-w>o       - Close all other windows
```

---

## 📍 Jump List (Navigation History)

**Jump around:**
```
<C-o>        - Jump to older location (go back)
<C-i>        - Jump to newer location (go forward)
``           - Jump to last position
'.           - Jump to last change
```

**Marks:**
```
ma           - Set mark 'a' at cursor
'a           - Jump to mark 'a'
:marks       - List all marks
```

---

## 🔧 Terminal Integration

**Toggle terminal:**
```
<C-/>        - Toggle terminal (horizontal)
<C-_>        - Same as above (some terminals)
<leader>ft   - Toggle floating terminal
<leader>fT   - Open terminal in new tab
```

**In terminal mode:**
```
<C-/>        - Toggle back to editor
<Esc><Esc>   - Exit terminal mode
<C-\><C-n>   - Exit terminal mode (alternative)
```

---

## 📑 Tabs (Separate Contexts)

**Manage tabs:**
```
<leader><tab>l   - Last tab
<leader><tab>n   - New tab
<leader><tab>]   - Next tab
<leader><tab>[   - Previous tab
<leader><tab>d   - Close tab
<leader><tab>f   - First tab
<leader><tab>o   - Close other tabs
```

---

## 🔄 Git Integration

**LazyGit (if lazygit.nvim plugin added):**
```
<leader>gg   - Open LazyGit
<leader>gf   - LazyGit current file history
```

**Git hunks (changes):**
```
]h           - Next git hunk
[h           - Previous git hunk
<leader>ghp  - Preview hunk
<leader>ghr  - Reset hunk
<leader>ghs  - Stage hunk
<leader>ghu  - Undo stage hunk
<leader>ghS  - Stage buffer
<leader>ghR  - Reset buffer
```

**Git blame & info:**
```
<leader>gb   - Git blame line
<leader>gB   - Git blame file
<leader>gc   - Git commits (Telescope)
<leader>gs   - Git status (Telescope)
```

---

## 📝 Editing Shortcuts

**Multiple cursors / Visual mode:**
```
<C-n>        - Add word under cursor to selection (repeat for more)
<A-j>        - Move line down
<A-k>        - Move line up
<A-Down>     - Move line down (alternative)
<A-Up>       - Move line up (alternative)
J            - Join lines (in normal mode)
gJ           - Join lines without space
```

**Indentation:**
```
>            - Indent right (in visual mode)
<            - Indent left (in visual mode)
>>           - Indent current line right
<<           - Indent current line left
=            - Auto-indent (in visual mode)
```

**Comments:**
```
gcc          - Toggle comment on current line
gc           - Toggle comment (with motion or visual)
gcap         - Toggle comment on paragraph
gco          - Add comment below
gcO          - Add comment above
```

---

## 🎨 UI & Visual Aids

**Toggle features:**
```
<leader>uf   - Toggle auto-format on save
<leader>us   - Toggle spelling
<leader>uw   - Toggle word wrap
<leader>ul   - Toggle line numbers
<leader>ud   - Toggle diagnostics
<leader>uc   - Toggle conceal
<leader>uh   - Toggle inlay hints
<leader>uT   - Toggle treesitter highlight
```

**Notifications:**
```
<leader>un   - Dismiss notifications
<leader>sn   - Search notifications
```

---

## 🔍 Search & Replace

**In current buffer:**
```
/            - Search forward
?            - Search backward
n            - Next match
N            - Previous match
*            - Search word under cursor forward
#            - Search word under cursor backward
```

**Project-wide (Spectre):**
```
<leader>sr   - Search and replace
<leader>sR   - Search and replace (current word)
```

---

## 💾 Save & Quit

**Save:**
```
<leader>w    - Save file
:w           - Save (command mode)
:wa          - Save all
```

**Quit:**
```
<leader>qq   - Quit all
:q           - Quit current window
:qa          - Quit all
:wq          - Save and quit
:q!          - Quit without saving
```

---

## 📦 Plugin Management (Lazy.nvim)

**Manage plugins:**
```
:Lazy        - Open Lazy plugin manager
:LazySync    - Update plugins
:LazyClean   - Remove unused plugins
:LazyExtras  - Browse optional LazyVim extras
```

**Inside Lazy UI:**
```
I            - Install missing plugins
U            - Update plugins
X            - Clean (remove unused)
C            - Check for updates
L            - View logs
?            - Help
```

---

## 🛠️ LSP & Mason (Language Servers)

**Mason (LSP/formatter/linter installer):**
```
:Mason       - Open Mason UI
:MasonUpdate - Update all tools
:MasonInstall <name> - Install specific tool
```

**LSP commands:**
```
:LspInfo     - Show LSP client info
:LspRestart  - Restart LSP server
:LspLog      - View LSP logs
```

---

## 🎓 Learning & Help

**Built-in help:**
```
:Tutor       - Vim tutorial (basics)
:help <topic> - Search help
:checkhealth - Check nvim health
```

**LazyVim specific:**
```
:LazyExtras  - Browse extra plugins/features
<leader>sk   - Search keymaps
<leader>?    - Search help
```

**WhichKey:**
- Press `<Space>` and pause → See available commands
- Works for any prefix (try `g`, `]`, `[`, `z`, etc.)

---

## 🚀 Real-World Workflow Examples

### Opening a Project
```bash
cd ~/projects/myapp
nvim .
```

### Daily Workflow
```
1. <leader>ff        # Find file you need
2. Edit the file
3. gd                # Jump to function definition
4. <C-o>             # Jump back
5. <leader>fg        # Search across project
6. <leader>ca        # Code action (auto-import, fix)
7. <leader>w         # Save
8. <leader>bd        # Close buffer
```

### Multi-File Editing
```
1. <leader>ff        # Open first file
2. <leader>ff        # Open second file
3. [b / ]b           # Switch between them
4. <leader>|         # Split vertical if needed
5. <C-h>/<C-l>       # Jump between splits
```

### Debugging Flow
```
1. <leader>xx        # View all errors (Trouble)
2. ]d                # Jump to next error
3. <leader>ca        # Apply code action to fix
4. <leader>cf        # Format file
5. :w                # Save
```

### Git Workflow
```
1. <leader>gg        # Open LazyGit
2. Stage/commit changes in LazyGit
3. q to exit
4. Continue editing
```

---

## 💡 Pro Tips

### 1. Start Simple
Focus on these 3 commands first:
- `<leader>ff` - Find any file instantly
- `<leader>fg` - Search any text in project
- `gd` - Jump to definition

### 2. Use WhichKey
Press `<Space>` and wait - it shows you what's available. This is your built-in cheatsheet!

### 3. Learn Incrementally
Pick ONE new shortcut per day. Don't try to memorize everything at once.

### 4. Customize
Edit `~/.config/nvim/lua/config/keymaps.lua` to add your own shortcuts.

### 5. Check Installed Extras
```
:LazyExtras
```
See optional features you can enable (Python support, TypeScript, etc.)

---

## 🔧 Common Customizations

### Add Custom Keymap
Edit `~/.config/nvim/lua/config/keymaps.lua`:

```lua
local map = vim.keymap.set

-- Add your custom keymaps
map("n", "<leader>pp", ":Telescope projects<CR>", { desc = "Find projects" })
map("n", "<leader>ot", ":terminal<CR>", { desc = "Open terminal" })
```

### Add New Plugin
Create `~/.config/nvim/lua/plugins/my-plugin.lua`:

```lua
return {
  {
    "ThePrimeagen/harpoon",
    keys = {
      { "<leader>a", function() require("harpoon.mark").add_file() end, desc = "Harpoon: Mark file" },
      { "<C-e>", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon: Quick menu" },
    },
  },
}
```

### Change Leader Key
Edit `~/.config/nvim/lua/config/options.lua`:

```lua
vim.g.mapleader = ","  -- Change from Space to comma
```

---

## 🆘 Troubleshooting

### Plugins Not Working
```
:Lazy sync           # Update all plugins
:checkhealth         # Check for issues
:LspInfo             # Check LSP status
```

### LSP Not Attaching
```
:LspInfo             # See which LSP is running
:Mason               # Install missing language server
:LspRestart          # Restart LSP
```

### Keybinding Conflicts
```
<leader>sk           # Search all keymaps
:verbose map <key>   # See what key is mapped to
```

### Performance Issues
```
:Lazy profile        # See which plugins are slow
:checkhealth         # Check for issues
```

---

## 📚 Resources

**Official Documentation:**
- LazyVim: https://www.lazyvim.org
- Neovim: https://neovim.io/doc/
- Telescope: https://github.com/nvim-telescope/telescope.nvim
- Neo-tree: https://github.com/nvim-neo-tree/neo-tree.nvim

**Learning:**
- `:Tutor` - Built-in Vim tutorial
- LazyVim keymaps: https://www.lazyvim.org/keymaps
- Vim motions: https://vim.rtorr.com/

**Community:**
- LazyVim discussions: https://github.com/LazyVim/LazyVim/discussions
- r/neovim: https://reddit.com/r/neovim

---

## 🎯 Quick Reference Card

**Most Used (Memorize These):**
```
<Space>ff    Find file
<Space>fg    Find in files
<Space>bb    Switch buffer
<Space>e     File explorer
gd           Go to definition
<C-o>        Jump back
K            Show docs
<Space>ca    Code actions
```

**File Tree:**
```
<Space>e     Toggle
a/d/r        Add/Delete/Rename
```

**Windows:**
```
<C-h/j/k/l>  Navigate
<Space>-     Split horizontal
<Space>|     Split vertical
```

**Terminal:**
```
<C-/>        Toggle
```

**Git:**
```
<Space>gg    LazyGit
]h/[h        Next/prev change
```

---

**Pro tip:** Keep this cheatsheet open in a split while learning! `:vsplit docs/neovim-lazyvim.md`

**Last updated:** 2025-10-22
