local ls = require("luasnip")
local p = ls.parser.parse_snippet
-- local s = ls.snippet
-- local sn = ls.snippet_node
-- local t = ls.text_node
-- local i = ls.insert_node
-- local fmt = require("luasnip.extras.fmt").fmt

-- mappable snippets
local snippets = {
	sc = p({
		trig = "sc",
		name = "surronds with {|}",
		dscr = "surrounds selection with curly brackets",
	}, "${1:if (${2:cond})} {\n\t$TM_SELECTED_TEXT$3\n}"),
	sp = p({
		trig = "sp",
		name = "surronds with (|)",
		dscr = "surrounds selection with parenthesis",
	}, "$1($TM_SELECTED_TEXT$2)"),
	ss = p({
		trig = "ss",
		name = "surronds with [|]",
		dscr = "surrounds selection with square brackets",
	}, "$1[$TM_SELECTED_TEXT$2]"),
	sf = p({
		trig = "sf",
		name = "surrounds with callback function",
		dscr = "surrounds selection with a callback function",
	}, "${1:name}(($3) => {\n\t$TM_SELECTED_TEXT$4\n})"),
}

return snippets
