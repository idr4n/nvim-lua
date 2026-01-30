return {
  "idr4n/andromeda.nvim",
  -- enabled = false,
  lazy = true,
  priority = 1000,
  opts = {
    styles = {
      comments = { italic = false },
      keywords = { italic = false },
    },
    on_highlights = function(hl, c)
      hl.Bold = { fg = c.fg, bg = c.bg_highlight, bold = true }
    end,
  },
}
