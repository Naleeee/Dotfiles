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
		focus_after_send = true,
	},
	config = function(_, opts)
		vim.o.autoread = true

		local function is_claude_buf(bufnr)
			return vim.api.nvim_buf_get_name(bufnr):match("claude") ~= nil
		end

		-- Recompute layout at toggle time so it responds to window resizes
		local function toggle()
			suppress_auto_insert = true
			require("claudecode.terminal").simple_toggle({
				snacks_win_opts = vim.tbl_deep_extend("force", opts.terminal.snacks_win_opts, claude_win()),
			})
			vim.defer_fn(function()
				suppress_auto_insert = false
			end, 200)
		end

		require("claudecode").setup(opts)

		-- Buffer-local terminal-mode pane navigation for Claude windows.
		local group = vim.api.nvim_create_augroup("ClaudeCodeTermNav", { clear = true })

		vim.api.nvim_create_autocmd("TermOpen", {
			group = group,
			callback = function(ev)
				if not is_claude_buf(ev.buf) then
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

		-- Auto-enter terminal mode when navigating into a Claude window.
		-- Skipped during toggle (suppress flag) so snacks keeps its own focus behavior.
		local suppress_auto_insert = false

		vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
			group = group,
			callback = function(ev)
				if suppress_auto_insert then
					return
				end
				if is_claude_buf(ev.buf) and vim.bo[ev.buf].buftype == "terminal" then
					vim.defer_fn(function()
						if vim.bo.buftype == "terminal" and is_claude_buf(vim.api.nvim_get_current_buf()) then
							vim.api.nvim_input("a")
						end
					end, 10)
				end
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
			suppress_auto_insert = true
			require("claudecode.terminal").simple_toggle({ flags = "--resume" })
			vim.defer_fn(function()
				suppress_auto_insert = false
			end, 200)
		end, { desc = "Resume Claude session" })

		-- Continue most recent session
		vim.keymap.set("n", "<leader>al", function()
			suppress_auto_insert = true
			require("claudecode.terminal").simple_toggle({ flags = "--continue" })
			vim.defer_fn(function()
				suppress_auto_insert = false
			end, 200)
		end, { desc = "Continue last Claude session" })

		-- Accept / deny diffs proposed by Claude
		vim.keymap.set("n", "<leader>aya", "<cmd>ClaudeCodeDiffAccept<cr>", { desc = "Accept Claude diff" })
		vim.keymap.set("n", "<leader>ayd", "<cmd>ClaudeCodeDiffDeny<cr>", { desc = "Deny Claude diff" })
	end,
}
