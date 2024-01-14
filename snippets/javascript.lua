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

M.snips.pp = p({
  trig = "pp",
  name = "console.log informative",
  dscr = "console.log with variable description",
}, 'console.log("$1: ", $1)')

M.snips.af = p({
  trig = "af",
  name = "surrounds with arrow function",
  dscr = "surrounds selection with an arrow function",
}, "const ${1:name} = ($2) => {\n\t$TM_SELECTED_TEXT$3\n}")

M.snips.aa = p({
  trig = "aa",
  name = "=> {|}",
  dscr = "adds an arrow function",
}, " => {$1}")

M.snips.ac = p({
  trig = "ac",
  name = "(|) => {}",
  dscr = "adds a callback function",
}, "($1) => {$2}")

M.snips.sc = p({
  trig = "sc",
  name = "surrounds with callback function",
  dscr = "surrounds selection with a callback function",
}, "${1:name}(($3) => {\n\t$TM_SELECTED_TEXT$4\n})")

M.snips.sf = p({
  trig = "sf",
  name = "surrounds with function",
  dscr = "surrounds selection with a function",
}, "function ${1:name}($3) {\n\t$TM_SELECTED_TEXT$4\n}")

M.snips.ds = p({
  trig = "ds",
  name = "Docstring",
  dscr = "creates a docstring comment block",
}, "/**\n * $1\n */")

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

M.autosnips.pp = p({
  trig = ";pp",
  name = "console.log informative",
  dscr = "console.log with variable description",
}, 'console.log("$1: ", $1)')

M.autosnips.af = p({
  trig = ";af",
  name = "surrounds with arrow function",
  dscr = "surrounds selection with an arrow function",
}, "const ${1:name} = ($2) => {\n\t$TM_SELECTED_TEXT$3\n}")

M.autosnips.aa = p({
  trig = ";aa",
  name = "=> {|}",
  dscr = "adds an arrow function",
}, " => {$1}")

M.autosnips.ac = p({
  trig = ";ac",
  name = "(|) => {}",
  dscr = "adds a callback function",
}, "($1) => {$2}")

M.autosnips.sc = p({
  trig = ";sc",
  name = "surrounds with callback function",
  dscr = "surrounds selection with a callback function",
}, "${1:name}(($3) => {\n\t$TM_SELECTED_TEXT$4\n})")

M.autosnips.sf = p({
  trig = ";sf",
  name = "surrounds with function",
  dscr = "surrounds selection with a function",
}, "function ${1:name}($3) {\n\t$TM_SELECTED_TEXT$4\n}")

M.autosnips.ds = p({
  trig = ";ds",
  name = "Docstring",
  dscr = "creates a docstring comment block",
}, "/**\n * $1\n */")

return getSnippetsList(M.snips), getSnippetsList(M.autosnips)
