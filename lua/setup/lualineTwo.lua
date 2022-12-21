-- "nvim-lualine/lualine.nvim"
-- modified from https://github.com/ChristianChiarulli/nvim (sept. 21, 2022)

M = {}
local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local lualine_scheme = "tokyonight"

local status_theme_ok, theme = pcall(require, "lualine.themes." .. lualine_scheme)
if not status_theme_ok then
	return
end

theme.normal.b.bg = "NONE"
theme.insert.b.bg = "NONE"
theme.normal.c.bg = "NONE"

-- check if value in table
local function contains(t, value)
	for _, v in pairs(t) do
		if v == value then
			return true
		end
	end
	return false
end

local function hex_to_rgb(hex_str)
	local hex = "[abcdef0-9][abcdef0-9]"
	local pat = "^#(" .. hex .. ")(" .. hex .. ")(" .. hex .. ")$"
	hex_str = string.lower(hex_str)

	assert(string.find(hex_str, pat) ~= nil, "hex_to_rgb: invalid hex_str: " .. tostring(hex_str))

	local red, green, blue = string.match(hex_str, pat)
	return { tonumber(red, 16), tonumber(green, 16), tonumber(blue, 16) }
end

local function blend(fg, bg, alpha)
	bg = hex_to_rgb(bg)
	fg = hex_to_rgb(fg)

	local function blendChannel(i)
		local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
		return math.floor(math.min(math.max(0, ret), 255) + 0.5)
	end

	return string.format("#%02X%02X%02X", blendChannel(1), blendChannel(2), blendChannel(3))
end

local function darken(hex, amount, bg)
	if bg == "bg" or bg == "" then
		bg = "#222222"
	end
	return blend(hex, bg, math.abs(amount))
end

local base = vim.fn.synIDattr(vim.fn.hlID("Cursor"), "fg")
local surface0 = vim.fn.synIDattr(vim.fn.hlID("Comment"), "fg")
local sep = darken(surface0, 0.4, base)
local gray = "#32363e"
local dark_gray = "#2E3239"
local red = "#D16969"
local blue = "#569CD6"
local green = "#6A9955"
local cyan = "#4EC9B0"
local orange = "#CE9178"
local indent = "#CE9178"
local yellow = "#DCDCAA"
local yellow_orange = "#D7BA7D"
local purple = "#C586C0"

vim.api.nvim_set_hl(0, "SLGitIcon", { fg = "#E8AB53", bg = dark_gray })
vim.api.nvim_set_hl(0, "SLTermIcon", { fg = purple, bg = sep })
vim.api.nvim_set_hl(0, "SLBranchName", { fg = "#abb2bf", bg = dark_gray, bold = false })
vim.api.nvim_set_hl(0, "SLProgress", { fg = purple, bg = sep })
vim.api.nvim_set_hl(0, "SLLocation", { fg = blue, bg = sep })
vim.api.nvim_set_hl(0, "SLFilename", { fg = blue, bg = sep, bold = true })
vim.api.nvim_set_hl(0, "SLFT", { fg = cyan, bg = sep })
vim.api.nvim_set_hl(0, "SLIndent", { fg = indent, bg = sep })
vim.api.nvim_set_hl(0, "SLLSP", { fg = "#6b727f", bg = "NONE" })
vim.api.nvim_set_hl(0, "SLSep", { fg = sep, bg = "NONE" })
vim.api.nvim_set_hl(0, "SLFG", { fg = "#abb2bf", bg = "NONE" })
vim.api.nvim_set_hl(0, "SLSeparator", { fg = "#6b727f", bg = "NONE", italic = true })
vim.api.nvim_set_hl(0, "SLError", { fg = "#bf616a", bg = "NONE" })
vim.api.nvim_set_hl(0, "SLWarning", { fg = "#D7BA7D", bg = "NONE" })
vim.api.nvim_set_hl(0, "SLCopilot", { fg = "#6CC644", bg = "NONE" })
vim.api.nvim_set_hl(0, "SLFormatter", { fg = green, bg = "NONE" })
vim.api.nvim_set_hl(0, "SLLinter", { fg = yellow_orange, bg = "NONE" })
vim.api.nvim_set_hl(0, "SLNone", { fg = "#6b727f", bg = "NONE" })
vim.api.nvim_set_hl(0, "SLAdded", { fg = cyan, bg = "NONE" })
vim.api.nvim_set_hl(0, "SLModified", { fg = orange, bg = "NONE" })
vim.api.nvim_set_hl(0, "SLRemoved", { fg = red, bg = "NONE" })

