return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	opts = {
		preset = "helix",
		icons = {
			breadcrumb = "»",
			separator = "➜",
			group = "+",
		},
		spec = {
			{ "<leader>x", group = "Trouble/Diagnostics", icon = "" },
			{ "<leader>q", group = "Quickfix", icon = "" },
			{ "<leader>r", group = "Rename/Restart", icon = "" },
			{ "<leader>g", group = "Git/Grep", icon = "" },
			{ "<leader>n", group = "Notifications", icon = "" },
		},
	},
}
