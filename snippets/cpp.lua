local ls = require("luasnip")
local p = ls.parser.parse_snippet
local c = ls.choice_node
local t = ls.text_node
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local ms = ls.multi_snippet
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

M.snips.cc = ms(
  {
    { trig = "co" },
    { trig = "cs" },
    { trig = "cout" },
    common = {
      name = "cout << '|' << endl",
      dscr = { "Surrounds with cout and endl\n", "Choices are:", "- without std", "- with std" },
    },
  },
  fmt('{a}cout << "{b}{c}" << {a}endl;', {
    a = c(1, { t(""), t("std::") }),
    b = f(function(_, snip)
      return snip.env.SELECT_DEDENT
    end, {}),
    c = i(2),
  }, { repeat_duplicates = true })
)

M.snips.lt = p(
  {
    trig = "lt",
    name = "CPP starter template",
    dscr = "CPP starter template",
  },
  [[
#include <iostream>
#include <string>

using namespace std;

int main() {
  ${1:return 0;}
}
]]
)

-- autosnippets

M.autosnips.cc = ms(
  {
    { trig = ";co" },
    { trig = ";cs" },
    common = {
      name = "cout << '|' << endl",
      dscr = { "Surrounds with cout and endl\n", "Choices are:", "- without std", "- with std" },
    },
  },
  fmt('{a}cout << "{b}{c}" << {a}endl;', {
    a = c(1, { t(""), t("std::") }),
    b = f(function(_, snip)
      return snip.env.SELECT_DEDENT
    end, {}),
    c = i(2),
  }, { repeat_duplicates = true })
)

M.autosnips.lt = p(
  {
    trig = ";lt",
    name = "CPP starter template",
    dscr = "CPP starter template",
  },
  [[
#include <iostream>
#include <string>

using namespace std;

int main() {
  ${1:return 0;}
}
]]
)

return getSnippetsList(M.snips), getSnippetsList(M.autosnips)
