local options = {
	autoindent = true,
	autowrite = true, -- saves buffer when changing files
	autoread = true, -- Always reload buffer when external changes detected
	backspace = { "indent", "eol", "start" }, -- Enable backspace
	backup = false, -- creates a backup file
	breakindent = true, -- Every wrapped line will continue visually indented
	clipboard = "", -- allows neovim to access the system clipboard
	-- clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	cmdheight = 1,
	completeopt = { "menuone", "noselect" }, -- mostly just for cmp
	conceallevel = 0, -- so that `` is visible in markdown files
	-- concealcursor = "nc", -- conceal in normal/command mode (not in insert/visual)
	cursorline = true, -- highlight the current line
	expandtab = true, -- convert tabs to spaces
	fileencoding = "utf-8", -- the encoding written to a file
	guicursor = "", -- no thin cursor on insert mode
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
	shiftwidth = 4, -- the number of spaces inserted for each indentation
	showmode = true, -- show -- INSERT --
	-- showtabline = 2,                         -- always show tabs
	sidescrolloff = 8, -- the same as scrolloff but horizontally
	signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
	smartcase = true, -- smart case
	smartindent = true, -- make indenting smarter again
	splitbelow = true, -- force all horizontal splits to go below current window
	splitright = true, -- force all vertical splits to go to the right of current window
	swapfile = false, -- creates a swapfile
	tabstop = 4, -- insert 4 spaces for a tab
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
  au TextYankPost * silent! lua vim.highlight.on_yank {timeout=70}
  augroup END
]])

-- Statusline

-- GitChanges = ""
local function getGitChanges()
	local gitsigns = vim.b.gitsigns_status_dict
	-- local git_icon = "   "
	-- local git_icon = "   "
	local git_icon = "   "
	local changes = 0
	local head = ""
	local status = ""
	if gitsigns then
		head = gitsigns.head
		changes = (gitsigns.added or 0) + (gitsigns.changed or 0) + (gitsigns.removed or 0)
	end
	if #head > 0 or changes > 0 then
		status = git_icon
		if head ~= "master" then
			status = string.format("%s%s ", status, head)
		end
		if changes > 0 then
			status = string.format("%s%d", status, changes)
		end
	end
	return string.format("%s  ", status)
end

-- vim.o.statusline = "%f %{&modified?'●':''}%r%h %= %l,%c     %{fnamemodify(getcwd(), ':p:h:t')}   %3.3p%%"

function Status_line()
	local statusline = ""
	statusline = statusline .. "%f %{&modified?'●':''}%r%h"
	-- statusline = statusline .. getGitChanges()
	-- statusline = statusline .. "%= %l,%c     %{fnamemodify(getcwd(), ':p:h:t')}   %3.3p%%"
	statusline = statusline .. "%= %l,%c  "
	statusline = statusline .. getGitChanges()
	statusline = statusline .. "  %{fnamemodify(getcwd(), ':p:h:t')}   %3.3p%%"

	return statusline
end

vim.o.statusline = "%!v:lua.Status_line()"

-- Explorer (netrw)
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_fastbrowse = 0
vim.g.netrw_bufsettings = "noma nomod nu nowrap ro nobl"

