-- Statusline components
local devicons = require("nvim-web-devicons")

local M = {}

function _G.get_lang_version(language)
    local script_path = "get_lang_version" -- Adjust the path to the Bash script if needed
    local cmd = script_path .. " " .. language
    local result = vim.fn.system(cmd)
    return result:gsub("%s+", " ")
end

_G.lang_versions = {}

vim.api.nvim_create_augroup("lang_version", { clear = true })
-- vim.api.nvim_create_autocmd("BufWinEnter", {
vim.api.nvim_create_autocmd("LspAttach", {
    pattern = { "*.py", "*.lua", "*.go", "*.rs", "*.js", "*.ts", "*.jsx", "*.tsx", "*.cpp", "*.java" },
    -- pattern = { "*.py", "*.lua", "*.go", "*.rs", "*.js", "*.ts", "*.jsx", "*.tsx", "*.java" },
    callback = function()
        local filetype = vim.bo.filetype
        local lang_v = _G.lang_versions[filetype]
        if not lang_v then
            _G.lang_versions[filetype] = _G.get_lang_version(filetype)
        end
        -- vim.cmd("redrawstatus!")
        -- vim.o.statusline = "%!v:lua.Status_line()"
    end,
    group = "lang_version",
})

local mode_color = {
    ["n"] = "%#StatusNormal#",
    ["i"] = "%#StatusInsert#",
    ["ic"] = "%#StatusInsert#",
    ["v"] = "%#StatusVisual#",
    ["V"] = "%#StatusVisual#",
    ["\22"] = "%#StatusVisual#",
    ["R"] = "%#StatusReplace#",
    ["c"] = "%#StatusCommand#",
    ["t"] = "%#StatusCommand#",
}

function M.mode()
    if mode_color[vim.fn.mode()] then
        return mode_color[vim.fn.mode()] .. "▍ ⬤ "
    else
        return "%#StatusNormal#" .. "▍ ⬤ "
    end
end

local function file_icon()
    local icon, icon_highlight_group = devicons.get_icon(vim.fn.expand("%:t"))
    if icon == nil then
        icon, icon_highlight_group = devicons.get_icon_by_filetype(vim.bo.filetype)
    end

    if icon == nil and icon_highlight_group == nil then
        icon = ""
        icon_highlight_group = "DevIconDefault"
    end

    local icon_hl = vim.api.nvim_get_hl_by_name(icon_highlight_group, true)
    local status_hl = vim.api.nvim_get_hl_by_name("StatusLine", true)
    vim.api.nvim_set_hl(0, "SLIcon", { fg = icon_hl.foreground, bg = status_hl.background })

    if not vim.bo.modifiable then
        icon = ""
        icon_highlight_group = "StatusIconLock"
        return "  %#StatusIconLock#" .. icon
    end

    return "  %#SLIcon#" .. icon
end

function M.get_fileinfo()
    local filename = ""

    if vim.fn.expand("%") == "" then
        return " nvim "
    end

    -- local ignored_filetypes = { "fzf", "neo-tree", "toggleterm", "TelescopePrompt" }
    -- local buf_ft = vim.bo.filetype
    -- if contains(ignored_filetypes, buf_ft) then
    --     return ""
    -- end

    local icon = file_icon() .. " "
    -- local icon = "%#SLNormal#" .. file_icon() .. " "
    filename = icon .. "%#StatusDir#" .. (vim.fn.expand("%:p:h:t")) .. "/" .. "%#SLFileName#" .. vim.fn.expand("%:t")

    if vim.bo.modified then
        filename = (vim.fn.expand("%:p:h:t")) .. "/" .. vim.fn.expand("%:t")
        return (icon .. "%#SLModified#" .. "  " .. filename)
    end

    return filename
end

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

function M.get_position()
    return "%#SLNormal#%l:%c " .. progress()
end

function M.get_search_count()
    if vim.v.hlsearch == 0 then
        return ""
    end

    local ok, count = pcall(vim.fn.searchcount, { recompute = true, maxcount = 500 })
    if (not ok or (count.current == nil)) or (count.total == 0) then
        return ""
    end

    if count.incomplete == 1 then
        return "%#SLMatches# ?/? %#SLNormal#"
    end

    local too_many = (">%d"):format(count.maxcount)
    local total = (((count.total > count.maxcount) and too_many) or count.total)

    return ("  %#SLMatches#" .. (" %s/%s "):format(count.current, total) .. "%#SLNormal#")
end

function M.get_bufnr()
    return "%#SLBufNr#" .. vim.api.nvim_get_current_buf() .. "%#SLNormal#"
end

function M.maximized_status()
    return vim.t.maximized and "   %#SLModified# %#SLNormal#" or ""
end

function M.lsp_running()
    if not vim.bo.modifiable then
        return ""
    end

    if #vim.lsp.buf_get_clients() > 0 then
        return " " .. "%#SLFileType#󱓞 " .. "%#SLNormal#" .. " "
    else
        return ""
    end
end

function M.get_words()
    if vim.bo.filetype == "md" or vim.bo.filetype == "text" or vim.bo.filetype == "markdown" then
        if vim.fn.wordcount().visual_words == nil then
            return " " .. "%#SLWords#" .. " " .. tostring(vim.fn.wordcount().words) .. "%#SLNormal#" .. " "
        end
        return " " .. "%#SLWords#" .. " " .. tostring(vim.fn.wordcount().visual_words) .. "%#SLNormal#" .. " "
    else
        return ""
    end
end

function M.charcode()
    return _G.charcode and " %#SLBufNr#Ux%04B%#SLNormal# " or ""
end

function M.git_status()
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

    local branch = (vim.b.gitsigns_status_dict or { head = "" })
    local git_icon = "%#SLModified#" .. "󰊢 " .. "%#SLFileName#"
    local is_head_empty = (branch.head ~= "")
    -- return ((is_head_empty and string.format("(λ • #%s%s)", (branch.head or ""), getGitChanges())) or "")
    return ((is_head_empty and string.format(" %s%s%s ", git_icon, (branch.head or ""), getGitChanges())) or "")
end

function M.get_filetype()
    local filetype = vim.bo.filetype
    local lang_v = _G.lang_versions[filetype]
    -- local lang_v = ""
    local version = lang_v and lang_v or ""
    filetype = filetype:sub(1, 1):upper() .. filetype:sub(2)
    -- return " " .. "%#SLFileType#" .. filetype .. "%#SLNormal#" .. " "
    return " " .. "%#SLFileType#" .. filetype .. " " .. version .. "%#SLNormal#" .. ""
end

function M.get_lsp_diagnostic()
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
        errors = " " .. " " .. result.errors
    end
    if result.warnings > 0 then
        warnings = " " .. " " .. result.warnings
    end
    if result.info > 0 then
        info = " " .. " " .. result.info
    end
    if result.hints > 0 then
        hints = " " .. " " .. result.hints
    end

    if vim.bo.modifiable then
        if #vim.lsp.buf_get_clients() == 0 then
            return ""
        elseif total == 0 then
            return " %#SLDiagnosticOK#" .. "  "
        else
            return string.format(
                "%%#SLDiagnosticWarn#%s%%#SLDiagnosticError#%s%%#SLDiagnosticInfo#%s%%#SLDiagnosticHint#%s ",
                warnings,
                errors,
                info,
                hints
            )
        end
    else
        return ""
    end
end

return M
