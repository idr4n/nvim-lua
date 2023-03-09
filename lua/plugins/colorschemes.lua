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
                    local purple = "#9d7cd8"
                    -- hl.CursorLine = { bg = c.bg_dark }
                    hl.CursorLine = { bg = "#16161E" }
                    hl.CursorLineNr = { fg = c.orange, bold = true }
                    -- hl.TelescopeBorder = { bg = c.none, fg = c.magenta }
                    hl.TelescopeBorder = { bg = c.none, fg = purple }
                    hl.TelescopePromptTitle = { bg = c.none, fg = c.orange }
                    hl.TelescopePreviewTitle = { bg = c.none, fg = c.orange }
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
        -- lazy = duringDayTime,
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

            -- if not duringDayTime then
            --     vim.cmd([[colorscheme catppuccin-macchiato]])
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
        lazy = not duringDayTime,
        priority = 1000,
        init = function()
            vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "#F6F8FA" })
            vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "#F6F8FA" })
        end,
        opts = {
            theme_style = "light",
            function_style = "italic",
            sidebars = { "qf", "vista_kind", "terminal", "packer" },
            overrides = function()
                return {
                    CursorLine = { bg = "#F3F8FF" },
                    LspReferenceText = { bg = "#E2FFE8" },
                }
            end,
        },
        config = function(_, opts)
            require("github-theme").setup(opts)
        end,
    },
    --: }}}

    --: oxocarbon{{{
    {
        "nyoom-engineering/oxocarbon.nvim",
        lazy = duringDayTime,
        priority = 1000,
        config = function()
            if not duringDayTime then
                vim.o.background = "dark"
            end
            vim.cmd.colorscheme("oxocarbon")
        end,
    },
    --: }}}
}
