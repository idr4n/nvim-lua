local tokyonight_moon = {
	none = "NONE",
	bg_dark = "#1e2030", --
	bg = "#222436", --
	bg_highlight = "#2f334d", --
	terminal_black = "#444a73", --
	fg = "#c8d3f5", --
	fg_dark = "#828bb8", --
	fg_gutter = "#3b4261",
	dark3 = "#545c7e",
	comment = "#7a88cf", --
	dark5 = "#737aa2",
	blue0 = "#3e68d7", --
	blue = "#82aaff", --
	cyan = "#86e1fc", --
	blue1 = "#65bcff", --
	blue2 = "#0db9d7",
	blue5 = "#89ddff",
	blue6 = "#b4f9f8", --
	blue7 = "#394b70",
	purple = "#fca7ea", --
	magenta2 = "#ff007c",
	magenta = "#c099ff", --
	orange = "#ff966c", --
	yellow = "#ffc777", --
	green = "#c3e88d", --
	green1 = "#4fd6be", --
	green2 = "#41a6b5",
	teal = "#4fd6be", --
	red = "#ff757f", --
	red1 = "#c53b53", --
}
-- floating winbar
return {
	"b0o/incline.nvim",
	event = "BufReadPre",
	config = function()
		local colors = require("tokyonight.colors").setup()
		require("incline").setup({
			highlight = {
				groups = {
					InclineNormal = { guifg = "#9d7cd8", guibg = colors.black },
					InclineNormalNC = { guibg = colors.blue7, guifg = colors.fg },
				},
			},
			window = { margin = { vertical = 0, horizontal = 1 } },
			render = function(props)
				local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
				local icon, color = require("nvim-web-devicons").get_icon_color(filename)
				return { { icon, guifg = color }, { " " }, { filename } }
			end,
		})
	end,
}
