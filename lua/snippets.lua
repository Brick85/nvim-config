local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node

local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")

ls.cleanup()

ls.add_snippets("python", {
	-- ls.add_snippets("all", {
	s("pprint(", {
		t({ "from pprint import pprint; pprint(" }),
		i(1, "data"),
		t(")  # fmt: skip", ""),
	}),
})
ls.add_snippets("htmldjango", {
	-- ls.add_snippets("all", {
	s("{% for", {
		t({ "{% for " }),
		i(1, "item"),
		t(" in "),
		i(2, "items"),
		t(" %}"),
		i(0),
		t({ "{% endfor %}" }),
	}),
	s("{% endfor %}", {
		t("{% endfor %}"),
	}),
	s("{% if", {
		t({ "{% if " }),
		i(1, "condition"),
		t(" %}"),
		i(0),
		t({ "{% endif %}" }),
	}),
	s("{% endif %}", {
		t("{% endif %}"),
	}),
	s("{% block", {
		t({ "{% block " }),
		i(1),
		t(" %}"),
		i(0),
		t({ "{% endblock " }),
		rep(1),
		t(" %}"),
	}),
	s("{% endblock %}", {
		t("{% endblock %}"),
	}),
	s("{% extends", {
		t({ "{% extends " }),
		i(1),
		t(" %}"),
	}),
})
