local keymap = vim.keymap -- for conciseness

-- Config file patterns for linter detection
local biome_configs = { "biome.json", "biome.jsonc" }
local eslint_configs = { ".eslintrc", ".eslintrc.json", ".eslintrc.js", ".eslintrc.cjs", "eslint.config.js", "eslint.config.mjs" }

-- Helper: check if config files exist upward from buffer
local function has_config(patterns, bufnr)
	local bufname = vim.api.nvim_buf_get_name(bufnr or 0)
	return vim.fs.find(patterns, { path = bufname, upward = true })[1] ~= nil
end

-- Configure Biome: only attach if biome config exists
vim.lsp.config("biome", {
	root_markers = biome_configs,
	on_attach = function(client, bufnr)
		if not has_config(biome_configs, bufnr) then
			vim.lsp.stop_client(client.id, true)
		end
	end,
})

-- Configure ESLint: only attach if eslint config exists AND biome config does NOT exist
vim.lsp.config("eslint", {
	root_markers = eslint_configs,
	on_attach = function(client, bufnr)
		local has_eslint = has_config(eslint_configs, bufnr)
		local has_biome = has_config(biome_configs, bufnr)
		if not has_eslint or has_biome then
			vim.lsp.stop_client(client.id, true)
		end
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf, silent = true }

		-- Go to keymaps (no prefix)
		opts.desc = "Go to definition"
		keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts)

		opts.desc = "Go to declaration"
		keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

		opts.desc = "Find references"
		keymap.set("n", "gr", "<cmd>Lspsaga finder<CR>", opts)

		opts.desc = "Go to implementation"
		keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

		opts.desc = "Go to type definition"
		keymap.set("n", "gt", "<cmd>Lspsaga goto_type_definition<CR>", opts)

		opts.desc = "Show documentation"
		keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)

		-- Standalone keymaps
		opts.desc = "Code actions"
		keymap.set({ "n", "v" }, "<leader>qf", "<cmd>Lspsaga code_action<CR>", opts)

		opts.desc = "Previous diagnostic"
		keymap.set("n", "<leader>N", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)

		opts.desc = "Next diagnostic"
		keymap.set("n", "<leader>n", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)

		-- LSP group (<leader>m)
		opts.desc = "Rename symbol"
		keymap.set("n", "<leader>mn", "<cmd>Lspsaga rename<CR>", opts)

		opts.desc = "Toggle outline"
		keymap.set("n", "<leader>mo", "<cmd>Lspsaga outline<CR>", opts)

		opts.desc = "Restart LSP"
		keymap.set("n", "<leader>mr", ":LspRestart<CR>", opts)

		-- Diagnostics group (<leader>x)
		opts.desc = "Line diagnostics"
		keymap.set("n", "<leader>xi", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)

		opts.desc = "Buffer diagnostics (Telescope)"
		keymap.set("n", "<leader>xt", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
	end,
})

-- vim.lsp.inlay_hint.enable(true)

local severity = vim.diagnostic.severity

vim.diagnostic.config({
	signs = {
		text = {
			[severity.ERROR] = " ",
			[severity.WARN] = " ",
			[severity.HINT] = "󰠠 ",
			[severity.INFO] = " ",
		},
	},
})
