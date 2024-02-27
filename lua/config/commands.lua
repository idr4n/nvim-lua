-- Own commands

-- Shorten function name
local command = vim.api.nvim_create_user_command
local opts = { noremap = true, silent = true }
local keymap = function(mode, keys, cmd, options)
  options = options or {}
  options = vim.tbl_deep_extend("force", opts, options)
  vim.api.nvim_set_keymap(mode, keys, cmd, options)
end

-- :SublimeMerge
command("SublimeMerge", function()
  vim.cmd("execute 'silent !smerge pwd'")
end, {})

keymap("n", "<leader>oS", ":SublimeMerge<cr>", { desc = "SublimeMerge" })

-- Open markdown file in Marked 2
command("OpenMarked2", "execute 'silent !open -a Marked\\ 2 \"%\"'", {})

-- Open markdown in Deckset
command("OpenDeckset", "execute 'silent !open -a Deckset \"%\"'", {})

-- Convert markdown file to pdf using pandoc
command("MdToPdf", 'execute \'silent !pandoc "%" -o "%:r.pdf"\'', {})

-- Convert markdown file to Beamer presentation using pandoc
command("MdToBeamer", 'execute \'silent !pandoc "%" -t beamer -o "%:r.pdf"\'', {})

-- Reveal file in finder without changing the working dir in vim
command("RevealInFinder", "execute 'silent !open -R \"%\"'", {})
keymap("n", "<leader>;", ":RevealInFinder<cr>", { desc = "Reveal in finder" })

-- Code Run Script
command("CodeRun", function()
  require("noice").redirect("execute '!~/scripts/code_run \"%\"'")
end, {})
keymap("n", "<leader>cr", ":CodeRun<cr>", { desc = "Run code - own script" })

-- yank line after dash (-), i.e., bullet point in markdown without the bullet and the X
command("YankBullet", "execute '.g/- \\(X\\s\\)\\?\\zs.*$/normal \"+ygn'", {})
keymap("n", ",b", ":YankBullet<cr>", { desc = "Yank line no bullet" })

-- toggle charcode in statusline
command("CharcodeToggle", function()
  _G.charcode = not _G.charcode
  vim.cmd("redrawstatus!")
end, {})
keymap("n", "<leader>tc", ":CharcodeToggle<cr>", { desc = "Charcode" })

-- toggle more in the SimpleStatusline
vim.api.nvim_create_user_command("StatusMoreInfo", function()
  _G.show_more_info = not _G.show_more_info
  -- vim.g.show_more_info = not vim.g.show_more_info
  vim.cmd("redrawstatus!")
end, {})
keymap("n", "<leader>ti", ":StatusMoreInfo<cr>", { desc = "Status more info" })

-- Autocommands

-- Autospelling and zen mode for tex and md files
vim.api.nvim_create_augroup("tex-md_group", { clear = true })
vim.api.nvim_create_autocmd("BufRead", {
  pattern = { "*.tex", "*.md", "*.typ" },
  callback = function()
    vim.cmd("setlocal spell spelllang=en_us")
    -- vim.cmd("ZenMode")
  end,
  group = "tex-md_group",
})

-- Indent four spaces
-- vim.api.nvim_create_augroup("indent_4", { clear = true })
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = {
-- 		"sql",
-- 		"go",
-- 		"markdown",
-- 		"javascript",
-- 		"javascriptreact",
-- 		"typescript",
-- 		"typescriptreact",
-- 	},
-- 	command = "setlocal shiftwidth=4 tabstop=4",
-- 	group = "indent_4",
-- })

vim.api.nvim_create_augroup("no_wrap", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sql" },
  command = "set nowrap",
  group = "no_wrap",
})

-- Golang
vim.api.nvim_create_augroup("golang", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.tmpl", "*.gohtml" },
  command = "set filetype=html",
  group = "golang",
})

-- Typst
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.typ" },
  command = "set filetype=typst",
  group = vim.api.nvim_create_augroup("typst", { clear = true }),
})

-- SQL
vim.api.nvim_create_augroup("sql", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sql" },
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", ",e", ":SqlsExecuteQuery<cr>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "v", ",e", ":SqlsExecuteQuery<cr>", { noremap = true, silent = true })
  end,
  group = "sql",
})

