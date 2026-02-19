return {
	"folke/noice.nvim",
	event = "VeryLazy",
	config = function()
		local noice = require("noice")

		noice.setup({
			cmdline = {
				view = "cmdline_popup",
				format = {
					cmdline = { icon = ">" },
					search_up = { icon = "?" },
				},
			},
			messages = {
				enabled = true,
				view = "mini",
			},
			popupmenu = {
				enabled = true,
				backend = "nui",
			},
			lsp = {
				progress = { enabled = false }, -- Use fidget instead
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
				hover = { enabled = false }, -- Use lspsaga instead
				signature = { enabled = true },
			},
			presets = {
				bottom_search = false,
				command_palette = true,
				long_message_to_split = true,
				lsp_doc_border = true,
			},
			views = {
				mini = {
					win_options = {
						winblend = 0,
					},
				},
			},
		})

		local keymap = vim.keymap
		keymap.set("n", "<leader>nc", "<cmd>NoiceDismiss<cr>", { desc = "Dismiss notifications" })
		keymap.set("n", "<leader>nh", "<cmd>Noice history<cr>", { desc = "Notification history" })
	end,
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
}
