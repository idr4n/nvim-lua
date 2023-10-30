--: opts {{{
local keyset = vim.keymap.set
local opts = { noremap = true, silent = true }
local od = require("util").opts_and_desc
--: }}}

--: Shorten function name {{{
local keymap = vim.api.nvim_set_keymap
--: }}}

--: Remap space as leader key {{{
-- keymap("", "<Space>", "<Nop>", opts)
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = " "
--: }}}

--: Press jk fast to enter {{{
keymap("i", "jk", "<ESC>", od())
--: }}}

--: esc with c-g {{{
keyset("v", "<C-g>", "<ESC>")
--: }}}

--: Move around while in insert mode {{{
-- keymap("i", "<C-a>", "<C-O>0", opts)
keymap("i", "<C-a>", "<Home>", od())
-- keymap("i", "<C-e>", "<C-O>$", opts)
keymap("i", "<C-e>", "<End>", od())
keymap("i", "<C-f>", "<C-O>zt", od())
keymap("n", "<C-f>", "zt", od("Top current line"))
--: }}}

--: center around cursor using <C-/> {{{
keyset("n", "<C-_>", "zz", od("Center around cursor"))
keyset("i", "<C-_>", "<C-O>zz", od("Center around cursor"))
--: }}}

--: Move up and down with wrapped lines {{{
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)
--: }}}

--: new line above {{{
-- "<C-o>O" is equivalent to "<esc>O" while in insert mode
keyset("i", "<C-O>", "<C-o>O", od("Insert line above"))
--: }}}

--: Quicksave command {{{
keyset("n", "<leader>s", "<cmd>w<CR>", od("Save file"))
keyset("n", "<leader>fs", "<cmd>w<CR>", od("Save file"))
keymap("n", "<Leader>S", "<cmd>w!<CR>", od("Save file override"))
--: }}}

--: Quit current window {{{
keymap("n", "<leader>e", ":quit<CR>", od("Quit"))
keymap("n", "<leader>E", ":q!<CR>", od("Force Quit"))
--: }}}

--: Easy select all of file {{{
keymap("n", ",A", "ggVG<c-$>", od("Select All"))
--: }}}

--: Duplicate line and comment old line out {{{
keymap("n", "gcy", "gcc:t.<cr>gcc", { noremap = false, silent = true, desc = "Duplicate-comment line" })
--: }}}

--: Switch buffers {{{
-- keymap("n", "<S-w>", ":bnext<CR>", opts)
-- keymap("n", "<S-q>", ":bprevious<CR>", opts)
keymap("n", "ga", ":b#<CR>zz", od("Last buffer"))
--: }}}

--: Using Bbye plugin to close the current buffer {{{
keymap("n", "<leader>q", ":Bdelete<CR>", od("Delete buffer"))
keymap("n", "<leader>bd", ":Bdelete<CR>", od("Delete buffer"))
-- wipeout current buffer
keymap("n", "<leader>bw", ":Bwipeout<CR>", od("Wipeout buffer"))
-- keymap("n", "<leader>bd", ":bd<CR>", opts)
--: }}}

--: Close tab {{{
keymap("n", "<leader>Q", ":tabclose<cr>", od("Close tab"))
--: }}}

--: Move text up and down {{{
keymap("n", "<A-Down>", "]e==", { noremap = false, silent = true })
keymap("n", "<A-Up>", "[e==", { noremap = false, silent = true })
--: }}}

--: search for word under cursor and stays there {{{
-- searches exact word (* forward, # backwards)
keymap("n", "*", "*N", { noremap = true })
keymap("n", "#", "#N", { noremap = true })
-- searches but not the exact word (* forward, # backwards)
keymap("n", "g*", "g*N", { noremap = true, desc = "Search not exact" })
keymap("n", "g#", "g#N", { noremap = true, desc = "BckSearch not exact" })
--: }}}

--: select line without end of line {{{
keymap("n", ",a", "^v$h", od("Select line-no-end"))
keymap("n", "g;", "^v$h", od("Select line-no-end"))
--: }}}

--: paste register for printing (JavaScript) {{{
keymap("n", ",d", 'oconsole.log("<esc>pa")<esc>', od("Paste for printing - JS"))
keymap("n", ",D", 'Oconsole.log("<esc>pa")<esc>', od("Paste for printing - JS"))
--: }}}

--: Paste register for informative printing {{{
keymap("n", ",s", 'a"<esc>pa:", <esc>p', od("Paste for info printing"))
--: }}}

--: keep cursor at same position when joining lines {{{
keymap("n", "J", "mzJ`z", opts)
--: }}}

--: toggle wrapping lines {{{
keymap("n", "<leader>tw", "<cmd>set wrap!<cr>", od("Line wrap"))
--: }}}

--: toggle line numbers {{{
keyset("n", "<leader>tn", function()
    vim.cmd([[
        set invnumber
        set invrelativenumber
    ]])
end, od("Line numbers"))
--: }}}

--: center when scrolling page down and up {{{
keymap("n", "<c-d>", "<c-d>zz", opts)
keymap("n", "<c-u>", "<c-u>zz", opts)
--: }}}

--: center around next search result {{{
keyset("n", "n", "nzzzv")
keyset("n", "N", "Nzzzv")
--: }}}

--: set current file's directory as working directory {{{
keymap("n", "<leader>cd", "<cmd>cd %:p:h<CR>", od("Set directory as wd"))
--: }}}

