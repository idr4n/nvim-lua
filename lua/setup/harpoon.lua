-- 'ThePrimeagen/harpoon'

vim.keymap.set("n", "<leader><tab>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>")
vim.keymap.set("n", "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<cr>")
vim.keymap.set("n", "<c-s>", "<cmd>lua require('harpoon.ui').nav_next()<cr>")
vim.keymap.set("n", "<c-x>", "<cmd>lua require('harpoon.ui').nav_prev()<cr>")

for key = 1, 4 do
	vim.keymap.set("n", "<leader>" .. key, function()
		return require("harpoon.ui").nav_file(key)
	end)
end
