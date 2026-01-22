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

		-- Keymap to format file (LSP group)
		vim.keymap.set("n", "<leader>mf", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 2000,
			})
		end, { desc = "Format buffer" })

		-- Helper: create floating window
		local function create_float(content, title)
			local buf = vim.api.nvim_create_buf(false, true)
			vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)

			local width = 50
			local height = math.min(#content + 2, 20)

			for _, line in ipairs(content) do
				if #line + 4 > width then
					width = #line + 4
				end
			end
			width = math.min(width, 70)

			local win_opts = {
				relative = "editor",
				width = width,
				height = height,
				col = math.floor((vim.o.columns - width) / 2),
				row = math.floor((vim.o.lines - height) / 2),
				style = "minimal",
				border = "rounded",
				title = title,
				title_pos = "center",
			}

			local win = vim.api.nvim_open_win(buf, true, win_opts)

			vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
			vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })

			vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf, silent = true })
			vim.keymap.set("n", "<Esc>", "<cmd>close<cr>", { buffer = buf, silent = true })

			return buf
		end

		-- Keymap to show active formatters for current buffer (floating window)
		vim.keymap.set("n", "<leader>if", function()
			local formatters = conform.list_formatters_for_buffer()
			local content = {}

			table.insert(content, "")
			if #formatters > 0 then
				for _, f in ipairs(formatters) do
					local name = f.name or f
					local available = f.available ~= false
					local icon = available and "●" or "○"
					local status = available and "available" or "not found"
					table.insert(content, string.format("  %s  %s (%s)", icon, name, status))
				end
			else
				table.insert(content, "  󰅚  No formatters configured for this filetype")
			end
			table.insert(content, "")
			table.insert(content, "  Press 'q' or <Esc> to close")
			table.insert(content, "")

			local buf = create_float(content, "  Formatters ")

			vim.api.nvim_buf_call(buf, function()
				vim.fn.matchadd("DiagnosticOk", "●")
				vim.fn.matchadd("DiagnosticError", "○")
				vim.fn.matchadd("Comment", "available")
				vim.fn.matchadd("Comment", "not found")
				vim.fn.matchadd("Comment", "Press 'q' or <Esc> to close")
			end)
		end, { desc = "Show formatters (floating)" })

		-- Keymap to show active linters for current buffer (floating window)
		vim.keymap.set("n", "<leader>il", function()
			local clients = vim.lsp.get_clients({ bufnr = 0 })
			local content = {}
			local linters = {}

			for _, client in ipairs(clients) do
				if client.name == "biome" or client.name == "eslint" then
					table.insert(linters, client)
				end
			end

			table.insert(content, "")
			if #linters > 0 then
				for _, client in ipairs(linters) do
					local icon = client.initialized and "●" or "○"
					local status = client.initialized and "running" or "starting"
					table.insert(content, string.format("  %s  %s (%s)", icon, client.name, status))
				end
			else
				table.insert(content, "  󰅚  No JS/TS linters active for this buffer")
			end
			table.insert(content, "")
			table.insert(content, "  Press 'q' or <Esc> to close")
			table.insert(content, "")

			local buf = create_float(content, "  Linters ")

			vim.api.nvim_buf_call(buf, function()
				vim.fn.matchadd("DiagnosticOk", "●")
				vim.fn.matchadd("DiagnosticWarn", "○")
				vim.fn.matchadd("Comment", "running")
				vim.fn.matchadd("Comment", "starting")
				vim.fn.matchadd("Comment", "Press 'q' or <Esc> to close")
			end)
		end, { desc = "Show linters (floating)" })
	end,
}
