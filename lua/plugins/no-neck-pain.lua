return {
  "shortcuts/no-neck-pain.nvim",
  cmd = { "NoNeckPain" },
  keys = {
    {
      "<leader>tz",
      function()
        vim.cmd([[
            NoNeckPain
            set invnumber
            set invrelativenumber
          ]])
      end,
      desc = "Zen-mode (No-neck-pain)",
    },
  },
  opts = {
    buffers = { wo = { number = false, relativenumber = false } },
  },
}
