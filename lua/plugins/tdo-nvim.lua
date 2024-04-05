return {
  -- "2kabhishek/tdo.nvim",
  "idr4n/tdo.nvim",
  dependencies = "nvim-telescope/telescope.nvim",
  cmd = { "Tdo", "TdoEntry", "TdoNote", "TdoTodos", "TdoToggle", "TdoFind", "TdoFiles" },
  keys = {
    "[t",
    "]t",
    { "<leader>nt", "<cmd>Tdo<cr>", desc = "Today's todo (Tdo)" },
    { "<leader>nn", "<cmd>TdoNote<cr>", desc = "New note (Tdo)" },
    { "<leader>ne", "<cmd>TdoEntry<cr>", desc = "Today's entry (Tdo)" },
    { "<leader>nf", "<cmd>TdoFiles<cr>", desc = "Find note (Tdo)" },
    { "<leader>nr", "<cmd>TdoFind<cr>", desc = "Search notes (Tdo)" },
    {
      "<leader>ndt",
      function()
        local date = vim.fn.input({ prompt = "Enter offset date (e.g. -1) or ESC to cancel: ", cancelreturn = false })
        if date == false then
          return
        end
        vim.cmd(string.format("Tdo %s", date))
      end,
      desc = "Entry with offset date (Tdo)",
    },
    {
      "<leader>nde",
      function()
        local date = vim.fn.input({ prompt = "Enter offset date (e.g. -1) or ESC to cancel: ", cancelreturn = false })
        if date == false then
          return
        end
        vim.cmd(string.format("TdoEntry %s", date))
      end,
      desc = "Todow with offset date (Tdo)",
    },
  },
}
