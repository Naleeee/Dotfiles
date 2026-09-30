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
		windows.setup({
			ignore = {
				buftype = { "quickfix", "terminal" },
			},
			-- Animated resizes feed Normal-mode keys while a terminal is in Terminal mode, which desyncs the Claude split
			animation = { enable = false },
		})
	end,
}
