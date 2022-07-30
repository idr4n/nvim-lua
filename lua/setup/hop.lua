-- "phaazon/hop.nvim"

require("hop").setup()

vim.api.nvim_set_keymap("n", "f", "<cmd>lua require'hop'.hint_char1()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "F", "v<cmd>lua require'hop'.hint_char1()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "F", "<cmd>lua require'hop'.hint_char1()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "t", "<cmd>lua require'hop'.hint_words()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "T", "v<cmd>lua require'hop'.hint_words()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "T", "<cmd>lua require'hop'.hint_words()<cr>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<C-f>", "<cmd>lua require'hop'.hint_lines()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "L", "<cmd>lua require'hop'.hint_lines()<cr>", { noremap = false, silent = true })
vim.api.nvim_set_keymap("v", "L", "<cmd>lua require'hop'.hint_lines()<cr>", { noremap = false, silent = true })
