return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  keys = {
    {
      "<leader>cP",
      function()
        vim.cmd("Copilot toggle")
      end,
      desc = "Copilot Toggle",
    },
  },
  opts = {
    panel = {
      enabled = true,
      auto_refresh = true,
    },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      keymap = {
        accept = "<C-c>",
        accept_word = false,
        accept_line = false,
        next = "<C-n>",
        prev = "<C-p>",
        dismiss = "<C-]>",
      },
    },
  },
}
