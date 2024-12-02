return {
  "folke/snacks.nvim",
  -- cond = false,
  priority = 1000,
  event = { "BufReadPost", "BufNewFile" },
  -- stylua: ignore
  keys = {
    { "<leader>.", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    { "<leader>ss", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
  },
  opts = function()
    -- use statuscolumn with padding
    vim.opt.statuscolumn = [[%!v:lua.require'utils'.statuscolumn_with_padding()]]
    return {
      scratch = {
        ft = "markdown",
      },
    }
  end,
}
