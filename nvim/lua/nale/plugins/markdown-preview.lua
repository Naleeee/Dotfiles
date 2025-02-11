return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown" },
	build = "cd app && npm install",
	init = function()
		vim.g.strip_whitespace_on_save = 1

		vim.g.mkdp_auto_start = 0 -- go to browser when opening a .md

		vim.g.mkdp_auto_close = 1 -- close browser when leaving a .md

		vim.g.mkdp_refresh_slow = 1 -- refreshes automatically the browser window

		vim.g.mkdp_page_title = "「${name}」-- Vim Markdown" -- give a name to window

		vim.g.mkdp_filetypes = { "markdown", "md" }
		-- set keymaps
		local keymap = vim.keymap

		keymap.set("n", "<C-p>", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Open file in browser preview" })
	end,
}
