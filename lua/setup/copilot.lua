-- 'github/copilot.vim'

-- imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
-- let g:copilot_no_tab_map = v:true

vim.api.nvim_set_keymap(
	"i",
	"<C-C>",
	"copilot#Accept('<CR>')",
	{ noremap = false, silent = true, script = true, expr = true }
)
