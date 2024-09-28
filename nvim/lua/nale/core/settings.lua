vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt
local fn = vim.fn

opt.swapfile = false

opt.relativenumber = true
opt.number = true

-- Tabs and indentation
opt.tabstop = 2 -- 2 spaces for tabs
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- opt.wrap = false
opt.linebreak = true
opt.scrolloff = 10 -- make the cursor see x lines above cursor
opt.showbreak = "↪" -- show line wrapping character
opt.pumheight = 10 -- maximum number of items to show in the popup menu

-- Search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if mixed case in search, switch to case sensitive

opt.cursorline = true

opt.termguicolors = true
opt.background = "dark" -- prefer dark theme is available
opt.signcolumn = "yes" -- show sign column so that text doesn't shift
opt.fixendofline = false
opt.autowriteall = true -- autowrite on quit

-- Backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, eol or insert mode start position

-- Clipboard
opt.clipboard = "unnamedplus" -- use system clipboard as default register

-- Split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- Keep undo history across sessions, by storing in file
opt.undofile = true
if fn.isdirectory("/tmp/undodir") == 0 then
	fn.mkdir("/tmp/undodir")
end
opt.undodir = "/tmp/undodir"

vim.cmd("filetype plugin indent on") -- enable filetype detection, plugins, and indent
