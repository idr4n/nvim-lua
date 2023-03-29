local icons = require("icons")
local colors = require("plugins.lualine.my_theme").colors

local mode_color = {
    ["n"] = "#82cfff",
    ["i"] = "#ff7eb6",
    -- ["i"] = "String",
    ["ic"] = "#ff7eb6",
    ["v"] = "#be95ff",
    ["V"] = "#be95ff",
    ["\22"] = "#be95ff",
    ["R"] = "#3ddbd9",
    ["c"] = "#42be65",
    ["t"] = "#33b1ff",
}

-- check if value in table
-- local function contains(t, value)
--     for _, v in pairs(t) do
--         if v == value then
--             return true
--         end
--     end
--     return false
-- end

-- local function fg(name)
--     return function()
--         ---@type {foreground?:number}?
--         local hl = vim.api.nvim_get_hl_by_name(name, true)
--         return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
--     end
-- end
-- vim.api.nvim_set_hl(0, "SLNormal", { fg = vim.api.nvim_get_hl_by_name("Normal", true) })

local function isempty(s)
    return s == nil or s == ""
end

vim.api.nvim_set_hl(0, "StatusDir", { fg = "#be95ff" })
vim.api.nvim_set_hl(0, "StatusIconLock", { fg = "#f6c177" })
vim.api.nvim_set_hl(0, "SLNormal", { fg = colors.normal })
vim.api.nvim_set_hl(0, "SLModified", { fg = "#ff7eb6" })
vim.api.nvim_set_hl(0, "SLMatches", { fg = "#2c2a2e", bg = "#3ddbd9" })
vim.api.nvim_set_hl(0, "SLDiagnosticOK", { fg = colors.green })
vim.api.nvim_set_hl(0, "SLDiagnosticWarn", { fg = "#ff9e64", bold = true })
vim.api.nvim_set_hl(0, "SLDiagnosticInfo", { fg = "#3ddbd9", bold = true })
vim.api.nvim_set_hl(0, "SLDiagnosticHints", { fg = "#f6c177", bold = true })
vim.api.nvim_set_hl(0, "SLDiagnosticError", { fg = "#ff7eb6", bold = true })

local M = {}

local hide_in_width_60 = function()
    return vim.o.columns > 60
end

local hide_in_width_120 = function()
    return vim.o.columns > 120
end

local hide_in_width_140 = function()
    return vim.o.columns > 140
end

M.mode = {
    function()
        return "▍  "
        -- return "  "
    end,
    color = function()
        return { fg = mode_color[vim.fn.mode()], gui = "bold" }
    end,
    padding = 0,
}

M.getWords = {
    function()
        if vim.bo.filetype == "md" or vim.bo.filetype == "text" or vim.bo.filetype == "markdown" then
            if vim.fn.wordcount().visual_words == nil then
                return " " .. tostring(vim.fn.wordcount().words)
            end
            return " " .. tostring(vim.fn.wordcount().visual_words)
        else
            return ""
        end
    end,
    padding = 1,
    color = { fg = colors.orange },
}

M.get_fileinfo = {
    function()
        local filename = ""

        if vim.fn.expand("%") == "" then
            return " nvim "
        end

        -- local ignored_filetypes = { "fzf", "neo-tree", "toggleterm", "TelescopePrompt" }
        -- local buf_ft = vim.bo.filetype
        -- if contains(ignored_filetypes, buf_ft) then
        --     return ""
        -- end

        filename = "%#StatusDir#" .. (vim.fn.expand("%:p:h:t")) .. "/" .. "%#SLNormal#" .. vim.fn.expand("%:t")

        if vim.bo.modified then
            filename = (vim.fn.expand("%:p:h:t")) .. "/" .. vim.fn.expand("%:t")
            return ("%#SLModified#" .. " " .. filename)
        end

        return filename
    end,
}

M.get_fileicon = {
    function()
        local icon, icon_highlight_group
        local devicons = require("nvim-web-devicons")
        icon, icon_highlight_group = devicons.get_icon(vim.fn.expand("%:t"))
        if icon == nil then
            icon, icon_highlight_group = devicons.get_icon_by_filetype(vim.bo.filetype)
        end

        if icon == nil and icon_highlight_group == nil then
            icon = ""
            icon_highlight_group = "DevIconDefault"
        end
        if not vim.bo.modifiable then
            icon = ""
            icon_highlight_group = "StatusIconLock"
        end

        return "  %#" .. icon_highlight_group .. "#" .. icon
    end,
}

local function getGitChanges()
    local gitsigns = vim.b.gitsigns_status_dict
    local git_icon = "  "
    local changes = 0
    local status = ""
    if gitsigns then
        changes = (gitsigns.added or 0) + (gitsigns.changed or 0) + (gitsigns.removed or 0)
    end
    if changes > 0 then
        status = string.format("%s%d", git_icon, changes)
    end
    return status
