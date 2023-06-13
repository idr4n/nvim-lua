-- system apperance
local appearance = vim.fn.system("defaults read -g AppleInterfaceStyle")
local duringDayTime = appearance:match("^Dark") == nil
if vim.fn.has("linux") == 1 then
    duringDayTime = false
end

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
                    hl.CursorLine = { bg = c.bg_dark }
                    hl.Folded = { bg = c.none }
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
        lazy = not duringDayTime,
        -- lazy = false,
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
                vim.api.nvim_set_hl(0, "StatusLine", { bg = "#EFF2F6" })
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
                -- vim.cmd("colorscheme zenbones")
                vim.api.nvim_set_hl(0, "Type", { bold = true })
                vim.api.nvim_set_hl(0, "TabLineFill", { bg = "#171210" })
                vim.api.nvim_set_hl(0, "TabLine", { bg = "#302825" })
                vim.api.nvim_set_hl(0, "TabLineSel", { bg = "#453C39" })
            end
            -- vim.cmd("colorscheme zenbones")
        end,
    },
    --: }}}

    --: monokai-pro {{{
    {
        "loctvl842/monokai-pro.nvim",
        -- lazy = not duringDayTime,
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

    --: gruber-darker {{{
    {
        "blazkowolf/gruber-darker.nvim",
        -- lazy = duringDayTime,
        -- lazy = false,
        -- priority = 1000,
        -- opts = {
        --     bold = false,
        --     italic = {
        --         comments = true,
        --         strings = true,
        --         operators = true,
        --         folds = true,
        --     },
        -- },
        config = function()
            -- vim.cmd.colorscheme("gruber-darker")
            vim.api.nvim_set_hl(0, "Folded", { bg = "#181818" })
            vim.api.nvim_set_hl(0, "LspReferenceText", { bg = "#4F4E4F" })
            vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = "#4F4E4F" })
            vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = "#4F4E4F" })
        end,
    },
    --: }}}

    --: github {{{
    {
        "projekt0n/github-nvim-theme",
        lazy = duringDayTime,
        priority = 1000,
        opts = {
            groups = {
                -- Custom duskfox with black background
                github_dark = {
                    Normal = { bg = "#0D1117" }, -- Non-current windows
                    NormalNC = { bg = "#0D1117" }, -- Non-current windows
                    CursorLine = { bg = "#161B22" },
                    Folded = { bg = "#161B22" },
                    -- Cursor = { fg = "#0D1117", bg = "#2F81F7" },
                    -- lCursor = { fg = "#0D1117", bg = "#2F81F7" },
                    Cursor = { fg = "#0D1117", bg = "#FFDD33" },
                    lCursor = { fg = "#0D1117", bg = "#FFDD33" },
                    NormalFloat = { bg = "NONE" },
                    FloatBorder = { fg = "#30363D", bg = "NONE" },
                    StatusLine = { bg = "#181E27" },
                    NeogitHunkHeader = { bg = "#161B22" },
                    NeogitHunkHeaderHighlight = { bg = "#161B22" },
                    NeogitDiffAddHighlight = { bg = "#161B22" },
                    NeogitDiffDeleteHighlight = { bg = "#161B22" },
                    NeogitDiffContextHighlight = { bg = "#161B22" },
                    NeoTreeNormal = { bg = "#04070D" },
                    NeoTreeNormalNC = { bg = "#04070D" },
                },
            },
        },
        config = function(_, opts)
            require("github-theme").setup(opts)
            if not duringDayTime then
                -- vim.cmd("colorscheme github_dark_colorblind")
                vim.cmd("colorscheme github_dark")
                vim.opt.guicursor:append("a:Cursor/lCursor")
            end
        end,
    },
    -- : }}}
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
