local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local sn = ls.snippet_node
local d = ls.dynamic_node

local function rec_prop()
	return sn(
		nil,
		c(1, {
			t(nil),
			sn(nil, {
				t({ "", "\t" }),
				i(1, "prop1"),
				c(2, {
					t("?"),
					t(""),
				}),
				t(": "),
				c(3, {
					i(1, "string"),
					i(2, "boolean"),
					i(3, "number"),
				}),
				t(";"),
				d(4, rec_prop, {}),
			}),
		})
	)
end

local function default_props(args)
	local result = {}
	local idx = 1
	for _, elem in ipairs(args[1]) do
		if string.len(elem) > 0 then
			local name, type = elem:sub(1, -2):match("(.*):(.*)")
			if name:sub(-1) == "?" then
				type = type:sub(2)
				table.insert(result, t(name))
				table.insert(result, t(": "))
				if type == "number" then
					table.insert(result, i(idx, "10"))
				elseif type == "boolean" then
					table.insert(
						result,
						c(idx, {
							i(1, "true"),
							i(2, "false"),
						})
					)
				else
					table.insert(result, t('"'))
					table.insert(result, i(idx, "string"))
					table.insert(result, t('"'))
				end
				idx = idx + 1
				table.insert(result, t({ ",", "" }))
			end
		end
	end
	return sn(nil, result)
end

local function rec_expose()
	return sn(
		nil,
		c(1, {
			i(nil, ""),
			sn(nil, {
				t({ "", "\t" }),
				i(1, "exposed"),
				t(","),
				d(2, rec_expose, {}),
			}),
		})
	)
end

ls.filetype_extend("vue", { "css", "html", "javascript", "typescript" })

