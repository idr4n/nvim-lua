return {
  "folke/todo-comments.nvim",
  -- cond = false,
  cmd = { "TodoQuickFix", "TodoTelescope" },
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  keys = {
    { "<leader>zt", "<cmd>TodoQuickFix<cr>", noremap = true, silent = true, desc = "TodoTrouble" },
  },
  opts = {
    highlight = {
      comments_only = false,
      keyword = "wide_fg",
      after = "",
      before = "",
      pattern = { ".*<(KEYWORDS)\\s*:", ".*\\[(KEYWORDS)\\]" },
    },
    search = {
      command = "rg",
      args = {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--glob=!node_modules",
      },
      pattern = "\\b(KEYWORDS):|\\[(KEYWORDS)\\]",
    },
  },
}
