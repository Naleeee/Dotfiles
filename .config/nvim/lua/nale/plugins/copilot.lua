return {
	{

		"github/copilot.vim",
		-- config = function()
		-- 	local copilot = require("github/copilot.vim")
		-- 	copilot.setup()
		-- end,
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot", -- lazy load on command
		event = "InsertEnter", -- or other lazy trigger
		config = function()
			require("copilot").setup({
				suggestion = { enabled = true, auto_trigger = true, keymap = { accept = "<C-l>" } },
				panel = { enabled = true, keymap = { jump_next = "<C-j>", jump_prev = "<C-k>", open = "<C-p>" } },
			})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		dependencies = { "zbirenbaum/copilot.lua", "hrsh7th/nvim-cmp" },
		config = function()
			require("copilot_cmp").setup()
		end,
	},
}
