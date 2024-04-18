-- General settings
vim.o.compatible = false                -- Disable compatibility with Vi
vim.opt.termguicolors = true
vim.opt.clipboard:append("unnamedplus") -- Copy and paste between Vim and others
vim.opt.autowriteall = true             -- Autowrite when replace in multiple buffers

-- Text rendering options
vim.cmd('filetype plugin indent on')
vim.cmd('syntax enable')           -- Enable syntax highlighting
vim.opt.display:append("lastline") -- Always try to show a paragraph's last line
vim.opt.encoding = 'utf-8'         -- Use an encoding that supports unicode
vim.opt.linebreak = true           -- Split too long line
vim.opt.scrolloff = 10             -- Make the cursor see x lines above cursor
vim.opt.pumheight = 10             -- Maximum number of items to show in the popup menu
vim.opt.wrap = true
vim.opt.fixendofline = false       -- Disable adding new line and end of opened files

-- Indentation options
vim.opt.autoindent = true -- New lines inherit the indentation of previous lines
vim.opt.expandtab = true  -- Convert tabs to spaces
vim.opt.shiftround = true -- When shifting lines, round the indentation to the nearest multiple of "shiftwidth"
vim.opt.shiftwidth = 2    -- When shifting, indent using two spaces
vim.opt.smarttab = true   -- Insert "tabstop" number of spaces when the "tab" key is pressed.
vim.opt.tabstop = 2       -- Indent using two spaces
vim.opt.softtabstop = 2
vim.opt.smartindent = true

-- Seatch options
vim.opt.hlsearch = true                                         -- Enable search highlighting
vim.opt.ignorecase = true                                       -- Make search case insensitive
vim.opt.incsearch = true                                        -- Incremental search that shows partial matches
vim.opt.smartcase = true                                        -- Automatically switch search to case-sensitive when search query contains an uppercase letter
vim.opt.wildignorecase = true                                   -- Make filenames autocompletion case-insensitive
vim.opt.wildignore:append({ "*.a", "*.o", "*.gcno", "*.gcda" }) -- Exclude tmp files from autocompletion

-- User interface options
vim.opt.wildmenu = true -- Display command line's tab complete options as a menu
vim.opt.cursorline = true -- Highlight current line
vim.opt.relativenumber = true -- Set line numbers relatives
vim.opt.number = true -- Display line numbers
vim.opt.showbreak = "↪" -- Show line wrapping character

-- Keep undo history across sessions, by storing in file
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Set fold options
vim.opt.foldmethod = "indent"
vim.opt.foldnestmax = 10
vim.opt.foldenable = false
vim.opt.foldlevel = 2
