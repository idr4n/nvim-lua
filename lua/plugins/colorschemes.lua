-- system apperance
local appearance = vim.fn.system("defaults read -g AppleInterfaceStyle")
local duringDayTime = appearance:match("^Dark") == nil

return {
    --: tokyonight {{{
    {
        "folke/tokyonight.nvim",
        -- lazy = duringDayTime,
        -- priority = 1000,
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
                    -- local acc_bg = "#1A1B26"
                    local win_sep = "#1A1B26"
                    local acc_bg = c.bg
                    hl.CursorLine = { bg = c.bg_dark }
                    hl.CursorLineNr = { fg = c.fg, bg = c.bg_highlight, bold = true }
                    -- hl.StatusLine = { bg = acc_bg }
                    hl.StatusLine = { bg = win_sep }
                    -- hl.WinSeparator = { fg = acc_bg, bg = acc_bg }
                    hl.WinSeparator = { fg = win_sep, bg = win_sep }
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
            -- if not duringDayTime then
            --     vim.cmd("colorscheme tokyonight")
            -- end
        end,
    },
    --: }}}

    --: zenbones{{{
    {
        "mcchrish/zenbones.nvim",
        -- lazy = duringDayTime,
        lazy = false,
        priority = 1000,
        dependencies = "rktjmp/lush.nvim",
        config = function()
            vim.g.zenbones =
                { lightness = "bright", darkness = "stark", lighten_line_nr = 30, transparent_background = true }

            if duringDayTime then
                vim.o.background = "light"
                vim.cmd("colorscheme zenbones")
                vim.api.nvim_set_hl(0, "LspReferenceText", { bg = "#E9F3FE" })
                vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = "#E9F3FE" })
                vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = "#E9F3FE" })
                -- vim.api.nvim_set_hl(0, "CursorLine", { bg = "#F8F5F3" })
                -- vim.api.nvim_set_hl(0, "StatusLine", { bg = "#F2E9E5" })
                -- vim.api.nvim_set_hl(0, "LineNr", { fg = "#D6CAC4" })
                vim.api.nvim_set_hl(0, "CursorLine", { bg = "#F8F9FB" })
                vim.api.nvim_set_hl(0, "StatusLine", { bg = "#E6E6E6" })
                vim.api.nvim_set_hl(0, "Visual", { bg = "#DBE9F9" })
                vim.api.nvim_set_hl(0, "LineNr", { fg = "#BABBBD" })
                vim.api.nvim_set_hl(0, "Comment", { fg = "#A5ABB0" })
                vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#E6E6E6" })
                vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
                vim.api.nvim_set_hl(0, "Type", { bold = true })
                vim.api.nvim_set_hl(0, "TabLineFill", { bg = "#FFFFFF" })
                vim.api.nvim_set_hl(0, "TabLine", { fg = "#A5ABB0", bg = "#E6E6E6" })
                vim.api.nvim_set_hl(0, "TabLineSel", { bg = "#D6CAC4" })
            else
                vim.o.background = "dark"
                vim.cmd("colorscheme zenbones")
                vim.api.nvim_set_hl(0, "Type", { bold = true })
                vim.api.nvim_set_hl(0, "TabLineFill", { bg = "#171210" })
                vim.api.nvim_set_hl(0, "TabLine", { bg = "#302825" })
                vim.api.nvim_set_hl(0, "TabLineSel", { bg = "#453C39" })
            end
            -- vim.cmd("colorscheme zenbones")
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
