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
M.snips.pr = p({
	trig = "pr",
	name = "print(|)",
	dscr = "surrounds with print function",
}, "print($TM_SELECTED_TEXT$1)")

-- autosnippets
M.autosnips.pr = p(";pr", "print($TM_SELECTED_TEXT$1)")

return getSnippetsList(M.snips), getSnippetsList(M.autosnips)
