-- Set nocompatible
vim.opt.compatible = false

-- Disable adding new line and end of opened files
vim.opt.fixendofline = false

-- Split too long lines smart
vim.opt.linebreak = true

-- Auto-completion settings
vim.opt.wildignorecase = true                                   -- Make filenames autocompletion case-insensitive
vim.opt.wildignore:append({ "*.a", "*.o", "*.gcno", "*.gcda" }) -- Exclude tmp files from autocompletion
vim.opt.termguicolors = true

-- Enable filetype detection, plugins, and indent
vim.cmd('filetype on')
vim.cmd('filetype plugin on')
vim.cmd('filetype indent on')

-- Autowrite when replace in multiple buffers
vim.opt.autowriteall = true

-- Make search case insensitive
vim.opt.ignorecase = true

-- Enable syntax highlighting
vim.cmd('syntax enable')

-- Set colorscheme with termguicolors
vim.opt.termguicolors = true

-- Highlight current line
vim.opt.cursorline = true

-- Copy and paste between Vim and others
vim.opt.clipboard:append("unnamedplus")

-- Disable compatibility mode
vim.opt.compatible = false

-- Disable swap files
vim.opt.swapfile = false

-- Display line numbers
vim.opt.number = true

-- Make line numbers relative
vim.opt.relativenumber = true

-- Make the cursor see x lines above cursor
vim.opt.scrolloff = 15

-- Show line wrapping character
vim.opt.showbreak = "↪"

-- Maximum number of items to show in the popup menu
vim.opt.pumheight = 15

-- Make search case insensitive, but smart if mixed case is used
vim.opt.smartcase = true

-- Keep undo history across sessions, by storing in file
vim.opt.undofile = true
if vim.fn.isdirectory("/tmp/undodir") == 0 then
  vim.fn.mkdir("/tmp/undodir")
end
vim.opt.undodir = "/tmp/undodir"

-- Set fold options
vim.opt.foldmethod = "indent"
vim.opt.foldnestmax = 10
vim.opt.foldenable = false
vim.opt.foldlevel = 2

-- Verbosity level for imap <Space>
-- vim.opt.verbose:append("imap <Space>")

-- Background
vim.cmd('hi Normal ctermbg=none guibg=none')

-- Automatically call PrettierAsync when saving a buffer
-- vim.cmd('autocmd BufWritePre * :PrettierAsync')
