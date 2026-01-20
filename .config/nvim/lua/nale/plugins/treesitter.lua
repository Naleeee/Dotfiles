return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"windwp/nvim-ts-autotag",
		"HiPhish/rainbow-delimiters.nvim",
	},
	config = function()
		-- import nvim-treesitter plugin
		local treesitter = require("nvim-treesitter.configs")

		-- configure treesitter
		treesitter.setup({
			sync_install = false, -- install parsers synchronously
			auto_install = true, -- automatically install missing parsers when entering buffer
			modules = {},
			ignore_install = {}, -- List of parsers to ignore installing
			highlight = { enable = true }, -- enable syntax highlighting
			indent = { enable = true }, -- enable indentation
			-- ensure these language parsers are installed
			textobjects = {
				select = {
					enable = true,
					lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]m"] = "@function.outer",
						["]]"] = "@class.outer",
					},
					goto_next_end = {
						["]M"] = "@function.outer",
						["]["] = "@class.outer",
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
						["[["] = "@class.outer",
					},
					goto_previous_end = {
						["[M"] = "@function.outer",
						["[]"] = "@class.outer",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>p"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>ps"] = "@parameter.inner",
					},
				},
			},
			ensure_installed = {
				"bash",
				"c",
				"cmake",
				"cpp",
				"css",
				"diff",
				"dockerfile",
				"gitcommit",
				"gitignore",
				"graphql",
				"html",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"scss",
				"typescript",
				"tsx",
				"vim",
				"vimdoc",
				"vue",
				"yaml",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		})
	end,
}
