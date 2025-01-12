return {
  {
    "idr4n/github-monochrome.nvim",
    dev = false,
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

  {
    "Lokaltog/vim-monotone",
    init = function()
      -- vim.g.monotone_color = { 44, 97, 68 }
      -- vim.g.monotone_secondary_hue_offset = 0
      -- vim.g.monotone_emphasize_comments = 0
      -- vim.g.monotone_emphasize_whitespace = 0
      vim.g.monotone_contrast_factor = 0.97
    end,
  },

  {
    "mcchrish/zenbones.nvim",
    dependencies = { "rktjmp/lush.nvim" },
  },

  {
    "maxmx03/solarized.nvim",
    opts = {
      -- theme = "neo",
      styles = {
        comments = { italic = false },
      },
      highlights = function(c, ch)
        local lighter_base02 = ch.lighten(c.base02, 15)
        return {
          StatusLine = { fg = "#ffffff", bg = "#000000" },
          IblIndent = { fg = c.base02 },
          IblScope = { fg = c.base01 },
          NvimTreeIndentMarker = { fg = c.base02 },
          NvimTreeFolderArrowClosed = { fg = lighter_base02 },
          NvimTreeFolderArrowOpen = { fg = lighter_base02 },
          TelescopeSelection = { bg = c.base02, standout = false },
          TelescopeSelectionCaret = { fg = "#FF87D7", standout = false },
          TelescopeMatching = { fg = "#FF87D7" },
          TelescopePromptPrefix = { fg = c.base00 },
        }
      end,
    },
  },
}
