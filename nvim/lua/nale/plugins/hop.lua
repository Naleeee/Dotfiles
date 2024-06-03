return {
	"phaazon/hop.nvim",
	branch = "v2",
	config = function()
		local hop = require("hop")

		hop.setup()

		-- set keymaps
		local keymap = vim.keymap

		keymap.set("n", "<leader><leader>", "<cmd>HopWord<cr>", { desc = "Trigger hop moving view" })
	end,
}
