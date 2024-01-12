local M = {}

M.catppuccin = {
    opts = function()
        -- local ucolors = require("catppuccin.utils.colors")
        local cp = require("catppuccin.palettes").get_palette()
        local acc_bg = "#181825"
        -- local acc_bg = cp.none
        -- local win_sep = "#24273A"
        return {
            -- transparent_background = true,
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
                TSParameter = { fg = cp.maroon, style = {} },
                ["@parameter"] = { fg = cp.maroon, style = {} },
                TSInclude = { fg = cp.mauve, style = {} },
                ["@include"] = { fg = cp.mauve, style = {} },
                ["@namespace"] = { fg = cp.blue, style = {} },
                TSNamespace = { fg = cp.blue, style = {} },
                Folded = { bg = "NONE" },
                -- StatusLine = { bg = acc_bg },
                NeoTreeNormal = { bg = acc_bg },
                NeoTreeNormalNC = { bg = acc_bg },
                NotifyBackground = { bg = "#000000" },
            },
        }
    end,
}

M.kanagawa = {
    opts = {
        compile = true, -- enable compiling the colorscheme
        functionStyle = { italic = true },
        transparent = false, -- do not set background color
        dimInactive = true, -- dim inactive window `:h hl-NormalNC`
        background = {
            dark = "wave",
        },
        overrides = function(colors) -- add/modify highlights
            local theme = colors.theme
            return {
                CursorLine = { bg = "#2B2B37" },
                StatusLine = { bg = theme.ui.bg_m2 },
                StatusLineNC = { bg = theme.ui.bg_m2 },
            }
        end,
        colors = {
            theme = {
                all = { ui = { bg_gutter = "none" } },
            },
        },
    },
}

M.monokaipro = {
    opts = {
        -- transparent_background = true,
        background_clear = {
            "float_win",
            "telescope",
            -- "neo-tree",
        },
        override = function()
            local acc_bg = "#221F22"
            -- local background = "#2A2A2A"
            local background = "#1D1F21"
            return {
                Normal = { bg = background },
                NormalNC = { bg = background },
                FoldColumn = { fg = "#535353", bg = acc_bg },
                Folded = { bg = "NONE" },
                CursorLine = { bg = "#29272A" },
                CursorLineFold = { fg = "#4f4e4f", bg = acc_bg },
                CursorLineNr = { bg = "#29272A", bold = true },
                LineNr = { fg = "#676667", bg = background },
                SignColumn = { bg = background },
                LspReferenceText = { bg = "#3F3F3F" },
                LspReferenceRead = { bg = "#3F3F3F" },
                LspReferenceWrite = { bg = "#3F3F3F" },
                NormalFloat = { bg = "NONE" },
                FloatBorder = { bg = "NONE" },
                -- StatusLine = { bg = acc_bg },
                StatusLine = { bg = "#111314" },
                WinSeparator = { fg = "#111314" },
                NeoTreeNormal = { bg = "#111314" },
                NeoTreeNormalNC = { bg = "#111314" },
                NeoTreeWinSeparator = { bg = "#111314" },
                NeoTreeEndOfBuffer = { bg = "#111314" },
            }
        end,
    },
}

M.onedark = {
    opts = {
        style = "darker",
        highlights = {
            IblScope = { fg = "#626873" },
            MiniIndentscopeSymbol = { fg = "#525A66" },
            NeoTreeNormal = { bg = "#1B1F27" },
            NeoTreeNormalNC = { bg = "#1B1F27" },
            NeoTreeEndOfBuffer = { bg = "#1B1F27" },
            -- NeoTreeGitModified = { fg = "$blue" },
            NeoTreeGitModified = { fg = "#485A86" },
            NeoTreeWinSeparator = { fg = "#1E222A", bg = "none" },
            Normal = { bg = "#1E222A" },
            NormalNC = { bg = "#1E222A" },
            EndOfBuffer = { bg = "#1E222A" },
            CursorLine = { bg = "#282C34" },
            StatusLine = { bg = "#252931" },
            LineNr = { fg = "#41454D" },
        },
    },
}

M.rosepine = {
    opts = function()
        return {
            --- @usage 'main' | 'moon'
            dark_variant = "moon",
            bold_vert_split = false,
            dim_nc_background = false,
            disable_background = false,
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
                NeoTreeNormal = { bg = "nc" },
                NeoTreeNormalNC = { bg = "nc" },
                NeoTreeEndOfBuffer = { bg = "nc" },
                NeoTreeCursorLine = { bg = "p.highlight_low" },
                IblIndent = { fg = "#323048" },
                IblScope = { fg = "#525069" },
            },
        }
    end,
}

M.tokyonight = {
    opts = function()
        return {
            style = "moon",
            -- style = "night",
            -- transparent = true,
            styles = {
                -- functions = { italic = true },
                -- sidebars = "transparent",
                keywords = { italic = false },
                floats = "transparent",
            },
            on_highlights = function(hl, c)
                hl.CursorLine = { bg = c.bg_dark }
                hl.Folded = { bg = c.none }
                -- hl.IblIndent = { fg = "#303342" }
                hl.IblScope = { fg = "#634E89" }
                hl.NeoTreeCursorLine = { bg = "#2F344C" }
                hl.MiniIndentscopeSymbol = { fg = "#646FA1" }
                -- hl.TelescopeBorder = { fg = c.purple, bg = c.none }
            end,
        }
    end,
}

return M
