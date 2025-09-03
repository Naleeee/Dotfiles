return {
	"anuvyklack/windows.nvim",
	dependencies = {
		"anuvyklack/middleclass",
		"anuvyklack/animation.nvim",
	},
	config = function()
		local windows = require("windows")

		vim.o.winwidth = 10
		vim.o.winminwidth = 10
		vim.o.equalalways = false
		windows.setup()
	end,
}
