return {
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			-- list of servers for mason to install
			ensure_installed = {
				"bashls",
				"biome",
				"cssls",
				"eslint",
				"html",
				"lua_ls",
				"ts_ls",
				"tailwindcss",
				"vimls",
				"vue_ls",
			},
		},
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
			"neovim/nvim-lspconfig",
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"eslint_d",
				"prettier",
				"biome",
				"stylua",
				"markdownlint",
			},
		},
		dependencies = {
			"williamboman/mason.nvim",
		},
	},
}
