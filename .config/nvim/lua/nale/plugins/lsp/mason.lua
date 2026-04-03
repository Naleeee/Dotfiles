return {
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		dependencies = {
			{
				"williamboman/mason.nvim",
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
		},
		opts = {},
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
				"typescript-language-server",
				"tailwindcss-language-server",
				"vim-language-server",
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
