return {
  "rose-pine/neovim",
  lazy = true,
  name = "rose-pine",
  opts = function()
    return {
      --- @usage 'main' | 'moon'
      -- dark_variant = "moon",
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
        StatusLine = vim.o.background == "dark" and { bg = "surface" } or { bg = "highlight_low" },
        CursorLine = { bg = "highlight_low" },
        NeoTreeNormal = { bg = "highlight_low" },
        NeoTreeNormalNC = { bg = "highlight_low" },
        NeoTreeEndOfBuffer = { bg = "highlight_low" },
        NeoTreeCursorLine = { bg = "highlight_med" },
        NeoTreeWinSeparator = { fg = "highlight_low", bg = "highlight_low" },
        -- NeoTreeCursorLine = { bg = "p.highlight_low" },
        NvimTreeNormal = { bg = "surface" },
        NvimTreeNormalNC = { bg = "surface" },
        NvimTreeNormalFloat = { bg = "surface" },
        IblIndent = { fg = "highlight_med" },
        IblScope = { fg = "muted" },
        Visual = { bg = "#3B3770" },
        NonText = { fg = "overlay" },
        LineNr = { fg = "highlight_high" },
        CurSearch = { fg = "base", bg = "leaf", inherit = false },
        Search = { fg = "text", bg = "leaf", blend = 20, inherit = false },
      },
    }
  end,
}
