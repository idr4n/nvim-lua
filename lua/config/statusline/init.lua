local ut = require("utils")
local c = require("config.statusline.components")

local isDark = vim.o.background == "dark"

local colors = {
  green = "#4FD6BE",
  orange = "#FF966C",
  yellow = "#E2B86B",
  red = isDark and "#DE6E7C" or "#D73A4A",
  blue = isDark and "#6E89C3" or "#1E1E1E",
  insert = isDark and "#B08CEA" or "#9A5BFF",
  select = isDark and "#FCA7EA" or "#2188FF",
  stealth = isDark and "#4E546B" or "#A7ACBF",
  bg_lighten = isDark and "#333333" or "#D1D1D1",
}

local normal_hl = vim.api.nvim_get_hl(0, { name = "Normal" })
local statusline_hl = vim.api.nvim_get_hl(0, { name = "StatusLine" })
local comment_hl = vim.api.nvim_get_hl(0, { name = "Comment" })
local string_hl = vim.api.nvim_get_hl(0, { name = "String" })

local stealth = normal_hl.bg and ut.darken(string.format("#%06x", normal_hl.bg), 0.7) or colors.stealth
local bg_lighten = normal_hl.bg and ut.lighten(string.format("#%06x", normal_hl.bg), 0.96) or colors.bg_lighten
local bg_lighten_less = normal_hl.bg and ut.lighten(string.format("#%06x", normal_hl.bg), 0.98) or colors.bg_lighten

vim.api.nvim_set_hl(0, "SLStealth", { fg = stealth, bg = normal_hl.bg })
vim.api.nvim_set_hl(0, "SLBgLighten", { fg = comment_hl.fg, bg = bg_lighten })
vim.api.nvim_set_hl(0, "SLBgLightenLess", { fg = comment_hl.fg, bg = bg_lighten_less })
vim.api.nvim_set_hl(0, "StatusReplace", { bg = colors.red, fg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusInsert", { bg = colors.insert, fg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusVisual", { bg = colors.select, fg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusTerminal", { bg = "#33B1FF", fg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusNormal", { bg = colors.blue, fg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusCommand", { bg = colors.yellow, fg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusDir", { fg = string_hl.fg, bg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "SLFileName", { fg = statusline_hl.fg, bg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "SLNotModifiable", { fg = colors.yellow, bg = statusline_hl.bg })
vim.api.nvim_set_hl(0, "SLNormal", { fg = stealth, bg = statusline_hl.bg })
vim.api.nvim_set_hl(0, "SLBufNr", { fg = "#4E546B", bg = statusline_hl.bg })
vim.api.nvim_set_hl(0, "SLModified", { fg = "#FF7EB6", bg = statusline_hl.bg })
vim.api.nvim_set_hl(0, "SLMatches", { fg = "#2C2A2E", bg = "#3DDBD9" })
vim.api.nvim_set_hl(0, "SLGitHunks", { fg = colors.insert, bg = bg_lighten_less })

function Status_line()
  local statusline = ""
  local filetype = vim.bo.filetype

  if filetype == "neo-tree" or filetype == "minifiles" then
    local home_dir = os.getenv("HOME")
    local dir = vim.fn.getcwd()
    dir = dir:gsub("^" .. home_dir, "~")
    return c.decorator(dir)
  end

  local components = {
    "%#SLStealth#",
    _G.show_more_info and c.fileinfo() or "",
    _G.show_more_info and c.git_branch() or "",
    "%=",
    c.search_count(),
    "%=",
    _G.show_more_info and c.lang_version() or "",
    _G.show_more_info and " Ux%04B" or "",
    _G.show_more_info and c.get_position() or "",
    c.mode(),
    c.filetype(),
    _G.show_more_info and c.git_status() or "",
    not _G.show_more_info and c.git_hunks() or "",
    c.lsp_diagnostic(),
  }

  statusline = table.concat(components)

  return statusline
end

vim.o.statusline = "%!v:lua.Status_line()"

vim.api.nvim_create_augroup("statusline", { clear = true })
vim.api.nvim_create_autocmd("DiagnosticChanged", {
  pattern = { "*" },
  callback = function()
    vim.o.statusline = "%!v:lua.Status_line()"
  end,
  group = "statusline",
})
