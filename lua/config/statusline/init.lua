local c = require("config.statusline.components")

-- statusline highlight groups based on nvim-nyoom and oxocarbon
vim.api.nvim_set_hl(0, "StatusIconLock", { fg = "#f6c177" })
vim.api.nvim_set_hl(0, "StatusReplace", { fg = "#161616", bg = "#3ddbd9" })
vim.api.nvim_set_hl(0, "StatusReplaceFg", { fg = "#3ddbd9" })
vim.api.nvim_set_hl(0, "StatusInsert", { fg = "#161616", bg = "#ff7eb6" })
vim.api.nvim_set_hl(0, "StatusInsertFg", { fg = "#ff7eb6" })
vim.api.nvim_set_hl(0, "StatusDir", { fg = "#be95ff" })
vim.api.nvim_set_hl(0, "StatusVisual", { fg = "#161616", bg = "#be95ff" })
vim.api.nvim_set_hl(0, "StatusVisualFg", { fg = "#be95ff" })
vim.api.nvim_set_hl(0, "StatusTerminal", { fg = "#161616", bg = "#33b1ff" })
vim.api.nvim_set_hl(0, "StatusTerminalFg", { fg = "#33b1ff" })
vim.api.nvim_set_hl(0, "StatusNormal", { fg = "#161616", bg = "#82cfff" })
vim.api.nvim_set_hl(0, "StatusNormalFg", { fg = "#82cfff" })
vim.api.nvim_set_hl(0, "StatusCommand", { fg = "#161616", bg = "#42be65" })
vim.api.nvim_set_hl(0, "StatusCommandFg", { fg = "#42be65" })
vim.api.nvim_set_hl(0, "StatusLineDiagnosticWarn", { fg = "#be95ff", bold = true })
vim.api.nvim_set_hl(0, "StatusLineDiagnosticInfo", { fg = "#3ddbd9", bold = true })
vim.api.nvim_set_hl(0, "StatusLineDiagnosticHints", { fg = "#f6c177", bold = true })
vim.api.nvim_set_hl(0, "StatusLineDiagnosticError", { fg = "#ff7eb6", bold = true })

function Status_line()
    local statusline = ""
    -- statusline = c.color() .. string.format(" %s ", modes[vim.api.nvim_get_mode().mode]):upper()
    statusline = c.color() .. "▍  " .. "%#Normal#"
    statusline = statusline .. c.get_fileicon()
    statusline = statusline .. c.get_fileinfo()
    statusline = statusline .. c.get_searchcount()
    statusline = statusline .. c.get_bufnr()
    statusline = statusline .. c.python_env()
    statusline = statusline .. "%="
    statusline = statusline .. c.getWords()
    statusline = statusline .. c.get_git_status()
    statusline = statusline .. c.get_filetype()
    statusline = statusline .. c.get_lsp_diagnostic()
    -- statusline = statusline .. c.get_dir()

    return statusline
end

vim.o.statusline = "%!v:lua.Status_line()"