local hl_str = function(str, hl)
	return "%#" .. hl .. "#" .. str .. "%*"
end

local mode_color = {
	n = blue,
	i = orange,
	v = "#b668cd",
	[""] = "#b668cd",
	V = "#b668cd",
	c = "#46a6b2",
	no = "#D16D9E",
	s = green,
	S = orange,
	[""] = orange,
	ic = red,
	R = "#D16D9E",
	Rv = red,
	cv = blue,
	ce = blue,
	r = red,
	rm = "#46a6b2",
	["r?"] = "#46a6b2",
	["!"] = "#46a6b2",
	t = red,
}

local left_pad = {
	function()
		return " "
	end,
	padding = 0,
	color = function()
		return { fg = gray, bg = "NONE" }
	end,
}

local right_pad = {
	function()
		return ""
	end,
	padding = 0,
	color = function()
		return { fg = dark_gray, bg = "NONE" }
	end,
}

local mode = {
	-- mode component
	function()
		return " "
		-- return "  "
	end,
	color = function()
		-- auto change color according to neovims mode
		return { fg = mode_color[vim.fn.mode()], bg = gray }
	end,
	padding = 0,
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
	symbols = {
		error = "%#SLError#" .. icons.diagnostics.Error .. "%#SLNone#",
		warn = "%#SLWarning#" .. icons.diagnostics.Warning .. "%#SLNone#",
	},
	colored = false,
	update_in_insert = false,
	always_visible = false,
	padding = 0,
	fmt = function(str)
		if #str > 0 then
			return hl_str("", "SLSep") .. str .. hl_str("", "SLSep")
		else
			return ""
		end
	end,
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
	symbols = {
		added = "%#SLAdded#" .. icons.git.Add .. "%#SLNone#",
		modified = "%#SLModified#" .. icons.git.Mod .. "%#SLNone#",
		removed = "%#SLRemoved#" .. icons.git.Remove .. "%#SLNone#",
	},
	cond = hide_in_width_60,
	fmt = function(str)
		if #str > 0 then
			return "%#SLSep#" .. "" .. str .. "%#SLSep#" .. ""
		else
			return ""
		end
	end,
}

local filename = {
	"filename",
	path = 1,
	symbols = { modified = "●" },
	padding = 0,
	fmt = function(str)
		local ignored_filetypes = { "fzf", "neo-tree", "toggleterm", "TelescopePrompt" }
		local buf_ft = vim.bo.filetype
		if contains(ignored_filetypes, buf_ft) then
			return ""
		end
		return hl_str("", "SLSep") .. "%#SLLocation#" .. str .. "%#SLNone#" .. hl_str("", "SLSep") .. "%#SLNone#"
	end,
}

local function getDir()
	local dir = tostring(vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"))
	if #dir > 20 then
		dir = dir:sub(1, 17) .. "..."
	end
	return hl_str("", "SLSep") .. "%#SLFT#" .. " " .. dir .. "%#SLNone#" .. hl_str("", "SLSep") .. "%#SLNone#"
end

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

		local return_val = function(s)
			return hl_str(" ", "SLSep") .. hl_str(s, "SLFT") .. hl_str("", "SLSep")
		end

		if str == "TelescopePrompt" then
			return return_val(icons.ui.Telescope)
		end

		local function get_term_num()
			local t_status_ok, toggle_num = pcall(vim.api.nvim_buf_get_var, 0, "toggle_number")
			if not t_status_ok then
				return ""
			end
			return toggle_num
		end

		if str == "toggleterm" then
			local term = "%#SLTermIcon#" .. " " .. "%*" .. "%#SLFT#" .. get_term_num() .. "%*"
			return return_val(term)
		end

		if contains(ui_filetypes, str) then
			return ""
		else
			return return_val(str)
		end
	end,
	icons_enabled = false,
	padding = 0,
	cond = hide_in_width_120,
}

