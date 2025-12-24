return {
	"folke/trouble.nvim",
	opts = {
		focus = true, -- Focus trouble window when opened
	},
	cmd = "Trouble",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (workspace)" },
		{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Diagnostics (buffer)" },
		{ "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },
		{ "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location list" },
		{ "<leader>xs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols outline" },
		-- Show diagnostic info in floating window
		{
			"<leader>xd",
			function()
				vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
			end,
			desc = "Show diagnostic (cursor)",
		},
		{
			"<leader>xD",
			function()
				vim.diagnostic.open_float(nil, { focus = false, scope = "line" })
			end,
			desc = "Show diagnostics (line)",
		},
	},
}
