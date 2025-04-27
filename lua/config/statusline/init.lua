local ut = require("utils")
local c = require("config.statusline.components")
local colors = c.colors

local normal_hl = vim.api.nvim_get_hl(0, { name = "Normal" })
local statusline_hl = vim.api.nvim_get_hl(0, { name = "StatusLine" })
local fg_lighten = normal_hl.bg and ut.darken(string.format("#%06x", normal_hl.bg), 0.6) or colors.stealth

-- Create highlight groups
vim.api.nvim_set_hl(0, "SLBgNoneHl", { fg = colors.fg_hl, bg = "none" })
vim.api.nvim_set_hl(0, "StatusReplace", { bg = colors.red, fg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusInsert", { bg = colors.insert, fg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusVisual", { bg = colors.select, fg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusNormal", { bg = colors.blue, fg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusCommand", { bg = colors.yellow, fg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusReplaceInv", { fg = colors.red, bg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusInsertInv", { fg = colors.insert, bg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusVisualInv", { fg = colors.select, bg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusNormalInv", { fg = colors.blue, bg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusCommand", { fg = colors.yellow, bg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "SLNotModifiable", { fg = colors.yellow, bg = statusline_hl.bg })
vim.api.nvim_set_hl(0, "SLNormal", { fg = fg_lighten, bg = statusline_hl.bg })
vim.api.nvim_set_hl(0, "SLModified", { fg = "#FF7EB6", bg = statusline_hl.bg })
vim.api.nvim_set_hl(0, "SLMatches", { fg = colors.bg_hl, bg = colors.fg_hl })
vim.api.nvim_set_hl(0, "SLDecorator", { fg = "#414868", bg = "#7AA2F7", bold = true })

---@return string
function Status_line()
  local filetype = vim.bo.filetype

  local filetypes = { "neo-tree", "minifiles", "NvimTree", "oil", "TelescopePrompt", "fzf", "snacks_picker_input" }
  if vim.tbl_contains(filetypes, filetype) then
    local home_dir = os.getenv("HOME")
    local api = require("nvim-tree.api")
    local node = api.tree.get_node_under_cursor()
    local dir = filetype == "NvimTree" and node.absolute_path or vim.fn.getcwd()
    dir = dir:gsub("^" .. home_dir, "~")
    local ft = filetype:sub(1, 1):upper() .. filetype:sub(2)
    return c.decorator({ name = ft .. ": " .. dir, align = "left" })
  end

  local components = {
    -- "%#SLNormal#",
    c.padding(),
    -- c.mode(),
    c.fileinfo({ add_icon = false }),
    "%=",
    c.maximized_status(),
    c.search_count(),
    c.show_macro_recording(),
    "%=",
    c.lsp_progress(),
    _G.show_more_info and c.lang_version() or "",
    _G.show_more_info and c.LSP() or "",
    _G.show_more_info and " Ux%04B " or "",
    c.terminal_status(),
    _G.show_more_info and c.git_branch() or "",
    _G.show_more_info and c.separator() or "",
    c.codeium_status(),
    c.get_copilot_status(),
    c.padding(),
    c.get_fileinfo_widget(),
    c.padding(),
    c.get_position(),
    c.padding(2),
    c.file_icon() .. " ",
    vim.bo.filetype:upper(),
    c.padding(2),
    c.scrollbar2(),
    c.padding(),
    c.lsp_diagnostics_simple(),
    c.git_status_simple(),
    -- c.padding(3),
  }

  return table.concat(components)
end

vim.o.statusline = '%!luaeval("Status_line()")'