-- Netrw
vim.api.nvim_create_augroup("Netrw", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "netrw" },
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "h", "-", { silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "l", "<CR>", { silent = true })
  end,
  group = "Netrw",
})

-- format on save for specific files
vim.api.nvim_create_augroup("LspFormatting", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.go", "*.lua" },
  callback = function()
    vim.lsp.buf.format()
  end,
  group = "LspFormatting",
})

-- -- Alpha
-- vim.api.nvim_create_augroup("alpha", { clear = true })
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = { "alpha" },
--     command = "nnoremap <silent> <buffer> - :bwipe <Bar> Dirvish<CR>",
--     group = "alpha",
-- })

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Redraw statusline on different events
vim.api.nvim_create_autocmd("DiagnosticChanged", {
  group = vim.api.nvim_create_augroup("Status_Diagnostics", { clear = true }),
  callback = vim.schedule_wrap(function()
    vim.cmd("redrawstatus")
    vim.cmd("redrawtabline")
  end),
})
vim.api.nvim_create_autocmd("User", {
  group = vim.api.nvim_create_augroup("Status_GitUpdate", { clear = true }),
  pattern = "GitSignsUpdate",
  callback = vim.schedule_wrap(function()
    vim.cmd("redrawstatus")
  end),
})

-- Wrap text for some markdown files and others
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("md-tex-aucmd", { clear = true }),
  pattern = { "markdown", "tex", "typst" },
  callback = function()
    vim.cmd("setlocal wrap")
  end,
})

-- Other Commands
command("YankCwd", function()
  local cwd = vim.fn.getcwd()
  vim.cmd(string.format("call setreg('*', '%s')", cwd))
  print("Cwd copied to clipboard!")
end, {})
keymap("n", "<leader>cp", "<cmd>YankCwd<cr>", { desc = "Yank current dir" })

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

  if cwd == vim.fn.expand("$HOME") then
    return
  end

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
  local new_dirs_str_txt = vim.inspect(dirs):gsub("{ ", ""):gsub("}", ""):gsub(", ", "\n"):gsub('"', "")

  local path = vim.env.HOME .. "/.config/nvim/lua/workdirs.lua"
  local path_txt = vim.env.HOME .. "/.config/nvim/lua/workdirs.txt"
  writeFileSync(path, "return " .. new_dirs_str)
  writeFileSync(path_txt, new_dirs_str_txt)
end

command("SaveDir", saveDir, {})

vim.api.nvim_create_augroup("OnVimEnter", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = { "*" },
  callback = function()
    -- printDir()
    saveDir()
  end,
  group = "OnVimEnter",
})

-- open same file in nvim in a new pane
vim.api.nvim_create_user_command("NewTmuxNvim", function()
  if os.getenv("TERM_PROGRAM") == "tmux" and vim.fn.expand("%"):len() > 0 then
    -- vim.cmd("execute 'silent !tmux new-window nvim %'")
    vim.cmd("execute 'silent !tmux split-window -h nvim %'")
  else
    print("Nothing to open...")
  end
end, {})
keymap("n", "<leader>on", "<cmd>NewTmuxNvim<cr>", { desc = "Same file in TMUX window" })

-- new (tmux or terminal) window at current working directory
command("NewTerminalWindow", function()
  -- local cwd = vim.fn.getcwd()
  -- local cmd = {
  -- 	alacritty = "open -na alacritty --args --working-directory %s'",
  -- 	wezterm = "wezterm start --always-new-process --cwd %s'",
  -- 	["xterm-kitty"] = "open -na kitty --args -d %s'",
  -- }
  -- vim.cmd(string.format("execute 'silent !" .. cmd[vim.env.TERM], cwd))
  -- vim.cmd(string.format("execute 'silent !open -na alacritty --args --working-directory %s'", cwd))
  vim.cmd(string.format(
    -- "execute 'silent !open -na wezterm --args --config initial_rows=40 --config initial_cols=160 start lf %s'",
    -- cwd
    "execute 'silent !open -na wezterm --args --config initial_rows=40 --config initial_cols=160 start lf \"%s\"'",
    vim.fn.expand("%:p")
  ))
end, {})
keymap("n", "<leader>\\", "<cmd>NewTerminalWindow<cr>", { desc = "Open LF Ext-Window" })
