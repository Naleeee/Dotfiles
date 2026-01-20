return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		-- Config file patterns for each tool
		local biome_configs = { "biome.json", "biome.jsonc" }
		local eslint_configs =
			{ ".eslintrc", ".eslintrc.json", ".eslintrc.js", ".eslintrc.cjs", "eslint.config.js", "eslint.config.mjs" }
		local prettier_configs = {
			".prettierrc",
			".prettierrc.json",
			".prettierrc.js",
			".prettierrc.cjs",
			"prettier.config.js",
			"prettier.config.cjs",
		}

		-- Helper: check if config files exist in project
		local function has_config(patterns)
			return function(self, ctx)
				return vim.fs.find(patterns, { path = ctx.filename, upward = true })[1] ~= nil
			end
		end

		local has_biome = has_config(biome_configs)
		local has_eslint = has_config(eslint_configs)
		local has_prettier = has_config(prettier_configs)

		-- Custom biome-check: applies safe lint fixes + formatting (no unsafe fixes)
		conform.formatters["biome-check"] = {
			meta = {
				url = "https://biomejs.dev",
				description = "Biome safe fixes + formatting",
			},
			command = "biome",
			args = { "check", "--write", "--stdin-file-path", "$FILENAME" },
			stdin = true,
			condition = has_biome,
		}

		-- Web languages: biome-check OR (eslint_d + prettier) OR prettier fallback
		-- Order matters: first available wins due to stop_after_first
		local web_formatters = { "biome-check", "eslint_d", "prettier" }

		conform.setup({
			formatters_by_ft = {
				-- C/C++ always use clang-format
				c = { "clang-format" },
				cpp = { "clang-format" },

				-- Lua always uses stylua
				lua = { "stylua" },

				-- Markdown uses markdownlint
				markdown = { "markdownlint" },

				-- Web languages: biome-check → eslint_d + prettier → prettier
				css = { "biome-check", "prettier" }, -- eslint doesn't handle CSS
				graphql = { "biome-check", "prettier" },
				html = { "prettier" }, -- biome doesn't format HTML
				javascript = web_formatters,
				javascriptreact = web_formatters,
				json = { "biome-check", "prettier" },
				typescript = web_formatters,
				typescriptreact = web_formatters,
				vue = web_formatters,
				yaml = { "prettier" }, -- biome doesn't support yaml
			},

			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 2000,
			},

			-- Formatter configurations
			formatters = {
				eslint_d = {
					condition = function(self, ctx)
						return has_eslint(self, ctx) and not has_biome(self, ctx)
					end,
				},
				prettier = {
					condition = function(self, ctx)
						if has_biome(self, ctx) then
							return false
						end
						return has_prettier(self, ctx) or has_eslint(self, ctx) or true -- fallback
					end,
				},
				markdownlint = {
					-- Disable same rules as in linting.lua
					prepend_args = { "--disable", "MD013", "MD033", "MD041", "--" },
				},
			},
		})

		-- Keymap to format file or selection
		vim.keymap.set({ "n", "v" }, "<leader>tf", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 2000,
			})
		end, { desc = "Format file or range (in visual mode)" })

		-- Keymap to show active formatters for current buffer
		vim.keymap.set("n", "<leader>ti", function()
			local formatters = conform.list_formatters_for_buffer()
			if #formatters > 0 then
				local names = {}
				for _, f in ipairs(formatters) do
					table.insert(names, f.name or f)
				end
				vim.notify("Formatters: " .. table.concat(names, ", "), vim.log.levels.INFO)
			else
				vim.notify("No formatters configured for this filetype", vim.log.levels.WARN)
			end
		end, { desc = "Show active formatters for buffer" })

		-- Keymap to show active linters for current buffer
		vim.keymap.set("n", "<leader>tI", function()
			local clients = vim.lsp.get_clients({ bufnr = 0 })
			local linters = {}
			for _, client in ipairs(clients) do
				if client.name == "biome" or client.name == "eslint" then
					table.insert(linters, client.name)
				end
			end
			if #linters > 0 then
				vim.notify("Linters (LSP): " .. table.concat(linters, ", "), vim.log.levels.INFO)
			else
				vim.notify("No JS/TS linters active for this buffer", vim.log.levels.WARN)
			end
		end, { desc = "Show active linters for buffer" })
	end,
}
