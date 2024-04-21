local keymap = vim.keymap

-- Leader
vim.g.mapleader = " "

-- Exit insert mode with jk
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode" })
keymap.set("i", "kj", "<ESC>", { desc = "Exit insert mode" })
keymap.set("i", "Jk", "<ESC>", { desc = "Exit insert mode" })
keymap.set("i", "Kj", "<ESC>", { desc = "Exit insert mode" })
keymap.set("i", "jK", "<ESC>", { desc = "Exit insert mode" })
keymap.set("i", "kJ", "<ESC>", { desc = "Exit insert mode" })
keymap.set("i", "JK", "<ESC>", { desc = "Exit insert mode" })
keymap.set("i", "KJ", "<ESC>", { desc = "Exit insert mode" })

-- Clear current search highlight
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Increment / decrement number
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- Window management
keymap.set("n", "vv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "ss", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally

-- Buffer management
keymap.set("n", "<leader>bq", "<Cmd>bp <BAR> bd #<CR>", { desc = "Close current buffer" })

-- Move selection
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection up" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection down" })

-- Replace selection
keymap.set("v", "<C-r>", '"hy:%s/<C-r>h//gc<left><left><left>', { desc = "Find and replace current selection" })

-- Keep cursor in middle when searching keyword
keymap.set("n", "n", "nzz", { desc = "Keep cursor in middle" })
keymap.set("n", "N", "Nzz", { desc = "Keep cursor in middle" })

-- Delete to the void register
keymap.set("n", "<leader>d", '"_d', { desc = "Delete to the void register" })
keymap.set("v", "<leader>d", '"_d', { desc = "Delete to the void register" })

-- Paste over selection and don't copy
keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without copying" })

--  Better mouse scroll
keymap.set("n", "<ScrollWheelUp>", "k", { desc = "Move up on scroll wheel up" })
keymap.set("n", "<ScrollWheelDown>", "j", { desc = "Move down on scroll wheel down" })

-- Make basic editions tools work with hangul
keymap.set("n", "ㅗ", "h", { desc = "Go left" })
keymap.set("n", "ㅓ", "j", { desc = "Go down" })
keymap.set("n", "ㅏ", "k", { desc = "Go up" })
keymap.set("n", "ㅣ", "l", { desc = "Go right" })
keymap.set("n", "ㅑ", "a", { desc = "Switch to insert mode" })
keymap.set("i", "ㅓㅏ", "<ESC>", { desc = "Exit insert mode" })
keymap.set("i", "ㅏㅓ", "<ESC>", { desc = "Exit insert mode" })

-- Cycle through errors
keymap.set("n", "<leader>N", "<Cmd>lua vim.diagnostic.goto_prev()<CR>", { desc = "Go to previous diagnostic" })
keymap.set("n", "<leader>n", "<Cmd>lua vim.diagnostic.goto_next()<CR>", { desc = "Go to next diagnostic" })

-- Konami code
keymap.set(
	"n",
	"<leader><Up><Up><Down><Down><Left><Right><Left><Right>ba<space>",
	"<Cmd>Tetris<CR>",
	{ desc = "Special event..." }
)
