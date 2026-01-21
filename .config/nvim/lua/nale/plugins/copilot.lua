return {
	{
		"zbirenbaum/copilot.lua",
		event = "InsertEnter",
		build = ":Copilot auth",
		config = function()
			require("copilot").setup({
				suggestion = {
					enabled = true,
					auto_trigger = true,
					keymap = {
						accept = "<C-l>",
						next = "<C-]>",
						prev = "<C-[>",
						dismiss = "<C-h>",
					},
				},
				panel = { enabled = false },
			})
		end,
	},
}
