return {
  "folke/trouble.nvim",
  -- enabled = false,
  -- branch = "dev",
  -- stylua: ignore
  keys = {
    --: v3
    -- { "gr", "<cmd>Trouble lsp_references toggle<cr>", silent = true, noremap = true, desc = "LSP references (Trouble)" },
    { "<leader>zr", "<cmd>Trouble lsp_references toggle<cr>", silent = true, noremap = true, desc = "LSP references (Trouble)" },
    -- { "<leader>zx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
    { "<leader>zX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
    { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
    { "<leader>zs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
    { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)", },
    { "<leader>zl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)", },
    { "<leader>zL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
    { "<leader>zq", "<cmd>Trouble qflist toggle preview.type=float<cr>", desc = "Quickfix List (Trouble)" },
    { "]q", "<cmd>lua require('trouble').next()<cr>", silent = true, desc = "Trouble next", },
    { "[q", "<cmd>lua require('trouble').prev()<cr>", silent = true, desc = "Trouble previous", },
  },
  opts = {
    height = 15,
    --: v3
    focus = true,
    -- preview = { type = "float" },
  },
}
