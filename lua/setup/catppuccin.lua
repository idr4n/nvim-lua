-- "catppuccin/nvim"

require("catppuccin").setup({
	transparent_background = true,
	styles = {
		functions = { "italic" },
	},
	integrations = {
		native_lsp = {
			underlines = {
				errors = { "undercurl" },
				hints = { "undercurl" },
				warnings = { "undercurl" },
				information = { "undercurl" },
			},
		},
	},
	compile = {
		-- :CatppuccinCompile " Create/update the compile file
		-- :CatppuccinClean " Delete compiled file
		-- :CatppuccinStatus " Compile status
		enabled = true,
		path = vim.fn.stdpath("cache") .. "/catppuccin",
	},
})

local t = os.date("*t").hour + os.date("*t").min / 60

if t >= 8 and t < 18 then
	vim.g.catppuccin_flavour = "frappe" -- latte, frappe, macchiato, mocha
	-- vim.cmd([[colorscheme catppuccin]])
else
	vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
end

vim.cmd([[colorscheme catppuccin]])
