return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

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

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"bashls",
				"clangd",
				"cmake",
				"cssls",
				"eslint",
				"graphql",
				"html",
				"lua_ls",
				"tsserver",
				"vimls",
				"volar",
			},
			automatic_installation = true,
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"clang-format", -- c/cpp formatter
				"cmakelint", -- cmake linter
				"eslint_d", -- javascript linter
				"markdownlint", -- markdown formatter
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
			},
		})
	end,
}
