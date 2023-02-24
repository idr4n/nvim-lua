local ls = require("luasnip")
local p = ls.parser.parse_snippet
local s = ls.snippet
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
-- local sn = ls.snippet_node
-- local t = ls.text_node
-- local fmt = require("luasnip.extras.fmt").fmt

-- mappable snippets
local snippets = {
    sc = p({
        trig = "sc",
        name = "surronds with {|}",
        dscr = "surrounds selection with curly brackets",
    }, "${1:if (${2:cond})} {\n\t$TM_SELECTED_TEXT$3\n}"),
    sp = p({
        trig = "sp",
        name = "surronds with (|)",
        dscr = "surrounds selection with parenthesis",
    }, "$1($TM_SELECTED_TEXT$2)"),
    ss = p({
        trig = "ss",
        name = "surronds with [|]",
        dscr = "surrounds selection with square brackets",
    }, "$1[$TM_SELECTED_TEXT$2]"),
    sf = p({
        trig = "sf",
        name = "surrounds with callback function",
        dscr = "surrounds selection with a callback function",
    }, "${1:name}(($3) => {\n\t$TM_SELECTED_TEXT$4\n})"),
    scm = s(
        {
            trig = "scm",
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
    ),
}

return snippets
