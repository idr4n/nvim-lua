-- "akinsho/toggleterm.nvim"

local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

toggleterm.setup({
	size = 25,
	open_mapping = [[<C-\>]],
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = false,
	persist_size = true,
	direction = "float",
	-- direction = "horizontal",
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		height = 25,
		border = "curved",
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
})

local opts = { height = math.floor(vim.fn.winheight(0) * 0.85) }

local Terminal = require("toggleterm.terminal").Terminal
local gitui = Terminal:new({ cmd = "gitui", hidden = true, float_opts = opts })
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, float_opts = opts })

-- :GitUI
vim.api.nvim_add_user_command("GitUI", function()
	if os.getenv("TERM_PROGRAM") == "tmux" then
		vim.cmd("execute 'silent !tmux split-window -v -p 70 gitui'")
	else
		gitui:toggle()
	end
end, {})

-- :Lazygit
vim.api.nvim_add_user_command("LazyGit", function()
	if os.getenv("TERM_PROGRAM") == "tmux" then
		vim.cmd("execute 'silent !tmux split-window -v -p 70 lazygit'")
	else
		lazygit:toggle()
	end
end, {})

vim.api.nvim_set_keymap("n", "<leader>gi", ":GitUI<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>gl", ":LazyGit<cr>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap(
-- 	"n",
-- 	"<leader>cr",
-- 	":TermExec cmd='clear && ~/scripts/code_run \"%\"'<cr>",
-- 	{ noremap = true, silent = true }
-- )
