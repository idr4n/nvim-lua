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
        hl.TreesitterContext = { bg = c.none }
        hl.TreesitterContextBottom = { underline = true, sp = c.magenta }
        -- hl.TelescopeBorder = { fg = c.purple, bg = c.none }
      end,
    }
  end,
}

-- local moon = {
--   none = "NONE",
--   bg_dark = "#1e2030", --
--   bg = "#222436", --
--   bg_highlight = "#2f334d", --
--   terminal_black = "#444a73", --
--   fg = "#c8d3f5", --
--   fg_dark = "#828bb8", --
--   fg_gutter = "#3b4261",
--   dark3 = "#545c7e",
--   comment = "#7a88cf", --
--   dark5 = "#737aa2",
--   blue0 = "#3e68d7", --
--   blue = "#82aaff", --
--   cyan = "#86e1fc", --
--   blue1 = "#65bcff", --
--   blue2 = "#0db9d7",
--   blue5 = "#89ddff",
--   blue6 = "#b4f9f8", --
--   blue7 = "#394b70",
--   purple = "#fca7ea", --
--   magenta2 = "#ff007c",
--   magenta = "#c099ff", --
--   orange = "#ff966c", --
--   yellow = "#ffc777", --
--   green = "#c3e88d", --
--   green1 = "#4fd6be", --
--   green2 = "#41a6b5",
--   teal = "#4fd6be", --
--   red = "#ff757f", --
--   red1 = "#c53b53", --
-- }
