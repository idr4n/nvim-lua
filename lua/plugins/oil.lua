return {
  "stevearc/oil.nvim",
  -- enabled = false,
  cmd = "Oil",
  keys = {
    { "-", "<cmd>Oil<cr>", desc = "Oil - Parent Dir" },
    { "<leader>oo", "<cmd>Oil<cr>", desc = "Oil - Parent Dir" },
  },
  opts = {
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ["<C-s>"] = false,
      ["<C-h>"] = false,
    },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
