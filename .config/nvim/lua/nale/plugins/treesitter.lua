return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		lazy = false,
		dependencies = {
			"windwp/nvim-ts-autotag",
			"HiPhish/rainbow-delimiters.nvim",
		},
		config = function()
			require("nvim-treesitter").setup()

			-- Install parsers if missing
			local ensure_installed = {
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
				"prisma",
				"scss",
				"sql",
				"typescript",
				"tsx",
				"vim",
				"vimdoc",
				"vue",
				"yaml",
			}
			local installed = require("nvim-treesitter").get_installed()
			local to_install = vim.iter(ensure_installed)
				:filter(function(parser)
					return not vim.tbl_contains(installed, parser)
				end)
				:totable()
			if #to_install > 0 then
				require("nvim-treesitter").install(to_install)
			end

			-- Enable treesitter highlighting and indentation
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					pcall(vim.treesitter.start)
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			local ts_select = require("nvim-treesitter-textobjects.select")
			local ts_move = require("nvim-treesitter-textobjects.move")

			require("nvim-treesitter-textobjects").setup({
				select = { lookahead = true },
				move = { set_jumps = true },
			})

			-- Select textobjects
			local select_maps = {
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			}
			for key, query in pairs(select_maps) do
				vim.keymap.set({ "x", "o" }, key, function()
					ts_select.select_textobject(query)
				end)
			end

			-- Move between textobjects
			local move_maps = {
				["]m"] = { fn = ts_move.goto_next_start, query = "@function.outer" },
				["]]"] = { fn = ts_move.goto_next_start, query = "@class.outer" },
				["]M"] = { fn = ts_move.goto_next_end, query = "@function.outer" },
				["]["] = { fn = ts_move.goto_next_end, query = "@class.outer" },
				["[m"] = { fn = ts_move.goto_previous_start, query = "@function.outer" },
				["[["] = { fn = ts_move.goto_previous_start, query = "@class.outer" },
				["[M"] = { fn = ts_move.goto_previous_end, query = "@function.outer" },
				["[]"] = { fn = ts_move.goto_previous_end, query = "@class.outer" },
			}
			for key, mapping in pairs(move_maps) do
				vim.keymap.set({ "n", "x", "o" }, key, function()
					mapping.fn(mapping.query)
				end)
			end
		end,
	},
}
