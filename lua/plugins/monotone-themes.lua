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
      highlights = function(colors)
        return {
          StatusLine = { fg = "#ffffff", bg = "#000000" },
        }
      end,
    },
  },
}
