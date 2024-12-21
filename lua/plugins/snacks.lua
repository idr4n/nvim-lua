return {
  "folke/snacks.nvim",
  enabled = false,
  priority = 1000,
  event = { "BufReadPost", "BufNewFile" },
  -- stylua: ignore
  keys = {
    { "<leader>.", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    { "<leader>ss", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
  },
  opts = function()
    -- use statuscolumn with padding
    -- Uncomment if not using luukvbaal/statuscol.nvim
    -- vim.opt.statuscolumn = [[%!v:lua.require'utils'.statuscolumn_with_padding()]]
    return {
      scratch = {
        ft = "markdown",
      },
    }
  end,
}
