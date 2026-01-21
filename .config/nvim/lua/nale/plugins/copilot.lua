return {
	{
		"zbirenbaum/copilot.lua",
		event = "InsertEnter",
		build = ":Copilot auth",
		config = function()
			require("copilot").setup({
				suggestion = {
					enabled = true,
					auto_trigger = true,
					keymap = {
						-- Disable default keymaps, we'll set our own
						accept = false,
						next = false,
						prev = false,
						dismiss = false,
					},
				},
				panel = { enabled = false },
			})

			-- Smart keymaps that only work when suggestion is visible
			local suggestion = require("copilot.suggestion")

			vim.keymap.set("i", "<C-l>", function()
				if suggestion.is_visible() then
					suggestion.accept()
				end
			end, { desc = "Accept Copilot suggestion" })

			vim.keymap.set("i", "<M-]>", function()
				if suggestion.is_visible() then
					suggestion.next()
				end
			end, { desc = "Next Copilot suggestion" })

			vim.keymap.set("i", "<M-[>", function()
				if suggestion.is_visible() then
					suggestion.prev()
				end
			end, { desc = "Previous Copilot suggestion" })

			vim.keymap.set("i", "<C-x>", function()
				if suggestion.is_visible() then
					suggestion.dismiss()
				end
			end, { desc = "Dismiss Copilot suggestion" })

			-- Accept word by word (useful for partial accepts)
			vim.keymap.set("i", "<C-Right>", function()
				if suggestion.is_visible() then
					suggestion.accept_word()
				end
			end, { desc = "Accept Copilot word" })

			-- Accept line by line
			vim.keymap.set("i", "<C-Down>", function()
				if suggestion.is_visible() then
					suggestion.accept_line()
				end
			end, { desc = "Accept Copilot line" })
		end,
	},
}
