-- "lukas-reineke/indent-blankline.nvim"

-- vim.opt.list = true
-- vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup({
	-- show_end_of_line = true,
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
