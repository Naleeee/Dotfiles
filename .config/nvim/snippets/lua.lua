local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local rep = require("luasnip.extras").rep

return {
	-- Lazy plugin setup
	s("lazyplugin", {
		t({ "return { ", "" }),
		t({ "\t" }),
		i(1, "fullPluginName"),
		t({ ",", "" }),
		t({ "\tconfig = function()", "" }),
		t({ "\t\tlocal " }),
		i(2, "pluginName"),
		t({ " = require(" }),
		rep(1),
		t({ ")", "" }),
		t({ "\t\t" }),
		rep(2),
		t({ ".setup({", "" }),
		t({ "\t\t\t" }),
		i(3),
		t({ "", "\t\t})", "" }),
		t({ "\tend", "" }),
		t({ "}" }),
	}, {
		description = "Lazy plugin setup with config function",
	}),

	-- Keymap setter snippet
	s("keymap", {
		c(1, {
			t(""),
			t({ "local keymap = vim.keymap", "", "" }),
		}),
		f(function(args)
			return args[1][1] ~= "" or "keymap"
		end, { 1 }),
		t('.set("'),
		i(2, "Mode"),
		t('", "'),
		i(3, "Keymap"),
		t('", "'),
		i(4, "Command"),
		t('", { desc = "'),
		i(5, "Description"),
		t('" })'),
	}, {
		description = "Create a keymap with optional local keymap declaration",
	}),
}
