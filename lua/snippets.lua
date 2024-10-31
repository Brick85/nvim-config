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

-- ls.cleanup()
ls.add_snippets("python", {
	-- ls.add_snippets("all", {
	s(
		"pprint(data)",
		fmta(
			[[
from pprint import pprint; pprint(<data>)  # fmt: skip
<finish>]],
			{ data = i(1, "data"), finish = i(0) }
		)
	),
})

ls.add_snippets("htmldjango", {
	-- ls.add_snippets("all", {
	s(
		"{% for item in items %}",
		fmta(
			[[{% for <item> in <items> %}<finish>{% endfor %}]],
			{ item = i(1, "item"), items = i(2, "items"), finish = i(0) }
		)
	),
	s("{% endfor %}", {
		t("{% endfor %}"),
	}),
	s(
		"{% if condition %}",
		fmta([[{% if <condition> %}<finish>{% endif %}]], { condition = i(1, "condition"), finish = i(0) })
	),
	s("{% else %}", {
		t("{% else %}"),
	}),
	s("{% endif %}", {
		t("{% endif %}"),
	}),
	s(
		"{% block <name> %}",
		fmta(
			[[{% block <name> %}<finish>{% endblock <name_rep> %}]],
			{ name = i(1, "name"), name_rep = rep(1), finish = i(0) }
		)
	),
	s("{% endblock %}", {
		t("{% endblock %}"),
	}),
	s(
		"{% extends <template> %}",
		fmta([[{% extends <template> %}<finish>]], { template = i(1, "template"), finish = i(0) })
	),
	s(
		"{% include '<template>' %}",
		fmta([[{% include '<template>' %}<finish>]], { template = i(1, "template"), finish = i(0) })
	),
	s("{% load <library> %}", fmta([[{% load <library> %}<finish>]], { library = i(1, "library"), finish = i(0) })),
	s("{% url '<name>' %}", fmta([[{% url '<name>' %}<finish>]], { name = i(1, "name"), finish = i(0) })),
	s("{% static '<path>' %}", fmta([[{% static '<path>' %}<finish>]], { path = i(1, "path"), finish = i(0) })),
	s("{% blocktrans %}", fmta([[{% blocktrans %}<finish>{% endblocktrans %}]], { finish = i(0) })),
	s("{% trans '<text>' %}", fmta([[{% trans '<text>' %}<finish>]], { text = i(1, "text"), finish = i(0) })),
	s(
		"{% with <var> as <value> %}",
		fmta(
			[[{% with <var> as <value> %}<finish>{% endwith %}]],
			{ var = i(1, "var"), value = i(2, "value"), finish = i(0) }
		)
	),
})
