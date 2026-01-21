return {
	"nvimdev/lspsaga.nvim",
	event = "LspAttach",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("lspsaga").setup({
			ui = {
				border = "rounded",
				code_action = "",
			},
			lightbulb = {
				enable = false,
			},
			symbol_in_winbar = {
				enable = false,
			},
			code_action = {
				show_server_name = true,
				extend_gitsigns = true,
			},
			hover = {
				max_width = 0.6,
				max_height = 0.5,
			},
			rename = {
				in_select = false,
				auto_save = true,
			},
			outline = {
				win_width = 40,
				auto_preview = true,
				detail = true,
			},
			finder = {
				keys = {
					toggle_or_open = "<CR>",
					quit = "q",
				},
			},
		})
	end,
}
