-- 'folke/tokyonight.nvim'

local t = os.date("*t").hour + os.date("*t").min / 60
local theme_style = "night"

if t >= 8 and t < 18 then
	theme_style = "storm"
end

require("tokyonight").setup({
	style = theme_style,
	transparent = true,
	styles = {
		functions = "italic",
		sidebars = "transparent",
		floats = "transparent",
	},
	on_highlights = function(hl, c)
		hl.CursorLine = { bg = c.bg_dark }
	end,
})

-- Load the colorscheme
vim.cmd("colorscheme tokyonight")
