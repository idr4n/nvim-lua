-- "kazhala/close-buffers.nvim"

vim.api.nvim_set_keymap(
	"n",
	"<leader>kf",
	"<cmd>lua vim.cmd('Alpha'); require('close_buffers').delete({ type = 'other', force = false })<CR>",
	{ noremap = true, silent = false }
)

vim.api.nvim_set_keymap(
	"n",
	"<leader>ko",
	"<cmd>lua require('close_buffers').delete({ type = 'other', force = false })<CR>",
	{ noremap = true, silent = false }
)
