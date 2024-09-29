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

M.snips.bb = p({
  trig = "bb",
  name = "Bold Text \\textbf{|}",
  dscr = "Surrounds with bold text",
}, "\\\\textbf{$TM_SELECTED_TEXT$1}")

M.snips.it = p({
  trig = "it",
  name = "Italized Text \\textit{|}",
  dscr = "Surrounds with italized text",
}, "\\\\textit{$TM_SELECTED_TEXT$1}")

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

M.snips.bu = p({
  trig = "bu",
  name = "Blank Underline $$_____$$",
  dscr = "Adds a blank underline for mcqs questions",
}, "\\underline{\\phantom{mmmmm}}")

M.snips.ta = p(
  {
    trig = "ta",
    name = "Assignment Template",
    dscr = "Assignment Template",
  },
  [[
\documentclass[11pt,a4paper]{article}
\usepackage[margin=3.5cm, vmargin={3cm,3cm}]{geometry}
\usepackage{amsmath}
\usepackage{multirow}

\title{Chapter ${1:02} - Practice Problems}
\author{${2:FIN335} - Dr. Ivan Duran }
\date{}

\begin{document}

\maketitle

\begin{enumerate}

  \item $3

\end{enumerate}

\end{document}
]]
)

M.snips.e = p({
  trig = "e",
  name = "Environment",
  dscr = "Latex Environment",
}, "\\begin{$1}\n$TM_SELECTED_TEXT$2\n\\end{$1}")

M.snips.c = p({
  trig = "c",
  name = "Multicol Environment",
  dscr = "Multicol Environment",
}, "\\vspace*{-\\baselineskip}\n\\begin{multicols}{2}\n$TM_SELECTED_TEXT$2\n\\end{multicols}")

-- autosnippets

M.autosnips.bb = p({
  trig = ";bb",
  name = "Bold Text \\textbf{|}",
  dscr = "Surrounds with bold text",
}, "\\\\textbf{$TM_SELECTED_TEXT$1}")

M.autosnips.it = p({
  trig = ";it",
  name = "Italized Text \\textit{|}",
  dscr = "Surrounds with italized text",
}, "\\\\textit{$TM_SELECTED_TEXT$1}")

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

M.autosnips.bu = p({
  trig = ";bu",
  name = "Blank Underline $$_____$$",
  dscr = "Adds a blank underline for mcqs questions",
}, "\\underline{\\phantom{mmmmm}}")

M.autosnips.e = p({
  trig = ";e",
  name = "Environment",
  dscr = "Latex Environment",
}, "\\begin{$1}\n$TM_SELECTED_TEXT$2\n\\end{$1}")

M.autosnips.c = p({
  trig = ";c",
  name = "Multicol Environment",
  dscr = "Multicol Environment",
}, "\\vspace*{-\\baselineskip}\n\\begin{multicols}{2}\n$TM_SELECTED_TEXT$2\n\\end{multicols}")

return getSnippetsList(M.snips), getSnippetsList(M.autosnips)
