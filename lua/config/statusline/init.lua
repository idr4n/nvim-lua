local c = require("config.statusline.components")

local colors = {
    green = "#4fd6be",
    orange = "#ff966c",
    yellow = "#f6c177",
}

local statusline_hl = vim.api.nvim_get_hl_by_name("StatusLine", true)
local comment_hl = vim.api.nvim_get_hl_by_name("Comment", true)
local string_hl = vim.api.nvim_get_hl_by_name("String", true)
local keyword_hl = vim.api.nvim_get_hl_by_name("Keyword", true)
local warn_hl = vim.api.nvim_get_hl_by_name("DiagnosticWarn", true)
local info_hl = vim.api.nvim_get_hl_by_name("DiagnosticInfo", true)
local hint_hl = vim.api.nvim_get_hl_by_name("DiagnosticHint", true)
local error_hl = vim.api.nvim_get_hl_by_name("DiagnosticError", true)

vim.api.nvim_set_hl(0, "StatusReplace", { fg = "#3ddbd9", bg = statusline_hl.background, bold = true })
vim.api.nvim_set_hl(0, "StatusInsert", { fg = "#ff7eb6", bg = statusline_hl.background, bold = true })
vim.api.nvim_set_hl(0, "StatusVisual", { fg = "#be95ff", bg = statusline_hl.background, bold = true })
vim.api.nvim_set_hl(0, "StatusTerminal", { fg = "#33b1ff", bg = statusline_hl.background, bold = true })
vim.api.nvim_set_hl(0, "StatusNormal", { fg = "#65bcff", bg = statusline_hl.background, bold = true })
vim.api.nvim_set_hl(0, "StatusCommand", { fg = colors.yellow, bg = statusline_hl.background, bold = true })
vim.api.nvim_set_hl(0, "StatusDir", { fg = string_hl.foreground, bg = statusline_hl.background, bold = true })
vim.api.nvim_set_hl(0, "SLFileName", { fg = statusline_hl.foreground, bg = statusline_hl.background, bold = true })
vim.api.nvim_set_hl(0, "SLFileType", { fg = keyword_hl.foreground, bg = statusline_hl.background, bold = true })
vim.api.nvim_set_hl(0, "SLWords", { fg = colors.orange, bg = statusline_hl.background })
vim.api.nvim_set_hl(0, "StatusIconLock", { fg = colors.yellow, bg = statusline_hl.background })
vim.api.nvim_set_hl(0, "SLNormal", { fg = statusline_hl.foreground, bg = statusline_hl.background })
-- vim.api.nvim_set_hl(0, "SLNormalBg", { bg = statusline_hl.background })
vim.api.nvim_set_hl(0, "SLBufNr", { fg = comment_hl.foreground, bg = statusline_hl.background })
vim.api.nvim_set_hl(0, "SLModified", { fg = "#ff7eb6", bg = statusline_hl.background, bold = true })
vim.api.nvim_set_hl(0, "SLMatches", { fg = "#2c2a2e", bg = "#3ddbd9" })
vim.api.nvim_set_hl(0, "SLDiagnosticOK", { fg = colors.green, bg = statusline_hl.background })
vim.api.nvim_set_hl(0, "SLDiagnosticWarn", { fg = warn_hl.foreground, bg = statusline_hl.background, bold = true })
vim.api.nvim_set_hl(0, "SLDiagnosticInfo", { fg = info_hl.foreground, bg = statusline_hl.background, bold = true })
vim.api.nvim_set_hl(0, "SLDiagnosticHint", { fg = hint_hl.foreground, bg = statusline_hl.background, bold = true })
vim.api.nvim_set_hl(0, "SLDiagnosticError", { fg = error_hl.foreground, bg = statusline_hl.background, bold = true })

function Status_line()
    local statusline = ""
    statusline = c.mode()
    statusline = statusline .. " " .. c.get_fileinfo()
    statusline = statusline .. "  " .. c.get_position()
    statusline = statusline .. "  " .. c.get_bufnr()
    statusline = statusline .. c.get_search_count()
    statusline = statusline .. c.maximized_status()
    statusline = statusline .. "%="
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
        -- vim.o.statusline = "%!v:lua.Status_line()"
        vim.cmd("redrawstatus!")
    end,
    group = "statusline",
})
