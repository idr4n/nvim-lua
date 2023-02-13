-- "nvim-lualine/lualine.nvim"
-- modified from https://github.com/ChristianChiarulli/nvim (sept. 21, 2022)

M = {}

-- check if value in table
local function contains(t, value)
	for _, v in pairs(t) do
		if v == value then
			return true
		end
	end
	return false
end

local colors = {
	diff_added = { fg = "#4EC9B0" },
	diff_modified = { fg = "#CE9178" },
	diff_removed = { fg = "#D16969" },
	error = { fg = "#bf616a" },
	warning = { fg = "#D7BA7D" },
	gray = "#32363e",
	dark_gray = "#292E42",
	yellow_orange = "#D7BA7D",
	none = "NONE",
	bg = "#222436", --
	bg_highlight = "#2f334d", --
	terminal_black = "#444a73", --
	black = "black",
	fg = "#c8d3f5", --
	bg_dark = "#16161E",
	bg_dark2 = "#1e2030", --
	fg_dark = "#828bb8", --
	fg_gutter = "#3b4261",
	blue0 = "#3e68d7", --
	blue = "#82aaff", --
	cyan = "#86e1fc", --
	cyan2 = "#4EC9B0",
	blue1 = "#65bcff", --
	blue2 = "#0db9d7",
	blue5 = "#89ddff",
	blue6 = "#b4f9f8", --
	blue7 = "#394b70",
	blue8 = "#569CD6",
	purple = "#fca7ea", --
	purple2 = "#C586C0",
	magenta2 = "#ff007c",
	magenta = "#c099ff", --
	orange = "#ff966c", --
	orange2 = "#CE9178",
	yellow = "#ffc777", --
	green = "#c3e88d", --
	green1 = "#4fd6be", --
	green2 = "#41a6b5",
	teal = "#4fd6be", --
	red = "#ff757f", --
	red1 = "#c53b53", --
	red2 = "#D16969",
}

local bg_statusline = colors.bg_dark2

local my_theme = {
	normal = {
		a = { bg = colors.blue, fg = colors.black },
		b = { bg = colors.dark_gray, fg = colors.blue },
		c = { bg = bg_statusline, fg = colors.fg_dark },
	},
	insert = {
		a = { bg = colors.orange2, fg = colors.black },
		b = { bg = colors.dark_gray, fg = colors.orange2 },
	},
	visual = {
		a = { bg = colors.magenta, fg = colors.black },
		b = { bg = bg_statusline, fg = colors.magenta },
	},
	command = {
		a = { bg = colors.yellow, fg = colors.black },
		b = { bg = bg_statusline, fg = colors.yellow },
	},
	replace = {
		a = { bg = colors.red, fg = colors.black },
		b = { bg = bg_statusline, fg = colors.red },
	},
	terminal = {
		a = { bg = colors.green2, fg = colors.black },
		b = { bg = bg_statusline, fg = colors.green2 },
	},
	inactive = {
		a = { bg = bg_statusline, fg = colors.blue },
		b = { bg = bg_statusline, fg = colors.fg_gutter, gui = "bold" },
		c = { bg = bg_statusline, fg = colors.fg_gutter },
	},
}

vim.api.nvim_set_hl(0, "SLFormatter", { fg = colors.green, bg = bg_statusline })
vim.api.nvim_set_hl(0, "SLLinter", { fg = colors.yellow_orange, bg = bg_statusline })
vim.api.nvim_set_hl(0, "SLBranchIcon", { fg = colors.orange, bg = colors.bg_dark2 })

local mode_color = {
	n = colors.blue,
	i = colors.orange2,
	v = "#b668cd",
	[""] = "#b668cd",
	V = "#b668cd",
	c = "#46a6b2",
	no = "#D16D9E",
	s = colors.green,
	S = colors.orange,
	[""] = colors.orange,
	ic = colors.red,
	R = "#D16D9E",
	Rv = colors.red,
	cv = colors.blue,
	ce = colors.blue,
	r = colors.red,
	rm = "#46a6b2",
	["r?"] = "#46a6b2",
	["!"] = "#46a6b2",
	t = colors.red,
}

