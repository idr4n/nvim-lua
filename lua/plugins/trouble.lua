return {
  "folke/trouble.nvim",
  keys = {
    { "<leader>zx", "<cmd>TroubleToggle<cr>", silent = true, noremap = true, desc = "Toggle" },
    {
      "<leader>zw",
      "<cmd>TroubleToggle workspace_diagnostics<cr>",
      desc = "workspace_diagnostics",
    },
    {
      "<leader>zd",
      "<cmd>TroubleToggle document_diagnostics<cr>",
      desc = "document_diagnostics",
    },
    { "<leader>zl", "<cmd>TroubleToggle loclist<cr>", silent = true, noremap = true, desc = "loclist" },
    { "<leader>zq", "<cmd>TroubleToggle quickfix<cr>", silent = true, noremap = true, desc = "quickfix" },
    { "gr", "<cmd>TroubleToggle lsp_references<cr>", silent = true, noremap = true, desc = "LSP references" },
    -- { "gd", "<cmd>TroubleToggle lsp_definitions<cr>", silent = true, noremap = true },
  },
  opts = {
    height = 15,
  },
}
