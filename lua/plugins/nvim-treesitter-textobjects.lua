return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	event = "BufReadPre",
	opts = {
		textobjects = {
			select = {
				enable = true,

				-- Automatically jump forward to textobj, similar to targets.vim
				lookahead = true,

				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@conditional.outer",
					["ic"] = "@conditional.inner",
					["al"] = "@loop.outer",
					["il"] = "@loop.inner",
				},
			},
			lsp_interop = {
				enable = true,
				border = "rounded",
				peek_definition_code = {
					["<leader>Pf"] = "@function.outer",
					["<leader>Pc"] = "@class.outer",
				},
			},
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
