return {
  "CRAG666/code_runner.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  keys = {
    { "<leader>cc", ":RunCode<CR>", noremap = true, silent = false, desc = "Code run" },
    { "<leader>cf", ":RunFile float<CR>", noremap = true, silent = false, desc = "File run" },
  },
  config = function()
    require("code_runner").setup({
      focus = false,
      term = {
        position = "vert",
        size = 50,
      },
      float = {
        close_key = "q",
        border = "rounded",
        height = 0.4,
        width = 0.8,
        x = 0.5,
        y = 0.3,
      },
    })
  end,
}
