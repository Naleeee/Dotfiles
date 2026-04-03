return {
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
