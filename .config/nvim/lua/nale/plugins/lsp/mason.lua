return {
	{
		"neovim/nvim-lspconfig",
		lazy = false,
	},
	{
		"williamboman/mason.nvim",
		lazy = false,
		opts = {
			ui = {
				border = "rounded",
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				-- LSP servers
				"bash-language-server",
				"biome",
				"css-lsp",
				"eslint-lsp",
				"html-lsp",
				"json-lsp",
				"lua-language-server",
				"tailwindcss-language-server",
				"vim-language-server",
				"vtsls",
				"vue-language-server",
				-- Formatters & linters
				"eslint_d",
				"prettier",
				"stylua",
				"markdownlint",
			},
		},
		dependencies = {
			"williamboman/mason.nvim",
		},
	},
}
