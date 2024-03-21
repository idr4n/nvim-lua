return {
  "LunarVim/bigfile.nvim",
  -- enabled = false,
  event = "BufReadPre",
  opts = {
    features = { -- features to disable
      -- "filetype",
      "illuminate",
      "indent_blankline",
      "lsp",
      "matchparen",
      "syntax",
      "treesitter",
      -- "vimopts",
    },
  },
}
