-- system apperance
local appearance = vim.fn.system("defaults read -g AppleInterfaceStyle")
local duringDayTime = appearance:match("^Dark") == nil

return {
    --: tokyonight {{{
    {
        "folke/tokyonight.nvim",
        lazy = duringDayTime,
        priority = 1000,
        opts = function()
            return {
                style = "moon",
                -- transparent = true,
                styles = {
                    functions = "italic",
                    sidebars = "transparent",
                    floats = "transparent",
                },
                on_highlights = function(hl, c)
                    local acc_bg = "#1A1B26"
                    hl.CursorLine = { bg = c.bg_dark }
                    hl.CursorLineNr = { fg = c.fg, bg = c.bg_highlight, bold = true }
                    hl.StatusLine = { bg = acc_bg }
                    hl.WinSeparator = { fg = acc_bg, bg = acc_bg }
                    hl.TelescopeBorder = { bg = c.none, fg = c.dark3 }
                    hl.TelescopePromptTitle = { bg = c.none, fg = c.orange }
                    hl.TelescopePreviewTitle = { bg = c.none, fg = c.orange }
                    hl.Folded = { bg = c.none }
                    hl.FoldColumn = { fg = c.dark3, bg = acc_bg }
                    hl.LineNr = { fg = c.dark3, bg = acc_bg }
                    hl.SignColumn = { bg = acc_bg }
                    -- hl.NeoTreeNormal = { bg = acc_bg }
                    -- hl.NeoTreeNormalNC = { bg = "#1A1B26" }
                    hl.DiagnosticError = { fg = c.error, bg = acc_bg }
                    hl.DiagnosticWarn = { fg = c.warning, bg = acc_bg }
                    hl.DiagnosticInfo = { fg = c.info, bg = acc_bg }
                    hl.DiagnosticHint = { fg = c.hint, bg = acc_bg }
                end,
            }
        end,
        config = function(_, opts)
            require("tokyonight").setup(opts)

            -- Load the colorscheme
            if not duringDayTime then
                vim.cmd("colorscheme tokyonight")
            end
        end,
    },
    --: }}}

    --: catppuccin {{{
    {
        "catppuccin/nvim",
        lazy = not duringDayTime,
        -- lazy = duringDayTime,
        priority = 1000,
        name = "catppuccin",
        opts = function()
            local ucolors = require("catppuccin.utils.colors")
            local cp = require("catppuccin.palettes").get_palette()
            local acc_bg = "#24273A"

            return {
                transparent_background = false,
                styles = {
                    functions = { "italic" },
                    keywords = { "italic" },
                    conditionals = {},
                },
                integrations = {
                    native_lsp = {
                        underlines = {
                            errors = { "undercurl" },
                            hints = { "undercurl" },
                            warnings = { "undercurl" },
                            information = { "undercurl" },
                        },
                    },
                },
                custom_highlights = {
                    CursorLine = {
                        bg = ucolors.vary_color(
                            { latte = ucolors.lighten(cp.mantle, 0.70, cp.base) },
                            ucolors.darken(cp.surface0, 0.85, cp.base)
                        ),
                    },
                    LineNr = { bg = acc_bg },
                    CursorLineNr = { fg = cp.text, bg = cp.surface1, style = { "bold" } },
                    SignColumn = { bg = acc_bg },
                    StatusLine = { bg = acc_bg },
                    Folded = { bg = "NONE" },
                    DiagnosticSignError = { bg = acc_bg },
                    DiagnosticSignWarn = { bg = acc_bg },
                    DiagnosticSignInfo = { bg = acc_bg },
                    DiagnosticSignHint = { bg = acc_bg },
                    TSParameter = { fg = cp.maroon, style = {} },
                    ["@parameter"] = { fg = cp.maroon, style = {} },
                    TSInclude = { fg = cp.mauve, style = {} },
                    ["@include"] = { fg = cp.mauve, style = {} },
                    ["@namespace"] = { fg = cp.blue, style = {} },
                    TSNamespace = { fg = cp.blue, style = {} },
                    -- VertSplit = { fg = "#000000" },
                    WinSeparator = { fg = acc_bg, bg = acc_bg },
                    -- NeoTreeNormal = { bg = acc_bg },
                    -- NeoTreeNormalNC = { bg = acc_bg },
                    TelescopeNormal = { bg = "NONE" },
                    -- NeoTreeWinSeparator = { bg = acc_bg },
                },
            }
        end,
        config = function(_, opts)
            require("catppuccin").setup(opts)

            -- if not duringDayTime then
            if duringDayTime then
                -- vim.cmd([[colorscheme catppuccin-macchiato]])
                vim.cmd([[colorscheme catppuccin-frappe]])
            end
        end,
    },
    --: }}}

    --: monokai-pro {{{
    {
        "loctvl842/monokai-pro.nvim",
        -- lazy = duringDayTime,
        -- priority = 1000,
        config = function()
            require("monokai-pro").setup({
                -- transparent_background = true,
                background_clear = {
                    "float_win",
                    "telescope",
                    -- "neo-tree",
                },
                override = function()
                    local acc_bg = "#221F22"
                    local background = "#2A2A2A"
                    return {
                        Normal = { bg = background },
                        NormalNC = { bg = background },
                        FoldColumn = { fg = "#535353", bg = acc_bg },
                        Folded = { bg = "NONE" },
                        CursorLine = { bg = "#29272A" },
                        CursorLineFold = { fg = "#4f4e4f", bg = acc_bg },
                        CursorLineNr = { fg = "#FFFFFF", bg = "#535353", bold = true },
                        LineNr = { fg = "#676667", bg = acc_bg },
                        SignColumn = { bg = acc_bg },
                        LspReferenceText = { bg = "#4F4E4F" },
                        LspReferenceRead = { bg = "#4F4E4F" },
                        LspReferenceWrite = { bg = "#4F4E4F" },
                        NormalFloat = { bg = "NONE" },
                        FloatBorder = { bg = "NONE" },
                        StatusLine = { bg = acc_bg },
                    }
                end,
            })

            -- if not duringDayTime then
            --     vim.cmd([[colorscheme monokai-pro]])
            -- end
            -- vim.cmd([[colorscheme monokai-pro]])
        end,
    },
    --: }}}

    --: github {{{
    {
        "projekt0n/github-nvim-theme",
        -- lazy = not duringDayTime,
        -- priority = 1000,
        opts = {
            options = {
                styles = {
                    functions = "italic",
                },
                transparent = false,
                darken = {
                    sidebars = {
                        enable = false,
                        list = { "qf", "vista_kind", "terminal", "packer" },
                    },
                },
            },
            overrides = function(c)
                local acc_bg = "#F0F0F0"
                return {
                    -- CursorLine = { bg = "#F4F8FF" },
                    CursorLine = { bg = "#F6F6F6" },
                    LspReferenceText = { bg = "#E2FFE8" },
                    Folded = { bg = "NONE" },
                    FoldColumn = { fg = "#595959", bg = acc_bg },
                    LineNr = { fg = "#595959", bg = acc_bg },
                    CursorLineNr = { fg = "#000000", bg = "#C4C4C4", style = "bold" },
                    SignColumn = { bg = acc_bg },
                    -- StatusLine = { bg = "#F6F8FA", fg = "#7A83A4" },
                    -- StatusLine = { bg = acc_bg, fg = "#7A83A4" },
                    VertSplit = { fg = acc_bg, bg = acc_bg },
                    StatusLine = { bg = "#E6E6E6", fg = "#7A83A4" },
                    DiagnosticError = { fg = c.error, bg = acc_bg },
                    DiagnosticWarn = { fg = c.warning, bg = acc_bg },
                    DiagnosticInfo = { fg = c.info, bg = acc_bg },
                    DiagnosticHint = { fg = c.hint, bg = acc_bg },
                }
            end,
        },
        config = function(_, opts)
            require("github-theme").setup(opts)
            -- vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "#F6F8FA" })
            -- vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "#F6F8FA" })
            -- if duringDayTime then
            --     vim.cmd("colorscheme github_light")
            -- end
        end,
    },
    --: }}}

    --: gruvbox-material{{{
    -- stylua: ignore
    {
        "sainnhe/gruvbox-material",
        -- lazy = duringDayTime,
        -- priority = 1000,
        config = function()
            -- vim.g.gruvbox_material_background = "hard"
            vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
            -- if not duringDayTime then
            --     vim.cmd([[colorscheme gruvbox-material]])
            -- end
            local acc_bg = "#32302F"
            local warn_hl = vim.api.nvim_get_hl_by_name("YellowSign", true)
            local info_hl = vim.api.nvim_get_hl_by_name("BlueSign", true)
            local hint_hl = vim.api.nvim_get_hl_by_name("GreenSign", true)
            local error_hl = vim.api.nvim_get_hl_by_name("RedSign", true)
            local statusline_hl = vim.api.nvim_get_hl_by_name("StatusLine", true)
            vim.api.nvim_set_hl(0, "LineNr", { fg = "#5A524C", bg = acc_bg })
            vim.api.nvim_set_hl(0, "SignColumn", { fg = "#5A524C", bg = acc_bg })
            vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#A89984", bg = "#444241", bold = true })
            vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = warn_hl.foreground, bg = statusline_hl.background, bold = true })
            vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = info_hl.foreground, bg = statusline_hl.background, bold = true })
            vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = hint_hl.foreground, bg = statusline_hl.background, bold = true })
            vim.api.nvim_set_hl(0, "DiagnosticError", { fg = error_hl.foreground, bg = statusline_hl.background, bold = true })
            vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = warn_hl.foreground, bg = statusline_hl.background, bold = true })
            vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = info_hl.foreground, bg = statusline_hl.background, bold = true })
            vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = hint_hl.foreground, bg = statusline_hl.background, bold = true })
            vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = error_hl.foreground, bg = statusline_hl.background, bold = true })

        end,
    },
    --: }}}
}

