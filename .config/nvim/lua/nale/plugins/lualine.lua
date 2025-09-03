return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		local colors = {
			yellow = "#CDA715",
			orange = "#DC7B6A",
			pink = "#D19F9D",
			green = "#00C6C4",
			blue = "#7C87F2",
			fg = "#4A4A5C",
			sub_fg = "#A9A8CC",
			bg = "#40394F",
			sub_bg = "#665771",
		}

		local theme = {
			normal = {
				a = { fg = colors.fg, bg = colors.pink, gui = "bold" },
				b = { fg = colors.sub_fg, bg = colors.sub_bg },
				c = { fg = colors.sub_fg, bg = colors.bg },
				x = { fg = colors.sub_fg, bg = colors.bg },
				y = { fg = colors.sub_fg, bg = colors.sub_bg },
				z = { fg = colors.fg, bg = colors.pink },
			},

			insert = { a = { fg = colors.fg, bg = colors.orange, gui = "bold" } },
			visual = { a = { fg = colors.fg, bg = colors.green, gui = "bold" } },
			command = { a = { fg = colors.fg, bg = colors.yellow, gui = "bold" } },
			replace = { a = { fg = colors.fg, bg = colors.blue, gui = "bold" } },

			inactive = {
				a = { fg = colors.sub_fg, bg = colors.bg },
				b = { fg = colors.sub_fg, bg = colors.bg },
				c = { fg = colors.sub_fg, bg = colors.bg },
			},
		}

		lualine.setup({
			options = {
				theme = theme,
				icons_enabled = true,
				component_separators = "",
				section_separators = "",
				disabled_filetypes = {
					"alpha",
					"lazy",
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = false,
				refresh = {
					statusline = 1000,
				},
			},
			sections = {
				lualine_a = { {
					"mode",
					separator = { right = "" },
				} },

				lualine_b = {
					{
						"filename",
						file_status = true, -- Displays file status (readonly status, modified status)
						newfile_status = false, -- Display new file status (new file means no write after created)
						path = 0, -- 0: Just the filename / 1: Relative path / 2: Absolute path / 3: Absolute path, with tilde as the home directory / 4: Filename and parent dir, with tilde as the home directory

						shorting_target = 40, -- Shortens path to leave 40 spaces in the window for other components.
						symbols = {
							modified = "[+]", -- Text to show when the file is modified.
							readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
							unnamed = "[No Name]", -- Text to show for unnamed buffers.
							newfile = "[New]", -- Text to show for newly created file before first write
						},
						separator = { left = "", right = "" },
					},
				},

				lualine_c = {
					"branch",
					"diff",
				},

				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = colors.sub_fg },
					},
					{
						"diagnostics",
						sources = { "nvim_lsp" },
						sections = { "error", "warn", "info", "hint" },

						diagnostics_color = {
							error = { bg = colors.main_grey, fg = colors.red }, -- Changes diagnostics' error color.
							warn = { bg = colors.main_grey, fg = colors.orange }, -- Changes diagnostics' warn color.
							info = { bg = colors.main_grey, fg = colors.cyan }, -- Changes diagnostics' info color.
							hint = { bg = colors.main_grey, fg = colors.green }, -- Changes diagnostics' hint color.
						},
						symbols = { error = " ", warn = " ", info = " ", hint = " " },
						colored = true, -- Displays diagnostics status in color if set to true.
						update_in_insert = false, -- Update diagnostics in insert mode.
						always_visible = false, -- Show diagnostics even if there are none.
					},
				},

				lualine_y = {
					{
						"progress",
						separator = { left = "" },
					},
					{
						"searchcount",
					},
				},

				lualine_z = {
					{
						"filetype",
						"fileformat",
						colored = false, -- Displays filetype icon without colors
						separator = { left = "" },
					},
				},
			},
		})
	end,
}
