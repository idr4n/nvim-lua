-- "catppuccin/nvim"

local ucolors = require("catppuccin.utils.colors")
local cp = require("catppuccin.palettes").get_palette()

require("catppuccin").setup({
	transparent_background = true,
	styles = {
		functions = { "italic" },
		keywords = { "italic" },
		conditionals = {},
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
	custom_highlights = {
		CursorLine = {
			bg = ucolors.vary_color(
				{ latte = ucolors.lighten(cp.mantle, 0.70, cp.base) },
				ucolors.darken(cp.surface0, 0.70, cp.base)
			),
		},
		TSParameter = { fg = cp.maroon, style = {} },
		["@parameter"] = { fg = cp.maroon, style = {} },
		TSInclude = { fg = cp.mauve, style = {} },
		["@include"] = { fg = cp.mauve, style = {} },
		["@namespace"] = { fg = cp.blue, style = {} },
		TSNamespace = { fg = cp.blue, style = {} },
		VertSplit = { fg = "#15161e" },
	},
	compile = {
		-- :CatppuccinCompile " Create/update the compile file
		-- :CatppuccinClean " Delete compiled file
		-- :CatppuccinStatus " Compile status
		enabled = false,
		path = vim.fn.stdpath("cache") .. "/catppuccin",
	},
})

-- local t = os.date("*t").hour + os.date("*t").min / 60
--
-- if t >= 8 and t < 18 then
-- 	-- vim.cmd([[colorscheme catppuccin-macchiato]])
-- 	vim.cmd([[colorscheme catppuccin-frappe]])
-- else
-- 	vim.cmd([[colorscheme catppuccin-macchiato]])
-- 	-- vim.cmd([[colorscheme catppuccin-frappe]])
-- end

-- vim.cmd([[colorscheme catppuccin-frappe]])
-- vim.cmd([[colorscheme catppuccin-macchiato]])
