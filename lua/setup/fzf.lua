--  'junegunn/fzf.vim'

-- settings
vim.g.fzf_layout = { down = "50%" }
vim.g.fzf_preview_window = { "right:50%", "ctrl-l" }
-- vim.g.fzf_layout = { window = { width = 0.8, height = 0.85 } }
-- vim.g.fzf_preview_window = { "up:50%", "ctrl-l" }

-- colors
vim.g.fzf_colors = {
	["fg"] = { "fg", "Normal" },
	["bg"] = { "bg", "Normal" },
	["hl"] = { "fg", "Comment" },
	["fg+"] = { "fg", "CursorLine", "CursorColumn", "Normal" },
	["bg+"] = { "bg", "CursorLine", "CursorColumn" },
	["hl+"] = { "fg", "Statement" },
	["info"] = { "fg", "PreProc" },
	["border"] = { "fg", "Ignore" },
	["prompt"] = { "fg", "Conditional" },
	["pointer"] = { "fg", "Exception" },
	["marker"] = { "fg", "Keyword" },
	["spinner"] = { "fg", "Label" },
	["header"] = { "fg", "Comment" },
	["gutter"] = { "bg", "Normal" },
}

-- Default command
vim.env.FZF_DEFAULT_COMMAND = "rg --files --hidden --follow --no-ignore -g '!.git/*' -g '!node_modules'"

-- exlclude file name from fuzzy matching in Rg command
vim.cmd([[
command! -bang -nargs=* Rg
  \ call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case '
  \ . (len(<q-args>) > 0 ? <q-args> : '""'), 0,
  \ fzf#vim#with_preview({'options': ['--delimiter=:', '--nth=2..', '--layout=default', '--info=inline']}), <bang>0)
]])

-- Remove statusline
-- vim.cmd[[
--   augroup fzf
--     autocmd!
--     autocmd! FileType fzf set laststatus=0 noshowmode noruler
--       \| autocmd BufLeave <buffer> set laststatus=3 showmode ruler
--   augroup END
-- ]]

-- change statusline color
vim.cmd([[
function! s:fzf_statusline()
  highlight fzf1 guifg=#F55673
  highlight fzf2 guifg=Normal
  highlight fzf3 guifg=#F55673
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction
autocmd! User FzfStatusLine call <SID>fzf_statusline()
]])

-- this doesn't work as the color does not get interpolated somehow 🤷
-- local color = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("CursorLine")), "bg#")
-- vim.cmd(([[
-- function! s:fzf_statusline()
--   highlight fzf1 guifg=#F55673 guibg=%s
--   highlight fzf2 guifg=Normal
--   highlight fzf3 guifg=#F55673
--   setlocal statusline=%%#fzf1#\ >\ %%#fzf2#fz%%#fzf3#f
-- endfunction
-- autocmd! User FzfStatusLine call <SID>fzf_statusline()
-- ]]):format(color))

-- mappings

-- local opts = { noremap = true, silent = true }
-- vim.api.nvim_set_keymap("n", "<C-P>", ":Files<cr>", opts)
-- vim.api.nvim_set_keymap("n", "<C-T>", ":History<cr>", opts)
-- vim.api.nvim_set_keymap("n", "<C-B>", ":Buffers<cr>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>r", ":Rg<cr>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>gs", ":GitFiles?<cr>", opts)

