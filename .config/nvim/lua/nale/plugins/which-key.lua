return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 400
	end,
	opts = {
		preset = "helix",
		icons = {
			breadcrumb = "»",
			separator = "➜",
			group = "+",
		},
		spec = {
			-- Groups
			{ "<leader>b", group = "Buffers", icon = { icon = "📂", color = "cyan" } },
			{ "<leader>m", group = "LSP", icon = { icon = "💡", color = "yellow" } },
			{ "<leader>x", group = "Diagnostics", icon = { icon = "💊", color = "red" } },
			{ "<leader>t", group = "Tools", icon = { icon = "🛠️", color = "purple" } },
			{ "<leader>l", group = "Git", icon = { icon = "🌳", color = "orange" } },
			{ "<leader>n", group = "Notifications", icon = { icon = "1️⃣", color = "blue" } },
			{ "<leader>w", group = "Workspace", icon = { icon = "🏢", color = "azure" } },
			{ "<leader>e", group = "Explorer", icon = { icon = "🕵️", color = "green" } },
			-- Standalone
			{ "<leader>f", desc = "Find files", icon = { icon = "", color = "blue" } },
			{ "<leader>g", desc = "Grep", icon = { icon = "", color = "green" } },
			{ "<leader>F", desc = "Grep word", icon = { icon = "", color = "green" } },
			{ "<leader>j", desc = "Prev buffer", icon = { icon = "", color = "cyan" } },
			{ "<leader>k", desc = "Next buffer", icon = { icon = "", color = "cyan" } },
			{ "<leader>h", desc = "Clear highlights", icon = { icon = "", color = "yellow" } },
			{ "<leader>qf", desc = "Code actions", icon = { icon = "", color = "yellow" } },
		},
	},
}
