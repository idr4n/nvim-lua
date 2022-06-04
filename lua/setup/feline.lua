-- 'feline-nvim/feline.nvim'

local colors = {
	bg = vim.fn.synIDattr(vim.fn.hlID("StatusLineNC"), "bg"),
	fg = vim.fn.synIDattr(vim.fn.hlID("Comment"), "fg"),
	fg2 = vim.fn.synIDattr(vim.fn.hlID("StatusLine"), "fg"),
	yellow = "#e0af68",
	cyan = "#56b6c2",
	darkblue = "#081633",
	green = "#a7c080",
	orange = "#d19a66",
	violet = "#a9a1e1",
	magenta = "#c678dd",
	blue = "#61afef",
	red = "#ff6666",
}

local mode_colors = {
	n = { bg = vim.fn.synIDattr(vim.fn.hlID("PmenuSel"), "bg") },
	no = { bg = vim.fn.synIDattr(vim.fn.hlID("PmenuSel"), "bg") },
	i = { bg = vim.fn.synIDattr(vim.fn.hlID("Constant"), "fg") },
	v = { bg = vim.fn.synIDattr(vim.fn.hlID("DiagnosticInfo"), "fg") },
	V = { bg = vim.fn.synIDattr(vim.fn.hlID("DiagnosticInfo"), "fg") },
	[""] = "StatusLine",
	r = { bg = vim.fn.synIDattr(vim.fn.hlID("Number"), "fg") },
	rm = { bg = vim.fn.synIDattr(vim.fn.hlID("Number"), "fg") },
	R = { bg = vim.fn.synIDattr(vim.fn.hlID("Number"), "fg") },
	Rv = { bg = vim.fn.synIDattr(vim.fn.hlID("Number"), "fg") },
	s = { bg = vim.fn.synIDattr(vim.fn.hlID("Visual"), "bg") },
	S = { bg = vim.fn.synIDattr(vim.fn.hlID("Visual"), "bg") },
	c = { bg = vim.fn.synIDattr(vim.fn.hlID("WarningMsg"), "fg") },
	["!"] = { bg = vim.fn.synIDattr(vim.fn.hlID("Number"), "fg") },
	t = { bg = vim.fn.synIDattr(vim.fn.hlID("WarningMsg"), "fg") },
}

local icons = {
	linux = " ",
	macos = " ",
	windows = " ",

	errs = " ",
	warns = " ",
	infos = " ",
	hints = " ",

	-- lsp = " ",
	lsp = " ",
	git = "",
}

-- local function file_osinfo()
-- 	local os = vim.bo.fileformat:upper()
-- 	local icon
-- 	if os == "UNIX" then
-- 		icon = icons.linux
-- 	elseif os == "MAC" then
-- 		icon = icons.macos
-- 	else
-- 		icon = icons.windows
-- 	end
-- 	return icon .. os
-- end

local function charcode()
	return "Ux%04B"
end

local function getDir()
	local dir = tostring(vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"))
	if #dir > 20 then
		dir = dir:sub(1, 17) .. "..."
	end
	return " " .. dir
end

-- LuaFormatter off

local comps = {
	vi_mode = {
		left = {
			-- provider = "▊",
			provider = " ",
			right_sep = " ",
			hl = function()
				return mode_colors[vim.fn.mode()]
			end,
		},
		right = {
			-- provider = "▊",
			provider = " ",
			left_sep = " ",
			hl = function()
				return mode_colors[vim.fn.mode()]
			end,
		},
	},
	file = {
		info = {
			provider = "file_info",
			hl = {
				fg = colors.fg2,
				style = "bold",
			},
		},
		dir = {
			provider = getDir,
			left_sep = " ",
			right_sep = " ",
			hl = {
				fg = colors.fg2,
				style = "bold",
			},
		},
		encoding = {
			provider = "file_encoding",
			left_sep = " ",
			hl = {
				fg = colors.fg,
				-- style = "bold",
			},
		},
		type = {
			provider = "file_type",
		},
		os = {
			provider = charcode,
			right_sep = " ",
			hl = {
				-- fg = colors.violet,
				fg = colors.fg,
				-- style = "bold",
			},
		},
	},
	line_percentage = {
		provider = "line_percentage",
		left_sep = " ",
		hl = {
			style = "bold",
		},
	},
	position = {
		provider = {
			name = "position",
			opts = {
				padding = { col = 3 },
				format = "{col}",
			},
		},
		hl = {
			style = "bold",
		},
	},
	scroll_bar = {
		provider = "scroll_bar",
		left_sep = " ",
		right_sep = " ",
		hl = {
			style = "bold",
		},
	},
	diagnos = {
		err = {
			provider = "diagnostic_errors",
			left_sep = " ",
			hl = {
				fg = colors.red,
			},
		},
		warn = {
			provider = "diagnostic_warnings",
			left_sep = " ",
			hl = {
				fg = colors.yellow,
			},
		},
		info = {
			provider = "diagnostic_info",
			left_sep = " ",
			hl = {
				fg = colors.blue,
			},
		},
		hint = {
			provider = "diagnostic_hints",
			left_sep = " ",
			hl = {
				fg = colors.cyan,
			},
		},
	},
	lsp = {
		name = {
			provider = "lsp_client_names",
			left_sep = " ",
			icon = icons.lsp,
			hl = {
				fg = colors.fg,
				-- style = "bold",
			},
		},
	},
	git = {
		branch = {
			provider = "git_branch",
			-- icon = icons.git,
			left_sep = " ",
			hl = {
				fg = colors.fg2,
				style = "bold",
			},
		},
		add = {
			provider = "git_diff_added",
			hl = {
				fg = colors.green,
				-- style = "bold",
			},
		},
		change = {
			provider = "git_diff_changed",
			hl = {
				fg = colors.orange,
				-- style = "bold",
			},
		},
		remove = {
			provider = "git_diff_removed",
			hl = {
				fg = colors.red,
				-- style = "bold",
			},
		},
	},
}

local properties = {
	force_inactive = {
		filetypes = {
			"NvimTree",
			"dbui",
			"packer",
			"startify",
			"fugitive",
			"fugitiveblame",
		},
		buftypes = { "terminal" },
		bufnames = {},
	},
}

local components = {
	active = {
		{
			comps.vi_mode.left,
			comps.git.branch,
			comps.git.add,
			comps.git.change,
			comps.git.remove,
			comps.diagnos.err,
			comps.diagnos.warn,
			comps.diagnos.hint,
			comps.diagnos.info,
			-- comps.lsp.name,
		},
		{
			comps.file.info,
		},
		{
			comps.file.os,
			comps.position,
			comps.line_percentage,
			comps.scroll_bar,
			comps.file.dir,
			comps.vi_mode.right,
		},
	},
	inactive = {
		{
			{
				provider = "",
				hl = {
					bg = "nope",
					fg = colors.fg,
					-- style = "underline",
				},
			},
		},
	},
}

require("feline").setup({
	theme = { bg = colors.bg, fg = colors.fg },
	components = components,
	properties = properties,
})

-- References
-- https://github.com/kvrohit/dotfiles/blob/master/nvim/lua/config/statusline.lua
-- https://github.com/6cdh/dotfiles/blob/62959d27344dade28d6dd638252cd82accb309ab/nvim/.config/nvim/lua/statusline.lua
