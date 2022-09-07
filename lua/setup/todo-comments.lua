-- "folke/todo-comments.nvim"

require("todo-comments").setup({
	highlight = {
		comments_only = false,
		after = "",
	},
	search = {
		command = "rg",
		args = {
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--glob=!node_modules",
		},
	},
})

-- mappings
-- vim.api.nvim_set_keymap("n", "<leader>gt", "<cmd>TodoTelescope<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>gt", "<cmd>TodoTrouble<cr>", { noremap = true, silent = true })
