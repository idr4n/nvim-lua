-- 'folke/tokyonight.nvim'

-- Example config in Lua
-- vim.g.tokyonight_style = "storm"
-- vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_transparent = true
-- vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }

-- Change the "hint" color to the "orange" color, and make the "error" color bright red
-- vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
-- vim.g.tokyonight_colors = { bg_highlight = "#232431" }

-- Load the colorscheme
local t = os.date("*t").hour + os.date("*t").min / 60

if t >= 8 and t < 18 then
	vim.g.tokyonight_style = "storm"
	-- vim.cmd("colorscheme tokyonight")
else
	vim.g.tokyonight_style = "night"
	vim.cmd("colorscheme tokyonight")
end
-- vim.cmd("colorscheme tokyonight")
