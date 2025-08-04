return {
	"mason-org/mason.nvim",
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})
	end,

	"mason-org/mason-lspconfig.nvim",
	opts = {
		ensure_installed = {
			"bashls",
			"clangd",
			"cmake",
			"cssls",
			"eslint",
			"graphql",
			"html",
			"lua_ls",
			"ts_ls",
			"vimls",
		},
	},
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
	},
}
