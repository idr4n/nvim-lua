local ls = require("luasnip")
local p = ls.parser.parse_snippet
local c = ls.choice_node
local t = ls.text_node
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
-- local sn = ls.snippet_node

local M = { snips = {}, autosnips = {} }

-- helper function to get list of snippets
local getSnippetsList = function(tbl)
	local snipList = {}
	for _, v in pairs(tbl) do
		table.insert(snipList, v)
	end
	return snipList
end

-- snippets
M.snips.ie = p({
	trig = "ie",
	name = "if err != nil",
	dscr = "Snippet for if err != nil",
}, "if err != nil {\n\t${1}\n}")

M.snips.ea = p({
	trig = "ea",
	name = "_, err := ...",
	dscr = "Var assignment with error _, err :=",
}, "${1:_}, err := $2")

M.snips.fp = s(
	{
		trig = "fp",
		name = "fmt.<choice>(|)",
		dscr = { "Surrounds with fmt.<choice>(|)\n", "Choices are:", "- 'Println'", "- 'Printf'" },
	},
	fmt("fmt.{}({}{})", {
		c(1, { t("Println"), t("Printf") }),
		f(function(_, snip)
			return snip.env.SELECT_DEDENT
		end, {}),
		i(2),
	})
)

-- autosnippets
M.autosnips.ie = p(";ie", "if err != nil {\n\t${1}\n}")
M.autosnips.ea = p(";ea", "${1:_}, err := $2")
M.autosnips.fp = s(
	";fp",
	fmt("fmt.{}({}{})", {
		c(1, { t("Println"), t("Printf") }),
		f(function(_, snip)
			return snip.env.SELECT_DEDENT
		end, {}),
		i(2),
	})
)

return getSnippetsList(M.snips), getSnippetsList(M.autosnips)
