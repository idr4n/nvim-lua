local t = os.date("*t").hour + os.date("*t").min / 60

return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = function()
			local theme_style = "moon"

			if t >= 7 and t < 18 then
				theme_style = "moon"
			end

			return {
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
			}
		end,
		config = function(_, opts)
			require("tokyonight").setup(opts)

			-- Load the colorscheme
			vim.cmd("colorscheme tokyonight")

			-- define gitsigns colors
			vim.cmd([[:highlight CustomSignsAdd guifg=#73DACA]])
			vim.cmd([[:highlight CustomSignsChange guifg=#FF9E64]])
			vim.cmd([[:highlight CustomSignsDelete guifg=#F7768E]])
		end,
	},
	{
		"mcchrish/zenbones.nvim",
		dependencies = "rktjmp/lush.nvim",
		config = function()
			vim.g.zenbones =
				{ lightness = "default", darkness = "stark", lighten_line_nr = 30, transparent_background = true }

			if t >= 7 and t < 18.0 then
				-- vim.cmd("set background=light")
				-- vim.cmd("colorscheme zenbones")
				-- vim.env.BAT_THEME = "Monokai Extended Light"
				-- vim.env.BAT_THEME = "gruvbox-light"
				vim.env.BAT_THEME = "Nord"
			else
				-- vim.cmd("set background=dark")
				-- vim.cmd("colorscheme zenbones")
				-- vim.cmd("colorscheme nordbones")
				-- vim.env.BAT_THEME = "gruvbox-dark"
				vim.env.BAT_THEME = "Nord"
			end
		end,
	},
	{
		"EdenEast/nightfox.nvim",
		config = function()
			local options = {
				transparent = true,
				styles = {
					comments = "italic",
					-- functions = "italic,bold",
					functions = "italic",
				},
			}

			local groups = {
				nightfox = {
					CursorLine = { bg = "#1F2A38" },
				},
				nordfox = {
					CursorLine = { bg = "#343946" },
				},
				duskfox = {
					CursorLine = { bg = "#2C2A40" },
				},
				dawnfox = {
					CursorLine = { bg = "#F2E9ED" },
				},
			}

			require("nightfox").setup({
				options = options,
				groups = groups,
			})
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		opts = function()
			local ucolors = require("catppuccin.utils.colors")
			local cp = require("catppuccin.palettes").get_palette()

			return {
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
			}
		end,
		-- config = function(_, opts)
		-- 	require("catppuccin").setup(opts)
		--
		-- 	if t >= 7 and t < 18 then
		-- 		-- vim.cmd([[colorscheme catppuccin-macchiato]])
		-- 		vim.cmd([[colorscheme catppuccin-frappe]])
		-- 	else
		-- 		vim.cmd([[colorscheme catppuccin-macchiato]])
		-- 		-- vim.cmd([[colorscheme catppuccin-frappe]])
		-- 	end
		--
		-- 	vim.cmd([[colorscheme catppuccin-frappe]])
		-- 	vim.cmd([[colorscheme catppuccin-macchiato]])
		-- end,
	},
	{
		"rose-pine/neovim",
		opts = {
			--- @usage 'main' | 'moon'
			dark_variant = "moon",
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
				-- IndentBlanklineChar = { fg = "highlight_med" },
				-- CursorLine = { bg = "#302E45" },
				Variable = { fg = "text", style = "NONE" },
				TSVariable = { fg = "text", style = "NONE" },
				["@variable"] = { fg = "text", style = "NONE" },
				Parameter = { fg = "iris", style = "NONE" },
				TSParameter = { fg = "iris", style = "NONE" },
				["@parameter"] = { fg = "iris", style = "NONE" },
				Property = { fg = "iris", style = "NONE" },
				["@property"] = { fg = "iris", style = "NONE" },
				TSProperty = { fg = "iris", style = "NONE" },
				Keyword = { fg = "pine", style = "italic" },
				TSKeyword = { fg = "pine", style = "italic" },
				["@keyword"] = { fg = "pine", style = "italic" },
				Function = { fg = "rose", style = "italic" },
				TSFunction = { fg = "rose", style = "italic" },
			},
		},
		-- config = function(_, opts)
		-- 	require("rose-pine").setup(opts)
		-- 	vim.cmd("colorscheme rose-pine")
		-- end,
	},
}