local mode = {
	function()
		return " "
		-- return "  "
	end,
	-- color = function()
	-- 	return { fg = mode_color[vim.fn.mode()], bg = gray }
	-- end,
	padding = 1,
	color = { gui = "bold" },
}

local hide_in_width_60 = function()
	return vim.o.columns > 60
end

local hide_in_width_120 = function()
	return vim.o.columns > 120
end

local hide_in_width_140 = function()
	return vim.o.columns > 140
end

local icons = require("icons")

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	diagnostics_color = {
		error = colors.error,
		warn = colors.warning,
	},
	symbols = {
		error = icons.diagnostics.Error,
		warn = icons.diagnostics.Warning,
	},
	update_in_insert = false,
	always_visible = false,
	fmt = function(str)
		if #str > 0 then
			return str
		else
			return ""
		end
	end,
	padding = 1,
}

local function diff_source()
	local gitsigns = vim.b.gitsigns_status_dict
	if gitsigns then
		return {
			added = gitsigns.added,
			modified = gitsigns.changed,
			removed = gitsigns.removed,
		}
	end
end

local diff = {
	"diff",
	source = diff_source,
	colored = true,
	diff_color = {
		added = colors.diff_added,
		modified = colors.diff_modified,
		removed = colors.diff_removed,
	},
	symbols = {
		added = icons.git.Add,
		modified = icons.git.Mod,
		removed = icons.git.Remove,
	},
	cond = hide_in_width_60,
	fmt = function(str)
		if #str > 0 then
			return str
		else
			return ""
		end
	end,
	padding = 1,
}

local fileIcon = { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } }

local filename = {
	"filename",
	path = 1,
	shorting_target = 60,
	symbols = { modified = "●" },
	fmt = function(str)
		local ignored_filetypes = { "fzf", "neo-tree", "toggleterm", "TelescopePrompt" }
		local buf_ft = vim.bo.filetype
		if contains(ignored_filetypes, buf_ft) then
			return ""
		end
		return str
	end,
	padding = 1,
}

