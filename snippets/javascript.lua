local ls = require("luasnip")
local p = ls.parser.parse_snippet
local s = ls.snippet
local c = ls.choice_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

local M = { snips = {}, autosnips = {} }

-- helper function to get list of snippets
local getSnippetsList = function(tbl)
	local snipList = {}
	for _, v in pairs(tbl) do
		table.insert(snipList, v)
	end
	return snipList
end

M.snips.cl = s(
	{
		trig = "cl",
		name = "console.<choice>(|)",
		dscr = { "Surrounds with console.<choice>(|)\n", "Choices are:", "- 'log'", "- 'table'" },
	},
	fmt("console.{}({}{})", {
		c(1, { t("log"), t("table") }),
		f(function(_, snip)
			return snip.env.SELECT_DEDENT
		end, {}),
		i(2),
	})
)

M.snips.af = p({
	trig = "af",
	name = "surrounds with arrow function",
	dscr = "surrounds selection with an arrow function",
}, "const ${1:name} = ($2) => {\n\t$TM_SELECTED_TEXT$3\n})")

M.snips.aa = p({
	trig = "aa",
	name = "=> {|}",
	dscr = "adds an arrow function",
}, " => {$1}")

-- autosnippets
M.autosnips.cl = s(
	{
		trig = ";cl",
		name = "console.<choice>(|)",
		dscr = { "Surrounds with console.<choice>(|)\n", "Choices are:", "- 'log'", "- 'table'" },
	},
	fmt("console.{}({}{})", {
		c(1, { t("log"), t("table") }),
		f(function(_, snip)
			return snip.env.SELECT_DEDENT
		end, {}),
		i(2),
	})
)

M.autosnips.af = p({
	trig = ";af",
	name = "surrounds with arrow function",
	dscr = "surrounds selection with an arrow function",
}, "const ${1:name} = ($2) => {\n\t$TM_SELECTED_TEXT$3\n})")

M.autosnips.aa = p({
	trig = ";aa",
	name = "=> {|}",
	dscr = "adds an arrow function",
}, " => {$1}")

return getSnippetsList(M.snips), getSnippetsList(M.autosnips)
