return {
	"toppair/peek.nvim",
	event = { "VeryLazy" },
	ft = { "markdown" },
	build = "deno task --quiet build:fast",
	config = function()
		require("peek").setup({
			auto_load = false,
			close_on_bdelete = true,
			syntax = true,
			theme = "dark",
			update_on_change = true,
			app = "browser",
			filetype = { "markdown" },
			throttle_at = 200000,
			throttle_time = "auto",
		})

		vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
		vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})

		vim.keymap.set("n", "<C-p>", "<cmd>PeekOpen<cr>", { desc = "Open markdown preview in browser" })
	end,
}
