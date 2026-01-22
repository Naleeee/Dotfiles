-- Custom UI enhancements for LSP Info and Man pages
return {
	{
		"nale/ui-extras",
		name = "ui-extras",
		virtual = true,
		lazy = false,
		config = function()
			-- ══════════════════════════════════════════════════════════════════
			-- Custom LspInfo floating window
			-- ══════════════════════════════════════════════════════════════════
			local function create_float(content, title)
				local buf = vim.api.nvim_create_buf(false, true)
				vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)

				-- Calculate dimensions
				local width = 60
				local height = math.min(#content + 2, 30)

				-- Find max line width
				for _, line in ipairs(content) do
					if #line + 4 > width then
						width = #line + 4
					end
				end
				width = math.min(width, 80)

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

				-- Set buffer options
				vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
				vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
				vim.api.nvim_set_option_value("filetype", "lspinfo-custom", { buf = buf })

				-- Close on q or Escape
				vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf, silent = true })
				vim.keymap.set("n", "<Esc>", "<cmd>close<cr>", { buffer = buf, silent = true })

				-- Add syntax highlighting
				vim.api.nvim_set_option_value("winhl", "Normal:Normal,FloatBorder:FloatBorder", { win = win })

				return buf, win
			end

			local function show_lsp_info()
				local clients = vim.lsp.get_clients({ bufnr = 0 })
				local content = {}

				if #clients == 0 then
					table.insert(content, "")
					table.insert(content, "  󰅚  No LSP servers attached to this buffer")
					table.insert(content, "")
				else
					table.insert(content, "")
					for i, client in ipairs(clients) do
						local status_icon = client.initialized and "●" or "○"
						local status_color = client.initialized and "running" or "starting"

						table.insert(content, string.format("  %s  %s (%s)", status_icon, client.name, status_color))
						table.insert(content, "")

						-- Root directory
						if client.config.root_dir then
							local root = client.config.root_dir:gsub(vim.env.HOME, "~")
							table.insert(content, string.format("     Root: %s", root))
						end

						-- Filetypes
						if client.config.filetypes then
							local ft = table.concat(client.config.filetypes, ", ")
							if #ft > 45 then
								ft = ft:sub(1, 42) .. "..."
							end
							table.insert(content, string.format("     Filetypes: %s", ft))
						end

						-- Capabilities summary
						local caps = {}
						if client.server_capabilities.completionProvider then
							table.insert(caps, "completion")
						end
						if client.server_capabilities.hoverProvider then
							table.insert(caps, "hover")
						end
						if client.server_capabilities.definitionProvider then
							table.insert(caps, "definition")
						end
						if client.server_capabilities.referencesProvider then
							table.insert(caps, "references")
						end
						if client.server_capabilities.documentFormattingProvider then
							table.insert(caps, "format")
						end
						if #caps > 0 then
							table.insert(content, string.format("     Capabilities: %s", table.concat(caps, ", ")))
						end

						if i < #clients then
							table.insert(content, "")
							table.insert(
								content,
								"  ─────────────────────────────────────────"
							)
						end
						table.insert(content, "")
					end
				end

				-- Add footer
				table.insert(content, "  Press 'q' or <Esc> to close")
				table.insert(content, "")

				local buf = create_float(content, "  LSP Servers ")

				-- Add highlighting for the buffer
				vim.api.nvim_buf_call(buf, function()
					vim.fn.matchadd("DiagnosticOk", "●")
					vim.fn.matchadd("DiagnosticWarn", "○")
					vim.fn.matchadd("Comment", "running")
					vim.fn.matchadd("Comment", "starting")
					vim.fn.matchadd("Keyword", "Root:")
					vim.fn.matchadd("Keyword", "Filetypes:")
					vim.fn.matchadd("Keyword", "Capabilities:")
					vim.fn.matchadd("Comment", "Press 'q' or <Esc> to close")
				end)
			end

			-- Create the command
			vim.api.nvim_create_user_command(
				"LspInfoFloat",
				show_lsp_info,
				{ desc = "Show LSP info in floating win:dow" }
			)

			-- Keymap
			vim.keymap.set("n", "<leader>is", "<cmd>LspInfoFloat<cr>", { desc = "LSP info (floating)" })
		end,
	},
}
