local M = {}

M.colors = {
    diff_added = { fg = "#4EC9B0" },
    diff_modified = { fg = "#CE9178" },
    diff_removed = { fg = "#D16969" },
    error = { fg = "#bf616a" },
    warning = { fg = "#D7BA7D" },
    gray = "#32363e",
    dark_gray = "#292E42",
    yellow_orange = "#D7BA7D",
    none = "NONE",
    bg = "#222436",
    bg_highlight = "#2f334d",
    terminal_black = "#444a73",
    black = "black",
    fg = "#c8d3f5",
    bg_dark = "#16161E",
    bg_dark2 = "#1e2030",
    fg_dark = "#828bb8",
    fg_gutter = "#3b4261",
    blue0 = "#3e68d7",
    blue = "#82aaff",
    cyan = "#86e1fc",
    cyan2 = "#4EC9B0",
    blue1 = "#65bcff",
    blue2 = "#0db9d7",
    blue5 = "#89ddff",
    blue6 = "#b4f9f8",
    blue7 = "#394b70",
    blue8 = "#569CD6",
    purple = "#fca7ea",
    purple2 = "#C586C0",
    magenta2 = "#ff007c",
    magenta = "#c099ff",
    orange = "#ff966c",
    orange2 = "#CE9178",
    yellow = "#ffc777",
    green = "#c3e88d",
    green1 = "#4fd6be",
    green2 = "#41a6b5",
    teal = "#4fd6be",
    red = "#ff757f",
    red1 = "#c53b53",
    red2 = "#D16969",
}

local colors_light = {
    blue = "#82aaff",
    black = "black",
    dark_gray = "#EFEFEF",
    fg_dark = "#828bb8",
    bg_dark2 = "#f6f8fa",
    orange2 = "#DB8D18",
    magenta = "#c099ff",
    yellow = "#FFC169",
    red = "#ff757f",
    green2 = "#41a6b5",
    fg_gutter = "#3b4261",
}

M.setup = function()
    local appearance = vim.fn.system("defaults read -g AppleInterfaceStyle")
    local isDark = appearance:match("^Dark") ~= nil

    local colors = M.colors

    if not isDark then
        colors = colors_light
    end

    local bg_statusline = colors.bg_dark2

    return {
        normal = {
            a = { bg = colors.blue, fg = colors.black },
            b = { bg = colors.dark_gray, fg = colors.blue },
            c = { bg = bg_statusline, fg = colors.fg_dark },
        },
        insert = {
            a = { bg = colors.magenta, fg = colors.black },
            b = { bg = colors.dark_gray, fg = colors.magenta },
        },
        visual = {
            a = { bg = colors.orange2, fg = colors.black },
            b = { bg = colors.dark_gray, fg = colors.orange2 },
        },
        command = {
            a = { bg = colors.yellow, fg = colors.black },
            b = { bg = colors.dark_gray, fg = colors.yellow },
        },
        replace = {
            a = { bg = colors.red, fg = colors.black },
            b = { bg = colors.dark_gray, fg = colors.red },
        },
        terminal = {
            a = { bg = colors.green2, fg = colors.black },
            b = { bg = colors.dark_gray, fg = colors.green2 },
        },
        inactive = {
            a = { bg = bg_statusline, fg = colors.blue },
            b = { bg = bg_statusline, fg = colors.fg_gutter, gui = "bold" },
            c = { bg = bg_statusline, fg = colors.fg_gutter },
        },
    }
end

return M
