-- "folke/zen-mode.nvim",

require("zen-mode").setup({
  window = {
    width = 85,
    backdrop = 1,
    options = {
      number = true,
      relativenumber = false,
      signcolumn = "yes",
      cursorcolumn = false,
    },
  },
  -- plugins = {
  --   gitsigns = { enabled = false },
  -- }
})

-- Mapping
vim.api.nvim_set_keymap("n", "<leader>zz", ":ZenMode<cr>", { noremap = true, silent = true })
