-- "nvim-lualine/lualine.nvim"
local c = require("plugins.lualine.components")

return {
    "nvim-lualine/lualine.nvim",
    enabled = false,
    event = "VeryLazy",
    -- event = "BufReadPre",
    dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
    opts = function()
        return {
            options = {
                globalstatus = true,
                icons_enabled = true,
                theme = require("plugins.lualine.my_theme").setup(),
                -- theme = "auto",
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                disabled_filetypes = { "alpha", "dashboard", "lazy", "mason" },
                always_divide_middle = true,
                ignore_focus = { "fzf", "neo-tree", "TelescopePrompt" },
            },
            sections = {
                lualine_a = { c.mode },
                lualine_b = { c.get_fileinfo },
                lualine_c = { c.get_searchcount, c.get_bufnr },
                lualine_x = { c.lsp_running, c.getWords, c.charcode },
                lualine_y = { c.get_git_status, c.get_filetype },
                -- lualine_z = { c.get_lsp_diagnostic },
                lualine_z = { c.diagnostics },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
        }
    end,
}
