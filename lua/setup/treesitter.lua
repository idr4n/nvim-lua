-- Treesitter
-- "nvim-treesitter/nvim-treesitter",
-- "windwp/nvim-ts-autotag"

require("nvim-treesitter.configs").setup({
	autotag = {
		enable = true,
		filetypes = {
			"html",
			"javascript",
			"typescript",
			"markdown",
		},
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<CR>",
			scope_incremental = "<CR>",
			node_incremental = "<CR>",
			node_decremental = "<TAB>",
		},
	},
})

-- Setup treesitter
local ts = require("nvim-treesitter.configs")
ts.setup({
	ensure_installed = {
		"bash",
		"css",
		"go",
		-- "html",
		"javascript",
		"lua",
		"python",
		"rust",
		"tsx",
		"typescript",
		"cpp",
		"java",
		"json",
		"latex",
		"markdown",
		"vim",
		"org",
	},
	autopairs = { enable = true },
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = { enable = true },
	context_commentstring = { enable = true },
	playground = { enabled = true },
})
