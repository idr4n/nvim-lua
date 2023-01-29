return {
	"kazhala/close-buffers.nvim",
	keys = {
		{
			"<leader>kf",
			"<cmd>lua vim.cmd('Alpha'); require('close_buffers').wipe({ type = 'other', force = false })<CR>",
			noremap = true,
			silent = false,
		},

		{
			"<leader>ko",
			"<cmd>lua require('close_buffers').wipe({ type = 'other', force = false })<CR>",
			noremap = true,
			silent = false,
		},
	},
}
