-- "sindrets/diffview.nvim"

vim.api.nvim_set_keymap("n", "<leader>dv", ":DiffviewOpen<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>dh", ":DiffviewFileHistory %<cr>", { noremap = true, silent = true })
