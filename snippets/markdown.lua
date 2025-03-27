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

M.snips.td = p({
  trig = "td",
  name = "Snippet - Markdown TODO",
  dscr = "TODO unchecked",
}, "- [ ] ${1:todo...}")

M.snips.bb = p({
  trig = "bb",
  name = "Bold Text **|**",
  dscr = "Surrounds with bold text",
}, "**$TM_SELECTED_TEXT$1**")

M.snips.it = p({
  trig = "it",
  name = "Italize Text _|_",
  dscr = "Surrounds with italized text",
}, "_$TM_SELECTED_TEXT$1_")

M.snips.m = p({
  trig = "m",
  name = "Math $|$",
  dscr = "Surrounds with single math symbols",
}, "\\$$TM_SELECTED_TEXT$1\\$")

M.snips.M = p({
  trig = "M",
  name = "Math $$|$$",
  dscr = "Surrounds with double math symbols",
}, "\\$\\$$TM_SELECTED_TEXT$1\\$\\$")

M.snips.v = p({
  trig = "v",
  name = "Vertical space",
  dscr = "Vertical space in Latex notation",
}, "\\vspace{${1:1}cm}")

M.snips.p = p({
  trig = "p",
  name = "Phantom",
  dscr = "Phantom in Latex notation",
}, "\\phantom{.}")

M.snips.e = p({
  trig = "e",
  name = "Environment",
  dscr = "Environment in Latex notation",
}, "\\begin{${1:mdframed}}\n$TM_SELECTED_TEXT$2\n\\end{$1}")

M.snips.bc = p({
  trig = "bc",
  name = "Color Box",
  dscr = "Color Box Environment in Latex notation",
}, "\\begin{${1:tcolorbox}}\n$TM_SELECTED_TEXT$2\n\\end{$1}")

M.snips.col = p({
  trig = "col",
  name = "collapsible block",
  dscr = "Adds a collapsible/foldable block",
}, "<details>\n<summary>$1</summary>\n$2\n</details>")

M.snips.cb = p({
  trig = "cb",
  name = "code block",
  dscr = "Code block",
}, "```${1:python}\n$TM_SELECTED_TEXT$2\n```")

M.snips.cq = p({
  trig = "cq",
  name = "code block - quarto",
  dscr = "Code block - quarto",
}, "```{${1:python}}\n$TM_SELECTED_TEXT$2\n```")

M.snips.pfm = p(
  {
    trig = "pfm",
    name = "Pandoc front matter",
    dscr = "Pandoc front matter",
  },
  [[
---
output: 
    pdf_document:
      pandoc_args: ["--filter", "pandoc-eqnos"]
fontsize: 12pt
# geometry: "left=3.5cm,right=3.5cm,top=3cm,bottom=3cm"
geometry: margin=3cm
papersize: A4
urlcolor: blue
---
]]
)

-- autosnippets
M.autosnips.tt = p({
  trig = ";tt",
  name = "Autosnippet - Fish Shell prompt TODO",
  dscr = "TODO to be primpted by the fish shell",
}, "[${1:Project}] ${2:todo...}")

M.autosnips.td = p({
  trig = ";td",
  name = "Autosnippet - Markdown TODO",
  dscr = "TODO unchecked",
}, "- [ ] ${1:todo...}")

M.autosnips.bb = p({
  trig = ";bb",
  name = "Autosnippet - Bold Text **|**",
  dscr = "Surrounds with bold text",
}, "**$TM_SELECTED_TEXT$1**")

M.autosnips.it = p({
  trig = ";it",
  name = "Italize Text _|_",
  dscr = "Surrounds with italized text",
}, "_$TM_SELECTED_TEXT$1_")

M.autosnips.m = p({
  trig = ";m",
  name = "Math $|$",
  dscr = "Surrounds with single math symbols",
}, "\\$$TM_SELECTED_TEXT$1\\$")

M.autosnips.M = p({
  trig = ";M",
  name = "Math $$|$$",
  dscr = "Surrounds with double math symbols",
}, "\\$\\$$TM_SELECTED_TEXT$1\\$\\$")

M.autosnips.v = p({
  trig = ";v",
  name = "Vertical space",
  dscr = "Vertical space in Latex notation",
}, "\\vspace{${1:1}cm}")

M.autosnips.p = p({
  trig = ";p",
  name = "Phantom",
  dscr = "Phantom in Latex notation",
}, "\\phantom{.}")

M.autosnips.e = p({
  trig = ";e",
  name = "Environment",
  dscr = "Environment in Latex notation",
}, "\\begin{${1:mdframed}}\n$TM_SELECTED_TEXT$2\n\\end{$1}")

M.autosnips.bc = p({
  trig = ";bc",
  name = "Color Box",
  dscr = "Color Box Environment in Latex notation",
}, "\\begin{${1:tcolorbox}}\n$TM_SELECTED_TEXT$2\n\\end{$1}")

M.autosnips.cb = p({
  trig = ";cb",
  name = "code block",
  dscr = "Code block",
}, "```${1:python}\n$TM_SELECTED_TEXT$2\n```")

M.autosnips.cq = p({
  trig = ";cq",
  name = "code block - quarto",
  dscr = "Code block - quarto",
}, "```{${1:python}}\n$TM_SELECTED_TEXT$2\n```")

return getSnippetsList(M.snips), getSnippetsList(M.autosnips)
