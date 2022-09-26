-- "rose-pine/neovim"

local t = os.date("*t").hour + os.date("*t").min / 60
local variant = ""

if t >= 8 and t < 18 then
	variant = "moon"
else
	variant = "main"
end

require("rose-pine").setup({
	--- @usage 'main' | 'moon'
	dark_variant = variant,
	bold_vert_split = false,
	dim_nc_background = false,
	disable_background = true,
	disable_float_background = true,
	disable_italics = false,

	--- @usage string hex value or named color from rosepinetheme.com/palette
	groups = {
		background = "base",
		panel = "surface",
		border = "highlight_med",
		comment = "muted",
		link = "iris",
		punctuation = "subtle",

		error = "love",
		hint = "iris",
		info = "foam",
		warn = "gold",

		git_add = "pine",
		git_rename = "foam",

		headings = {
			h1 = "iris",
			h2 = "foam",
			h3 = "rose",
			h4 = "gold",
			h5 = "pine",
			h6 = "foam",
		},
		-- or set all headings at once
		-- headings = 'subtle'
	},

	-- Change specific vim highlight groups
	highlight_groups = {
		IndentBlanklineChar = { fg = "overlay" },
		-- CursorLine = { bg = "#302E45" },
		TSVariable = { fg = "text", style = "NONE" },
		TSParameter = { fg = "iris", style = "NONE" },
		TSProperty = { fg = "iris", style = "NONE" },
		Keyword = { fg = "pine", style = "italic" },
		TSKeyword = { fg = "pine", style = "italic" },
		Function = { fg = "rose", style = "italic" },
		TSFunction = { fg = "rose", style = "italic" },
	},
})

-- Load the colorscheme

-- if t >= 8 and t < 18 then
-- 	vim.cmd("colorscheme rose-pine")
-- else
-- 	vim.cmd("colorscheme rose-pine")
-- end

vim.cmd("colorscheme rose-pine")
