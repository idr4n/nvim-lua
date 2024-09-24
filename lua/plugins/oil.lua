return {
  "stevearc/oil.nvim",
  -- enabled = false,
  cmd = "Oil",
  keys = {
    -- { "<leader>-", "<cmd>Oil --float<cr>", desc = "Oil Float - Parent Dir" },
    { "s", "<cmd>Oil --float<cr>", desc = "Oil Float - Parent Dir" },
    { "<leader>oo", "<cmd>Oil<cr>", desc = "Oil - Parent Dir" },
  },
  opts = {
    view_options = {
      show_hidden = true,
    },
    float = {
      padding = 2,
      max_width = 90,
      max_height = 0,
    },
    win_options = {
      wrap = true,
      winblend = 0,
    },
    keymaps = {
      ["<C-s>"] = false,
      ["<C-h>"] = false,
      ["q"] = "actions.close",
      -- ["<leader>-"] = "actions.close",
      ["s"] = "actions.close",
    },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
