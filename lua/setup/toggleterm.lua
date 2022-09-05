-- "akinsho/toggleterm.nvim"

local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

toggleterm.setup({
	-- size = 25,
	size = function(term)
		if term.direction == "horizontal" then
			return 17
		elseif term.direction == "vertical" then
			return vim.o.columns * 0.4
		end
	end,
	open_mapping = [[<M-\>]],
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
		width = math.min(math.ceil(vim.fn.winwidth(0) * 0.8), 120),
		height = math.min(math.ceil(vim.fn.winheight(0) * 0.8), 28),
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
vim.api.nvim_create_user_command("GitUI", function()
	if os.getenv("TERM_PROGRAM") == "tmux" then
		vim.cmd("execute 'silent !tmux split-window -v -p 70 gitui'")
	else
		gitui:toggle()
	end
end, {})

-- :Lazygit
vim.api.nvim_create_user_command("LazyGit", function()
	if os.getenv("TERM_PROGRAM") == "tmux" then
		vim.cmd("execute 'silent !tmux split-window -v -p 70 lazygit'")
	else
		lazygit:toggle()
	end
end, {})

-- vim.api.nvim_set_keymap("n", "<leader>gi", ":GitUI<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>gl", ":LazyGit<cr>", { noremap = true, silent = true })

-- function _G.set_terminal_keymaps()
-- 	local opts = { buffer = 0 }
-- 	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
-- 	vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
-- 	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
-- 	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
-- 	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
-- 	vim.keymap.set("t", "<C-;>", [[<Cmd>wincmd l<CR>]], opts)
-- end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
-- vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
-- vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")
