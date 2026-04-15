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
			snacks_win_opts = claude_win(),
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

		-- Buffer-local terminal-mode pane navigation for Claude windows.
		-- Snacks `keys` config wasn't translating <C-\><C-n> termcodes, so
		-- bind directly on TermOpen for any claudecode terminal buffer.
		vim.api.nvim_create_autocmd("TermOpen", {
			group = vim.api.nvim_create_augroup("ClaudeCodeTermNav", { clear = true }),
			callback = function(ev)
				local name = vim.api.nvim_buf_get_name(ev.buf)
				if not name:match("claude") then
					return
				end
				local map = function(lhs, cmd)
					vim.keymap.set("t", lhs, "<C-\\><C-n>:" .. cmd .. "<CR>", {
						buffer = ev.buf,
						silent = true,
						desc = "Navigate from Claude terminal",
					})
				end
				map("<C-h>", "TmuxNavigateLeft")
				map("<C-j>", "TmuxNavigateDown")
				map("<C-k>", "TmuxNavigateUp")
				map("<C-l>", "TmuxNavigateRight")
			end,
		})

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

		-- Continue most recent session
		vim.keymap.set("n", "<leader>al", function()
			require("claudecode.terminal").simple_toggle({ flags = "--continue" })
		end, { desc = "Continue last Claude session" })

		-- Accept / deny diffs proposed by Claude
		vim.keymap.set("n", "<leader>aya", "<cmd>ClaudeCodeDiffAccept<cr>", { desc = "Accept Claude diff" })
		vim.keymap.set("n", "<leader>ayd", "<cmd>ClaudeCodeDiffDeny<cr>", { desc = "Deny Claude diff" })
	end,
}
