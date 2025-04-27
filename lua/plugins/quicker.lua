return {
  "stevearc/quicker.nvim",
  event = "FileType qf",
  keys = {
    { "<leader>zq", "<cmd>lua require('quicker').toggle()<cr>", desc = "Toggle quickfix list" },
    -- {
    --   "<leader>zx",
    --   function()
    --     local diagnostics = vim.diagnostic.get()
    --
    --     if #diagnostics == 0 then
    --       vim.notify("No diagnostics found in workspace", vim.log.levels.INFO)
    --       return
    --     end
    --
    --     vim.diagnostic.setqflist()
    --   end,
    --   desc = "Diagnostics Project",
    -- },
    -- {
    --   "<leader>zd",
    --   function()
    --     local diagnostics = vim.diagnostic.get(0)
    --
    --     if #diagnostics == 0 then
    --       vim.notify("No diagnostics found in current buffer", vim.log.levels.INFO)
    --       return
    --     end
    --
    --     local items = vim.diagnostic.toqflist(diagnostics)
    --     vim.fn.setqflist({}, " ", {
    --       title = "Current Buffer Diagnostics",
    --       items = items,
    --     })
    --     vim.cmd("copen")
    --   end,
    --   desc = "Diagnostics Buffer",
    -- },
  },
  opts = {
    opts = {
      buflisted = true,
    },
    keys = {
      { ">", "<cmd>lua require('quicker').expand()<CR>", desc = "Expand quickfix content" },
      { "<", "<cmd>lua require('quicker').collapse()<CR>", desc = "Collapse quickfix content" },
    },
  },
}
