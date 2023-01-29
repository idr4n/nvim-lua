-- 'folke/tokyonight.nvim'

local t = os.date("*t").hour + os.date("*t").min / 60
-- local theme_style = "night"
-- local theme_style = "storm"
local theme_style = "moon"

if t >= 7 and t < 18 then
	-- theme_style = "storm"
	theme_style = "moon"
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
		local purple = "#9d7cd8"
		-- hl.CursorLine = { bg = c.bg_dark }
		hl.CursorLine = { bg = "#16161E" }
		hl.CursorLineNr = { fg = c.orange, bold = true }
		-- hl.TelescopeBorder = { bg = c.none, fg = c.magenta }
		hl.TelescopeBorder = { bg = c.none, fg = purple }
		hl.TelescopePromptTitle = { bg = c.none, fg = c.orange }
		hl.TelescopePreviewTitle = { bg = c.none, fg = c.orange }
	end,
})

-- Load the colorscheme
vim.cmd("colorscheme tokyonight")

vim.cmd([[:highlight CustomSignsAdd guifg=#73DACA]])
vim.cmd([[:highlight CustomSignsChange guifg=#FF9E64]])
vim.cmd([[:highlight CustomSignsDelete guifg=#F7768E]])
