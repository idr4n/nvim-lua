local colored_fts = {
  "cfg",
  "css",
  "html",
  "conf",
  "lua",
  "scss",
}

return {
  {
    "uga-rosa/ccc.nvim",
    -- enabled = false,
    ft = colored_fts,
    cmd = { "CccPick", "CccHighlighterToggle" },
    keys = {
      { ",c", "<cmd>CccHighlighterToggle<cr>", silent = true, desc = "Toggle colorizer" },
      { ",p", "<cmd>CccPick<cr>", silent = true, desc = "Pick color" },
    },
    opts = function()
      local ccc = require("ccc")

      -- Use uppercase for hex codes.
      ccc.output.hex.setup({ uppercase = true })
      ccc.output.hex_short.setup({ uppercase = true })

      return {
        highlighter = {
          auto_enable = true,
          filetypes = colored_fts,
        },
      }
    end,
  },
}
