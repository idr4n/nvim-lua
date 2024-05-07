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
-- command("MdToPdf", 'execute \'silent !pandoc "%" -o "%:r.pdf"\'', {})
command("MdToPdf", 'execute \'silent !pandoc "%"  --listings -H ~/dotfiles/listings-setup.tex -o "%:r.pdf"\'', {})

-- Convert markdown file to docx using pandoc
command("MdToDocx", 'execute \'silent !pandoc "%" -o "%:r.docx"\'', {})

-- Convert markdown file to Beamer presentation using pandoc
command("MdToBeamer", 'execute \'silent !pandoc "%" -t beamer -o "%:r.pdf"\'', {})

-- Reveal file in finder without changing the working dir in vim
command("RevealInFinder", "execute 'silent !open -R \"%\"'", {})
keymap("n", "<leader>;", ":RevealInFinder<cr>", { desc = "Reveal in finder" })

-- Code Run Script
command("CodeRun", function()
  vim.cmd("execute '!~/scripts/code_run \"%\"'")
  -- require("noice").redirect("execute '!~/scripts/code_run \"%\"'")
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

-- Other Commands
command("YankCwd", function()
  local cwd = vim.fn.getcwd()
  vim.cmd(string.format("call setreg('*', '%s')", cwd))
  print("Cwd copied to clipboard!")
end, {})
keymap("n", "<leader>cp", "<cmd>YankCwd<cr>", { desc = "Yank current dir" })

-- open same file in nvim in a new tmux pane
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

command("OpenGithubRepo", function()
  local mode = vim.api.nvim_get_mode().mode
  local text = ""

  if mode == "v" then
    text = vim.getVisualSelection()
    vim.fn.setreg('"', text) -- yank the selected text
  else
    local node = vim.treesitter.get_node() --[[@as TSNode]]
    -- Get the text of the node
    text = vim.treesitter.get_node_text(node, 0)
  end

  if text:match("^[%w%-%.%_%+]+/[%w%-%.%_%+]+$") == nil then
    local msg = string.format("OpenGithubRepo: '%s' Invalid format. Expected 'foo/bar' format.", text)
    vim.notify(msg, vim.log.levels.ERROR)
    return
  end

  local url = string.format("https://www.github.com/%s", text)
  print("Opening", url)
  vim.ui.open(url)
end, {})
vim.keymap.set({ "n", "v" }, "<leader>og", "<cmd>OpenGithubRepo<cr>", { desc = "Open Github Repo" })
