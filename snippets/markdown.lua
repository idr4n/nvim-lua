local ls = require("luasnip")
local p = ls.parser.parse_snippet
-- local c = ls.choice_node
-- local t = ls.text_node
-- local s = ls.snippet
-- local i = ls.insert_node
-- local f = ls.function_node
-- local fmt = require("luasnip.extras.fmt").fmt
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
M.snips.tt = p({
	trig = "tt",
	name = "Fish Shell prompt TODO",
	dscr = "TODO to be primpted by the fish shell",
}, "[${1:Project}] ${2:todo...}")

-- autosnippets
M.autosnips.tt = p({
	trig = ";tt",
	name = "Fish Shell prompt TODO",
	dscr = "TODO to be primpted by the fish shell",
}, "[${1:Project}] ${2:todo...}")

return getSnippetsList(M.snips), getSnippetsList(M.autosnips)
