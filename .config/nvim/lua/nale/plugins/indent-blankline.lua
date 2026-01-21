return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPre", "BufNewFile" },
	main = "ibl",
	config = function()
		-- Define highlight groups for scope
		local hooks = require("ibl.hooks")

		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, "IblIndent", { fg = "#3b3b4d" })
			vim.api.nvim_set_hl(0, "IblScope", { fg = "#7c87f2" })
		end)

		require("ibl").setup({
			indent = {
				char = "│",
				highlight = "IblIndent",
			},
			scope = {
				enabled = true,
				char = "│",
				highlight = "IblScope",
				show_start = false,
				show_end = false,
				include = {
					node_type = {
						["*"] = { "return_statement", "table_constructor" },
						lua = { "table_constructor" },
						typescript = { "object", "array", "jsx_element", "jsx_self_closing_element" },
						typescriptreact = { "object", "array", "jsx_element", "jsx_self_closing_element" },
						javascript = { "object", "array", "jsx_element", "jsx_self_closing_element" },
						vue = { "object", "array", "element" },
					},
				},
			},
		})
	end,
}
