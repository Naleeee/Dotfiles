return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		-- NOTE: JavaScript/TypeScript linting is handled by Biome LSP and ESLint LSP
		-- They auto-detect their config files (biome.json, .eslintrc, etc.)
		-- Do NOT add biomejs/eslint_d here to avoid duplicate diagnostics
		lint.linters_by_ft = {
			-- c = { "clangd" },
			cmake = { "cmakelint" },
			-- cpp = { "clangd" },
			markdown = { "markdownlint" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>tl", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
