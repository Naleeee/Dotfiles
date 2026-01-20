# Neovim Configuration

A modern, fully Lua-based Neovim configuration optimized for web development (TypeScript, Vue, React) with comprehensive LSP support, intelligent autocompletion, and a beautiful Catppuccin theme.

---

## Table of Contents

- [Overview](#overview)
- [File Structure](#file-structure)
- [Core Settings](#core-settings)
- [Key Mappings](#key-mappings)
- [Plugin Categories](#plugin-categories)
  - [Plugin Manager](#plugin-manager)
  - [LSP and Completion](#lsp-and-completion)
  - [Formatting and Linting](#formatting-and-linting)
  - [File Navigation](#file-navigation)
  - [Editor Enhancements](#editor-enhancements)
  - [UI and Appearance](#ui-and-appearance)
  - [Git Integration](#git-integration)
  - [Markdown](#markdown)
- [LSP Servers](#lsp-servers)
- [Snippets](#snippets)
- [Filetype Settings](#filetype-settings)

---

## Overview

### Features

- **Full Lua Configuration** - No Vimscript, entirely Lua-based
- **Lazy Loading** - Fast startup with lazy.nvim plugin manager
- **LSP Integration** - Language servers via Mason with auto-installation
- **Smart Completion** - nvim-cmp with multiple sources including Copilot
- **Auto-formatting** - Conform.nvim with Biome/ESLint/Prettier detection
- **Real-time Linting** - nvim-lint with markdownlint
- **Fuzzy Finding** - Telescope with fzf-native
- **Git Integration** - Gitsigns, LazyGit
- **Beautiful UI** - Catppuccin theme, custom statusline, bufferline

### Theme

**Catppuccin Mocha** with transparent background - consistent with the entire desktop environment.

---

## File Structure

```
~/.config/nvim/
├── init.lua                    # Entry point
├── lazy-lock.json              # Plugin version lock file
├── ftplugin/                   # Filetype-specific settings
│   ├── javascript.lua
│   ├── typescript.lua
│   ├── vue.lua
│   ├── lua.lua
│   ├── markdown.lua
│   └── ...
├── snippets/                   # Custom LuaSnip snippets
│   ├── all.lua                 # Global snippets
│   ├── typescript.lua
│   ├── typescriptreact.lua
│   ├── vue.lua
│   └── lua.lua
└── lua/nale/
    ├── core/
    │   ├── init.lua            # Core module loader
    │   ├── settings.lua        # Vim options
    │   └── mappings.lua        # Global keymaps
    ├── lazy.lua                # Lazy.nvim bootstrap
    ├── lsp.lua                 # LSP configuration
    └── plugins/                # Plugin configurations
        ├── lsp/
        │   ├── lsp.lua         # LSP capabilities
        │   └── mason.lua       # Mason server management
        ├── alpha.lua           # Dashboard
        ├── autopairs.lua
        ├── bufferline.lua
        ├── colorscheme.lua
        ├── comment.lua
        ├── copilot.lua
        ├── flash.lua
        ├── formatting.lua
        ├── gitsigns.lua
        ├── linting.lua
        ├── lualine.lua
        ├── noice.lua
        ├── nvim-cmp.lua
        ├── nvim-tree.lua
        ├── telescope.lua
        ├── treesitter.lua
        ├── trouble.lua
        └── ...
```

---

## Core Settings

Key settings from `lua/nale/core/settings.lua`:

| Setting | Value | Description |
|---------|-------|-------------|
| `relativenumber` | `true` | Relative line numbers |
| `number` | `true` | Show current line number |
| `tabstop` | `2` | 2 spaces per tab |
| `shiftwidth` | `2` | 2 spaces for indentation |
| `expandtab` | `true` | Use spaces instead of tabs |
| `scrolloff` | `10` | Keep 10 lines visible around cursor |
| `clipboard` | `unnamedplus` | Use system clipboard |
| `undofile` | `true` | Persistent undo history |
| `ignorecase` | `true` | Case-insensitive search |
| `smartcase` | `true` | Case-sensitive if uppercase in search |
| `termguicolors` | `true` | True color support |
| `cursorline` | `true` | Highlight current line |

---

## Key Mappings

**Leader key:** `<Space>`

### General

| Mapping | Mode | Description |
|---------|------|-------------|
| `jk` / `kj` | Insert | Exit insert mode |
| `<leader>nh` | Normal | Clear search highlights |
| `<leader>+` / `<leader>-` | Normal | Increment/decrement number |
| `vv` | Normal | Split window vertically |
| `ss` | Normal | Split window horizontally |
| `<leader>bq` | Normal | Close current buffer |
| `J` / `K` | Visual | Move selection up/down |
| `<C-r>` | Visual | Find and replace selection |
| `n` / `N` | Normal | Search next/prev (centered) |
| `<leader>d` | Normal/Visual | Delete to void register |
| `<leader>p` | Visual | Paste without copying |

### File Explorer (NvimTree)

| Mapping | Description |
|---------|-------------|
| `<leader>ee` | Toggle file explorer |
| `<leader>ef` | Find current file in explorer |
| `<leader>ec` | Collapse file explorer |
| `<leader>er` | Refresh file explorer |

### Telescope

| Mapping | Description |
|---------|-------------|
| `<leader>f` | Find files |
| `<leader>g` | Live grep (search text) |
| `<leader>F` | Grep string under cursor |
| `<leader>mt` | Show keymaps |

### Formatting and Linting

| Mapping | Description |
|---------|-------------|
| `<leader>tf` | Format file/selection |
| `<leader>ti` | Show active formatters |
| `<leader>tI` | Show active linters |
| `<leader>tl` | Trigger linting |

### Diagnostics (Trouble)

| Mapping | Description |
|---------|-------------|
| `<leader>xx` | Toggle workspace diagnostics |
| `<leader>xX` | Toggle buffer diagnostics |
| `<leader>xd` | Show diagnostic at cursor |
| `<leader>xD` | Show diagnostics on line |
| `<leader>xs` | Toggle symbols outline |
| `<leader>xq` | Toggle quickfix list |
| `<leader>N` / `<leader>n` | Previous/next diagnostic |

### Flash (Motion)

| Mapping | Description |
|---------|-------------|
| `<leader>c` | Flash jump |
| `<leader>C` | Flash Treesitter |
| `r` | Remote Flash (operator mode) |

### Git

| Mapping | Description |
|---------|-------------|
| `<leader>lg` | Open LazyGit |

### Markdown

| Mapping | Description |
|---------|-------------|
| `<C-p>` | Open markdown preview in browser |
| `<leader>tm` | Toggle in-editor markdown rendering |

### Window Management

| Mapping | Description |
|---------|-------------|
| `<leader>sm` | Maximize/restore window |

### Special

| Mapping | Description |
|---------|-------------|
| Konami Code | Start Snake game |

---

## Plugin Categories

### Plugin Manager

**[lazy.nvim](https://github.com/folke/lazy.nvim)** - Modern plugin manager with lazy loading support.

### LSP and Completion

| Plugin | Purpose |
|--------|---------|
| [mason.nvim](https://github.com/williamboman/mason.nvim) | LSP/DAP/Linter installer |
| [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) | Mason + lspconfig bridge |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP configurations |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Completion engine |
| [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) | LSP completion source |
| [cmp-buffer](https://github.com/hrsh7th/cmp-buffer) | Buffer completion source |
| [cmp-path](https://github.com/hrsh7th/cmp-path) | Path completion source |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet engine |
| [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | Snippet collection |
| [copilot.lua](https://github.com/zbirenbaum/copilot.lua) | GitHub Copilot |
| [lspkind.nvim](https://github.com/onsails/lspkind.nvim) | VSCode-like pictograms |
| [lazydev.nvim](https://github.com/folke/lazydev.nvim) | Lua LSP improvements |

### Formatting and Linting

| Plugin | Purpose |
|--------|---------|
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Formatter management |
| [nvim-lint](https://github.com/mfussenegger/nvim-lint) | Async linting |

**Auto-detection Logic:**
- If `biome.json` exists → Use **Biome** (format + safe fixes)
- If `.eslintrc*` exists (no Biome) → Use **ESLint** fixes + **Prettier**
- If `.prettierrc*` exists → Use **Prettier**
- Fallback → **Prettier**

### File Navigation

| Plugin | Purpose |
|--------|---------|
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder |
| [telescope-fzf-native](https://github.com/nvim-telescope/telescope-fzf-native.nvim) | FZF algorithm |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | File explorer |
| [flash.nvim](https://github.com/folke/flash.nvim) | Navigation/motion |

### Editor Enhancements

| Plugin | Purpose |
|--------|---------|
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting |
| [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) | Text objects |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Auto close brackets |
| [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) | Auto close HTML tags |
| [nvim-surround](https://github.com/kylechui/nvim-surround) | Surround text objects |
| [Comment.nvim](https://github.com/numToStr/Comment.nvim) | Commenting |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Keybinding hints |
| [auto-session](https://github.com/rmagatti/auto-session) | Session management |

### UI and Appearance

| Plugin | Purpose |
|--------|---------|
| [catppuccin/nvim](https://github.com/catppuccin/nvim) | Color scheme |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Status line |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | Buffer tabs |
| [alpha-nvim](https://github.com/goolord/alpha-nvim) | Dashboard |
| [noice.nvim](https://github.com/folke/noice.nvim) | UI enhancements |
| [nvim-notify](https://github.com/rcarriga/nvim-notify) | Notifications |
| [dressing.nvim](https://github.com/stevearc/dressing.nvim) | UI improvements |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Indent guides |
| [nvim-colorizer.lua](https://github.com/norcalli/nvim-colorizer.lua) | Color preview |
| [illuminate](https://github.com/RRethy/vim-illuminate) | Highlight word under cursor |
| [highlight-undo](https://github.com/tzachar/highlight-undo.nvim) | Highlight undo/redo |
| [rainbow-delimiters](https://github.com/HiPhish/rainbow-delimiters.nvim) | Rainbow brackets |

### Git Integration

| Plugin | Purpose |
|--------|---------|
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git signs in gutter |
| [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) | LazyGit integration |

### Markdown

| Plugin | Purpose |
|--------|---------|
| [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim) | Browser preview |
| [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) | In-editor rendering |
| [nvim-markdown](https://github.com/ixru/nvim-markdown) | Markdown utilities |
| [vim-table-mode](https://github.com/dhruvasagar/vim-table-mode) | Table editing |
| [vim-markdown-toc](https://github.com/mzlogin/vim-markdown-toc) | Table of contents |

### Other

| Plugin | Purpose |
|--------|---------|
| [trouble.nvim](https://github.com/folke/trouble.nvim) | Diagnostics list |
| [vim-maximizer](https://github.com/szw/vim-maximizer) | Window maximizer |
| [windows.nvim](https://github.com/anuvyklack/windows.nvim) | Window animations |
| [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) | Tmux integration |
| [presence.nvim](https://github.com/andweeb/presence.nvim) | Discord presence |
| [snake.nvim](https://github.com/Febri-i/snake.nvim) | Snake game (Easter egg) |

---

## LSP Servers

Automatically installed via Mason:

| Server | Languages |
|--------|-----------|
| `lua_ls` | Lua |
| `ts_ls` | TypeScript, JavaScript |
| `vue_ls` | Vue |
| `biome` | JS/TS/JSON linting & formatting |
| `eslint` | JavaScript, TypeScript |
| `html` | HTML |
| `cssls` | CSS |
| `tailwindcss` | Tailwind CSS |
| `bashls` | Bash |
| `vimls` | Vimscript |

### Additional Tools (Mason Tool Installer)

| Tool | Purpose |
|------|---------|
| `eslint_d` | Fast ESLint daemon |
| `prettier` | Code formatter |
| `biome` | Formatter and linter |
| `stylua` | Lua formatter |
| `markdownlint` | Markdown linter |

---

## Snippets

Custom snippets are defined in `~/.config/nvim/snippets/` using LuaSnip format:

- `all.lua` - Global snippets (available in all filetypes)
- `typescript.lua` - TypeScript-specific
- `typescriptreact.lua` - React/TSX-specific
- `vue.lua` - Vue-specific
- `lua.lua` - Lua-specific

### Creating Snippets

```lua
-- Example snippet in snippets/typescript.lua
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s("log", {
    t("console.log("),
    i(1, "message"),
    t(")"),
  }),
}
```

---

## Filetype Settings

Filetype-specific configurations in `ftplugin/`:

Each file can override settings for specific file types:

```lua
-- ftplugin/markdown.lua
vim.opt_local.wrap = true
vim.opt_local.spell = true
vim.opt_local.conceallevel = 2
```

### Configured Filetypes

- JavaScript/TypeScript/TSX
- Vue
- HTML/CSS/SCSS
- JSON/YAML
- Lua
- Markdown
- Bash/Shell
- C/C++
- GraphQL
- Git commit

---

## Quick Reference

### First Launch

1. Open Neovim: `nvim`
2. Lazy.nvim will automatically install all plugins
3. Mason will install LSP servers on first use
4. Run `:checkhealth` to verify installation

### Useful Commands

| Command | Description |
|---------|-------------|
| `:Lazy` | Open plugin manager |
| `:Mason` | Open LSP/tool installer |
| `:LspInfo` | Show active LSP clients |
| `:Telescope keymaps` | Browse all keybindings |
| `:checkhealth` | Run health checks |

---

## Customization

To customize this configuration:

1. **Settings**: Edit `lua/nale/core/settings.lua`
2. **Keymaps**: Edit `lua/nale/core/mappings.lua`
3. **Plugins**: Add/modify files in `lua/nale/plugins/`
4. **LSP**: Configure in `lua/nale/plugins/lsp/`
5. **Colorscheme**: Edit `lua/nale/plugins/colorscheme.lua`

