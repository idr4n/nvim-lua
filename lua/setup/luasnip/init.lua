-- "L3MON4D3/LuaSnip"

local ls = require("luasnip")

local snippets = require("setup.luasnip.snips").snippets
local autosnippets = require("setup.luasnip.snips").autosnippets

-- Add snippets
ls.add_snippets("go", snippets.go)
ls.add_snippets("javascript", snippets.js)

-- Add autosnippets
ls.add_snippets("go", autosnippets.go, { type = "autosnippets" })
ls.add_snippets("javascript", autosnippets.js, { type = "autosnippets" })

-- -- load snippets from path/of/your/nvim/config/
-- require("luasnip.loaders.from_lua").lazy_load({ paths = { "./snippets" } })
-- require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
-- require("luasnip.loaders.from_snipmate").lazy_load({ paths = { "./snippets" } })

-- Settings
ls.filetype_extend("lua", { "javascript" })
ls.filetype_extend("typescript", { "javascript" })
ls.filetype_extend("javascriptreact", { "javascript" })
ls.filetype_extend("typescriptreact", { "javascript" })

ls.config.set_config({
	store_selection_keys = "<c-s>",
	history = true,
	enable_autosnippets = true,
})

-- keymappings
vim.keymap.set({ "i", "s" }, "<c-j>", function()
	if ls.jumpable(1) then
		ls.jump(1)
	end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-k>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })

vim.keymap.set("i", "<c-l>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end)
