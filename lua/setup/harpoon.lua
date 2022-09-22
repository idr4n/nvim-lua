-- 'ThePrimeagen/harpoon'

vim.keymap.set("n", "<leader><tab>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>")
vim.keymap.set("n", "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<cr>")
vim.keymap.set("n", "<c-s>", "<cmd>lua require('harpoon.ui').nav_next()<cr>")
-- vim.keymap.set("n", "<c-x>", "<cmd>lua require('harpoon.ui').nav_prev()<cr>")
vim.keymap.set("n", "<M-u>", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>")
vim.keymap.set("n", "<M-i>", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>")
vim.keymap.set("n", "<M-o>", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>")
vim.keymap.set("n", "<M-p>", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>")
vim.keymap.set("n", "<M-[>", "<cmd>lua require('harpoon.ui').nav_file(5)<cr>")
