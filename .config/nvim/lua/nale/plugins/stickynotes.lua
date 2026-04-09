return {
	"Sou1lah/Sticky-Notes-for-Nvim-",
	event = "VeryLazy",
	config = function()
		vim.g.sticky_notes_lazy_loaded = true
		require("sticky-notes").setup({
			keymaps = true,
		})
	end,
	keys = {
		{ "<leader>sn", "<cmd>StickyNote<cr>", desc = "Open Sticky Note" },
		{ "<leader>sb", "<cmd>StickyNotePicker<cr>", desc = "Browse Sticky Notes" },
	},
}
