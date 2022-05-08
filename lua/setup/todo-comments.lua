-- "folke/todo-comments.nvim"

require("todo-comments").setup {
	highlight = {
		comments_only = false,
	}
}

-- mappings
vim.api.nvim_set_keymap("n", "<leader>gt", "<cmd>TodoTelescope<cr>", { noremap = true, silent = true })
