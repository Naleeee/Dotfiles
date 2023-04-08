local map = require("utils").map

vim.g.mapleader = ","

-- Copy to clipboard
map("n", "<leader>y", "\"+yy")
map("v", "<leader>y", "\"+y")

-- Paste from clipboard
map("n", "<leader>p", "\"+p")
map("v", "<leader>p", "\"+p")

-- Buffer manipulation
map("n", "<leader>bq", "<Cmd>bp <BAR> bd #<CR>")

-- Remove search highlight with //
map("n", "//", "<Cmd>nohlsearch<CR>")

-- Splits
map("n", "ss", "<Cmd>split<CR><C-W>j")
map("n", "vv", "<Cmd>vsplit<CR><C-W>l")

-- Exit insert mode
map("i", "kj", "<ESC>")
map("i", "jk", "<ESC>")
map("i", "Kj", "<ESC>")
map("i", "Jk", "<ESC>")
map("i", "kJ", "<ESC>")
map("i", "jK", "<ESC>")
map("i", "KJ", "<ESC>")
map("i", "JK", "<ESC>")

-- Make navigation easier
map("n", "<C-j>", "<C-w>j")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Folds
map("n", "<Space>", "za")

-- Replace selection
map("v", "<C-r>", "\"hy:%s/<C-r>h//gc<left><left><left>")

-- Move selection
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor in middle when searching keyword
map("n", "n", "nzz")
map("n", "N", "Nzz")

-- Delete to the void register
map("n", "<leader>d", "\"_d")
map("v", "<leader>d", "\"_d")

-- TODO: Find key to map this on
-- Paste over selection and don't copy
-- map("x", "<leader>p", "\"_dP")

-- CodeActionMenu
map("n", "<leader>ac", "<Cmd>CodeActionMenu<CR>")

-- Comment line
-- map("n", "<C-u>", "<leader>c<Space><CR>")

--  Better mouse scroll
map("n", "<ScrollWheelUp>", "k")
map("n", "<ScrollWheelDown>", "j")

--  Open git messenger
map("n", "<leader>gm", ":GitMessenger")

--  Toggle markdown preview
map("n", "<C-p>", ":MarkdownPreviewToggle<CR>")

--  Navigate from erros / warnings
-- map("n", "<leader>N", "<Plug>(coc-diagnostic-prev)")
-- map("n", "<leader>n", "<Plug>(coc-diagnostic-next)")

vim.api.nvim_create_user_command("W", "w", {})

-- map("n", "<Up><Up><Down><Down><Left><Right><Left><Right>ba<space>", ":x<ENTER>")
