local M = {}

M.colors = {
    diff_added = { fg = "#4EC9B0" },
    diff_modified = { fg = "#CE9178" },
    diff_removed = { fg = "#D16969" },
    error = { fg = "#ff7eb6" },
    warning = { fg = "#ff9e64" },
    hint = { fg = "#f6c177" },
    info = { fg = "#3ddbd9" },
    normal = "#A6ACCD",
    gray = "#32363e",
    none = "NONE",
    bg = "#171822",
    bg_highlight = "#2f334d",
    black = "black",
    fg = "#c8d3f5",
    fg_dark = "#828bb8",
    fg_gutter = "#3b4261",
    cyan = "#86e1fc",
    blue = "#65bcff",
    purple = "#fca7ea",
    purple2 = "#C586C0",
    magenta2 = "#ff007c",
    magenta = "#c099ff",
    orange = "#ff966c",
    orange2 = "#CE9178",
    yellow = "#ffc777",
    green = "#4fd6be",
    red = "#ff757f",
}

local colors_light = {
    normal = "#404040",
    blue = "#82aaff",
    black = "black",
    dark_gray = "#EFEFEF",
    fg_dark = "#828bb8",
    bg_dark2 = "#f6f8fa",
    orange = "#DB8D18",
    magenta = "#c099ff",
    yellow = "#FFC169",
    red = "#ff757f",
    green = "#41a6b5",
    fg_gutter = "#3b4261",
    none = "NONE",
}

M.setup = function()
    -- local appearance = vim.fn.system("defaults read -g AppleInterfaceStyle")
    -- local isDark = appearance:match("^Dark") ~= nil

    local colors = M.colors

    local statusline_hl = vim.api.nvim_get_hl(0, { name = "StatusLine" })
    local comment_hl = vim.api.nvim_get_hl(0, { name = "Comment" })
    local string_hl = vim.api.nvim_get_hl(0, { name = "String" })
    local keyword_hl = vim.api.nvim_get_hl(0, { name = "Keyword" })

    vim.api.nvim_set_hl(0, "StatusDir", { fg = string_hl.fg, bg = statusline_hl.bg, bold = true })
    vim.api.nvim_set_hl(0, "SLFileName", { fg = statusline_hl.fg, bg = statusline_hl.bg, bold = true })
    vim.api.nvim_set_hl(0, "SLFileType", { fg = keyword_hl.fg, bg = statusline_hl.bg, bold = true })
    vim.api.nvim_set_hl(0, "StatusIconLock", { fg = "#f6c177", bg = statusline_hl.bg })
    vim.api.nvim_set_hl(0, "SLNormal", { fg = statusline_hl.fg, bg = statusline_hl.bg })
    -- vim.api.nvim_set_hl(0, "SLNormalBg", { bg = statusline_hl.bg })
    vim.api.nvim_set_hl(0, "SLBufNr", { fg = comment_hl.fg, bg = statusline_hl.bg })
    vim.api.nvim_set_hl(0, "SLModified", { fg = "#ff7eb6", bg = statusline_hl.bg, bold = true })
    vim.api.nvim_set_hl(0, "SLMatches", { fg = "#2c2a2e", bg = "#3ddbd9" })
    vim.api.nvim_set_hl(0, "SLDiagnosticOK", { fg = colors.green, bg = statusline_hl.bg })
    vim.api.nvim_set_hl(0, "SLDiagnosticWarn", { fg = "#ff9e64", bg = statusline_hl.bg, bold = true })
    vim.api.nvim_set_hl(0, "SLDiagnosticInfo", { fg = "#3ddbd9", bg = statusline_hl.bg, bold = true })
    vim.api.nvim_set_hl(0, "SLDiagnosticHints", { fg = "#f6c177", bg = statusline_hl.bg, bold = true })
    vim.api.nvim_set_hl(0, "SLDiagnosticError", { fg = "#ff7eb6", bg = statusline_hl.bg, bold = true })

    -- if not isDark then
    --     colors = colors_light
    -- end

    return {
        normal = {
            a = "SLNormal",
            b = "SLNormal",
            c = "SLNormal",
        },
        inactive = {
            a = { fg = colors.fg_gutter, bg = string.format("#%06x", statusline_hl.background) },
            b = { fg = colors.fg_gutter, bg = string.format("#%06x", statusline_hl.background) },
            c = { fg = colors.fg_gutter, bg = string.format("#%06x", statusline_hl.background) },
        },
    }
end

return M
