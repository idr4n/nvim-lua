-- config for 'ibhagwan/fzf-lua': fzf.vim written in lua for neovim

-- setup
require("fzf-lua").setup({
	winopts = {
		height = 0.4,
		width = 0.9,
		-- row = 0.2,
		preview = {
			vertical = "up:40%",
			horizontal = "right:54%",
			flip_columns = 120,
			delay = 60,
			scrollbar = false,
			hidden = "nohidden",
		},
	},
	winopts_fn = function()
		-- smaller width if neovim win has over 80 columns
		local max_width = 140 / vim.o.columns
		local max_height = 30 / vim.o.lines
		-- return { width = vim.o.columns > 140 and max_width or 1 }
		return {
			width = math.min(max_width, 1),
			height = math.min(max_height, 1),
		}
	end,
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
		fzf = {
			["ctrl-l"] = "toggle-preview",
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

-- sets new working dir
map("n", "<leader>cw", "<cmd>lua require('setup.fzf-lua.commands').workdirs()<CR>", opts)
map("n", "<leader>/", "<cmd>lua require('setup.fzf-lua.commands').workdirs({ nvim_tmux = true })<CR>", opts)
-- map("n", "<leader>/", "<cmd>lua require('setup.fzf-lua.commands').workdirs({ nvim_alacritty = true })<CR>", opts)
