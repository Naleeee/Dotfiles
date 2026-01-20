local ls = require("luasnip")
local s = ls.snippet
local partial = require("luasnip.extras").partial
local t = ls.text_node

return {
	s({
		trig = "dmy",
		name = "Current date",
		dscr = "Insert the current date (d-m-y)",
	}, {
		partial(os.date, "%d-%m-%Y"),
	}),
	s({
		trig = "lorem",
		name = "Lorem Ipsum",
		dscr = "Insert Lorem Ipsum t",
	}, {
		t(
			"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
		),
	}),
}, {}
