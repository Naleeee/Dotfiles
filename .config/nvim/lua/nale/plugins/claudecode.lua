local function claude_win()
	return {
		position = "right",
		width = 0.25,
		stack = false,
		resize = false,
	}
end

return {
	"coder/claudecode.nvim",
	dependencies = {
		{
			"folke/snacks.nvim",
			optional = true,
		},
	},
	opts = {
		terminal = {
			provider = "snacks",
			snacks_win_opts = vim.tbl_deep_extend("force", claude_win(), {
				keys = {
					nav_left = {
						"<C-h>",
						function()
							vim.cmd("TmuxNavigateLeft")
						end,
						mode = "t",
						desc = "Navigate left from terminal",
					},
					nav_down = {
						"<C-j>",
						function()
							vim.cmd("TmuxNavigateDown")
						end,
						mode = "t",
						desc = "Navigate down from terminal",
					},
					nav_up = {
						"<C-k>",
						function()
							vim.cmd("TmuxNavigateUp")
						end,
						mode = "t",
						desc = "Navigate up from terminal",
					},
					nav_right = {
						"<C-l>",
						function()
							vim.cmd("TmuxNavigateRight")
						end,
						mode = "t",
						desc = "Navigate right from terminal",
					},
				},
			}),
		},
	},
	config = function(_, opts)
		vim.o.autoread = true

		-- Recompute layout at toggle time so it responds to window resizes
		local function toggle()
			require("claudecode.terminal").simple_toggle({
				snacks_win_opts = vim.tbl_deep_extend("force", opts.terminal.snacks_win_opts, claude_win()),
			})
		end

		require("claudecode").setup(opts)

		-- Toggle: normal mode on leader, terminal mode without leader
		vim.keymap.set("n", "<leader>ac", toggle, { desc = "Toggle Claude Code" })

		-- Send visual selection as context
		vim.keymap.set("v", "<leader>ac", "<cmd>ClaudeCodeSend<cr>", { desc = "Send selection to Claude" })

		-- Add current buffer to Claude context
		vim.keymap.set("n", "<leader>a+", "<cmd>ClaudeCodeAdd %<cr>", { desc = "Add buffer to Claude context" })

		-- Resume last session via picker
		vim.keymap.set("n", "<leader>an", function()
			require("claudecode.terminal").simple_toggle({ flags = "--resume" })
		end, { desc = "Resume Claude session" })

		-- Accept / deny diffs proposed by Claude
		vim.keymap.set("n", "<leader>aya", "<cmd>ClaudeCodeDiffAccept<cr>", { desc = "Accept Claude diff" })
		vim.keymap.set("n", "<leader>ayd", "<cmd>ClaudeCodeDiffDeny<cr>", { desc = "Deny Claude diff" })
	end,
}
