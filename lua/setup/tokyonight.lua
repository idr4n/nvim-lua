-- 'folke/tokyonight.nvim'

require("tokyonight").setup({
	transparent = true,
	styles = {
		functions = "italic",
		sidebars = "transparent",
		floats = "transparent",
	},
})

-- Load the colorscheme
-- local t = os.date("*t").hour + os.date("*t").min / 60

-- if t >= 8 and t < 18 then
-- 	-- vim.cmd("colorscheme tokyonight-storm")
-- else
-- 	vim.cmd("colorscheme tokyonight-night")
-- end
