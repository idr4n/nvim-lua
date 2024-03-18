return {
  "kazhala/close-buffers.nvim",
  keys = {
    {
      "<leader>bk",
      -- "<cmd>lua vim.cmd('Alpha'); require('close_buffers').wipe({ type = 'other', force = false })<CR>",
      "<cmd>lua vim.cmd('Dashboard'); require('close_buffers').wipe({ type = 'other', force = false })<CR>",
      noremap = true,
      silent = false,
      desc = "Close all and show Dashboard",
    },
    {
      "<leader>bo",
      "<cmd>lua require('close_buffers').wipe({ type = 'other', force = false })<CR>",
      noremap = true,
      silent = false,
      desc = "Close all other buffers",
    },
  },
}