local getDir = {
	"getDir",
	fmt = function()
		local dir = tostring(vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"))
		if #dir > 20 then
			dir = dir:sub(1, 17) .. "..."
		end
		return " " .. dir
	end,
	padding = 1,
}

local filetype = {
	"filetype",
	fmt = function(str)
		local ui_filetypes = {
			"help",
			"packer",
			"neogitstatus",
			"NvimTree",
			"Trouble",
			"lir",
			"Outline",
			"spectre_panel",
			"toggleterm",
			"DressingSelect",
			"",
			"nil",
		}

		if str == "TelescopePrompt" then
			return icons.ui.Telescope
		end

		local function get_term_num()
			local t_status_ok, toggle_num = pcall(vim.api.nvim_buf_get_var, 0, "toggle_number")
			if not t_status_ok then
				return ""
			end
			return toggle_num
		end

		if str == "toggleterm" then
			local term = " " .. get_term_num()
			return term
		end

		if contains(ui_filetypes, str) then
			return ""
		else
			return str
		end
	end,
	icons_enabled = false,
	padding = 1,
	cond = hide_in_width_120,
}

local branch = {
	"branch",
	-- icon = "%#SLBranchIcon#" .. "" .. "%*",
	icon = "",
	fmt = function(str)
		if str == "" or str == nil then
			return "!=vcs"
		end

		return str
	end,
	padding = 1,
}

local progress = {
	"progress",
	fmt = function(str)
		local newStr = ""
		if str == "Top" or str == "Bot" then
			newStr = str
		else
			newStr = "%2.3p%%"
		end
		return newStr .. "/%L"
	end,
	-- color = function()
	-- 	return { fg = mode_color[vim.fn.mode()], bg = gray }
	-- end,
	padding = 1,
	-- color = { gui = "bold" },
}

local function isempty(s)
	return s == nil or s == ""
end

local current_signature = {
	function()
		local buf_ft = vim.bo.filetype

		if buf_ft == "toggleterm" or buf_ft == "TelescopePrompt" then
			return ""
		end
		if not pcall(require, "lsp_signature") then
			return ""
		end
		local sig = require("lsp_signature").status_line(30)
		local hint = sig.hint

		if not isempty(hint) then
			return ": " .. hint
		end

		return ""
	end,
	cond = hide_in_width_140,
	padding = 1,
}

local getWords = {
	"getWords",
	fmt = function()
		if vim.bo.filetype == "md" or vim.bo.filetype == "text" or vim.bo.filetype == "markdown" then
			if vim.fn.wordcount().visual_words == nil then
				return " " .. tostring(vim.fn.wordcount().words)
			end
			return " " .. tostring(vim.fn.wordcount().visual_words)
		else
			return ""
		end
	end,
	padding = 1,
	color = { fg = colors.orange2 },
}

local language_server = {
	function()
		local buf_ft = vim.bo.filetype
		local ui_filetypes = {
			"help",
			"packer",
			"neogitstatus",
			"NvimTree",
			"neo-tree",
			"Trouble",
			"lir",
			"Outline",
			"spectre_panel",
			"toggleterm",
			"DressingSelect",
			"TelescopePrompt",
			"lspinfo",
			"lsp-installer",
			"",
		}

		if contains(ui_filetypes, buf_ft) then
			if M.language_servers == nil then
				return ""
			else
				return M.language_servers
			end
		end

		local clients = vim.lsp.buf_get_clients()
		local client_names = {}

		-- add client
		for _, client in pairs(clients) do
			if client.name ~= "null-ls" then
				table.insert(client_names, client.name)
			end
		end

		-- add formatter
		local s = require("null-ls.sources")
		local available_sources = s.get_available(buf_ft)
		local registered = {}
		for _, source in ipairs(available_sources) do
			for method in pairs(source.methods) do
				registered[method] = registered[method] or {}
				table.insert(registered[method], source.name)
			end
		end

		local formatter = registered["NULL_LS_FORMATTING"]
		local linter = registered["NULL_LS_DIAGNOSTICS"]

		local formatter_icon = ""
		if formatter then
			formatter_icon = " " .. " "
		end

		local linter_icon = ""
		if linter then
			linter_icon = " " .. icons.ui.Fire
		end

		-- shorten clients names if needed
		if #client_names > 2 then
			for i, client in pairs(client_names) do
				client_names[i] = string.sub(client, 1, 3)
			end
		end

		-- join client names with commas
		local client_names_str = table.concat(client_names, ", ")

		-- check client_names_str if empty
		local language_servers = ""
		local client_names_str_len = #client_names_str
		if client_names_str_len ~= 0 or #formatter_icon > 0 or #linter_icon > 0 then
			language_servers = "["
				.. client_names_str
				.. "]"
				.. "%#SLFormatter#"
				.. formatter_icon
				.. "%#SLLinter#"
				.. linter_icon
		end

		if #client_names > 2 and vim.o.columns <= 140 then
			return "[LSP]"
		end

		if client_names_str_len == 0 then
			return ""
		else
			M.language_servers = language_servers
			return language_servers:gsub(", anonymous source", "")
		end
	end,
	padding = 1,
	color = { gui = "italic" },
	cond = hide_in_width_120,
}

local location = {
	"location",
	fmt = function(str)
		return str
	end,
	padding = 1,
}

local charcode = {
	"charcode",
	fmt = function()
		return "Ux%04B"
	end,
	padding = 1,
	cond = hide_in_width_120,
}

return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
	opts = function()
		return {
			options = {
				globalstatus = true,
				icons_enabled = true,
				theme = my_theme,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = { "alpha", "dashboard" },
				always_divide_middle = true,
				-- ignore_focus = { "fzf", "neo-tree", "TelescopePrompt" },
			},
			sections = {
				lualine_a = { mode },
				lualine_b = { branch },
				lualine_c = { getDir, fileIcon, filename, diff, current_signature },
				lualine_x = { diagnostics, language_server, getWords, charcode, filetype },
				lualine_y = { location },
				lualine_z = { progress },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {},
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
		}
	end,
}
