return {
    "folke/trouble.nvim",
    keys = {
        { "<leader>xx", "<cmd>TroubleToggle<cr>", silent = true, noremap = true },
        { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", silent = true, noremap = true },
        { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", silent = true, noremap = true },
        { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", silent = true, noremap = true },
        { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", silent = true, noremap = true },
        { "gr", "<cmd>TroubleToggle lsp_references<cr>", silent = true, noremap = true },
        { "gd", "<cmd>TroubleToggle lsp_definitions<cr>", silent = true, noremap = true },
    },
    opts = {
        height = 15,
    },
}
