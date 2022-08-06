-- "lukas-reineke/indent-blankline.nvim"

-- vim.opt.list = true
-- vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup({
	-- enabled = false,
	-- show_end_of_line = true,
	-- char = "",
	-- context_char = "│",
	-- show_current_context = true,
	-- show_current_context_start = true,
	filetype_exclude = {
		"alpha",
		"NvimTree",
		"help",
		"markdown",
		"dirvish",
		"nnn",
		"packer",
		"toggleterm",
		"lsp-installer",
		"Outline",
	},
})