end

M.get_git_status = {
    function()
        local branch = (vim.b.gitsigns_status_dict or { head = "" })
        local is_head_empty = (branch.head ~= "")
        return ((is_head_empty and string.format("(λ • #%s%s)", (branch.head or ""), getGitChanges())) or "")
    end,
}

M.get_bufnr = {
    function()
        return vim.api.nvim_get_current_buf()
    end,
    color = "Comment",
}

M.get_filetype = {
    function()
        local filetype = vim.bo.filetype
        filetype = filetype:sub(1, 1):upper() .. filetype:sub(2)
        return ("%#StatusDir#" .. filetype .. " ")
    end,
}

M.get_lsp_diagnostic = {
    function()
        local function get_severity(s)
            return #vim.diagnostic.get(0, { severity = s })
        end

        local result = {
            errors = get_severity(vim.diagnostic.severity.ERROR),
            warnings = get_severity(vim.diagnostic.severity.WARN),
            info = get_severity(vim.diagnostic.severity.INFO),
            hints = get_severity(vim.diagnostic.severity.HINT),
        }

        local total = result.errors + result.warnings + result.hints + result.info
        local errors = ""
        local warnings = ""
        local info = ""
        local hints = ""

        if result.errors > 0 then
            errors = " " .. result.errors .. " "
        end
        if result.warnings > 0 then
            warnings = " " .. result.warnings .. " "
        end
        if result.info > 0 then
            info = " " .. result.warnings .. " "
        end
        if result.hints > 0 then
            hints = " " .. result.hints .. " "
        end

        if vim.bo.modifiable then
            if #vim.lsp.buf_get_clients() == 0 then
                return ""
            elseif total == 0 then
                return " %#SLDiagnosticOK#" .. " "
            else
                return string.format(
                    " %%#SLDiagnosticWarn#%s%%#SLDiagnosticError#%s%%#SLDiagnosticInfo#%s%%#SLDiagnosticHints#%s",
                    warnings,
                    errors,
                    info,
                    hints
                )
            end
        else
            return ""
        end
    end,
}

M.diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn", "info", "hint" },
    diagnostics_color = {
        error = colors.error,
        warn = colors.warning,
        info = colors.info,
        hint = "SLDiagnosticHints", -- colors.hint is not working for some reason
    },
    symbols = {
        error = icons.diagnostics.Error,
        warn = icons.diagnostics.Warning,
        info = icons.diagnostics.Information,
        hint = icons.diagnostics.Hint,
    },
    update_in_insert = false,
    always_visible = false,
    fmt = function(str)
        if vim.bo.modifiable then
            if #vim.lsp.buf_get_clients() == 0 then
                return ""
            elseif #str == 0 then
                return "%#SLDiagnosticOK#" .. " "
            else
                return str
            end
        else
            return ""
        end
    end,
    padding = { right = 1 },
}

local function progress()
    local cur = vim.fn.line(".")
    local total = vim.fn.line("$")
    if cur == 1 then
        return "Top"
    elseif cur == total then
        return "Bot"
    else
        return math.floor(cur / total * 100) .. "%%"
    end
end

M.get_searchcount = {
    function()
        if vim.v.hlsearch == 0 then
            return "%l:%c " .. progress()
        end
        local ok, count = pcall(vim.fn.searchcount, { recompute = true })
        if (not ok or (count.current == nil)) or (count.total == 0) then
            return ""
        end
        if count.incomplete == 1 then
            return "?/?"
        end
        local too_many = (">%d"):format(count.maxcount)
        local total = (((count.total > count.maxcount) and too_many) or count.total)
        return ("%#SLMatches#" .. ("%s matches"):format(total))
    end,
}

M.noice = {
    function()
        return require("noice").api.status.command.get()
    end,
    cond = function()
        return package.loaded["noice"] and require("noice").api.status.command.has()
    end,
    padding = 1,
}

M.current_signature = {
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
            return ": " .. hint
        end

        return ""
    end,
    cond = hide_in_width_140,
    padding = 1,
}

M.charcode = {
    function()
        return "Ux%04B"
    end,
    padding = 1,
    cond = hide_in_width_120,
}

M.python_env = {
    function()
        if vim.bo.filetype == "python" then
            local venv = os.getenv("CONDA_DEFAULT_ENV") or os.getenv("VIRTUAL_ENV")
            if venv then
                local icons = require("nvim-web-devicons")
                local py_icon, _ = icons.get_icon(".py")
                local venv_name = string.match(venv, "/(%w+)$")
                return string.format(" (" .. py_icon .. " %s)", venv_name)
            end
        end
        return ""
    end,
}

return M
