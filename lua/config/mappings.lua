local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
-- keymap("", "<Space>", "<Nop>", opts)
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = " "

-- Insert --

-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Move around while in insert mode
-- keymap("i", "<C-a>", "<C-O>0", opts)
keymap("i", "<C-a>", "<Home>", opts)
-- keymap("i", "<C-e>", "<C-O>$", opts)
keymap("i", "<C-e>", "<End>", opts)
keymap("i", "<C-f>", "<right>", opts)

-- center screen around coursor
keymap("i", "<C-F>", "<C-O>zt", opts)

-- Normal --

-- center screen around coursor
keymap("n", "<C-F>", "zt", opts)

-- Move up and down with wrapped lines
-- keymap("n", "j", "gj", opts)
-- keymap("n", "k", "gk", opts)

-- Quicksave command
vim.keymap.set({ "n", "i", "v", "s" }, "<C-s>", "<cmd>w<CR>")

-- Quit current window
keymap("n", "<leader>e", ":quit<CR>", opts)
keymap("n", "<leader>E", ":q!<CR>", opts)

-- Easy select all of file
keymap("n", "<Leader>S", "ggVG<c-$>", opts)
keymap("n", ",A", "ggVG<c-$>", opts)

-- Duplicate line and comment old line out
keymap("n", "gcy", "gcc:t.<cr>gcc", { noremap = false, silent = true })

-- swtich buffers
-- keymap("n", "<S-w>", ":bnext<CR>", opts)
-- keymap("n", "<S-q>", ":bprevious<CR>", opts)
keymap("n", "ga", ":b#<CR>", opts)

-- Using Bbye plugin to close the current buffer
keymap("n", "<leader>q", ":Bdelete<CR>", opts)
-- wipeout current buffer
keymap("n", "<leader>B", ":Bwipeout<CR>", opts)
-- keymap("n", "<leader>bd", ":bd<CR>", opts)

-- Close tab
keymap("n", "<leader>Q", ":tabclose<cr>", opts)

-- Move text up and down
keymap("n", "<A-Down>", "]e==", { noremap = false, silent = true })
keymap("n", "<A-Up>", "[e==", { noremap = false, silent = true })

-- search for word under cursor and stays there
-- searches exact word (* forward, # backwards)
keymap("n", "*", "*N", { noremap = true })
keymap("n", "#", "#N", { noremap = true })
-- searches but not the exact word (* forward, # backwards)
keymap("n", "g*", "g*N", { noremap = true })
keymap("n", "g#", "g#N", { noremap = true })

-- select line without end of line
keymap("n", ",a", "^v$h", opts)

-- paste register for printing (JavaScript)
keymap("n", ",d", 'oconsole.log("<esc>pa")<esc>', opts)
keymap("n", ",D", 'Oconsole.log("<esc>pa")<esc>', opts)

-- Paste register for informative printing
keymap("n", ",s", 'a"<esc>pa:", <esc>p', opts)

-- keep cursor at same position when joining lines
keymap("n", "J", "mzJ`z", opts)

-- toggle wrapping lines
keymap("n", ",w", "<cmd>set wrap!<cr>", opts)

-- center when scrolling page down and up
keymap("n", "<c-d>", "<c-d>zz", opts)
keymap("n", "<c-u>", "<c-u>zz", opts)

-- center around next search result
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- set current file's directory as working directory
keymap("n", "<leader>cd", "<cmd>cd %:p:h<CR>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize windows with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Clear search highlight
keymap("n", "<leader>,", "<cmd>nohlsearch|diffupdate|normal! <C-L><CR>", opts)

-- home row goto end and start of line (same as in Helix editor)
keymap("n", "gh", "^", opts)
keymap("n", "gl", "$", opts)
keymap("v", "gh", "^", opts)
keymap("v", "gl", "$", opts)

-- Visual --

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Duplicate and comment selection
keymap("v", "gy", ":t'><cr>gvgcgv<esc>", { noremap = false, silent = true })

-- Move text up and down
keymap("v", "<A-Down>", ":m .+1<CR>==", opts)
keymap("v", "<A-Up>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- search for highlighted text
keymap("v", "*", "y/\\V<C-R>=escape(@\",'/')<CR><CR>", { noremap = true })

-- substitute word previously searched
-- on selection only
keymap("v", "<leader>R", ":s///g<LEFT><LEFT>", { noremap = true })
-- on entire buffer
keymap("n", "<leader>R", ":%s///g<LEFT><LEFT>", { noremap = true })
-- substitute current word
vim.keymap.set("n", "<leader>X", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("v", "<leader>X", [[y:%s/<C-r>0/<C-r>0/gI<Left><Left><Left>]])

-- Visual Block --

-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv=gv", opts)
keymap("x", "K", ":move '<-2<CR>gv=gv", opts)
keymap("x", "<A-Down>", ":move '>+1<CR>gv=gv", opts)
keymap("x", "<A-Up>", ":move '<-2<CR>gv=gv", opts)

-- Explorer (netrw)
keymap("n", "<leader>xe", ":Explor<cr>", opts)

-- some mapping ideas from thePrimeagen to replace the easy-clip plugin

-- greatest remap ever
-- keymap("x", "<leader>p", '"_dP', opts)
keymap("n", "<leader>p", '"+p', opts)
keymap("v", "<leader>p", '"+p', opts)
keymap("n", "<leader>P", '"+P', opts)
keymap("v", "<leader>P", '"+P', opts)

-- next greatest remap ever (if not using system clipboard as main register)
keymap("n", "<leader>y", '"+y', opts)
keymap("v", "<leader>y", '"+y', opts)
keymap("n", "<leader>Y", '"+Y', { noremap = false, silent = true })

keymap("n", "d", '"_d', opts)
keymap("v", "d", '"_d', opts)
keymap("", "<leader>d", "d", opts)
vim.keymap.set("n", "gm", "m", opts)
keymap("", "m", "d", opts)
keymap("", "<leader>m", '"+d', opts)
keymap("n", "x", '"_x', opts)
keymap("n", "X", '"_X', opts)
keymap("n", "c", '"_c', opts)
keymap("n", "C", '"_C', opts)
keymap("v", "x", '"_x', opts)
keymap("v", "c", '"_c', opts)
