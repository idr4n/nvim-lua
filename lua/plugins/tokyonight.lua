return {
  "folke/tokyonight.nvim",
  lazy = true,
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
        -- hl.IblIndent = { fg = "#303342" }
        hl.IblScope = { fg = "#634E89" }
        hl.NeoTreeCursorLine = { bg = "#2F344C" }
        hl.MiniIndentscopeSymbol = { fg = "#646FA1" }
        -- hl.TelescopeBorder = { fg = c.purple, bg = c.none }
      end,
    }
  end,
}
