-- "folke/todo-comments.nvim"

require("todo-comments").setup({
	highlight = {
		comments_only = false,
		after = "",
	},
})

-- mappings
-- vim.api.nvim_set_keymap("n", "<leader>gt", "<cmd>TodoTelescope<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>gt", "<cmd>TodoTrouble<cr>", { noremap = true, silent = true })
