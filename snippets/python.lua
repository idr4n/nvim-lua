local ls = require("luasnip")
local p = ls.parser.parse_snippet
-- local s = ls.snippet
-- local sn = ls.snippet_node
-- local t = ls.text_node
-- local i = ls.insert_node
-- local fmt = require("luasnip.extras.fmt").fmt

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
M.snips.pr = p({
  trig = "pr",
  name = "print(|)",
  dscr = "surrounds with print function",
}, "print($TM_SELECTED_TEXT$1)")

-- autosnippets
M.autosnips.pr = p({
  trig = ";pr",
  name = "Autosnippet - print(|)",
  dscr = "surrounds with print function",
}, "print($TM_SELECTED_TEXT$1)")

return getSnippetsList(M.snips), getSnippetsList(M.autosnips)
