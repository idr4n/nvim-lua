return {
  "folke/trouble.nvim",
  -- branch = "dev",
  -- stylua: ignore
  keys = {
    { "<leader>zx", "<cmd>TroubleToggle<cr>", silent = true, noremap = true, desc = "Toggle Trouble" },
    { "<leader>zw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "workspace_diagnostics", },
    { "<leader>zd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "document_diagnostics", },
    { "<leader>zl", "<cmd>TroubleToggle loclist<cr>", silent = true, noremap = true, desc = "loclist" },
    { "<leader>zq", "<cmd>TroubleToggle quickfix<cr>", silent = true, noremap = true, desc = "quickfix" },
    { "gr", "<cmd>TroubleToggle lsp_references<cr>", silent = true, noremap = true, desc = "LSP references" },
    -- { "gd", "<cmd>TroubleToggle lsp_definitions<cr>", silent = true, noremap = true },
    { "]q", "<cmd>lua require('trouble').next({skip_groups = true, jump = true})<cr>", silent = true, desc = "Trouble next", },
    { "[q", "<cmd>lua require('trouble').previous({skip_groups = true, jump = true})<cr>", silent = true, desc = "Trouble previous" },

    --: v3
    -- { "gr", "<cmd>Trouble lsp_references toggle<cr>", silent = true, noremap = true, desc = "LSP references (Trouble)" },
    -- { "<leader>zr", "<cmd>Trouble lsp_references toggle<cr>", silent = true, noremap = true, desc = "LSP references (Trouble)" },
    -- { "<leader>zx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
    -- { "<leader>zX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
    -- { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
    -- { "<leader>zs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
    -- { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)", },
    -- { "<leader>zl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)", },
    -- { "<leader>zL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
    -- { "<leader>zq", "<cmd>Trouble qflist toggle preview.type=float<cr>", desc = "Quickfix List (Trouble)" },
    -- { "]q", "<cmd>lua require('trouble').next()<cr>", silent = true, desc = "Trouble next", },
    -- { "[q", "<cmd>lua require('trouble').prev()<cr>", silent = true, desc = "Trouble previous", },
  },
  opts = {
    height = 15,
    --: v3
    -- focus = true,
    -- preview = { type = "float" },
  },
}
