return {
	"norcalli/nvim-colorizer.lua",
	config = function()
		require("colorizer").setup({
			"*",
		}, {
			RGB = true, -- highlight rgb() colors
			RRGGBB = true, -- highlight #RRGGBB hex colors
			names = false, -- disable color name highlighting (like "red")
			css = true, -- enable css features like hsl()
			css_fn = true, -- enable css functions like rgba()
		})
	end,
}
