local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local rep = require("luasnip.extras").rep

return {
	s({
		trig = "log",
		name = "Console log print",
		dscr = "Insert a basic console.log() print",
	}, {
		t("console.log('"),
		i(1, "message"),
		t("');"),
	}),
	s({
		trig = "logvar",
		name = "Console log print",
		dscr = "Insert a basic console.log() print",
	}, {
		t("console.log('"),
		i(1, "message"),
		t(": ', "),
		rep(1),
		t(");"),
	}),
}, {}
