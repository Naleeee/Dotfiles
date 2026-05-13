return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown" },
	build = "cd app && npx --yes yarn install",
	config = function()
		vim.g.mkdp_auto_start = 0
		vim.g.mkdp_auto_close = 1
		vim.g.mkdp_theme = "dark"

		vim.keymap.set("n", "<C-p>", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Toggle markdown preview in browser" })
	end,
}
