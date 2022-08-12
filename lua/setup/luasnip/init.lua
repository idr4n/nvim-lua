-- "L3MON4D3/LuaSnip"

local ls = require("luasnip")
local mappable = require("setup.luasnip.snips")

-- loads snippets from path/of/nvim/config/
require("luasnip.loaders.from_lua").lazy_load({ paths = { "./snippets" } })
-- require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
-- require("luasnip.loaders.from_snipmate").lazy_load({ paths = { "./snippets" } })

-- Settings --
ls.filetype_extend("typescript", { "javascript" })
ls.filetype_extend("javascriptreact", { "javascript" })
ls.filetype_extend("typescriptreact", { "javascript" })

ls.config.set_config({
	store_selection_keys = "<c-s>",
	history = true,
	enable_autosnippets = true,
})

-- keymappings --
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

vim.keymap.set("i", "<c-h>", function()
	if ls.choice_active() then
		ls.change_choice(-1)
	end
end)

-- -- Mapped snippets --
local function map_snippet(keys, snippet)
	vim.keymap.set("i", keys, function()
		require("luasnip").snip_expand(snippet)
	end)
end

-- surrounds with {|}
map_snippet(";cc", mappable.sc)
vim.api.nvim_set_keymap("v", ";cc", "<c-s>;cc", { noremap = false, silent = false })

-- surrounds with callback function
map_snippet(";cf", mappable.sf)
vim.api.nvim_set_keymap("v", ";cf", "<c-s>;cf", { noremap = false, silent = false })
