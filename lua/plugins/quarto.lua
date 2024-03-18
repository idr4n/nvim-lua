return {
  "quarto-dev/quarto-nvim",
  dev = false,
  ft = { "quarto" },
  dependencies = {
    {
      "jmbuhr/otter.nvim",
      dependencies = {
        { "neovim/nvim-lspconfig" },
      },
      config = true,
    },
  },
  opts = {
    lspFeatures = {
      languages = { "r", "python", "julia", "bash", "lua", "html" },
    },
    codeRunner = {
      enabled = true,
      default_method = "molten",
    },
  },
  config = function(_, opts)
    require("quarto").setup(opts)
    local runner = require("quarto.runner")
    vim.keymap.set("n", "<localleader>rc", runner.run_cell, { desc = "run cell" })
    vim.keymap.set("n", "<localleader>ra", runner.run_above, { desc = "run cell and above" })
    vim.keymap.set("n", "<localleader>rA", runner.run_all, { desc = "run all cells" })
    vim.keymap.set("n", "<localleader>rl", runner.run_line, { desc = "run line" })
    vim.keymap.set("v", "<localleader>r", runner.run_range, { desc = "run visual range" })
    vim.keymap.set("n", "<localleader>RA", function()
      runner.run_all(true)
    end, { desc = "run all cells of all languages" })
  end,
}
