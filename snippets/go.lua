local ls = require("luasnip")
local p = ls.parser.parse_snippet
-- local s = ls.snippet
-- local sn = ls.snippet_node
-- local t = ls.text_node
-- local i = ls.insert_node
-- local fmt = require("luasnip.extras.fmt").fmt

local M = { snips = {}, autosnips = {} }

-- helper function to get list of snippets from M.all.<lang>
local getSnippetsList = function(t)
	local snipList = {}
	for _, v in pairs(t) do
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

M.snips.fp = p({
	trig = "fp",
	name = "fmt.Println(|)",
	dscr = "Surrounds with fmt.Println(|)",
}, "fmt.Println($TM_SELECTED_TEXT$1)")

-- autosnippets
M.autosnips.ie = p(";ie", "if err != nil {\n\t${1}\n}")
M.autosnips.ea = p(";ea", "${1:_}, err := $2")

return getSnippetsList(M.snips), getSnippetsList(M.autosnips)
