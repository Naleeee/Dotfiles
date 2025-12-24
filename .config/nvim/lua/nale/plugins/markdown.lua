return {
	-- Markdown manager
	"ixru/nvim-markdown",
	-- Better table in Markdown
	"dhruvasagar/vim-table-mode",
	-- Table of content creator in Markdown
	"mzlogin/vim-markdown-toc",
	-- Beautiful in-editor markdown rendering
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		ft = { "markdown" },
		opts = {
			-- Render in normal mode, clear in insert mode for editing
			render_modes = { "n", "c" },

			-- Headings with modern icons and distinctive styling
			heading = {
				enabled = true,
				sign = true,
				icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
				-- Width of heading background
				width = "full",
				-- Highlight groups for each heading level (uses Catppuccin colors)
				backgrounds = {
					"RenderMarkdownH1Bg",
					"RenderMarkdownH2Bg",
					"RenderMarkdownH3Bg",
					"RenderMarkdownH4Bg",
					"RenderMarkdownH5Bg",
					"RenderMarkdownH6Bg",
				},
				foregrounds = {
					"RenderMarkdownH1",
					"RenderMarkdownH2",
					"RenderMarkdownH3",
					"RenderMarkdownH4",
					"RenderMarkdownH5",
					"RenderMarkdownH6",
				},
			},

			-- Code blocks with language icon
			code = {
				enabled = true,
				sign = true,
				style = "full", -- full background
				position = "left",
				language_pad = 1,
				width = "full",
				left_pad = 2,
				right_pad = 2,
				border = "thin",
				above = "▄",
				below = "▀",
				highlight = "RenderMarkdownCode",
				highlight_inline = "RenderMarkdownCodeInline",
			},

			-- Bullet points with nice icons
			bullet = {
				enabled = true,
				icons = { "●", "○", "◆", "◇" },
				highlight = "RenderMarkdownBullet",
			},

			-- Checkboxes with distinctive icons
			checkbox = {
				enabled = true,
				unchecked = {
					icon = "󰄱 ",
					highlight = "RenderMarkdownUnchecked",
				},
				checked = {
					icon = "󰱒 ",
					highlight = "RenderMarkdownChecked",
				},
				custom = {
					todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo" },
				},
			},

			-- Quotes with nice styling
			quote = {
				enabled = true,
				icon = "▋",
				highlight = "RenderMarkdownQuote",
			},

			-- Tables with clean borders
			pipe_table = {
				enabled = true,
				preset = "round", -- round corners (uses ╭╮╰╯)
				style = "full",
				cell = "padded",
			},

			-- Links with icons
			link = {
				enabled = true,
				image = "󰥶 ",
				hyperlink = "󰌹 ",
				highlight = "RenderMarkdownLink",
			},

			-- Horizontal rule
			dash = {
				enabled = true,
				icon = "─",
				width = "full",
				highlight = "RenderMarkdownDash",
			},

			-- Callouts/alerts (GitHub style)
			callout = {
				note = { raw = "[!NOTE]", rendered = "󰋽 Note", highlight = "RenderMarkdownInfo" },
				tip = { raw = "[!TIP]", rendered = "󰌶 Tip", highlight = "RenderMarkdownSuccess" },
				important = { raw = "[!IMPORTANT]", rendered = "󰅾 Important", highlight = "RenderMarkdownHint" },
				warning = { raw = "[!WARNING]", rendered = "󰀪 Warning", highlight = "RenderMarkdownWarn" },
				caution = { raw = "[!CAUTION]", rendered = "󰳦 Caution", highlight = "RenderMarkdownError" },
			},

			-- Sign column indicators
			sign = {
				enabled = true,
				highlight = "RenderMarkdownSign",
			},

			-- Window options for better rendering
			win_options = {
				conceallevel = {
					default = vim.api.nvim_get_option_value("conceallevel", {}),
					rendered = 3,
				},
				concealcursor = {
					default = vim.api.nvim_get_option_value("concealcursor", {}),
					rendered = "",
				},
			},
		},
		config = function(_, opts)
			require("render-markdown").setup(opts)

			-- Custom highlight groups for a modern look (compatible with Catppuccin)
			local colors = {
				h1 = "#f38ba8", -- red/pink
				h2 = "#fab387", -- peach
				h3 = "#f9e2af", -- yellow
				h4 = "#a6e3a1", -- green
				h5 = "#89dceb", -- sky
				h6 = "#cba6f7", -- mauve
			}

			-- Set highlight groups
			vim.api.nvim_set_hl(0, "RenderMarkdownH1", { fg = colors.h1, bold = true })
			vim.api.nvim_set_hl(0, "RenderMarkdownH2", { fg = colors.h2, bold = true })
			vim.api.nvim_set_hl(0, "RenderMarkdownH3", { fg = colors.h3, bold = true })
			vim.api.nvim_set_hl(0, "RenderMarkdownH4", { fg = colors.h4, bold = true })
			vim.api.nvim_set_hl(0, "RenderMarkdownH5", { fg = colors.h5, bold = true })
			vim.api.nvim_set_hl(0, "RenderMarkdownH6", { fg = colors.h6, bold = true })

			vim.api.nvim_set_hl(0, "RenderMarkdownH1Bg", { bg = "#2a2034" })
			vim.api.nvim_set_hl(0, "RenderMarkdownH2Bg", { bg = "#2a2530" })
			vim.api.nvim_set_hl(0, "RenderMarkdownH3Bg", { bg = "#2a2830" })
			vim.api.nvim_set_hl(0, "RenderMarkdownH4Bg", { bg = "#1e2a24" })
			vim.api.nvim_set_hl(0, "RenderMarkdownH5Bg", { bg = "#1e2a2e" })
			vim.api.nvim_set_hl(0, "RenderMarkdownH6Bg", { bg = "#252035" })

			vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = "#1e1e2e" })
			vim.api.nvim_set_hl(0, "RenderMarkdownCodeInline", { bg = "#313244", fg = "#f5c2e7" })
			vim.api.nvim_set_hl(0, "RenderMarkdownBullet", { fg = "#89b4fa" })
			vim.api.nvim_set_hl(0, "RenderMarkdownQuote", { fg = "#6c7086", italic = true })
			vim.api.nvim_set_hl(0, "RenderMarkdownDash", { fg = "#45475a" })
			vim.api.nvim_set_hl(0, "RenderMarkdownLink", { fg = "#89b4fa", underline = true })
			vim.api.nvim_set_hl(0, "RenderMarkdownChecked", { fg = "#a6e3a1" })
			vim.api.nvim_set_hl(0, "RenderMarkdownUnchecked", { fg = "#6c7086" })
			vim.api.nvim_set_hl(0, "RenderMarkdownTodo", { fg = "#f9e2af" })
			vim.api.nvim_set_hl(0, "RenderMarkdownTableHead", { fg = "#cba6f7", bold = true })
			vim.api.nvim_set_hl(0, "RenderMarkdownTableRow", { fg = "#cdd6f4" })
			vim.api.nvim_set_hl(0, "RenderMarkdownTableFill", { fg = "#45475a" })

			-- Callout highlights
			vim.api.nvim_set_hl(0, "RenderMarkdownInfo", { fg = "#89b4fa" })
			vim.api.nvim_set_hl(0, "RenderMarkdownSuccess", { fg = "#a6e3a1" })
			vim.api.nvim_set_hl(0, "RenderMarkdownHint", { fg = "#cba6f7" })
			vim.api.nvim_set_hl(0, "RenderMarkdownWarn", { fg = "#f9e2af" })
			vim.api.nvim_set_hl(0, "RenderMarkdownError", { fg = "#f38ba8" })

			-- Toggle keymap
			vim.keymap.set("n", "<leader>tm", "<cmd>RenderMarkdown toggle<cr>", { desc = "Toggle markdown rendering" })
		end,
	},
}
