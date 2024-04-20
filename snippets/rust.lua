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

M.snips.pl = s(
  {
    trig = "p",
    name = "println!('|')",
    dscr = { "Surrounds with println!(<choice>)\n", "Choices are:", "- ('')", "- ('$1{}, $2')", "- ()" },
  },
  fmt("println!({}{}{})", {
    c(1, { { t('"'), i(1), t('"') }, i(1), { t('"'), i(1), t(' {}", ') } }),
    f(function(_, snip)
      return snip.env.SELECT_DEDENT
    end, {}),
    i(2),
  })
)

-- autosnippets

M.autosnips.pl = s(
  {
    trig = ";p",
    name = "Autosnippet - println!('|')",
    dscr = { "Surrounds with println!(<choice>)\n", "Choices are:", "- ('')", "- ('$1{}, $2')", "- ()" },
  },
  fmt("println!({}{}{});", {
    c(1, { { t('"'), i(1), t('"') }, i(1), { t('"'), i(1), t(' {}", ') } }),
    f(function(_, snip)
      return snip.env.SELECT_DEDENT
    end, {}),
    i(2),
  })
)

return getSnippetsList(M.snips), getSnippetsList(M.autosnips)
