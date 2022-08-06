-- "catppuccin/nvim"

require("catppuccin").setup({
	transparent_background = true,
	styles = {
		functions = { "italic" },
	},
})

local t = os.date("*t").hour + os.date("*t").min / 60

if t >= 8 and t < 18 then
	vim.g.catppuccin_flavour = "frappe" -- latte, frappe, macchiato, mocha
	vim.cmd([[colorscheme catppuccin]])
else
	vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
	vim.cmd([[colorscheme catppuccin]])
end
