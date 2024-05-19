return {
  {
    "Lokaltog/vim-monotone",
    -- enabled = false,
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

-- solarized = {
--   dark = {
--     base03 = "#002b36", -- background tone dark (main)
--     base02 = "#073642", -- background tone (highlight/menu/LineNr)
--     base01 = "#586e75", -- content tone (comment)
--     base00 = "#657b83", -- content tone (winseparator)
--     base0 = "#839496", -- content tone (foreground)
--     base1 = "#93a1a1", -- content tone (statusline/tabline)
--     base2 = "#eee8d5", -- background tone light (highlight)
--     base3 = "#fdf6e3", -- background tone lighter (main)
--     -- accent
--     yellow = "#b58900",
--     orange = "#cb4b16",
--     red = "#dc322f",
--     magenta = "#d33682",
--     violet = "#6c71c4",
--     blue = "#268bd2",
--     cyan = "#2aa198",
--     green = "#859900",
--     -- git
--     add = "#859900",
--     change = "#b58900",
--     delete = "#dc322f",
--     -- diagnostic
--     info = "#268bd2",
--     hint = "#859900",
--     warning = "#b58900",
--     error = "#dc322f",
--   },
-- }
