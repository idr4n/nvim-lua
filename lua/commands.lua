-- Own commands

-- Shorten function name
local command = vim.api.nvim_add_user_command
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- :SublimeMerge
command("SublimeMerge", function()
	vim.cmd("execute 'silent !smerge pwd'")
end, {})

keymap("n", "<leader>om", ":SublimeMerge<cr>", { noremap = true, silent = true })

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
vim.cmd([[
  augroup spell_tex_md
    autocmd!
    autocmd FileType tex setlocal spell spelllang=en_us
    autocmd FileType markdown setlocal spell spelllang=en_us
    " autocmd FileType markdown setlocal nonumber nocursorline
  augroup END
]])


local function printDir()
  local dir = vim.fn.getcwd()
  print(string.format("Directory: %s", dir))
  -- print("Directory: "..dir..". Vim did enter: "..vim.v.vim_did_enter)
end

local function writeFileSync(path, data)
  local uv = require("luv")
  local fd = assert(uv.fs_open(path, "w", -1))
  uv.fs_write(fd, data.."\n", nil, function(_)
    uv.fs_close(fd)
  end)
end

local function saveDir()
  local cwd = vim.fn.getcwd()

  local ok
  ok, _G.dirs = pcall(require, "workdirs")
  if not ok then
    _G.dirs = {}
  end

  for _, dir in ipairs(_G.dirs) do
    if dir == cwd then
      return
    end
  end

  table.insert(_G.dirs, cwd)
  table.sort(_G.dirs)

  local new_dirs_str = vim.inspect(_G.dirs):gsub(" ", "\n\t")

  local path = vim.env.HOME.."/.config/nvim/lua/workdirs.lua"
  writeFileSync(path, "return " .. new_dirs_str)
end

local function onVimEnter()
  printDir()
  saveDir()
end

vim.api.nvim_create_augroup("OnVimEnter", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = {"*"},
  callback = onVimEnter,
  group = "OnVimEnter",
})
