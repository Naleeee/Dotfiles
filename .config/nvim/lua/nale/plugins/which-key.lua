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
			-- Groups
			{ "<leader>a", group = "Claude", icon = "" },
			{ "<leader>ay", group = "Claude Diff", icon = "" },
			{ "<leader>b", group = "Buffer", icon = "󰈔" },
			{ "<leader>e", group = "Explorer", icon = "󰙅" },
			{ "<leader>i", group = "Info", icon = "󰍡" },
			{ "<leader>w", group = "Window", icon = "" },
			{ "<leader>m", group = "LSP", icon = "󰒕" },
			{ "<leader>o", group = "Opencode", icon = "󰚩" },
			{ "<leader>q", group = "Quickfix", icon = "󰁨" },
			{ "<leader>s", group = "Sticky Notes", icon = "󰍔" },
			{ "<leader>t", group = "Tooling", icon = "󰔨" },
			{ "<leader>x", group = "Trouble", icon = "󰚑" },

			-- Standalone keys
			{ "<leader>c", icon = "󱐋", desc = "Flash" },
			{ "<leader>C", icon = "󱐋", desc = "Flash Treesitter" },
			{ "<leader>d", icon = "󰈸", desc = "Delete to void register" },
			{ "<leader>l", icon = "󰊢", desc = "Lazygit" },
			{ "<leader>j", icon = "󰮳", desc = "Previous buffer" },
			{ "<leader>k", icon = "󰮱", desc = "Next buffer" },
		},
	},
}
