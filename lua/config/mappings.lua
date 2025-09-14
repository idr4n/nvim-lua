local cursorMoveAround = require("utils").CursorMoveAround

--: helpers {{{
-- https://github.com/nvim-telescope/telescope.nvim/issues/1923
function vim.getVisualSelection()
  vim.cmd('noau normal! "vy"')
  local text = tostring(vim.fn.getreg("v"))
  vim.fn.setreg("v", {})

  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ""
  end
end
--: }}}

--: default keymaps options {{{
local opts = { noremap = true, silent = true }
--: }}}

--: Shorten key mappings function names {{{
local keymap = function(mode, keys, cmd, options)
  options = options or {}
  options = vim.tbl_deep_extend("force", opts, options)
  vim.api.nvim_set_keymap(mode, keys, cmd, options)
end

local keyset = function(modes, keys, cmd, options)
  options = options or {}
  options = vim.tbl_deep_extend("force", opts, options)
  vim.keymap.set(modes, keys, cmd, options)
end
--: }}}

--: Remap space as leader key {{{
-- keymap("", "<Space>", "<Nop>")
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = " "
--: }}}

--: Press jk fast to enter {{{
keymap("i", "jk", "<ESC>")
--: }}}

--: esc with c-g {{{
keyset("v", "<C-g>", "<ESC>")
--: }}}

--: Move around while in insert mode {{{
-- keymap("i", "<C-a>", "<C-O>0")
keymap("i", "<C-a>", "<Home>")
-- keymap("i", "<C-e>", "<C-O>$")
keymap("i", "<C-e>", "<End>")
keymap("i", "<C-b>", "<Left>")
keymap("i", "<A-b>", "<ESC>bi")
keymap("i", "<C-f>", "<Right>")
keymap("i", "<A-f>", "<ESC>lwi")
--: }}}

--: Move up and down with wrapped lines {{{
keymap("n", "j", "gj")
keymap("n", "k", "gk")
--: }}}

--: new line above {{{
-- "<C-o>O" is equivalent to "<esc>O" while in insert mode
keyset("i", "<C-O>", "<C-o>O", { desc = "Insert line above" })
--: }}}

--: insert line below or above {{{
-- source: https://arc.net/l/quote/bexrxjgz
-- stylua: ignore
keymap("n", "]<space>", "<cmd>call append(line('.'),   repeat([''], v:count1))<cr>", { desc = "Insert line below" })
-- stylua: ignore
keymap("n", "[<space>", "<cmd>call append(line('.')-1, repeat([''], v:count1))<cr>", { desc = "Insert line above" })
--: }}}

--: Quicksave command {{{
-- keyset({ "n", "i", "x", "s" }, "<C-S>", "<cmd>w<CR><esc>", { desc = "Save file" })
keyset({ "n", "i" }, "<C-S>", "<cmd>w<CR><esc>", { desc = "Save file" })
keyset("n", "<leader>fs", "<cmd>w<CR>", { desc = "Save file" })
keymap("n", "<Leader>S", "<cmd>w!<CR>", { desc = "Save file override" })
keymap("n", "<Leader>w", "<cmd>noa w<CR>", { desc = "Save file no formatting" })
--: }}}

--: Quit current window {{{
keymap("n", "<leader>qq", ":qa<CR>", { desc = "Quit all" })
keymap("n", "<leader>qw", ":q<CR>", { desc = "Quit window" })
keymap("n", "<leader>qQ", ":q!<CR>", { desc = "Force Quit" })
--: }}}

--: Easy select all of file {{{
keymap("n", ",A", "ggVG<c-$>", { desc = "Select All" })
--: }}}

--: Duplicate line and comment old line out {{{
keymap("n", "gcy", "gcc:t.<cr>gcc", { noremap = false, desc = "Duplicate-comment line" })
--: }}}

--: Switch buffers {{{
keymap("n", "<S-l>", ":bnext<CR>")
keymap("n", "<S-h>", ":bprevious<CR>")
-- keymap("n", "ga", ":b#<CR>zz", { desc = "Last buffer" })
keymap("n", "ga", "<cmd>e#<cr>zz", { desc = "Reopen buffer" })
-- keymap("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
-- keymap("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
--: }}}

--: Close current buffer {{{
keyset("n", "<leader>x", function()
  if vim.bo.filetype == "gitcommit" then
    vim.cmd("bdelete")
  else
    require("snacks").bufdelete()
  end
end, { desc = "Close (delete) Buffer" })
keymap("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete Buffer and Window" })
keymap("n", "<leader>bD", ":Bdelete!<CR>", { desc = "Force Close Buffer!" })
--: }}}
-- wipeout current buffer
keymap("n", "<leader>bw", ":bwipeout<CR>", { desc = "Wipeout Buffer" })
keyset("n", "<leader>bo", function()
  require("utils").close_all_bufs({ close_current = false })
end, { desc = "Close all buffers" })
--: }}}

