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
local undodir = fn.stdpath("state") .. "/undodir"
if fn.isdirectory(undodir) == 0 then
	fn.mkdir(undodir, "p")
end
opt.undodir = undodir

vim.cmd("filetype plugin indent on") -- enable filetype detection, plugins, and indent

-- Highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ timeout = 200 })
	end,
})

-- Restore cursor position on file open
vim.api.nvim_create_autocmd("BufReadPost", {
	group = vim.api.nvim_create_augroup("restore_cursor", { clear = true }),
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			vim.api.nvim_win_set_cursor(0, mark)
		end
	end,
})

-- Auto-resize splits when terminal is resized
vim.api.nvim_create_autocmd("VimResized", {
	group = vim.api.nvim_create_augroup("auto_resize", { clear = true }),
	command = "wincmd =",
})

-- Set default border for all floating windows
vim.o.winborder = "rounded"
