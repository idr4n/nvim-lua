local ut = require("utils")
local c = require("config.statusline.components")

local isDark = vim.o.background == "dark"

--- Gets the color for either insert or normal mode.
---@param mode "insert"|nil
---@return string
local function get_theme_color(mode)
  if vim.g.colors_name == "tokyonight-moon" then
    local colors = require("tokyonight.colors").setup()
    return mode == "insert" and colors.green1 or "#9580FF"
  elseif vim.g.colors_name == "dracula" then
    local c_dracula = require("dracula").colors()
    return mode == "insert" and c_dracula.green or c_dracula.purple
  elseif vim.g.colors_name == "catppuccin-mocha" then
    local cp = require("catppuccin.palettes").get_palette("mocha")
    return mode == "insert" and cp.mauve or cp.blue
  end

  if mode == "insert" then
    return isDark and "#4FD6BE" or "#1E1E1E"
  end

  return isDark and "#9580FF" or "#9A5BFF"
end

local colors = {
  green = "#4FD6BE",
  orange = "#FF966C",
  yellow = "#E2B86B",
  red = isDark and "#DE6E7C" or "#D73A4A",
  blue = get_theme_color(),
  insert = get_theme_color("insert"),
  select = isDark and "#FCA7EA" or "#2188FF",
  stealth = isDark and "#4E546B" or "#A7ACBF",
  bg_lighten = isDark and "#303342" or "#D1D1D1",
  bg_lighten_less = isDark and "#2C2E3C" or "#D1D1D1",
  fg_hl = isDark and "#FFAFF3" or "#9A5BFF",
  bg_hl = isDark and "#151515" or "#E1E1E1",
}

local normal_hl = vim.api.nvim_get_hl(0, { name = "Normal" })
local statusline_hl = vim.api.nvim_get_hl(0, { name = "StatusLine" })
-- local comment_hl = vim.api.nvim_get_hl(0, { name = "Comment" })
local string_hl = vim.api.nvim_get_hl(0, { name = "String" })

local stealth = normal_hl.bg and ut.darken(string.format("#%06x", normal_hl.bg), 0.7) or colors.stealth
local fg_lighten = normal_hl.bg and ut.darken(string.format("#%06x", normal_hl.bg), 0.6) or colors.stealth
local bg_lighten = normal_hl.bg and ut.lighten(string.format("#%06x", normal_hl.bg), 0.95) or colors.bg_lighten
local bg_lighten_less = normal_hl.bg and ut.lighten(string.format("#%06x", normal_hl.bg), 0.98)
  or colors.bg_lighten_less

