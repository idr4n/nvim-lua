-- 'luukvbaal/nnn.nvim'

require("nnn").setup({
  picker = {
    style = {
      width = 0.5,
      height = 0.6,
      xoffset = 0.95,
      yoffset = 0.1,
      border = "rounded",
    }
  },
  auto_close = 0,
})

-- Start nnn in the current file's directory
vim.api.nvim_set_keymap("n", "<leader>n", ":NnnPicker %:p:h<cr>", { noremap = true, silent = true })

