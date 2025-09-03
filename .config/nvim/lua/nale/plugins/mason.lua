return {
	{
		"mason-org/mason.nvim",
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
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			ensure_installed = {
				"bashls",
				-- "clangd",
				-- "cmake",
				"cssls",
				"eslint",
				-- "graphql",
				"html",
				"lua_ls",
				"ts_ls",
				"vimls",
				"vue_ls",
				"vtsls",
			},
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = "mason-org/mason.nvim",
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- "clang-format",
					"stylua",
					"prettier",
					"prettierd",
				},
				run_on_start = true,
				auto_update = true,
			})
		end,
	},
}