--: tabs {{{
keymap("n", "<leader><tab>d", ":tabclose<cr>", { desc = "Close tab" })
keymap("n", "<leader><tab>q", ":tabclose<cr>", { desc = "Close tab" })
keymap("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
keymap("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
keymap("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
keymap("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
keymap("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
--: }}}

--: toggle line numbers {{{
keyset("n", "<leader>tl", function()
  vim.cmd([[
    set invnumber
    set invrelativenumber
    set invcursorline
    ]])
end, { desc = "Toggle Line Numbers" })
--: }}}

--: search for word under cursor and stays there {{{
-- searches exact word (* forward, # backwards)
keymap("n", "*", "*N")
keymap("n", "#", "#N")
-- searches but not the exact word (* forward, # backwards)
keymap("n", "g*", "g*N", { desc = "Search not exact" })
keymap("n", "g#", "g#N", { desc = "BckSearch not exact" })
--: }}}

--: select line without end of line {{{
keymap("n", ",a", "^v$h", { desc = "Select line-no-end" })
keymap("n", "g;", "^v$h", { desc = "Select line-no-end" })
--: }}}

--: paste register for printing (JavaScript) {{{
keymap("n", ",d", 'oconsole.log("<esc>pa")<esc>', { desc = "Paste for printing - JS" })
keymap("n", ",D", 'Oconsole.log("<esc>pa")<esc>', { desc = "Paste for printing - JS" })
--: }}}

--: Paste register for informative printing {{{
keymap("n", ",s", 'a"<esc>pa:", <esc>p', { desc = "Paste for info printing" })
--: }}}

--: toggle wrapping lines {{{
keymap("n", "<leader>tw", "<cmd>set wrap!<cr>", { desc = "Line wrap" })
--: }}}

--: center when scrolling page down and up {{{
keymap("n", "<c-d>", "<c-d>zz")
keymap("n", "<c-u>", "<c-u>zz")
--: }}}

--: center around next search result {{{
keyset("n", "n", "nzzzv")
keyset("n", "N", "Nzzzv")
--: }}}

--: set current file's directory as working directory {{{
-- keymap("n", "<leader>cd", "<cmd>cd %:p:h<CR>", { desc = "Set directory as wd" })
--: }}}

--: Better window navigation {{{
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-z>", "<C-w>l")

-- smart window cycle with c-t {{{
local function is_tree_window()
  local buftype = vim.bo.buftype
  local filetype = vim.bo.filetype
  return buftype == "nofile" and (filetype == "neo-tree" or filetype == "NvimTree")
end

keyset({ "n", "t" }, "<C-t>", function()
  if vim.b.is_zoomed then
    vim.b.is_zoomed = false
    vim.api.nvim_call_function("execute", { vim.w.original_window_layout })
    vim.cmd("wincmd w")
  else
    vim.cmd("wincmd w")
    if is_tree_window() then
      vim.cmd("wincmd w")
    end
  end
end, { desc = "Smart window cycle" })
--: }}}

--: Resize windows with arrows {{{
keymap("n", "<C-Up>", ":resize -2<CR>")
keymap("n", "<C-Down>", ":resize +2<CR>")
keymap("n", "<C-Left>", ":vertical resize -2<CR>")
keymap("n", "<C-Right>", ":vertical resize +2<CR>")
--: }}}

--: Clear search highlight {{{
keymap(
  "n",
  "<leader>tr",
  "<cmd>nohlsearch|diffupdate|normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" }
)
keymap("n", "<esc>", "<esc><cmd>noh<cr><cmd>redrawstatus<cr><cmd>echon ''<cr>", { desc = "No highlight escape" })
--: }}}

--: home row goto end and start of line (same as in Helix editor) {{{
keyset({ "n", "v", "o" }, "gk", "0", { desc = "Go to start of line" })
keyset({ "n", "v", "o" }, "gh", "^", { desc = "Go to beginning of line" })
keyset({ "n", "o" }, "gl", "$", { desc = "Go to end of line" })
keyset("v", "gl", "$h", { desc = "Select to end of line" })
--: }}}

--: Stay in indent mode {{{
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")
--: }}}

--: Comment {{{
-- toggle comment in normal mode
keyset("n", "<C-c>", function()
  return vim.v.count == 0 and "<Plug>(comment_toggle_linewise_current)" or "<Plug>(comment_toggle_linewise_count)"
end, { expr = true, desc = "Comment line" })
keyset("n", "<C-b>", "<Plug>(comment_toggle_blockwise_current)")

-- toggle comment using C-/
-- keyset("n", "<C-_>", function()
--     return vim.v.count == 0 and "<Plug>(comment_toggle_linewise_current)" or "<Plug>(comment_toggle_linewise_count)"
-- end, { expr = true })
-- vim.keymap.set("x", "<C-_>", "<Plug>(comment_toggle_linewise_visual)")

-- toggle comment in visual mode
keyset("x", "<C-c>", "<Plug>(comment_toggle_linewise_visual)", { desc = "Comment line(s)" })
keyset("x", "<C-b>", "<Plug>(comment_toggle_blockwise_visual)", { desc = "Comment block" })
--: }}}

--: Duplicate and comment selection {{{
keymap("v", "gy", ":t'><cr>gvgcgv<esc>", { noremap = false, desc = "Duplicate and comment" })
--: }}}

--: Move text up and down {{{
-- keymap("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
-- keymap("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
-- keymap("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line down" })
-- keymap("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up" })
-- keymap("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move line down" })
-- keymap("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move line up" })
--: }}}

--: diagnostics {{{
-- souce: https://github.com/LazyVim/LazyVim
local diagnostic_goto = function(next, severity)
  local go = vim.diagnostic.jump
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    local count = next and 1 or -1
    go({ count = count, float = true, severity = severity })
  end
end
keyset("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
keyset("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
keyset("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
keyset("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
keyset("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
keyset("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
keyset("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })
--: }}}

--: paste and replace selection {{{
keymap("v", "p", '"_dP')
--: }}}

--: search for highlighted text {{{
keymap("v", "*", "y/\\V<C-R>=escape(@\",'/')<CR><CR>N", { desc = "Search selection" })
keymap("v", "g*", "y/\\V\\C<C-R>=escape(@\",'/')<CR><CR>N", { desc = "Search selection (case sensitive)" })
--: }}}

--: substitute word previously searched {{{
-- on selection only
keymap("v", "<leader>R", ":s///g<LEFT><LEFT>", { desc = "Replace search" })
-- on entire buffer
keymap("n", "<leader>R", ":%s///g<LEFT><LEFT>", { desc = "Replace search" })
-- substitute current word
keyset("n", "<leader>X", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Substitute current word" })
keyset("v", "<leader>X", [[y:%s/<C-r>0/<C-r>0/gI<Left><Left><Left>]], { desc = "Substitute selection" })
--: }}}

--: Explorer (netrw) {{{
-- keymap("n", "<leader>oe", ":Explor<cr>", { desc = "Netrw" })
--: }}}

--: Quickfix and location list {{{
keyset("n", "[q", "<cmd>cprev<cr>zvzz", { desc = "Previous quickfix item" })
keyset("n", "]q", "<cmd>cnext<cr>zvzz", { desc = "Next quickfix item" })
keyset("n", "[l", "<cmd>lprev<cr>zvzz", { desc = "Previous loclist item" })
keyset("n", "]l", "<cmd>lnext<cr>zvzz", { desc = "Next loclist item" })
keyset("n", "<C-q>", function()
  local qf_exists = false
  local loc_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_exists = true
    elseif win["loclist"] == 1 then
      loc_exists = true
    end
  end
  if qf_exists or loc_exists then
    vim.cmd("cclose")
    vim.cmd("lclose")
  else
    if vim.fn.getloclist(0, { size = 0 }).size > 0 then
      vim.cmd("lopen 10")
    elseif vim.fn.getqflist({ size = 0 }).size > 0 then
      vim.cmd("copen 10")
    else
      vim.cmd("copen 10")
    end
  end
end, { desc = "Toggle quickfix/location list" })
--: }}}

--: Replace the easy-clip plugin {{{
-- keyset({ "n", "v", "o" }, "<leader>p", '"+p', { desc = "Paste from clipboard" })
-- keyset({ "n", "v", "o" }, "<leader>P", '"+P', { desc = "Paste from clipboard" })
-- keyset({ "n", "v", "o" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })
-- keymap("n", "<leader>Y", '"+Y', { noremap = false, desc = "Yank to clipboard line-end" })
keymap("x", "p", '"_dP')
keymap("n", "d", '"_d')
keymap("n", "D", '"_D')
keymap("v", "d", '"_d')
keyset("n", "gm", "m", { desc = "Add mark" })
keymap("", "m", "d")
keymap("", "M", "D")
-- keymap("", "<leader>m", '"+d', { desc = "Cut to clipboard" })
keymap("n", "x", '"_x')
keymap("n", "X", '"_X')
keyset({ "n", "x", "o" }, "c", '"_c')
keymap("n", "cc", '"_cc')
keymap("n", "cl", '"_cl')
keymap("n", "ce", '"_ce')
keymap("n", "ci", '"_ci')
keymap("n", "C", '"_C')
keymap("v", "x", '"_x')
-- keymap("v", "c", '"_c')
--: }}}

--: Other mappings {{{
keyset("n", "<leader>ol", "<cmd>:Lazy<cr>", { desc = "Lazy Dashboard" })
keyset("n", "<leader>op", "<cmd>e#<cr>", { desc = "Reopen buffer" })
--: }}}

--: Transpose {{{
keymap("n", ",t", '"zx"zph', { desc = "Transpose/Swap characters" })
keymap("n", ",w", '"zdiwxea<space><esc>"zpbb', { desc = "Transpose/Swap words" })
--: }}}

--: Add undo break-points {{{
keymap("i", ",", ",<c-g>u")
keymap("i", ".", ".<c-g>u")
keymap("i", ";", ";<c-g>u")
keymap("i", "<Space>", "<Space><c-g>u")
--: }}}

--: Move cursor around {{{
vim.keymap.set({ "n", "i", "v" }, "<C-l>", function()
  -- insert mode is defined in the nvim-cmp config
  cursorMoveAround()
end, { desc = "Move Around Cursor" })
--: }}}

--: Maximize window {{{
vim.b.is_zoomed = false
vim.w.original_window_layout = {}

local function toggle_maximize_buffer()
  if not vim.b.is_zoomed then
    -- Save the current window layout
    vim.w.original_window_layout = vim.api.nvim_call_function("winrestcmd", {})
    -- Maximize the current window
    vim.cmd("wincmd _")
    vim.cmd("wincmd |")
    vim.b.is_zoomed = true
  else
    -- Restore the previous window layout
    vim.api.nvim_call_function("execute", { vim.w.original_window_layout })
    vim.b.is_zoomed = false
  end
end
keyset({ "n", "t" }, "<A-,>", toggle_maximize_buffer, { desc = "Maximize buffer" })
--: }}}

--: Fold {{{
keyset("n", "z0", ":set foldlevel=0<cr>", { desc = "Fold level 0" })
keyset("n", "z1", ":set foldlevel=1<cr>", { desc = "Fold level 1" })
keyset("n", "z2", ":set foldlevel=2<cr>", { desc = "Fold level 2" })
keyset("n", "z3", ":set foldlevel=3<cr>", { desc = "Fold level 3" })
keyset("n", "z9", ":set foldlevel=99<cr>", { desc = "Fold level 99" })
keyset("n", "<leader>fi", ":set foldmethod=indent<cr>", { desc = "Set fold indent" })
keyset("n", "<leader>fm", ":set foldmethod=marker<cr>", { desc = "Set fold marker" })
keyset(
  "n",
  "<leader>fx",
  ":set foldmethod=expr<cr>:set foldexpr=nvim_treesitter#foldexpr()<cr>",
  { desc = "Set fold treesitter" }
)
keyset("n", "zm", ":set foldmethod=marker<cr>:set foldlevel=0<cr>", { desc = "Set fold marker" })
--: }}}

--: Diff selection agains clipboard {{{
-- layout: selection<->clipboard
local function compare_to_clipboard()
  local ftype = vim.api.nvim_eval("&filetype")
  vim.cmd(string.format(
    [[
    execute "normal! \"xy"
    vsplit
    enew
    normal! P
    setlocal buftype=nowrite
    set filetype=%s
    diffthis
    execute "normal! \<C-w>\<C-w>"
    enew
    set filetype=%s
    normal! "xP
    diffthis
  ]],
    ftype,
    ftype
  ))
end
keyset("x", "<Space>D", compare_to_clipboard, { desc = "Compare to clipboard" })
--: }}}

--: Utility mappings {{{
keyset("n", "<space>y", "<cmd>let @+ = expand('%:p')<CR>")
keyset("n", "<C-P>", function()
  local peek = require("utils").lazy_require("peek")
  peek().peek_definition()
end, { desc = "Peek Definition" })
keyset("n", ",d", function()
  local peek = require("utils").lazy_require("peek")
  peek().peek_diagnostics()
end, { desc = "Peek Diagnostics" })
keyset("n", ",f", function()
  local peek = require("utils").lazy_require("peek")
  peek().peek_symbols("Function")
end, { desc = "Peek Functions" })
keyset("n", "<leader>nn", require("zk").new_note, { desc = "ZK - Create New Note" })
keyset("n", "<leader>qs", require("sessions").load_session, { desc = "Session - Load" })
--: }}}

--: Delete default mappings {{{
-- vim.kezmap.del({ "n" }, "crn")
-- vim.keymap.del({ "n", "v" }, "crr")
-- vim.keymap.del({ "n" }, "grr")
-- vim.keymap.del({ "n" }, "grt")
-- vim.keymap.del({ "n" }, "grn")
-- vim.keymap.del({ "n" }, "gri")
-- vim.keymap.del({ "n", "x" }, "gra")
--: }}}
