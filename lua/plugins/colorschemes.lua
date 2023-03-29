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
                transparent = true,
                styles = {
                    functions = "italic",
                    sidebars = "transparent",
                    floats = "transparent",
                },
                on_highlights = function(hl, c)
                    -- hl.CursorLine = { bg = c.bg_dark }
                    hl.CursorLine = { bg = "#16161E" }
                    hl.CursorLineNr = { fg = c.orange, bold = true }
                    hl.TelescopeBorder = { bg = c.none, fg = c.dark3 }
                    hl.TelescopePromptTitle = { bg = c.none, fg = c.orange }
                    hl.TelescopePreviewTitle = { bg = c.none, fg = c.orange }
                    hl.Folded = { bg = c.none }
                    hl.FoldColumn = { fg = c.fg_gutter }
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
        -- lazy = not duringDayTime,
        -- priority = 1000,
        -- dependencies = "rktjmp/lush.nvim",
        config = function()
            vim.g.zenbones_compat = 1
            -- vim.g.zenbones = { lightness = "default", darkness = "stark", lighten_line_nr = 30, transparent_background = true }

            -- if duringDayTime then
            --     vim.o.background = "light"
            --     vim.cmd("colorscheme zenbones")
            -- end
        end,
    },
    --: }}}

    --: nightfox {{{
    {
        "EdenEast/nightfox.nvim",
        config = function()
            local options = {
                transparent = true,
                styles = {
                    comments = "italic",
                    -- functions = "italic,bold",
                    functions = "italic",
                },
            }

            local groups = {
                nightfox = {
                    CursorLine = { bg = "#1F2A38" },
                },
                nordfox = {
                    CursorLine = { bg = "#343946" },
                },
                duskfox = {
                    CursorLine = { bg = "#2C2A40" },
                },
                dawnfox = {
                    CursorLine = { bg = "#F2E9ED" },
                },
            }

            require("nightfox").setup({
                options = options,
                groups = groups,
            })
        end,
    },
    --: }}}

    --: catppuccin {{{
    {
        "catppuccin/nvim",
        -- lazy = not duringDayTime,
        -- priority = 1000,
        name = "catppuccin",
        opts = function()
            local ucolors = require("catppuccin.utils.colors")
            local cp = require("catppuccin.palettes").get_palette()

            return {
                transparent_background = true,
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
                            ucolors.darken(cp.surface0, 0.70, cp.base)
                        ),
                    },
                    TSParameter = { fg = cp.maroon, style = {} },
                    ["@parameter"] = { fg = cp.maroon, style = {} },
                    TSInclude = { fg = cp.mauve, style = {} },
                    ["@include"] = { fg = cp.mauve, style = {} },
                    ["@namespace"] = { fg = cp.blue, style = {} },
                    TSNamespace = { fg = cp.blue, style = {} },
                    VertSplit = { fg = "#15161e" },
                },
            }
        end,
        config = function(_, opts)
            require("catppuccin").setup(opts)

            -- -- if not duringDayTime then
            -- if duringDayTime then
            --     -- vim.cmd([[colorscheme catppuccin-macchiato]])
            --     vim.cmd([[colorscheme catppuccin-frappe]])
            -- end
        end,
    },
    --: }}}

    --: rose-pine {{{
    {
        "rose-pine/neovim",
        name = "rose-pine",
        -- lazy = false,
        -- priority = 1000,
        opts = function()
            return {
                --- @usage 'main' | 'moon'
                dark_variant = "moon",
                bold_vert_split = false,
                dim_nc_background = false,
                disable_background = true,
                disable_float_background = false,
                disable_italics = false,

                --- @usage string hex value or named color from rosepinetheme.com/palette
                groups = {
                    background = "base",
                    background_nc = "_experimental_nc",
                    panel = "surface",
                    panel_nc = "surface",
                    border = "highlight_med",
                    comment = "muted",
                    link = "iris",
                    punctuation = "subtle",

                    error = "love",
                    hint = "iris",
                    info = "foam",
                    warn = "gold",

                    git_add = "pine",
                    git_rename = "foam",

                    headings = {
                        h1 = "iris",
                        h2 = "foam",
                        h3 = "rose",
                        h4 = "gold",
                        h5 = "pine",
                        h6 = "foam",
                    },
                    -- or set all headings at once
                    -- headings = 'subtle'
                },

                -- Change specific vim highlight groups
                highlight_groups = {
                    -- CursorLine = { bg = "surface" },
                    IndentBlanklineChar = { fg = "overlay" },
                    -- IndentBlanklineChar = { fg = "highlight_med" },
                    Variable = { fg = "text", italic = false },
                    TSVariable = { fg = "text", italic = false },
                    ["@variable"] = { fg = "text", italic = false },
                    Parameter = { fg = "iris", italic = false },
                    TSParameter = { fg = "iris", italic = false },
                    ["@parameter"] = { fg = "iris", italic = false },
                    Property = { fg = "iris", italic = false },
                    ["@property"] = { fg = "iris", italic = false },
                    TSProperty = { fg = "iris", italic = false },
                    Keyword = { fg = "pine", italic = true },
                    TSKeyword = { fg = "pine", italic = true },
                    ["@keyword"] = { fg = "pine", italic = true },
                    Function = { fg = "rose", italic = true },
                    TSFunction = { fg = "rose", italic = true },

                    -- nvim-telescope/telescope.nvim
                    TelescopeBorder = { fg = "pine", bg = "none" },
                    TelescopeMatching = { fg = "rose" },
                    TelescopeNormal = { bg = "none" },
                    TelescopePromptNormal = { bg = "none" },
                    -- TelescopeSelection = { bg = "highlight_low" },
                    -- TelescopeSelectionCaret = { bg = "highlight_low" },
                },
            }
        end,
        config = function(_, opts)
            require("rose-pine").setup(opts)
            -- if duringDayTime then
            --     vim.o.background = "light"
            -- else
            --     vim.o.background = "dark"
            -- end
            -- vim.cmd("colorscheme rose-pine")
        end,
    },
    --: }}}

    --: github {{{
    {
        "projekt0n/github-nvim-theme",
        -- lazy = not duringDayTime,
        -- priority = 1000,
        opts = {
            theme_style = "light",
            function_style = "italic",
            sidebars = { "qf", "vista_kind", "terminal", "packer" },
            transparent = true,
            overrides = function(c)
                return {
                    CursorLine = { bg = "#F3F8FF" },
                    LspReferenceText = { bg = "#E2FFE8" },
                    Folded = { bg = "NONE" },
                    FoldColumn = { fg = c.bg_visual, bg = "NONE" },
                    LineNr = { fg = c.line_nr },
                }
            end,
        },
        config = function(_, opts)
            require("github-theme").setup(opts)
        end,
    },
    --: }}}

    --: onedarkpro {{{
    {
        "olimorris/onedarkpro.nvim",
        -- lazy = not duringDayTime,
        -- priority = 1000,
        config = function()
            vim.cmd("colorscheme onedark")
        end,
    },
    --: }}}

    --: oxocarbon{{{
    {
        "nyoom-engineering/oxocarbon.nvim",
        -- lazy = duringDayTime,
        -- priority = 1000,
        config = function()
            if duringDayTime then
                -- vim.o.background = "dark"
                -- vim.o.background = "light"
            else
                vim.o.background = "dark"
            end

            local _local_1_ = require("oxocarbon.colorutils")
            local blend_hex = _local_1_["blend-hex"]
            if vim.g.colors_name then
                vim.cmd.hi("clear")
            end
            vim.g["colors_name"] = "oxocarbon"
            vim.o["termguicolors"] = true
            local base00 = "#161616"
            local base06 = "#ffffff"

            local oxocarbon = (
                (
                    (vim.o.background == "dark")
                    and {
                        base00 = base00,
                        base02 = blend_hex(base00, base06, 0.18),
                        base03 = blend_hex(base00, base06, 0.3),
                        base05 = blend_hex(base00, base06, 0.95),
                        none = "NONE",
                    }
                )
                or {
                    base00 = base06,
                    base02 = blend_hex(base00, base06, 0.82),
                    base03 = blend_hex(base00, base06, 0.80),
                    base05 = "#90A4AE",
                    none = "NONE",
                }
            )

            -- vim.cmd.colorscheme("oxocarbon")
            vim.api.nvim_set_hl(0, "LspReferenceText", { fg = oxocarbon.none, bg = oxocarbon.base03 })
            vim.api.nvim_set_hl(0, "LspReferenceRead", { fg = oxocarbon.none, bg = oxocarbon.base03 })
            vim.api.nvim_set_hl(0, "LspReferenceWrite", { fg = oxocarbon.none, bg = oxocarbon.base03 })
            vim.api.nvim_set_hl(0, "NormalFloat", { fg = oxocarbon.base05, bg = oxocarbon.base00 })
            vim.api.nvim_set_hl(0, "FloatBorder", { fg = oxocarbon.base02, bg = oxocarbon.base00 })
            vim.api.nvim_set_hl(0, "Comment", { fg = oxocarbon.base03, bg = oxocarbon.none, italic = true })
        end,
    },
    --: }}}

    --: monokai-pro {{{
    {
        "loctvl842/monokai-pro.nvim",
        -- lazy = not duringDayTime,
        lazy = false,
        priority = 1000,
        config = function()
            require("monokai-pro").setup({
                transparent_background = true,
                override = function(c)
                    return {
                        FoldColumn = { fg = c.base.dimmed5 },
                        CursorLineFold = { fg = c.base.dimmed5 },
                        LspReferenceText = { bg = c.base.dimmed5 },
                        LspReferenceRead = { bg = c.base.dimmed5 },
                        LspReferenceWrite = { bg = c.base.dimmed5 },
                    }
                end,
            })

            -- if duringDayTime then
            --     vim.cmd([[colorscheme monokai-pro]])
            -- end
            vim.cmd([[colorscheme monokai-pro]])
        end,
    },
    --: }}}
}
