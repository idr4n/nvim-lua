return {
  {
    "idr4n/github-monochrome.nvim",
    -- dev = false,
    lazy = true,
    priority = 1000,
    opts = {
      style = "light",
      -- style = "dark",
      styles = {
        comments = { italic = false },
      },
      on_highlights = function(hl, c, _)
        hl.FloatBorder = { fg = c.magenta }
        -- hl.TreesitterContextBottom = { underline = true, sp = c.magenta }
      end,
    },
  },
}
