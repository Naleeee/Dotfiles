return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	config = function()
		local todo_comments = require("todo-comments")

		todo_comments.setup({
			search = {
				command = "rg",
				args = {
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--hidden",
					"--glob=!.git/",
				},
			},
		})

		-- Navigate between todo comments
		vim.keymap.set("n", "]t", function()
			todo_comments.jump_next()
		end, { desc = "Next todo comment" })

		vim.keymap.set("n", "[t", function()
			todo_comments.jump_prev()
		end, { desc = "Previous todo comment" })

		vim.keymap.set("n", "<leader>td", "<cmd>TodoTelescope<cr>", { desc = "Search todo comments" })
	end,
}
