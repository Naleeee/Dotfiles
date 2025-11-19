return {
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			-- list of servers for mason to install
			ensure_installed = {
				"bashls",
				"cssls",
				"eslint",
				"html",
				"lua_ls",
				"ts_ls",
				"tailwindcss",
				"vimls",
				"vue_ls",
				"vts_ls",
			},
		},
		dependencies = {
			{
				"williamboman/mason.nvim",
				opts = {
					ui = {
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
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
			},
		},
		dependencies = {
			"williamboman/mason.nvim",
		},
	},
}
