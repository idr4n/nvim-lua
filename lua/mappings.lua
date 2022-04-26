local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Insert --

-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Move around while in insert mode
-- keymap("i", "<C-a>", "<C-O>0", opts)
keymap("i", "<C-a>", "<Home>", opts)
-- keymap("i", "<C-e>", "<C-O>$", opts)
keymap("i", "<C-e>", "<End>", opts)
keymap("i", "<C-f>", "<right>", opts)


-- Normal --

-- Move up and down with wrapped lines
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)

-- Quicksave command
keymap("n", "<leader>s", ":w<CR>", opts)

-- Quit current window
keymap("n", "<leader>e", ":quit<CR>", opts)
keymap("n", "<leader>E", ":q!<CR>", opts)

-- Easy select all of file
keymap("n", "<Leader>S", "ggVG<c-$>", opts)

-- Duplicate line and comment old line out
keymap("n", "gcy", "gccyypgcc", { noremap = false, silent = true })
keymap("n", "Y", "gccyypgcc", { noremap = false, silent = true })

-- swtich buffers
keymap("n", "<S-w>", ":bnext<CR>", opts)
keymap("n", "<S-q>", ":bprevious<CR>", opts)
keymap("n", "ga", ":b#<CR>", opts)

-- Using Bbye plugin to close the current buffer
keymap("n", "<leader>q", ":Bdelete<CR>", opts)
-- wipeout current buffer
-- keymap("n", "<leader>w", ":Bwipeout<CR>", opts)
keymap("n", "<leader>bd", ":bd<CR>", opts)

-- Move text up and down
keymap("n", "<A-Down>", "]e", { noremap = false, silent = true })
keymap("n", "<A-Up>", "[e", { noremap = false, silent = true })

-- search for word under cursor and stays there
-- searches exact word (* forward, # backwards)
keymap("n", "*", "*N", { noremap = true })
keymap("n", "#", "#N", { noremap = true })
-- searches but not the exact word (* forward, # backwards)
keymap("n", "g*", "g*N", { noremap = true })
keymap("n", "g#", "g#N", { noremap = true })

-- set current file's directory as working directory
keymap("n", "<leader>dc", "<cmd>cd %:p:h<CR>", opts)

-- close all other buffers (exept the current one)
keymap("n", "<leader>Q", ':%bdelete|edit #|normal `"zz<CR>', opts)

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

-- Visual --

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Duplicate and comment selection
keymap("v", "gy", "gcgvyPgvgc", { noremap = false, silent = true })

-- Move text up and down
keymap("v", "<A-Down>", ":m .+1<CR>==", opts)
keymap("v", "<A-Up>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- search for highlighted text
keymap("v", "*", "y/\\V<C-R>=escape(@\",'/\')<CR><CR>", { noremap = true })

-- substitute word previously searched
-- on selection only
keymap("v", "<leader>R", ":s///g<LEFT><LEFT>", { noremap = true })
-- on entire buffer
keymap("n", "<leader>R", ":%s///g<LEFT><LEFT>", { noremap = true })


-- Visual Block --

-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-Down>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-Up>", ":move '<-2<CR>gv-gv", opts)