-- vim.api.nvim_set_hl(0, "SLStealth", { fg = stealth, bg = normal_hl.bg })
vim.api.nvim_set_hl(0, "SLBgLighten", { fg = fg_lighten, bg = bg_lighten })
-- vim.api.nvim_set_hl(0, "SLBgLightenLess", { fg = comment_hl.fg, bg = bg_lighten_less })
vim.api.nvim_set_hl(0, "SLBgLightenLess", { fg = stealth, bg = bg_lighten_less })
-- vim.api.nvim_set_hl(0, "SLBgNone", { fg = fg_lighten, bg = "none", underline = true })
-- vim.api.nvim_set_hl(0, "SLBgNoneHl", { fg = colors.fg_hl, bg = "none", underline = true, sp = fg_lighten })
vim.api.nvim_set_hl(0, "SLBgNone", { fg = fg_lighten, bg = bg_lighten_less })
vim.api.nvim_set_hl(0, "SLBgNoneHl", { fg = colors.fg_hl, bg = "none" })
vim.api.nvim_set_hl(0, "StatusReplace", { bg = colors.red, fg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusInsert", { bg = colors.insert, fg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusVisual", { bg = colors.select, fg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusTerminal", { bg = "#33B1FF", fg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusNormal", { bg = colors.blue, fg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusCommand", { bg = colors.yellow, fg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusDir", { fg = string_hl.fg, bg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "SLFileName", { fg = statusline_hl.fg, bg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "SLNotModifiable", { fg = colors.yellow, bg = statusline_hl.bg })
vim.api.nvim_set_hl(0, "SLNormal", { fg = fg_lighten, bg = statusline_hl.bg })
vim.api.nvim_set_hl(0, "SLNormalNoFg", { bg = statusline_hl.bg })
vim.api.nvim_set_hl(0, "SLBufNr", { fg = "#4E546B", bg = statusline_hl.bg })
vim.api.nvim_set_hl(0, "SLModified", { fg = "#FF7EB6", bg = statusline_hl.bg })
vim.api.nvim_set_hl(0, "SLMatches", { fg = colors.bg_hl, bg = colors.fg_hl })
vim.api.nvim_set_hl(0, "SLGitHunks", { fg = colors.insert, bg = bg_lighten_less })
vim.api.nvim_set_hl(0, "SLDecorator", { fg = "#414868", bg = "#7AA2F7", bold = true })

---@return string
---@param opts? {status:number, mono:boolean}
function Status_line(opts)
  opts = vim.tbl_extend("force", { status = 1, mono = true }, opts)
  local num = vim.tbl_contains({ 1, 2 }, opts.status) and opts.status or 1
  local mono = opts.mono
  local statusline = ""
  local filetype = vim.bo.filetype

  local filetypes = { "neo-tree", "minifiles", "NvimTree", "oil", "TelescopePrompt" }
  if vim.tbl_contains(filetypes, filetype) then
    local home_dir = os.getenv("HOME")
    local api = require("nvim-tree.api")
    local node = api.tree.get_node_under_cursor()
    local dir = filetype == "NvimTree" and node.absolute_path or vim.fn.getcwd()
    dir = dir:gsub("^" .. home_dir, "~")
    -- return c.decorator({ name = dir, align = num == 1 and "right" or "left" })
    return c.decorator({ name = dir, align = "left" })
  end

  local components2 = {
    c.mode(),
    c.filetype(),
    "%#SLBgLightenLess#",
    c.fileinfo(),
    c.lsp_diagnostics({ mono = mono }),
    "%=%#SLBgLightenLess#",
    c.search_count(),
    "%=",
    c.lsp_progress(),
    c.get_words(),
    _G.show_more_info and c.lang_version() or "",
    _G.show_more_info and c.LSP() or "",
    _G.show_more_info and " Ux%04B" or "",
    _G.show_more_info and c.get_position() or "",
    c.codeium_status(),
    c.terminal_status(),
    c.git_status({ mono = mono }),
    c.git_branch(),
    c.cwd(),
  }

  local simple = {
    -- "%#SLNormal#",
    c.fileinfo({ add_icon = false }),
    "%=",
    c.search_count(),
    c.lsp_progress(),
    c.get_words(),
    _G.show_more_info and c.lang_version() or "",
    _G.show_more_info and c.LSP() or "",
    _G.show_more_info and " Ux%04B " or "",
    -- _G.show_more_info and c.get_position() or "",
    c.terminal_status(),
    _G.show_more_info and c.git_branch() or "",
    c.status_noice(),
    _G.show_more_info and vim.bo.filetype:upper() .. " " or "",
    c.codeium_status(),
    c.get_copilot_status(),
    c.get_position(),
    c.lsp_diagnostics_simple(),
    c.git_status_simple(),
  }

  statusline = num == 1 and table.concat(simple) or table.concat(components2)

  return statusline
end

function StatusBoring()
  local components = {
    c.mode(),
    "%#SLBgNone#",
    c.fileinfo({ add_icon = false }),
    "%h%m%r",
    c.git_boring(),
    c.diagnostics_boring(),
    "%=",
    c.search_count() .. "%#SLBgNone#",
    "%=",
    -- "%3l,%-2c" .. (vim.g.codeium_enabled and string.rep(" ", 1) or string.rep(" ", 10)),
    c.codeium_status(),
    "  " .. vim.loop.cwd():match("([^/\\]+)[/\\]*$") .. " ",
  }

  return table.concat(components)
end

-- vim.o.statusline = "%!v:lua.Status_line(2)"
vim.o.statusline = '%!luaeval("Status_line({ status = 1, mono = false })")'
-- vim.o.statusline = '%!luaeval("_G.show_more_info and Status_line({ status = 2, mono = false }) or StatusBoring()")'
