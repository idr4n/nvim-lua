-- 'mfussenegger/nvim-fzy'

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- keymap(
-- 	"n",
-- 	"<C-P>",
-- 	":lua require('fzy').execute('rg --files --hidden --follow --no-ignore -g \"!.git/*\" -g \"!node_modules\" 2> /dev/null', require('fzy').sinks.edit_file)<CR>",
-- 	-- ":lua require('fzy').execute('fd --type f -L --hidden --no-ignore -E .git -E node_modules', require('fzy').sinks.edit_file)<CR>",
-- 	opts
-- )
keymap(
	"n",
	"<leader>r",
	":lua require('fzy').execute('rg --no-heading --trim -nH . 2> /dev/null', require('fzy').sinks.edit_live_grep)<CR>",
	opts
)
