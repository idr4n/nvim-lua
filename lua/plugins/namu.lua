return {
  "bassamsdata/namu.nvim",
  -- "idr4n/namu.nvim",
  event = { "BufReadPost", "BufNewFile" },
  keys = {
    {
      "gs",
      function()
        require("namu.namu_symbols").show()
      end,
      desc = "Namu - Buffer Symbols",
    },
    { "gw", ":Namu watchtower<cr>", silent = true, desc = "Namu - Open buffers Symbols" },
    { "<leader>lS", ":Namu workspace<cr>", silent = true, desc = "Namu - LSP workspace symbols" },
    { "<leader>zd", ":Namu diagnostics<cr>", silent = true, desc = "Namu - Diagnostics Buffer" },
    { "<leader>zx", ":Namu diagnostics workspace<cr>", silent = true, desc = "Namu - Diagnostics Project" },
  },
  config = function()
    require("namu").setup({
      namu_symbols = {
        enable = true,
        options = {
          AllowKinds = {
            python = { "Function", "Class", "Method", "Constant", "Variable" },
            lua = { "Function", "Method", "Table", "Module", "Object" },
          },
          display = { format = "tree_guides" },
          preserve_hierarchy = true,
          movement = {
            next = { "<C-n>", "<DOWN>", "<C-j>" }, -- Support multiple keys
            previous = { "<C-p>", "<UP>", "<C-k>" }, -- Support multiple keys
          },
        },
      },
      diagnostics = {
        options = {
          window = {
            min_width = 120,
            max_width = 140,
          },
        },
      },
    })
  end,
}
