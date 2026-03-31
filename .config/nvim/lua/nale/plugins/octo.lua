return {
	"pwntester/octo.nvim",
	cmd = "Octo",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		-- Navigation
		{ "<leader>oi", "<cmd>Octo issue list<cr>", desc = "List GitHub Issues" },
		{ "<leader>op", "<cmd>Octo pr list<cr>", desc = "List GitHub PRs" },
		{ "<leader>od", "<cmd>Octo discussion list<cr>", desc = "List GitHub Discussions" },
		{ "<leader>on", "<cmd>Octo notification list<cr>", desc = "List GitHub Notifications" },
		{ "<leader>os", "<cmd>Octo search<cr>", desc = "Search GitHub" },

		-- Review lifecycle
		{ "<leader>ors", "<cmd>Octo review start<cr>", desc = "Start Review" },
		{ "<leader>orr", "<cmd>Octo review resume<cr>", desc = "Resume Pending Review" },
		{ "<leader>orf", "<cmd>Octo review submit<cr>", desc = "Finish/Submit Review" },
		{ "<leader>ord", "<cmd>Octo review discard<cr>", desc = "Discard Review" },
		{ "<leader>orc", "<cmd>Octo review comments<cr>", desc = "View Pending Review Comments" },
		{ "<leader>ork", "<cmd>Octo review commit<cr>", desc = "Review Specific Commit" },

		-- Comments & suggestions
		{ "<leader>oca", "<cmd>Octo comment add<cr>", desc = "Add Comment" },
		{ "<leader>ocd", "<cmd>Octo comment delete<cr>", desc = "Delete Comment" },

		-- Thread management
		{ "<leader>otr", "<cmd>Octo thread resolve<cr>", desc = "Resolve Thread" },
		{ "<leader>otu", "<cmd>Octo thread unresolve<cr>", desc = "Unresolve Thread" },

		-- PR actions
		{ "<leader>opa", "<cmd>Octo pr merge squash<cr>", desc = "Squash Merge PR" },
		{ "<leader>opm", "<cmd>Octo pr merge commit<cr>", desc = "Merge PR (commit)" },
		{ "<leader>opr", "<cmd>Octo pr merge rebase<cr>", desc = "Rebase Merge PR" },
		{ "<leader>opc", "<cmd>Octo pr checkout<cr>", desc = "Checkout PR" },
		{ "<leader>opd", "<cmd>Octo pr diff<cr>", desc = "Show PR Diff" },
	},
	opts = {
		picker = "telescope",
		enable_builtin = true,
		default_remote = { "upstream", "origin" },
	},
}
