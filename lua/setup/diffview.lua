-- "sindrets/diffview.nvim"

vim.api.nvim_set_keymap("n", "<leader>vo", ":DiffviewOpen<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>vh", ":DiffviewFileHistory %<cr>", { noremap = true, silent = true })
