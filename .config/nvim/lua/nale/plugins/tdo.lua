return {
	{
		"2kabhishek/pickme.nvim",
		cmd = "PickMe",
		dependencies = { "nvim-telescope/telescope.nvim" },
		opts = {
			picker_provider = "telescope",
			add_default_keybindings = false, -- avoid conflicts with existing telescope keymaps
		},
	},
	{
		"2kabhishek/tdo.nvim",
		dependencies = { "2kabhishek/pickme.nvim" },
		cmd = { "Tdo" },
		keys = { "<leader>nn", "<leader>ne", "<leader>nf", "<leader>ng", "<leader>nh", "<leader>nl", "<leader>nc", "<leader>nt", "<leader>nx" },
		opts = {
			add_default_keybindings = true,
		},
	},
}
