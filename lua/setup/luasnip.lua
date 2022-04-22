-- "L3MON4D3/LuaSnip"

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

-- load snippets from path/of/your/nvim/config/
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

_G.snip_jump_fwd = function()
	if luasnip.jumpable(1) then
		return t("<Plug>luasnip-jump-next")
	end
end

_G.snip_jump_bwd = function()
	if luasnip.jumpable(-1) then
		return t("<Plug>luasnip-jump-prev")
	end
end

-- this is an easy option to map jumping to next in snip
-- keymap("i", "<C-j>", "<cmd>lua require('luasnip').jump(1)<cr>", opts)

-- set this way instead to follow a similar example in luasnip website, and why not
-- to make it more complicated... 😎
keymap("i", "<C-j>", "v:lua.snip_jump_fwd()", vim.tbl_deep_extend("force", opts, { expr = true }))
keymap("i", "<C-k>", "v:lua.snip_jump_bwd()", vim.tbl_deep_extend("force", opts, { expr = true }))

