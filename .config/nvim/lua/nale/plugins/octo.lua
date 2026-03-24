return {
	"pwntester/octo.nvim",
	cmd = "Octo",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "<leader>oi", "<cmd>Octo issue list<cr>", desc = "List GitHub Issues" },
		{ "<leader>op", "<cmd>Octo pr list<cr>", desc = "List GitHub PRs" },
		{ "<leader>od", "<cmd>Octo discussion list<cr>", desc = "List GitHub Discussions" },
		{ "<leader>on", "<cmd>Octo notification list<cr>", desc = "List GitHub Notifications" },
		{ "<leader>os", "<cmd>Octo search<cr>", desc = "Search GitHub" },
	},
	opts = {
		picker = "telescope",
		enable_builtin = true,
		default_remote = { "upstream", "origin" },
	},
}
