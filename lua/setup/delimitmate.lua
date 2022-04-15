-- "Raimondi/delimitMate"

vim.g.delimitMate_expand_space = 1
vim.g.delimitMate_expand_cr = 1

vim.api.nvim_set_keymap("i", "<C-\\>", "<Plug>delimitMateS-Tab", { noremap = false, silent = true })

