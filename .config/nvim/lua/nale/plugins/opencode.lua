local function opencode_win()
	local min_columns = 160
	if vim.o.columns >= min_columns then
		return {
			position = "right",
			width = 0.25,
			enter = true,
		}
	end
	return {
		position = "float",
		width = 0.9,
		height = 0.9,
		enter = true,
	}
end

return {
	"nickjvandyke/opencode.nvim",
	dependencies = {
		{
			"folke/snacks.nvim",
			optional = true,
			opts = {
				input = {},
				picker = {
					actions = {
						opencode_send = function(...)
							return require("opencode").snacks_picker_send(...)
						end,
					},
					win = {
						input = {
							keys = {
								["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
							},
						},
					},
				},
				terminal = {},
			},
		},
	},
	config = function()
		vim.g.opencode_opts = {}
		vim.o.autoread = true

		local function apply_layout()
			local provider = require("opencode.config").provider
			if provider and provider.name == "snacks" then
				provider.opts.win = vim.tbl_deep_extend("force", provider.opts.win or {}, opencode_win())
			end
		end

		local function toggle()
			apply_layout()
			require("opencode").toggle()
		end

		-- Toggle: normal mode uses leader, terminal mode uses a non-leader key
		-- to avoid intercepting <Space> inside the terminal
		vim.keymap.set("n", "<leader>ot", toggle, { desc = "Toggle opencode" })
		vim.keymap.set("t", "<C-\\><C-o>", toggle, { desc = "Toggle opencode" })

		-- Ask: submit immediately with context
		vim.keymap.set({ "n", "x" }, "<leader>oa", function()
			require("opencode").ask("@this: ", { submit = true })
		end, { desc = "Ask opencode" })

		-- Select prompt / command palette
		vim.keymap.set({ "n", "x" }, "<leader>os", function()
			require("opencode").select()
		end, { desc = "Select opencode action" })

		-- Operator: supports ranges and dot-repeat (e.g. goip, go3j)
		vim.keymap.set({ "n", "x" }, "go", function()
			return require("opencode").operator("@this ")
		end, { desc = "Add range to opencode", expr = true })
		vim.keymap.set("n", "goo", function()
			return require("opencode").operator("@this ") .. "_"
		end, { desc = "Add line to opencode", expr = true })

		-- Context: append buffer or selection to prompt
		vim.keymap.set("n", "<leader>o+", function()
			require("opencode").prompt("@buffer", { append = true })
		end, { desc = "Add buffer to prompt" })
		vim.keymap.set("x", "<leader>o+", function()
			require("opencode").prompt("@this", { append = true })
		end, { desc = "Add selection to prompt" })

		-- Explain
		vim.keymap.set({ "n", "x" }, "<leader>oe", function()
			require("opencode").prompt("Explain @this and its context")
		end, { desc = "Explain this code" })

		-- Session
		vim.keymap.set("n", "<leader>on", function()
			require("opencode").command("session.new")
		end, { desc = "New session" })

		-- Scroll opencode messages
		vim.keymap.set("n", "<S-C-u>", function()
			require("opencode").command("session.half.page.up")
		end, { desc = "Scroll opencode up" })
		vim.keymap.set("n", "<S-C-d>", function()
			require("opencode").command("session.half.page.down")
		end, { desc = "Scroll opencode down" })
	end,
}