return {
	s({
		trig = "ib",
		name = "Import composable",
		dscr = "Import a composable",
	}, {
		t({ "import { " }),
		i(1),
		t({ ' } from "@/composables/' }),
		f(function(args)
			return args[1]
		end, { 1 }),
		i(2),
		t('";'),
	}),
	s({
		trig = "id",
		name = "Import directive",
		dscr = "Import a directive",
	}, {
		t({ "import { " }),
		i(1),
		t({ ' } from "@/directives/' }),
		f(function(args)
			return args[1]
		end, { 1 }),
		i(2),
		t('";'),
	}),
	s({
		trig = "ic",
		name = "Import component",
		dscr = "Import a component",
	}, {
		t({ "import " }),
		i(1),
		t({ ' from "@/components/' }),
		f(function(args)
			return args[1]
		end, { 1 }),
		i(2),
		t('.vue";'),
	}),
	s({
		trig = "ip",
		name = "Import page",
		dscr = "Import a page",
	}, {
		t({ "import " }),
		i(1),
		t({ ' from "@/pages/' }),
		f(function(args)
			return args[1]
		end, { 1 }),
		i(2),
		t('.vue";'),
	}),
	s({
		trig = "iv",
		name = "Import view",
		dscr = "Import a view",
	}, {
		t({ "import " }),
		i(1),
		t({ ' from "@/views/' }),
		f(function(args)
			return args[1]
		end, { 1 }),
		i(2),
		t('.vue";'),
	}),
	s({
		trig = "is",
		name = "Import store",
		dscr = "Import a store",
	}, {
		t({ "import { " }),
		i(1),
		t({ ' } from "@/stores/' }),
		f(function(args)
			return args[1]
		end, { 1 }),
		i(2),
		t('";'),
	}),
	s({
		trig = "it",
		name = "Import type",
		dscr = "Import a type",
	}, {
		t({ "import { " }),
		i(1),
		t({ ' } from "@/types/' }),
		f(function(args)
			return args[1]
		end, { 1 }),
		i(2),
		t('";'),
	}),
	s({
		trig = "iu",
		name = "Import util",
		dscr = "Import a util",
	}, {
		t({ "import { " }),
		i(1),
		t({ ' } from "@/utils/' }),
		f(function(args)
			return args[1]
		end, { 1 }),
		i(2),
		t('";'),
	}),
	s({
		trig = "props",
		name = "props definition",
		dscr = "Define the props of a component",
	}, {
		c(1, {
			t("const props = "),
			i(1, ""),
		}),
		t("defineProps<{"),
		d(2, rec_prop, {}),
		t({ "", "}>();" }),
	}),
	s({
		trig = "propsd",
		name = "props definition with defaults",
		dscr = "Define the props of a component with default values",
	}, {
		c(1, {
			t("const props = "),
			i(nil, ""),
		}),
		t("withDefaults("),
		t("defineProps<{"),
		d(2, rec_prop, {}),
		t({ "", "}>(), {", "" }),
		d(3, default_props, { 2 }),
		t({ "});" }),
	}),
	s({
		trig = "model",
		name = "model definition",
		dscr = "Define a model of a component",
	}, {
		t("const "),
		i(1, "modelValue"),
		t(" = defineModel<"),
		c(2, {
			i(1, "string"),
			i(2, "boolean"),
			i(3, "number"),
		}),
		t(">("),
		c(3, {
			sn(nil, {
				t('"'),
				i(1, "custom"),
				t('"'),
			}),
			i(nil, ""),
		}),
		t(");"),
	}),
	s({
		trig = "emits",
		name = "emits definition",
		dscr = "Define the emits of a component",
	}, {
		c(1, {
			t("const emit = "),
		}),
		t("defineEmits<{"),
		i(1, "custom emits"),
		t({ "", "}>();" }),
	}),
	s({
		trig = "ref",
		name = "ref var",
		dscr = "Define a new ref var",
	}, {
		t("const "),
		i(1, "var"),
		t(" = ref("),
		i(2, "value"),
		t(");"),
	}),
	s({
		trig = "computed",
		name = "computed var",
		dscr = "Define a new computed var",
	}, {
		t("const "),
		i(1, "computedVar"),
		t(" = computed(() => {"),
		t({ "", "\treturn " }),
		i(2, "value"),
		t({ ";", "});" }),
	}),
	s({
		trig = "watch",
		name = "watcher",
		dscr = "Define a new watcher",
	}, {
		t("watch("),
		c(1, {
			i(1, "watchedValue"),
			sn(nil, {
				c(1, {
					i(nil, ""),
					i(1, "async "),
				}),
				t("() => "),
				i(2, "somethingToWatch"),
			}),
		}),
		t(", "),
		c(2, {
			i(nil, ""),
			i(1, "async "),
		}),
		t("("),
		i(4, "value"),
		t(", "),
		i(5, "prevValue"),
		t({ ") => {", "\t" }),
		i(3),
		t({ "", "});" }),
	}),
	s({
		trig = "slots",
		name = "slots definition",
		dscr = "Define the slots of a component",
	}, {
		t("defineSlots<{"),
		i(1),
		t({ "", "}>();" }),
	}),
	s({
		trig = "script",
		name = "Vue script tag",
		dscr = "Insert a script tag in a vue file",
	}, {
		t("<script"),
		c(1, {
			i(1, " setup"),
			t(""),
		}),
		c(2, {
			sn(nil, {
				t(' lang="'),
				c(1, {
					i(1, "ts"),
					i(2, "js"),
				}),
				t('"'),
			}),
			t(""),
		}),
		t({ ">", "" }),
		i(3),
		t({ "", "</script>" }),
	}),
	s({
		trig = "template",
		name = "Template tag",
		dscr = "Insert a template html tag",
	}, {
		t({ "<template>", "" }),
		i(1),
		t({ "", "</template>" }),
	}),
	s({
		trig = "style",
		name = "Style tag",
		dscr = "Insert a style css tag",
	}, {
		t("<style"),
		c(1, {
			i(1, " scoped"),
			t(""),
		}),
		c(2, {
			t(""),
			sn(nil, {
				i(1, ' lang="'),
				c(2, {
					i(1, "css"),
					i(2, "scss"),
				}),
				t('"'),
			}),
		}),
		t({ ">", "" }),
		i(3),
		t({ "", "</style>" }),
	}),

	s({
		trig = "v-for=",
		name = "v-for loop",
		dscr = "Insert a vue v-for",
	}, {
		t('v-for"'),
		i(1, "item"),
		t(" in "),
		i(2, "items"),
		t('"'),
		t(' :key="'),
		f(function(args)
			return args[1][1] .. "."
		end, { 1 }),
		i(3, "id"),
		t('"'),
	}),
}
