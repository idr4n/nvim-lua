return {
  "TimUntersberger/neogit",
  dependencies = "nvim-lua/plenary.nvim",
  keys = {
    { "<leader>gn", ":Neogit<cr>", noremap = true, silent = true, desc = "Neogit" },
  },
  opts = {
    disable_signs = false,
    signs = {
      -- { CLOSED, OPENED }
      section = { "", "" },
      item = { "", "" },
    },
    integrations = { diffview = true },
    highlight = {
      italic = false,
      bold = false,
      underline = true,
    },
  },
}
