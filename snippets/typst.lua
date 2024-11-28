local ls = require("luasnip")
local p = ls.parser.parse_snippet

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
  name = "Bold Text *|*",
  dscr = "Surrounds with bold text",
}, "*$TM_SELECTED_TEXT$1*")

M.snips.it = p({
  trig = "it",
  name = "Emphasis _emphasis_",
  dscr = "Surrounds with emphasis",
}, "_$TM_SELECTED_TEXT$1_")

M.snips.m = p({
  trig = "m",
  name = "Math $|$",
  dscr = "Surrounds with single math symbols",
}, "\\$$TM_SELECTED_TEXT$1\\$")

M.snips.M = p({
  trig = "M",
  name = "Math $ | $",
  dscr = "Surrounds with block math symbols",
}, "\\$ $TM_SELECTED_TEXT$1 \\$")

M.snips.cb = p({
  trig = "cb",
  name = "code block",
  dscr = "Code block",
}, "```${1:python}\n$TM_SELECTED_TEXT$2\n```")

M.snips.pb = p({
  trig = "pb",
  name = "Page break",
  dscr = "Adds a page break",
}, "\n\n#pagebreak()\n\n")

M.snips.lt = p(
  {
    trig = "lt",
    name = "Typst 'general' template",
    dscr = "Typst 'general' template",
  },
  [[
#import "/typst/templates/${1:general}.typ": template, source_code, status
#show: template.with(
  title: "$2",
  authors: (
    (name: "${3:Dr. Ivan Duran}"),
  ),
  prefix: "${4:Course}",
  suffix: "Prince Sultan University"
  // heading_font: "New Computer Modern",
  // text_font: "New Computer Modern",
)
#set text(font: "New Computer Modern",size: 11pt)
#set enum(full: true, numbering: (..n) => {
  let format = if n.pos().len() > 1 {"(a)"} else {"1."}
  numbering(format, n.pos().last())
})
#set math.equation(numbering: "(1)")
#set heading(numbering: none)
#import "@preview/xarrow:0.3.0": xarrow

#let highlight(content) = align(
  // center, 
  block(
    width: 100%,
    // fill: luma(95%),
    inset: (x: 5pt, y: 15pt),
    radius: 2pt,
    stroke: (thickness: 0.5pt),
    content
  )
)

#pagebreak()

= Introduction
]]
)

-- autosnippets
M.autosnips.bb = p({
  trig = ";bb",
  name = "Autosnippet - Bold Text *|*",
  dscr = "Surrounds with bold text",
}, "*$TM_SELECTED_TEXT$1*")

M.autosnips.it = p({
  trig = ";it",
  name = "Emphasis _emphasis_",
  dscr = "Surrounds with emphasis",
}, "_$TM_SELECTED_TEXT$1_")

M.autosnips.m = p({
  trig = ";m",
  name = "Math $|$",
  dscr = "Surrounds with single math symbols",
}, "\\$$TM_SELECTED_TEXT$1\\$")

M.autosnips.M = p({
  trig = ";M",
  name = "Math $$|$$",
  dscr = "Surrounds with block math symbols",
}, "\\$ $TM_SELECTED_TEXT$1 \\$")

M.autosnips.pb = p({
  trig = ";pb",
  name = "Page break",
  dscr = "Adds a page break",
}, "\n\n#pagebreak()\n\n")

M.autosnips.lt = p(
  {
    trig = ";lt",
    name = "Typst 'general' template",
    dscr = "Typst 'general' template",
  },
  [[
#import "/typst/templates/${1:general}.typ": template, source_code, status
#show: template.with(
  title: "$2",
  authors: (
    (name: "${3:Dr. Ivan Duran}"),
  ),
  prefix: "${4:Course}",
  suffix: "Prince Sultan University"
  // heading_font: "New Computer Modern",
  // text_font: "New Computer Modern",
)
#set text(font: "New Computer Modern",size: 11pt)
#set enum(full: true, numbering: (..n) => {
  let format = if n.pos().len() > 1 {"(a)"} else {"1."}
  numbering(format, n.pos().last())
})
#set math.equation(numbering: "(1)")
#set heading(numbering: none)
#import "@preview/xarrow:0.3.0": xarrow

#let highlight(content) = align(
  // center, 
  block(
    width: 100%,
    // fill: luma(95%),
    inset: (x: 5pt, y: 15pt),
    radius: 2pt,
    stroke: (thickness: 0.5pt),
    content
  )
)

#pagebreak()

= Introduction
]]
)

return getSnippetsList(M.snips), getSnippetsList(M.autosnips)
