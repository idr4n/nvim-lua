local M = {}

M.colors = {
    diff_added = { fg = "#4EC9B0" },
    diff_modified = { fg = "#CE9178" },
    diff_removed = { fg = "#D16969" },
    error = { fg = "#ff7eb6" },
    warning = { fg = "#ff9e64" },
    hint = { fg = "#f6c177" },
    info = { fg = "#3ddbd9" },
    normal = "#d2d2d2",
    gray = "#32363e",
    none = "NONE",
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

    -- if not isDark then
    --     colors = colors_light
    -- end

    return {
        normal = {
            a = { fg = colors.normal },
            b = { fg = colors.normal },
            c = { fg = colors.normal },
        },
        insert = {
            a = { fg = colors.normal },
            b = { fg = colors.normal },
        },
        visual = {
            a = { fg = colors.normal },
            b = { fg = colors.normal },
        },
        command = {
            a = { fg = colors.normal },
            b = { fg = colors.normal },
        },
        replace = {
            a = { fg = colors.normal },
            b = { fg = colors.normal },
        },
        terminal = {
            a = { fg = colors.normal },
            b = { fg = colors.normal },
        },
        inactive = {
            a = { fg = colors.fg_gutter },
            b = { fg = colors.fg_gutter },
            c = { fg = colors.fg_gutter },
        },
    }
end

return M
