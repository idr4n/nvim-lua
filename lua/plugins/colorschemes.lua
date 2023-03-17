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
        -- lazy = false,
        priority = 1000,
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
            local base09 = "#78a9ff"

            local oxocarbon = (
                (
                    (vim.o.background == "dark")
                    and {
                        base00 = base00,
                        base01 = blend_hex(base00, base06, 0.085),
                        base02 = blend_hex(base00, base06, 0.18),
                        base03 = blend_hex(base00, base06, 0.3),
                        base04 = blend_hex(base00, base06, 0.82),
                        base05 = blend_hex(base00, base06, 0.95),
                        base06 = base06,
                        base07 = "#08bdba",
                        base08 = "#3ddbd9",
                        base09 = base09,
                        base10 = "#ee5396",
                        base11 = "#33b1ff",
                        base12 = "#ff7eb6",
                        base13 = "#42be65",
                        base14 = "#be95ff",
                        base15 = "#82cfff",
                        blend = "#131313",
                        none = "NONE",
                    }
                )
                or {
                    base00 = base06,
                    base01 = blend_hex(base00, base06, 0.95),
                    base02 = blend_hex(base00, base06, 0.82),
                    base03 = blend_hex(base00, base06, 0.80),
                    base04 = "#37474F",
                    base05 = "#90A4AE",
                    base06 = "#525252",
                    base07 = "#08bdba",
                    base08 = "#ff7eb6",
                    base09 = "#ee5396",
                    base10 = "#FF6F00",
                    base11 = "#0f62fe",
                    base12 = "#673AB7",
                    base13 = "#42be65",
                    base14 = "#be95ff",
                    base15 = "#FFAB91",
                    blend = "#FAFAFA",
                    none = "NONE",
                }
            )

            vim.cmd.colorscheme("oxocarbon")
            vim.api.nvim_set_hl(0, "LspReferenceText", { fg = oxocarbon.none, bg = oxocarbon.base03 })
            vim.api.nvim_set_hl(0, "LspReferenceRead", { fg = oxocarbon.none, bg = oxocarbon.base03 })
            vim.api.nvim_set_hl(0, "LspReferenceWrite", { fg = oxocarbon.none, bg = oxocarbon.base03 })
            vim.api.nvim_set_hl(0, "NormalFloat", { fg = oxocarbon.base05, bg = oxocarbon.base00 })
            vim.api.nvim_set_hl(0, "FloatBorder", { fg = oxocarbon.base02, bg = oxocarbon.base00 })
            vim.api.nvim_set_hl(0, "Comment", { fg = oxocarbon.base03, bg = oxocarbon.none, italic = true })
        end,
    },
    --: }}}
}
