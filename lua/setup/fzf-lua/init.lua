-- config for 'ibhagwan/fzf-lua': fzf.vim written in lua for neovim

-- setup
require("fzf-lua").setup({
	winopts = {
		height = 0.4,
		width = 0.8,
		-- row = 0.2,
		preview = {
			-- vertical = "up:30%",
			vertical = "right:50%",
			flip_columns = 170,
			delay = 60,
			scrollbar = false,
			hidden = "hidden",
		},
	},
	fzf_opts = {
		-- ["--layout"] = "default",
		["--layout"] = "reverse",
		-- ["--pointer"] = "\xc2\xa0",
	},
	fzf_colors = {
		["fg"] = { "fg", "CursorLine" },
		["bg"] = { "bg", "Normal" },
		["hl"] = { "fg", "Comment" },
		-- ["fg+"] = { "fg", "ModeMsg" },
		["fg+"] = { "fg", "Normal" },
		["bg+"] = { "bg", "CursorLine" },
		["hl+"] = { "fg", "Statement" },
		["info"] = { "fg", "PreProc" },
		["prompt"] = { "fg", "Conditional" },
		["pointer"] = { "fg", "Exception" },
		["marker"] = { "fg", "Keyword" },
		["spinner"] = { "fg", "Label" },
		["header"] = { "fg", "Comment" },
		["gutter"] = { "bg", "Normal" },
	},
	files = {
		cmd = "rg --files --hidden --follow --no-ignore -g '!.git/*' -g '!node_modules'",
	},
	keymap = {
		builtin = {
			["<C-L>"] = "toggle-preview",
			["<S-down>"] = "preview-page-down",
			["<S-up>"] = "preview-page-up",
		},
	},
	-- needed for kitty for better icon rendering
	file_icon_padding = " ",
	nbsp = "\xc2\xa0",
})

-- mappings
local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap

-- map("n", "<leader>l", "<cmd>lua require('fzf-lua').resume()<CR>", opts)
-- map("n", "<C-P>", "<cmd>lua require('fzf-lua').files()<CR>", opts)
-- map("n", "<leader>ff", "<cmd>lua require('fzf-lua').files()<CR>", opts)
-- map("n", "<C-T>", "<cmd>lua require('fzf-lua').oldfiles()<CR>", opts)
-- map("n", "<C-B>", "<cmd>lua require('fzf-lua').buffers()<CR>", opts)
map("n", "<leader>ol", "<cmd>lua require('fzf-lua').blines()<CR>", opts)
map("n", "<leader>oa", "<cmd>lua require('fzf-lua').lines()<CR>", opts)
-- map("n", "<leader>r", "<cmd>lua require('fzf-lua').grep_project()<CR>", opts)
-- map("n", "<leader>gs", "<cmd>lua require('fzf-lua').git_status()<CR>", opts)
-- map("n", "<leader>cc", "<cmd>lcd ~/.config/nvim | lua require('fzf-lua').files()<cr>", opts)

-- sets workdir in current window
map("n", "<leader><tab>", "<cmd>lua require('setup.fzf-lua.commands').workdirs()<CR>", opts)
-- sets workdit in new tab
map("n", "<leader>t", "<cmd>lua require('setup.fzf-lua.commands').workdirs(true)<CR>", opts)
