local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
-- local i = ls.insert_node

local snippets, autosnippets = {}, {}

local testSnip = s(";tes", { t("Test snippet...") })

table.insert(autosnippets, testSnip)

return snippets, autosnippets
