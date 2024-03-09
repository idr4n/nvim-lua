local opt = vim.opt

opt.autoindent = true
opt.autowrite = true -- saves buffer when changing files
opt.autoread = true -- Always reload buffer when external changes detected
opt.backspace = { "indent", "eol", "start" } -- Enable backspace
opt.backup = false -- creates a backup file
opt.breakindent = true -- Every wrapped line will continue visually indented
-- opt.colorcolumn = "80"
-- opt.clipboard = "" -- don't use system clipboard by default
opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
opt.cmdheight = 1
opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
opt.conceallevel = 1 -- hide some markup such as `` and * in markdown files
-- opt.concealcursor = "nc" -- conceal in normal/command mode (not in insert/visual)
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- highlight the current line
opt.expandtab = true -- convert tabs to spaces
-- opt.foldcolumn = "1"
-- opt.foldmethod = "marker"
-- opt.guicursor = "" -- no thin cursor on insert mode
opt.hlsearch = true -- highlight all matches on previous search pattern
opt.incsearch = true
opt.ignorecase = true -- ignore case in search patterns
opt.laststatus = 3 -- global statusline
opt.linebreak = true -- Break lines in spaces not in the middle of a word
opt.list = true -- Show some invisible characters (tabs...
opt.mouse = "a" -- allow the mouse to be used in neovim
opt.number = true -- set numbered lines
opt.pumheight = 10 -- pop up menu height
opt.relativenumber = true -- set relative numbered lines
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.scrolloff = 8 -- Lines of context
opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
-- opt.showbreak = "↪ "
opt.showmode = false -- Don't show mode
opt.showtabline = 2 -- always show the tabline
opt.sidescrolloff = 8 -- the same as scrolloff but horizontally
opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
opt.smartcase = true -- smart case
opt.smartindent = true -- make indenting smarter again
opt.splitbelow = true -- force all horizontal splits to go below current window
opt.splitright = true -- force all vertical splits to go to the right of current window
opt.swapfile = false -- creates a swapfile
opt.tabstop = 2 -- insert 4 spaces for a tab
opt.termguicolors = true -- set term gui colors (most terminals support this)
opt.undofile = true -- enable persistent undo
opt.updatetime = 300 -- control CursorHold event waiting time (4000ms default)
opt.wrap = false -- display lines as one long line
opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.nrformats:append("alpha") -- increments letters sequences as well with <c-a>

-- statuscolumn
opt.statuscolumn = [[%!v:lua.require'utils'.statuscolumn()]]

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])

-- fill and list chars
-- vim.o.fillchars = [[msgsep: ,eob: ,horiz: ,vert: ,diff:╱,fold: ,foldopen:,foldsep: ,foldclose:,]]
-- vim.o.fillchars = [[msgsep: ,eob: ,diff:╱,fold: ,foldopen:,foldclose:,]]
-- vim.o.fillchars = [[msgsep: ,eob: ,vert: ,diff:╱,fold: ,foldopen:,foldsep: ,foldclose:,]]
vim.o.listchars = [[tab:──,trail:·,nbsp:␣,precedes:«,extends:»,]]
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

if vim.fn.has("nvim-0.10") == 1 then
  opt.smoothscroll = true
end

-- Highlight on Yank
vim.cmd([[
  augroup highlight_yank
  autocmd!
  " au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=400, on_visual=false}
  au TextYankPost * silent! lua vim.highlight.on_yank {timeout=70}
  augroup END
]])

if vim.fn.exists(vim.g.neovide) then
  vim.opt.guifont = { "FiraCode Nerd Font", ":h16" }
  vim.g.neovide_transparency = 0.0
  vim.g.transparency = 0.97
  vim.g.transparency = 1
  vim.g.neovide_background_color = "#000000" .. vim.fn.printf("%x", vim.fn.float2nr(255 * vim.g.transparency))
  vim.g.neovide_input_macos_alt_is_meta = true
end

-- Explorer (netrw)
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 1
vim.g.netrw_winsize = 25
vim.g.netrw_fastbrowse = 0
vim.g.netrw_bufsettings = "noma nomod nu nowrap ro nobl"
