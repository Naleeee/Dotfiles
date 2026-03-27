return {
	"olimorris/codecompanion.nvim",
	version = "^19.0.0",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		adapters = {
			claude_code = function()
				return require("codecompanion.adapters").extend("claude_code", {})
			end,
			opencode = function()
				return require("codecompanion.adapters").extend("opencode", {})
			end,
		},
		strategies = {
			chat = {
				adapter = "claude_code",
			},
			inline = {
				adapter = "claude_code",
			},
			cmd = {
				adapter = "claude_code",
			},
		},
	},
	config = function(_, opts)
		require("codecompanion").setup(opts)

		-- Toggle chat
		vim.keymap.set({ "n", "v" }, "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Toggle chat" })

		-- Add selection/buffer to chat
		vim.keymap.set("v", "<leader>c+", "<cmd>CodeCompanionChat Add<cr>", { desc = "Add selection to chat" })

		-- Action palette
		vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>CodeCompanionActions<cr>", { desc = "Action palette" })

		-- Inline prompt
		vim.keymap.set({ "n", "v" }, "<leader>ci", "<cmd>CodeCompanion<cr>", { desc = "Inline prompt" })

		-- Quick chat with specific adapter
		vim.keymap.set("n", "<leader>co", "<cmd>CodeCompanionChat adapter=opencode<cr>", { desc = "Chat with OpenCode" })
		vim.keymap.set("n", "<leader>cl", "<cmd>CodeCompanionChat adapter=claude_code<cr>", { desc = "Chat with Claude" })

		-- Command-line generation
		vim.keymap.set("n", "<leader>cm", "<cmd>CodeCompanionCmd<cr>", { desc = "Generate command" })

		-- Abbreviation for quick access
		vim.cmd([[cab cc CodeCompanion]])
	end,
}