-- Monokai-pro palette
--   dark2 = "#19181a",
--   dark1 = "#221f22",
--   background = "#2d2a2e",
--   text = "#fcfcfa",
--   accent1 = "#ff6188",
--   accent2 = "#fc9867",
--   accent3 = "#ffd866",
--   accent4 = "#a9dc76",
--   accent5 = "#78dce8",
--   accent6 = "#ab9df2",
--   dimmed1 = "#c1c0c0",
--   dimmed2 = "#939293", -- border
--   dimmed3 = "#727072",
--   dimmed4 = "#5b595c",
--   dimmed5 = "#403e41",

-- tokyonight-moon palette
-- none = "NONE",
-- bg_dark = "#1e2030", --
-- bg = "#222436", --
-- bg_highlight = "#2f334d", --
-- terminal_black = "#444a73", --
-- fg = "#c8d3f5", --
-- fg_dark = "#828bb8", --
-- fg_gutter = "#3b4261",
-- dark3 = "#545c7e",
-- comment = "#7a88cf", --
-- dark5 = "#737aa2",
-- blue0 = "#3e68d7", --
-- blue = "#82aaff", --
-- cyan = "#86e1fc", --
-- blue1 = "#65bcff", --
-- blue2 = "#0db9d7",
-- blue5 = "#89ddff",
-- blue6 = "#b4f9f8", --
-- blue7 = "#394b70",
-- purple = "#fca7ea", --
-- magenta2 = "#ff007c",
-- magenta = "#c099ff", --
-- orange = "#ff966c", --
-- yellow = "#ffc777", --
-- green = "#c3e88d", --
-- green1 = "#4fd6be", --
-- green2 = "#41a6b5",
-- teal = "#4fd6be", --
-- red = "#ff757f", --
-- red1 = "#c53b53", --

-- Catppuccin-Frappe
-- rosewater = "#F2D5CF",
-- flamingo = "#EEBEBE",
-- pink = "#F4B8E4",
-- mauve = "#CA9EE6",
-- red = "#E78284",
-- maroon = "#EA999C",
-- peach = "#EF9F76",
-- yellow = "#E5C890",
-- green = "#A6D189",
-- teal = "#81C8BE",
-- sky = "#99D1DB",
-- sapphire = "#85C1DC",
-- blue = "#8CAAEE",
-- lavender = "#BABBF1",
--
-- text = "#c6d0f5",
-- subtext1 = "#b5bfe2",
-- subtext0 = "#a5adce",
-- overlay2 = "#949cbb",
-- overlay1 = "#838ba7",
-- overlay0 = "#737994",
-- surface2 = "#626880",
-- surface1 = "#51576d",
-- surface0 = "#414559",
--
-- base = "#303446",
-- mantle = "#292C3C",
-- crust = "#232634",
