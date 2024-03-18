return {
  "folke/todo-comments.nvim",
  cmd = { "TodoTrouble", "TodoTelescope" },
  event = "LazyFile",
  keys = {
    { "<leader>zt", "<cmd>TodoTrouble<cr>", noremap = true, silent = true, desc = "TodoTrouble" },
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
