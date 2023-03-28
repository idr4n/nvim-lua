-- Statusline Components

local M = {}

function M.color()
    local mode = vim.api.nvim_get_mode().mode
    local mode_color = "%#Normal#"
    if mode == "n" then
        -- mode_color = "%#StatusNormal#"
        mode_color = "%#StatusNormalFg#"
    elseif (mode == "i") or (mode == "ic") then
        -- mode_color = "%#StatusInsert#"
        mode_color = "%#String#"
    elseif ((mode == "v") or (mode == "V")) or (mode == "\22") then
        -- mode_color = "%#StatusVisual#"
        mode_color = "%#StatusVisualFg#"
    elseif mode == "R" then
        -- mode_color = "%#StatusReplace#"
        mode_color = "%#StatusReplaceFg#"
    elseif mode == "c" then
        -- mode_color = "%#StatusCommand#"
        mode_color = "%#StatusCommandFg#"
    elseif mode == "t" then
        -- mode_color = "%#StatusTerminal#"
        mode_color = "%#StatusTerminalFg#"
    end
    return mode_color
end

function M.getWords()
    if vim.bo.filetype == "md" or vim.bo.filetype == "txt" or vim.bo.filetype == "markdown" then
        if not (vim.fn.wordcount().visual_words == nil) then
            return "%#Normal#" .. " " .. tostring(vim.fn.wordcount().visual_words) .. " "
        else
            return "%#Normal#" .. " " .. tostring(vim.fn.wordcount().words) .. " "
        end
    else
        return ""
    end
end

function M.getGitChanges()
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

function M.get_fileinfo()
    local filename = ""

    if vim.fn.expand("%") == "" then
        return "%#Normal#" .. " nvim "
    end

    filename = "%#Normal#" .. "%#StatusDir#" .. (vim.fn.expand("%:p:h:t")) .. "/" .. "%#Normal#" .. vim.fn.expand("%:t")

    if vim.bo.modified then
        filename = " " .. (vim.fn.expand("%:p:h:t")) .. "/" .. vim.fn.expand("%:t")
        return ("%#StatusInsertFg#" .. "   " .. filename .. "%#NormalNC#" .. "%r%h")
    end

    return (" %#Normal#" .. filename .. "%#NormalNC#" .. "%r%h")
end

function M.get_fileicon()
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
        -- icon = ""
        icon = devicons.get_icon("lock")
        icon_highlight_group = "StatusIconLock"
    end

    return "  %#" .. icon_highlight_group .. "#" .. icon .. "%#Normal#"
end

function M.get_git_status()
    local branch = (vim.b.gitsigns_status_dict or { head = "" })
    local is_head_empty = (branch.head ~= "")
    return (
        (is_head_empty and "%#Normal#" .. string.format("(λ • #%s%s) ", (branch.head or ""), M.getGitChanges()))
        or ""
    )
end

function M.get_bufnr()
    return ("%#Comment#" .. "  " .. vim.api.nvim_get_current_buf())
end

function M.get_filetype()
    return ("%#NormalNC#" .. vim.bo.filetype .. " ")
end

function M.get_dir()
    return ("%#NormalNC#" .. " %{fnamemodify(getcwd(), ':p:h:t')}")
end

function M.get_lsp_diagnostic()
    if not rawget(vim, "lsp") then
        return ""
    else
    end
    local function get_severity(s)
        return #vim.diagnostic.get(0, { severity = s })
    end
    local result = {
        errors = get_severity(vim.diagnostic.severity.ERROR),
        warnings = get_severity(vim.diagnostic.severity.WARN),
        info = get_severity(vim.diagnostic.severity.INFO),
        hints = get_severity(vim.diagnostic.severity.HINT),
    }
    return string.format(
        " %%#StatusLineDiagnosticWarn#%s %%#StatusLineDiagnosticError#%s ",
        (result.warnings or 0),
        (result.errors or 0)
    )
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

function M.get_searchcount()
    if vim.v.hlsearch == 0 then
        return "%#Normal#  %l:%c " .. progress()
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
    return ("%#Normal#" .. ("  %s matches"):format(total))
end

function M.python_env()
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
end

return M
