return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha", -- latte, frappe, macchiato, mocha
			transparent_background = true,
			show_end_of_buffer = true, -- show the '~' characters after the end of buffers
			integrations = {
				notify = true,
				illuminate = true,
				indent_blankline = {
					enabled = true,
					colored_indent_levels = false,
				},
				markdown = true,
				telescope = true,
				which_key = true,
			},
		})

		vim.cmd("colorscheme catppuccin")
	end,
}
