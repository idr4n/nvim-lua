return {
  "nvim-pack/nvim-spectre",
  dependencies = { "nvim-lua/plenary.nvim" },
  -- stylua: ignore
  keys = {
    { "<leader>ts", '<cmd>lua require("spectre").toggle()<CR>', desc = "Toggle Spectre" },
    { "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', desc = "Spectre current word" },
    { "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', mode = "v", desc = "Spectre current word" },
    { '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', desc = "Spectre on current file" }
  },
}
