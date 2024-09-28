return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	config = function()
		local bufferline = require("bufferline")

		bufferline.setup({
			options = {
				mode = "buffers",
				separator_style = "thin",
				-- diagnostics = "nvim_lsp",
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						text_align = "center",
						separator = true,
					},
				},
				show_buffer_close_icons = false,
				show_close_icon = false,
				always_show_bufferline = true,
				sort_by = "insert_at_end",
			},
		})

		-- set keymaps
		local keymap = vim.keymap

		keymap.set("n", "<leader>j", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Go to previous buffer" })
		keymap.set("n", "<leader>k", "<Cmd>BufferLineCycleNext<CR>", { desc = "Go to next buffer" })
	end,
}