local branch = {
	"branch",
	icons_enabled = true,
	icon = "%#SLGitIcon#" .. " " .. "%*" .. "%#SLBranchName#",
	colored = false,
	padding = 0,
	fmt = function(str)
		if str == "" or str == nil then
			return "!=vcs"
		end

		return str
	end,
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
		-- return hl_str("", "SLSep") .. hl_str("%2.3p%%/%L", "SLProgress") .. hl_str(" ", "SLSep")
		return hl_str("", "SLSep") .. hl_str(newStr .. "/%L", "SLProgress") .. hl_str(" ", "SLSep")
	end,
	-- color = "SLProgress",
	padding = 0,
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
			-- return "%#SLSeparator#│ : " .. hint .. "%*"
			return "%#SLSeparator# : " .. hint .. "%*"
			-- return "%#SLSeparator# " .. hint .. "%*"
		end

		return ""
	end,
	cond = hide_in_width_140,
	padding = 0,
}

local spaces = {
	function()
		local buf_ft = vim.bo.filetype

		local ui_filetypes = {
			"help",
			"packer",
			"neogitstatus",
			"NvimTree",
			"Trouble",
			"lir",
			"Outline",
			"spectre_panel",
			"DressingSelect",
			"",
		}
		local space = ""

		if contains(ui_filetypes, buf_ft) then
			space = " "
		end

		local shiftwidth = vim.api.nvim_buf_get_option(0, "shiftwidth")

		if shiftwidth == nil then
			return ""
		end

		return hl_str(" ", "SLSep") .. hl_str(" " .. shiftwidth .. space, "SLIndent") .. hl_str("", "SLSep")
	end,
	padding = 0,
	cond = hide_in_width_120,
}

local getWords = {
	"getWords",
	padding = 0,
	fmt = function()
		if vim.bo.filetype == "md" or vim.bo.filetype == "txt" or vim.bo.filetype == "markdown" then
			if vim.fn.wordcount().visual_words == nil then
				return hl_str(" ", "SLSep")
					.. hl_str(" " .. tostring(vim.fn.wordcount().words), "SLIndent")
					.. hl_str("", "SLSep")
			end
			return hl_str(" ", "SLSep")
				.. hl_str(" " .. tostring(vim.fn.wordcount().visual_words), "SLIndent")
				.. hl_str("", "SLSep")
		else
			return ""
		end
	end,
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
		local copilot_active = false

		-- add client
		for _, client in pairs(clients) do
			if client.name ~= "copilot" and client.name ~= "null-ls" then
				table.insert(client_names, client.name)
			end
			if client.name == "copilot" then
				copilot_active = true
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
		-- if formatter ~= nil then
		-- 	vim.list_extend(client_names, formatter)
		-- end
		-- if linter ~= nil then
		-- 	vim.list_extend(client_names, linter)
		-- end

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
			language_servers = hl_str("", "SLSep")
				.. hl_str(client_names_str, "SLSeparator")
				.. hl_str("", "SLSep")
				.. "%#SLFormatter#"
				.. formatter_icon
				.. "%#SLLinter#"
				.. linter_icon
		end
		if copilot_active then
			language_servers = language_servers .. "%#SLCopilot#" .. " " .. icons.git.Octoface .. "%*"
		end

		if client_names_str_len == 0 and not copilot_active then
			return ""
		else
			M.language_servers = language_servers
			return language_servers:gsub(", anonymous source", "")
		end
	end,
	padding = 0,
	cond = hide_in_width_120,
}

local location = {
	"location",
	fmt = function(str)
		return hl_str(" ", "SLSep") .. hl_str(str, "SLLocation") .. hl_str(" ", "SLSep") .. "%#SLNone#"
	end,
	padding = 0,
}

lualine.setup({
	options = {
		globalstatus = true,
		icons_enabled = true,
		theme = theme,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard" },
		always_divide_middle = true,
		-- ignore_focus = { "fzf", "neo-tree", "TelescopePrompt" },
	},
	sections = {
		lualine_a = { left_pad, mode, branch, right_pad },
		lualine_b = { getDir, filename },
		lualine_c = { diff, diagnostics, current_signature },
		-- lualine_x = { language_server, spaces, filetype },
		lualine_x = { language_server, getWords, filetype },
		lualine_y = {},
		lualine_z = { location, progress },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
})
