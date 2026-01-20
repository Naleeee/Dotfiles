return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown" },
	build = "cd app && npm install",
	init = function()
		vim.g.strip_whitespace_on_save = 1

		-- Browser settings - use system default browser
		vim.g.mkdp_browser = "" -- empty string = system default browser
		vim.g.mkdp_open_to_the_world = 0
		vim.g.mkdp_open_ip = ""
		vim.g.mkdp_port = ""

		vim.g.mkdp_auto_start = 0 -- don't auto-open browser when opening .md
		vim.g.mkdp_auto_close = 1 -- close browser tab when leaving .md
		vim.g.mkdp_refresh_slow = 0 -- refresh on every change (set to 1 for only on save)
		vim.g.mkdp_command_for_global = 0 -- only available in markdown files

		vim.g.mkdp_page_title = "${name} - Markdown Preview"
		vim.g.mkdp_filetypes = { "markdown" }

		-- Preview options
		vim.g.mkdp_preview_options = {
			mkit = {},
			katex = {},
			uml = {},
			maid = {},
			disable_sync_scroll = 0,
			sync_scroll_type = "middle",
			hide_yaml_meta = 1,
			sequence_diagrams = {},
			flowchart_diagrams = {},
			content_editable = false,
			disable_filename = 0,
			toc = {},
		}

		-- Keymap for preview toggle
		vim.keymap.set("n", "<C-p>", "<cmd>MarkdownPreview<cr>", { desc = "Open markdown preview in browser" })
	end,
}