--: Better window navigation {{{
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
--: }}}

--: Resize windows with arrows {{{
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)
--: }}}

--: Clear search highlight {{{
keymap("n", "<leader>,", "<cmd>nohlsearch|diffupdate|normal! <C-L><CR>", od("Clear search highlight"))
keymap("n", "<esc>", "<esc><cmd>noh<cr>", { noremap = true, silent = true, desc = "No highlight escape" })
--: }}}

--: home row goto end and start of line (same as in Helix editor) {{{
keyset({ "n", "v", "o" }, "gh", "^", od("Go to start of line"))
keyset({ "n", "o" }, "gl", "$", od("Go to end of line"))
keyset("v", "gl", "$h", od("Go to end of line"))
--: }}}

--: Stay in indent mode {{{
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
--: }}}

--: Comment {{{
-- toggle comment in normal mode
keyset("n", "<C-c>", function()
    return vim.v.count == 0 and "<Plug>(comment_toggle_linewise_current)" or "<Plug>(comment_toggle_linewise_count)"
end, { expr = true })
keyset("n", "<C-b>", "<Plug>(comment_toggle_blockwise_current)")

-- toggle comment using C-/
-- keyset("n", "<C-_>", function()
--     return vim.v.count == 0 and "<Plug>(comment_toggle_linewise_current)" or "<Plug>(comment_toggle_linewise_count)"
-- end, { expr = true })
-- vim.keymap.set("x", "<C-_>", "<Plug>(comment_toggle_linewise_visual)")

-- toggle comment in visual mode
vim.keymap.set("x", "<C-c>", "<Plug>(comment_toggle_linewise_visual)")
vim.keymap.set("x", "<C-b>", "<Plug>(comment_toggle_blockwise_visual)")
--: }}}

--: Duplicate and comment selection {{{
keymap("v", "gy", ":t'><cr>gvgcgv<esc>", { noremap = false, silent = true, desc = "Duplicate and comment" })
--: }}}

--: Move text up and down {{{
keymap("v", "<A-Down>", ":m .+1<CR>==", opts)
keymap("v", "<A-Up>", ":m .-2<CR>==", opts)
keymap("x", "<A-Down>", ":move '>+1<CR>gv=gv", opts)
keymap("x", "<A-Up>", ":move '<-2<CR>gv=gv", opts)
--: }}}

--: paste and replace selection {{{
keymap("v", "p", '"_dP', opts)
--: }}}

--: search for highlighted text {{{
keymap("v", "*", "y/\\V<C-R>=escape(@\",'/')<CR><CR>N", { noremap = true })
--: }}}

--: substitute word previously searched {{{
-- on selection only
keymap("v", "<leader>R", ":s///g<LEFT><LEFT>", { noremap = true, desc = "Replace search" })
-- on entire buffer
keymap("n", "<leader>R", ":%s///g<LEFT><LEFT>", { noremap = true, desc = "Replace search" })
-- substitute current word
keyset("n", "<leader>X", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Substitute current word" })
keyset("v", "<leader>X", [[y:%s/<C-r>0/<C-r>0/gI<Left><Left><Left>]], { desc = "Substitute selection" })
--: }}}

--: Explorer (netrw) {{{
keymap("n", "<leader>oe", ":Explor<cr>", od("Netrw"))
--: }}}

--: Replace the easy-clip plugin {{{
-- keymap("x", "<leader>p", '"_dP', opts)
keyset({ "n", "v", "o" }, "<leader>p", '"+p', od("Paste from clipboard"))
keyset({ "n", "v", "o" }, "<leader>P", '"+P', od("Paste from clipboard"))
keyset({ "n", "v", "o" }, "<leader>y", '"+y', od("Yank to clipboard"))
keymap("n", "<leader>Y", '"+Y', { noremap = false, silent = true, desc = "Yank to clipboard line-end" })
keymap("n", "d", '"_d', opts)
keymap("v", "d", '"_d', opts)
keyset("n", "gm", "m", opts)
keymap("", "m", "d", opts)
keymap("", "<leader>m", '"+d', od("Cut to clipboard"))
keymap("n", "x", '"_x', opts)
keymap("n", "X", '"_X', opts)
keymap("n", "c", '"_c', opts)
keymap("n", "C", '"_C', opts)
keymap("v", "x", '"_x', opts)
keymap("v", "c", '"_c', opts)
--: }}}

--: Other mappings {{{
keyset("n", "<leader>ol", "<cmd>:Lazy<cr>", { desc = "Lazy Dashboard" })
--: }}}
