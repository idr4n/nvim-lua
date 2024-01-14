local ls = require("luasnip")
local p = ls.parser.parse_snippet
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
-- local c = ls.choice_node
-- local t = ls.text_node
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
M.snips.sc = p({
  trig = "sc",
  name = "surrounds with {|}",
  dscr = "surrounds selection with curly brackets",
}, "${1:if (${2:cond})} {\n\t$TM_SELECTED_TEXT$3\n}")

M.snips.sp = p({
  trig = "sp",
  name = "surrounds with (|)",
  dscr = "surrounds selection with parenthesis",
}, "$1($TM_SELECTED_TEXT$2)")

M.snips.ss = p({
  trig = "ss",
  name = "surrounds with [|]",
  dscr = "surrounds selection with square brackets",
}, "$1[$TM_SELECTED_TEXT$2]")

M.snips.cm = s(
  {
    trig = "cm",
    name = "Comment folde marker",
    dscr = { "Surrounds with fold marker comment" },
  },
  fmt(
    [[
        {1}: {2} {{{{{{
        {3}{4}
        {1}: }}}}}}
    ]],
    {
      f(function()
        local cm = vim.opt_local.commentstring["_value"]
        local cmString = string.gmatch(cm, "[^ %%s]+")()

        if cmString then
          return cmString
        else
          return "#"
        end
      end, {}),
      i(1, "comment..."),
      f(function(_, snip)
        return snip.env.SELECT_DEDENT
      end, {}),
      i(2),
    }
  )
)

-- autosnippets
M.autosnips.sc = p({
  trig = ";sc",
  name = "Autosnippet - surrounds with {|}",
  dscr = "surrounds selection with curly brackets",
}, "${1:if (${2:cond})} {\n\t$TM_SELECTED_TEXT$3\n}")

M.autosnips.sp = p({
  trig = ";sp",
  name = "Autosnippet - surrounds with (|)",
  dscr = "surrounds selection with parenthesis",
}, "$1($TM_SELECTED_TEXT$2)")

M.autosnips.ss = p({
  trig = ";ss",
  name = "Autosnippet - surrounds with [|]",
  dscr = "surrounds selection with square brackets",
}, "$1[$TM_SELECTED_TEXT$2]")

return getSnippetsList(M.snips), getSnippetsList(M.autosnips)
