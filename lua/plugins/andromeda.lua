return {
  "idr4n/andromeda.nvim",
  -- enabled = false,
  dev = false,
  lazy = true,
  priority = 1000,
  opts = {
    transparent = true,
    styles = {
      comments = { italic = false },
      keywords = { italic = false },
      sidebars = "transparent",
      floats = "transparent",
    },
    on_highlights = function(hl, c)
      hl.Bold = { fg = c.fg, bg = c.bg_highlight, bold = true }
    end,
  },
}
