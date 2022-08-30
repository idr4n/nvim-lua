-- 'folke/trouble.nvim'

local util = require("trouble.util")
local _jump_to_item = util.jump_to_item
util.jump_to_item = function(win, ...)
	return _jump_to_item(win or 0, ...)
end

require("trouble").setup({
	height = 15,
})

-- Lua
vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap(
	"n",
	"<leader>xw",
	"<cmd>TroubleToggle workspace_diagnostics<cr>",
	{ silent = true, noremap = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>xd",
	"<cmd>TroubleToggle document_diagnostics<cr>",
	{ silent = true, noremap = true }
)
vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "gr", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true })
-- vim.api.nvim_set_keymap("n", "gd", "<cmd>TroubleToggle lsp_definitions<cr>", { silent = true, noremap = true })
