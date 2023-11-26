local c = require("config.statusline.components")
local appearance = vim.fn.system("defaults read -g AppleInterfaceStyle")
-- local isDark = appearance:match("^Dark") ~= nil
local isDark = true
if vim.fn.has("linux") == 1 then
    isDark = true
end

local colors = {
    green = "#4fd6be",
    orange = "#ff966c",
    yellow = "#f6c177",
    red = isDark and "#DE6E7C" or "#D73A4A",
    blue = isDark and "#65bcff" or "#0A407F",
    insert = isDark and "#FF7EB6" or "#8754FF",
    select = isDark and "#9FBFE4" or "#2188FF",
}

-- local statusline_hl = vim.api.nvim_get_hl(0, { name = "StatusLine" })
local statusline_hl = vim.api.nvim_get_hl(0, { name = "StatusLine" })
local comment_hl = vim.api.nvim_get_hl(0, { name = "Comment" })
local string_hl = vim.api.nvim_get_hl(0, { name = "String" })
local keyword_hl = vim.api.nvim_get_hl(0, { name = "Keyword" })
local warn_hl = vim.api.nvim_get_hl(0, { name = "DiagnosticWarn" })
local info_hl = vim.api.nvim_get_hl(0, { name = "DiagnosticInfo" })
local hint_hl = vim.api.nvim_get_hl(0, { name = "DiagnosticHint" })
local error_hl = vim.api.nvim_get_hl(0, { name = "DiagnosticError" })

vim.api.nvim_set_hl(0, "StatusReplace", { fg = colors.red, bg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusReplaceBg", { bg = colors.red, fg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusInsert", { fg = colors.insert, bg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusInsertBg", { bg = colors.insert, fg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusVisual", { fg = colors.select, bg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusVisualBg", { bg = colors.select, fg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusTerminal", { fg = "#33b1ff", bg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusTerminalBg", { bg = "#33b1ff", fg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusNormal", { fg = colors.blue, bg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusNormalBg", { bg = colors.blue, fg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusCommand", { fg = colors.yellow, bg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusCommandBg", { bg = colors.yellow, fg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusDir", { fg = string_hl.fg, bg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "SLFileName", { fg = statusline_hl.fg, bg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "SLFileType", { fg = keyword_hl.fg, bg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "SLWords", { fg = colors.orange, bg = statusline_hl.bg })
vim.api.nvim_set_hl(0, "StatusIconLock", { fg = colors.yellow, bg = statusline_hl.bg })
vim.api.nvim_set_hl(0, "SLNormal", { fg = statusline_hl.fg, bg = statusline_hl.bg })
-- vim.api.nvim_set_hl(0, "SLNormalBg", { bg = statusline_hl.bg })
vim.api.nvim_set_hl(0, "SLBufNr", { fg = comment_hl.fg, bg = statusline_hl.bg })
vim.api.nvim_set_hl(0, "SLModified", { fg = "#ff7eb6", bg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "SLMatches", { fg = "#2c2a2e", bg = "#3ddbd9" })
vim.api.nvim_set_hl(0, "SLDiagnosticOK", { fg = colors.green, bg = statusline_hl.bg })
vim.api.nvim_set_hl(0, "SLDiagnosticWarn", { fg = warn_hl.fg, bg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "SLDiagnosticInfo", { fg = info_hl.fg, bg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "SLDiagnosticHint", { fg = hint_hl.fg, bg = statusline_hl.bg, bold = true })
vim.api.nvim_set_hl(0, "SLDiagnosticError", { fg = error_hl.fg, bg = statusline_hl.bg, bold = true })

function Status_line()
    local statusline = ""
    statusline = c.mode()
    statusline = statusline .. "  " .. c.get_position()
    statusline = statusline .. "  " .. c.total_lines()
    -- statusline = statusline .. "  " .. c.get_bufnr()
    statusline = statusline .. "%=" .. c.get_fileinfo()
    statusline = statusline .. c.get_search_count()
    statusline = statusline .. c.maximized_status()
    statusline = statusline .. "%="
    statusline = statusline .. c.colemak()
    statusline = statusline .. c.lsp_running()
    statusline = statusline .. c.get_words()
    statusline = statusline .. c.charcode()
    statusline = statusline .. c.git_status()
    statusline = statusline .. c.get_filetype()
    statusline = statusline .. c.get_lsp_diagnostic()

    return statusline
end

vim.o.statusline = "%!v:lua.Status_line()"

vim.api.nvim_create_augroup("statusline", { clear = true })
vim.api.nvim_create_autocmd("DiagnosticChanged", {
    pattern = { "*" },
    callback = function()
        vim.o.statusline = "%!v:lua.Status_line()"
        -- vim.cmd("redrawstatus")
    end,
    group = "statusline",
})
