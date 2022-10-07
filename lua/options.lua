local options = {
	autoindent = true,
	autowrite = true, -- saves buffer when changing files
	autoread = true, -- Always reload buffer when external changes detected
	backspace = { "indent", "eol", "start" }, -- Enable backspace
	backup = false, -- creates a backup file
	breakindent = true, -- Every wrapped line will continue visually indented
	clipboard = "", -- allows neovim to access the system clipboard
	-- clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	cmdheight = 1, -- more space in the neovim command line for displaying messages
	completeopt = { "menuone", "noselect" }, -- mostly just for cmp
	conceallevel = 0, -- so that `` is visible in markdown files
	-- concealcursor = "nc", -- conceal in normal/command mode (not in insert/visual)
	cursorline = true, -- highlight the current line
	expandtab = true, -- convert tabs to spaces
	fileencoding = "utf-8", -- the encoding written to a file
	guifont = "monospace:h17", -- the font used in graphical neovim applications
	hlsearch = false, -- highlight all matches on previous search pattern
	incsearch = true,
	ignorecase = true, -- ignore case in search patterns
	linebreak = true, -- Break lines in spaces not in the middle of a word
	mouse = "a", -- allow the mouse to be used in neovim
	number = true, -- set numbered lines
	-- numberwidth = 4,                         -- set number column width to 2 {default 4}
	pumheight = 10, -- pop up menu height
	relativenumber = true, -- set relative numbered lines
	scrolloff = 8, -- is one of my fav
	shiftwidth = 2, -- the number of spaces inserted for each indentation
	showmode = false, -- we don't need to see things like -- INSERT -- anymore
	-- showtabline = 2,                         -- always show tabs
	sidescrolloff = 8, -- the same as scrolloff but horizontally
	signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
	smartcase = true, -- smart case
	smartindent = true, -- make indenting smarter again
	splitbelow = true, -- force all horizontal splits to go below current window
	splitright = true, -- force all vertical splits to go to the right of current window
	swapfile = false, -- creates a swapfile
	tabstop = 2, -- insert 2 spaces for a tab
	termguicolors = true, -- set term gui colors (most terminals support this)
	-- timeoutlen = 100,                        -- time to wait for a mapped sequence to complete (in milliseconds)
	undofile = true, -- enable persistent undo
	updatetime = 300, -- control CursorHold event waiting time (4000ms default)
	wrap = true, -- display lines as one long line
	writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
}

vim.opt.shortmess:append("c")
vim.opt.nrformats:append("alpha") -- increments letters sequences as well with <c-a>

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])

-- Format
vim.cmd([[
  augroup Format
    autocmd!
    " don't add comment in new line
    " au FileType * set fo-=o fo-=r
		au FileType * set fo-=o
    " global statusline at the bottom instead of one for each window
    au BufNewFile,BufRead * set laststatus=3 
  augroup END
]])

-- Highlight on Yank
vim.cmd([[
  augroup highlight_yank
  autocmd!
  " au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=400, on_visual=false}
  au TextYankPost * silent! lua vim.highlight.on_yank {timeout=100}
  augroup END
]])

-- Statusline
vim.o.statusline = "%f %{&modified?'●':''}%r%h %= %l,%c     %{fnamemodify(getcwd(), ':p:h:t')}   %3.3p%%"

-- Explorer (netrw)
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_fastbrowse = 0
