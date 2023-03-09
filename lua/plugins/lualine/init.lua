-- "nvim-lualine/lualine.nvim"

local colors = require("plugins.lualine.my_theme").colors

local function fg(name)
    return function()
        ---@type {foreground?:number}?
        local hl = vim.api.nvim_get_hl_by_name(name, true)
        return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
    end
end

-- check if value in table
local function contains(t, value)
    for _, v in pairs(t) do
        if v == value then
            return true
        end
    end
    return false
end

local mode = {
    function()
        return " "
        -- return "  "
    end,
    -- color = function()
    -- 	return { fg = mode_color[vim.fn.mode()], bg = gray }
    -- end,
    padding = 1,
    color = { gui = "bold" },
}

local hide_in_width_60 = function()
    return vim.o.columns > 60
end

local hide_in_width_120 = function()
    return vim.o.columns > 120
end

local hide_in_width_140 = function()
    return vim.o.columns > 140
end

local icons = require("icons")

local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn" },
    diagnostics_color = {
        error = colors.error,
        warn = colors.warning,
    },
    symbols = {
        error = icons.diagnostics.Error,
        warn = icons.diagnostics.Warning,
    },
    update_in_insert = false,
    always_visible = false,
    fmt = function(str)
        if #str > 0 then
            return str
        else
            return ""
        end
    end,
    padding = 1,
}

local function diff_source()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
        return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
        }
    end
end

local diff = {
    "diff",
    source = diff_source,
    colored = true,
    diff_color = {
        added = colors.diff_added,
        modified = colors.diff_modified,
        removed = colors.diff_removed,
    },
    symbols = {
        added = icons.git.Add,
        modified = icons.git.Mod,
        removed = icons.git.Remove,
    },
    cond = hide_in_width_60,
    fmt = function(str)
        if #str > 0 then
            return str
        else
            return ""
        end
    end,
    padding = 1,
}

local fileIcon = { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } }

local filename = {
    "filename",
    path = 1,
    shorting_target = 60,
    symbols = { modified = "●" },
    fmt = function(str)
        local ignored_filetypes = { "fzf", "neo-tree", "toggleterm", "TelescopePrompt" }
        local buf_ft = vim.bo.filetype
        if contains(ignored_filetypes, buf_ft) then
            return ""
        end
        return str
    end,
    padding = 1,
}

local getDir = {
    "getDir",
    fmt = function()
        local dir = tostring(vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"))
        if #dir > 20 then
            dir = dir:sub(1, 17) .. "..."
        end
        return " " .. dir
    end,
    padding = 1,
}

local filetype = {
    "filetype",
    fmt = function(str)
        local ui_filetypes = {
            "help",
            "packer",
            "neogitstatus",
            "NvimTree",
            "Trouble",
            "lir",
            "Outline",
            "spectre_panel",
            "toggleterm",
            "DressingSelect",
            "",
            "nil",
        }

        if str == "TelescopePrompt" then
            return icons.ui.Telescope
        end

        local function get_term_num()
            local t_status_ok, toggle_num = pcall(vim.api.nvim_buf_get_var, 0, "toggle_number")
            if not t_status_ok then
                return ""
            end
            return toggle_num
        end

        if str == "toggleterm" then
            local term = " " .. get_term_num()
            return term
        end

        if contains(ui_filetypes, str) then
            return ""
        else
            return str
        end
    end,
    icons_enabled = false,
    padding = 1,
    cond = hide_in_width_120,
}

local branch = {
    "branch",
    icon = "",
    fmt = function(str)
        if str == "" or str == nil then
            return "!=vcs"
        end

        return str
    end,
    padding = 1,
}

local progress = {
    "progress",
    fmt = function(str)
        local newStr = ""
        if str == "Top" or str == "Bot" then
            newStr = str
        else
            newStr = "%2.3p%%"
        end
        return newStr .. "/%L"
    end,
    -- color = function()
    -- 	return { fg = mode_color[vim.fn.mode()], bg = gray }
    -- end,
    padding = 1,
    -- color = { gui = "bold" },
}

local function isempty(s)
    return s == nil or s == ""
end

local current_signature = {
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

local getWords = {
    "getWords",
    fmt = function()
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
    color = { fg = colors.orange2 },
}

local location = {
    "location",
    fmt = function(str)
        return str
    end,
    padding = 1,
}

local charcode = {
    "charcode",
    fmt = function()
        return "Ux%04B"
    end,
    padding = 1,
    cond = hide_in_width_120,
}

-- stylua: ignore
-- local noice = {
--     function() return require("noice").api.status.command.get() end,
--     cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
--     color = fg("Statement"),
--     padding = 1,
-- }

return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    -- event = "BufReadPre",
    dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
    opts = function()
        return {
            options = {
                globalstatus = true,
                icons_enabled = true,
                -- theme = require("plugins.lualine.my_theme").setup(),
                theme = "auto",
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                disabled_filetypes = { "alpha", "dashboard", "lazy" },
                always_divide_middle = true,
                -- ignore_focus = { "fzf", "neo-tree", "TelescopePrompt" },
            },
            sections = {
                lualine_a = { mode },
                lualine_b = { branch },
                lualine_c = { getDir, fileIcon, filename, diff, current_signature },
                -- lualine_x = { noice, diagnostics, language_server, getWords, charcode, filetype },
                lualine_x = { diagnostics, getWords, charcode, filetype },
                lualine_y = { location },
                lualine_z = { progress },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {},
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
        }
    end,
}
