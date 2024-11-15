return {
	"folke/noice.nvim",
	event = "VeryLazy",
	config = function()
		local noice = require("noice")

		noice.setup({
			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
			},
			messages = {
				enabled = false, -- disable the Noice messages UI
			},
			presets = {
				bottom_search = false, -- use a top cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
			},
		})

		-- set keymaps
		local keymap = vim.keymap

		keymap.set("n", "<leader>nc", "<cmd>NoiceDismiss<cr>", { desc = "Clear current noice notifications" })
	end,
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
}
