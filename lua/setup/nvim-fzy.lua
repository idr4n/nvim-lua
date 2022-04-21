-- 'mfussenegger/nvim-fzy'

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap(
	"n",
	"<C-P>",
	-- "<leader>ff",
	":lua require('fzy').execute('rg --files --hidden --follow --no-ignore -g \"!.git/*\" -g \"!node_modules\"', require('fzy').sinks.edit_file)<CR>",
	opts
)
