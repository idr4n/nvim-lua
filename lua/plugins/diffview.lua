return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = true,
  keys = {
    { "<leader>vo", ":DiffviewOpen<cr>", desc = "Diffview Project Open" },
    { "<leader>vH", ":DiffviewFileHistory %<cr>", desc = "Diffview File History" },
  },
}
