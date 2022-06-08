-- Own commands

-- Shorten function name
local command = vim.api.nvim_create_user_command
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- :SublimeMerge
command("SublimeMerge", function()
	vim.cmd("execute 'silent !smerge pwd'")
end, {})

keymap("n", "<leader>om", ":SublimeMerge<cr>", opts)

-- Open markdown file in Marked 2
command("OpenMarked2", "execute 'silent !open -a Marked\\ 2 \"%\"'", {})

-- Open markdown in Deckset
-- command! OpenDeckset execute 'silent !open -a Deckset "%"'

-- Convert markdown file to pdf using pandoc
command("MdToPdf", 'execute \'silent !pandoc "%" -o "%:r.pdf"\'', {})

-- Convert markdown file to Beamer presentation using pandoc
command("MdToBeamer", 'execute \'silent !pandoc "%" -t beamer -o "%:r.pdf"\'', {})

-- Reveal file in finder without changing the working dir in vim
command("RevealInFinder", "execute 'silent !open -R \"%\"'", {})
keymap("n", "<leader>;", ":RevealInFinder<cr>", opts)

-- Code Run Script
command("CodeRun", "execute '!~/scripts/code_run \"%\"'", {})
keymap("n", "<leader>cr", ":CodeRun<cr>", opts)

-- Autocommands

-- Autospelling for tex and md files
vim.api.nvim_create_augroup("spell_tex_md", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "tex", "markdown" },
	command = "setlocal spell spelllang=en_us",
})

-- Golang
vim.api.nvim_create_augroup("golang", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "go" },
	command = "setlocal shiftwidth=4 tabstop=4",
	group = "golang",
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.tmpl", "*.gohtml" },
	command = "set filetype=html",
	group = "golang",
})

-- format on save for specific files
vim.api.nvim_create_augroup("LspFormatting", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.go", "*.lua" },
	callback = vim.lsp.buf.formatting_sync,
	group = "LspFormatting",
})

-- Lua
vim.api.nvim_create_augroup("lua", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "lua" },
	command = "setlocal shiftwidth=2 tabstop=2 noexpandtab",
	group = "lua",
})

-- Other Commands

local function printDir()
	local dir = vim.fn.getcwd()
	print(string.format("Directory: %s", dir))
	-- print("Directory: "..dir..". Vim did enter: "..vim.v.vim_did_enter)
end

local function writeFileSync(path, data)
	local uv = require("luv")
	local fd = assert(uv.fs_open(path, "w", -1))
	uv.fs_write(fd, data .. "\n", nil, function(_)
		uv.fs_close(fd)
	end)
end

local function readFileSync(path)
	local uv = require("luv")
	local fd = assert(uv.fs_open(path, "r", 438))
	local stat = assert(uv.fs_fstat(fd))
	local data = assert(uv.fs_read(fd, stat.size, 0))
	assert(uv.fs_close(fd))
	return data
end

local function saveDir()
	local cwd = vim.fn.getcwd()

	local ok, dirs = pcall(require, "workdirs")
	if not ok then
		print("couldn't find workdirs")
		local prevData = readFileSync(vim.env.HOME .. "/.config/nvim/lua/workdirs.lua")
		writeFileSync(vim.env.HOME .. "/.config/nvim/lua/workdirs_bk.lua", prevData)
		dirs = {}
	end

	for _, dir in ipairs(dirs) do
		if dir == cwd then
			return
		end
	end

	table.insert(dirs, cwd)
	table.sort(dirs)

	local new_dirs_str = vim.inspect(dirs):gsub(", ", ",\n\t")

	local path = vim.env.HOME .. "/.config/nvim/lua/workdirs.lua"
	writeFileSync(path, "return " .. new_dirs_str)
end

local function onVimEnter()
	printDir()
	saveDir()
end

vim.api.nvim_create_augroup("OnVimEnter", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
	pattern = { "*" },
	callback = onVimEnter,
	group = "OnVimEnter",
})
