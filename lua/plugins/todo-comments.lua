return {
  "folke/todo-comments.nvim",
  cmd = { "TodoQuickFix", "TodoTelescope" },
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  keys = {
    { "<leader>zt", "<cmd>TodoQuickFix<cr>", noremap = true, silent = true, desc = "TodoTrouble" },
  },
  opts = {
    highlight = {
      comments_only = false,
      after = "",
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
    },
  },
}
