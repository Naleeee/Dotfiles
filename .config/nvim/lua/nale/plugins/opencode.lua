return {
	"nickjvandyke/opencode.nvim",
	version = "*",
	dependencies = {
		{
			"folke/snacks.nvim",
			optional = true,
		},
	},
	config = function()
		---@type opencode.Opts
		vim.g.opencode_opts = {
			provider = {
				enabled = "tmux",
				tmux = {
					options = "-h",
					focus = true, -- Auto-focus the opencode pane when it is created
				},
			},
		}

		vim.o.autoread = true

		-- Focus the opencode tmux pane after dispatching a prompt.
		-- The pane_id is stored on the provider instance after start().
		local function focus_panel()
			local ok, config = pcall(require, "opencode.config")
			if not ok then
				return
			end
			local provider = config.provider
			if provider and provider.pane_id then
				vim.fn.system("tmux select-pane -t " .. provider.pane_id)
			end
		end

		-- Keymaps using <leader>o prefix to avoid conflicts with copilot and built-in mappings
		vim.keymap.set({ "n", "x" }, "<leader>oa", function()
			require("opencode").ask("@this: ", { submit = true })
			focus_panel()
		end, { desc = "Ask opencode" })

		vim.keymap.set({ "n", "x" }, "<leader>os", function()
			require("opencode").select()
			focus_panel()
		end, { desc = "Select opencode action" })

		vim.keymap.set({ "n", "t" }, "<leader>ot", function()
			require("opencode").toggle()
			-- toggle() calls start() which respects focus=true on creation;
			-- also focus explicitly so re-toggling an existing pane also focuses
			focus_panel()
		end, { desc = "Toggle opencode" })

		vim.keymap.set({ "n", "x" }, "go", function()
			return require("opencode").operator("@this ")
		end, { desc = "Add range to opencode", expr = true })

		vim.keymap.set("n", "goo", function()
			return require("opencode").operator("@this ") .. "_"
		end, { desc = "Add line to opencode", expr = true })

		vim.keymap.set("n", "<S-C-u>", function()
			require("opencode").command("session.half.page.up")
		end, { desc = "Scroll opencode up" })

		vim.keymap.set("n", "<S-C-d>", function()
			require("opencode").command("session.half.page.down")
		end, { desc = "Scroll opencode down" })
	end,
}
