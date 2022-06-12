local ls = require("luasnip")
local p = ls.parser.parse_snippet
-- local s = ls.snippet
-- local sn = ls.snippet_node
-- local t = ls.text_node
-- local i = ls.insert_node
-- local fmt = require("luasnip.extras.fmt").fmt

local M = { snippets = {}, autosnippets = {} }

-- JavaScript
M.snippets.js = {
	p({
		trig = "sc",
		name = "surrond with {}",
		dscr = "surround with curly brackets",
	}, "$1 {\n\t$TM_SELECTED_TEXT$2\n}"),
	p({
		trig = "sp",
		name = "surrond with ()",
		dscr = "surround with parenthesis",
	}, "$1($TM_SELECTED_TEXT$2)"),
	p({
		trig = "cl",
		name = "console.log",
		dscr = "surround with console.log",
	}, "console.log($TM_SELECTED_TEXT$1)"),
}

M.autosnippets.js = {
	p(";sc", "${1:if (${2:cond})} {\n\t$TM_SELECTED_TEXT$3\n}"),
	p(";sp", "$1($TM_SELECTED_TEXT$2)"),
	p(";cl", "console.log($TM_SELECTED_TEXT$1)"),
}

-- Golang
M.snippets.go = {
	p({
		trig = "ie",
		name = "if err != nil",
		dscr = "Snippet for if err != nil",
	}, "if err != nil {\n\t${1}\n}"),
	p({
		trig = "ea",
		name = "_, err := ...",
		dscr = "Var assignment with error _, err :=",
	}, "${1:_}, err := $2"),
}

M.autosnippets.go = {
	p(";ie", "if err != nil {\n\t${1}\n}"),
	p(";ea", "${1:_}, err := $2"),
}

return M
