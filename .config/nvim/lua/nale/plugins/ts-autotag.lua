return {
	"windwp/nvim-ts-autotag",
	dependencies = "nvim-treesitter/nvim-treesitter",
	config = function()
		local autotag = require("nvim-ts-autotag")

		autotag.setup({})
	end,
	lazy = true,
	event = "VeryLazy",
}
